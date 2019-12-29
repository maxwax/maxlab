#
# Cookbook:: maxlab_pxe
# Recipe:: deploy
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Deploy PXE files: Kickstart files for Linux distributions, PXE menus for all.
#>
=end

# High level scoping: We construct this while building kickstart files
# then use it when building PXE menu files
pxe_menu = {}

# Load the main PXE configuration
config_pxe = data_bag_item('config_pxe', 'pxeconfig').to_h

# Iterate over the configured PXE software distributions
config_pxe['kickstart_configs'].each do |dist_id|

  # For each distribution, load PXE (kickstart & PXE) configuration data
  dist_install_config = data_bag_item('config_kickstart', dist_id)

  dist_label = dist_install_config['dist_label']

  # Cycle through each PXE configuration found in json
  dist_install_config[dist_id].each do |major, val_major|

    # Iterate over major versions
    val_major.each do |minor, val_minor|

      # Directories containing kickstart files; Available locally and via URLs
      local_kickstart_dir = "#{config_pxe['local_repo_dir']}/#{config_pxe['kickstart_dir']}"

      local_kickstart_dist_dir = "#{local_kickstart_dir}/#{dist_id}"

      url_kickstart_dist_dir =
        "#{node['global']['repo_url']}/#{config_pxe['kickstart_dir']}/#{dist_id}"

      # Directories containing script snippets files; Available locally
      local_scripts_dir =
        "#{config_pxe['local_repo_dir']}/#{config_pxe['scripts_dir']}"
      local_scripts_dist_dir = "#{local_scripts_dir}/#{dist_id}"

      # Directories containing stub files (incomplete kickstart files)
      local_stubs_dir =
        "#{config_pxe['local_repo_dir']}/#{config_pxe['stubs_dir']}"
      local_stubs_dist_dir = "#{local_stubs_dir}/#{dist_id}"

      # Directories containing kickstart password instructions in files
      local_passwords_dir =
        "#{config_pxe['local_repo_dir']}/#{config_pxe['passwords_dir']}"
      local_passwords_dist_dir = "#{local_passwords_dir}/#{dist_id}"

      # Ensures all directories exist
      %W[
         #{local_kickstart_dir}
         #{local_kickstart_dist_dir}
         #{local_scripts_dir}
         #{local_scripts_dist_dir}
         #{local_stubs_dir}
         #{local_stubs_dist_dir}
         #{local_passwords_dist_dir}
      ].each do |dirname|

        directory dirname do
          owner config_pxe['user']
          group config_pxe['group']
          mode 0755
          recursive true
          action :create
        end
      end

      # Iterate over minor versions (ex: RH8.0, 8.1, 8.2)
      val_minor.each do |config_name, ksconfig|

        # Set the PXE menu group (ordering) for readability
        group = ksconfig['group']

        linux_release_id = "#{dist_id}-#{major}.#{minor}"
        linux_config_id = "#{linux_release_id}-#{config_name}"

        # Load network information for the network this kickstart config uses
        config_network = data_bag_item('config_network', ksconfig['network']).to_h

        # Pull subnet specific info from the overall network
        subnet_info = config_network['subnet'][ksconfig['subnet']]

        kickstart_file = "#{local_kickstart_dist_dir}/ks-#{linux_config_id}.ks"

        url_kickstart_file = "#{url_kickstart_dist_dir}/ks-#{linux_config_id}.ks"

        # Deploy most of our kickstart commands to this stub file
        stub_file = "#{local_stubs_dist_dir}/stub-#{linux_config_id}.ks"

        # URL to repo containing ISO software files via HTTP
        dist_url = "#{node['global']['dist_url']}/#{dist_id}/#{ksconfig['isodir']}"

        # Deploy the stub file
        template stub_file do
          source "kickstart/#{ksconfig['template']}"
          owner config_pxe['user']
          group config_pxe['group']
          mode 0755
          variables(
            ksconfig: ksconfig,
            subnet_info: subnet_info
          )
        end

        # Copy the stub to the kickstart file
        execute "copy-ks-file" do
          command "cp -p #{stub_file} #{kickstart_file}"
          action :run
        end

        # Append a file to the kickstart file containing root password directive
        # This file is deployed manually to avoid Chef/Github inclusion
        ksconfig['password_file'].each do |pfile|

          # The password file contains data to be appended to the kickstart file
          password_file = "#{local_passwords_dist_dir}/#{pfile}"

          execute "include-file-#{pfile}" do
            command "if [[ -f #{password_file} ]]; then cat #{password_file} >> #{kickstart_file}; fi"
            action :run
          end

        end

        # For each kickstart 'post' script, deploy it then append it to ks file
        ksconfig['post_scripts'].each do |script_name, script_cfg|

          script_file = "#{local_scripts_dist_dir}/#{script_cfg['filename']}"

          template script_file do
            source "kickstart/#{script_cfg['filename']}.erb"
            owner config_pxe['user']
            group config_pxe['group']
            mode 0755
          end

          execute "#{script_name}" do
            command "cat #{script_file} >> #{kickstart_file}"
            action :run
          end
        end

        #
        # Construct a hash tree via pxe_menu containing data to build menus ltr
        #

        unless pxe_menu.key? dist_id
          pxe_menu[dist_id] = {}
        end

        # Branch for dist_id to hold label only
        unless pxe_menu[dist_id].key? 'dist_label'
          pxe_menu[dist_id]['dist_label'] = dist_label
        end

        # Branch for dist_id to hold details for menus
        unless pxe_menu[dist_id].key? 'versions'
          pxe_menu[dist_id]['versions'] = {}
        end

        unless pxe_menu[dist_id]['versions'].key? major
          pxe_menu[dist_id]['versions'][major] = {}
        end

        unless pxe_menu[dist_id]['versions'][major].key? minor
          pxe_menu[dist_id]['versions'][major][minor] = {}
        end

        unless pxe_menu[dist_id]['versions'][major][minor].key? group
          pxe_menu[dist_id]['versions'][major][minor][group] = {}
        end

        unless pxe_menu[dist_id]['versions'][major][minor][group].key? config_name
          pxe_menu[dist_id]['versions'][major][minor][group][config_name] = {}
        end

        pm = {
         'dist_label' => "#{dist_install_config['dist_label']}",
         'menu_label' => "#{ksconfig['menu_label']}",
         'kernel_text' => "#{config_pxe['default_kernel_dir']}/#{dist_id}/#{linux_release_id}/#{config_pxe['default_kernel_fname']}",
         'initrd_text' => "initrd=#{config_pxe['default_initrd_dir']}/#{dist_id}/#{linux_release_id}/#{config_pxe['default_initrd_fname']}",
         'kickstart_file' => "inst.ks=#{url_kickstart_file}",
         'dist_url' => "inst.repo=#{dist_url}",
         'serial_console' => "#{ksconfig['serial_console']}",
         'bootloader_options' => "#{ksconfig['bootloader_options']}"
        }

        # After hash constructed, concatenate these values together
        pm['append_text'] = "#{pm['initrd_text']} #{pm['kickstart_file']} #{pm['dist_url']} #{pm['bootloader_options']}"

        pxe_menu[dist_id]['versions'][major][minor][group][config_name] = pm

      end
    end
  end
end

# Iterate over the configured PXE software distributions
config_pxe['netboot_configs'].each do |tool_id|

#puts "NETBOOT LOOP #{tool_id}"

  # For each distribution, load PXE (kickstart & PXE) configuration data
  netboot_config = data_bag_item('config_netboot', tool_id)

  # Cycle through each PXE configuration found in json
  netboot_config[tool_id].each do |major, val_major|

#puts "NETBOOT LOOP MAJOR #{major}"

    # Iterate over major versions
    val_major.each do |minor, val_minor|

#puts "NETBOOT LOOP MINOR #{minor}"

      # Iterate over minor versions (ex: RH8.0, 8.1, 8.2)
      val_minor.each do |config_name, boot_config|

#puts "NETBOOT LOOP CONFIG_NAME #{config_name}"

        # Set the PXE menu group (ordering) for readability
        group = boot_config['group']

#puts
#puts "GROUP #{group}"
#puts
        dist_label = netboot_config['dist_label']

#puts
#puts "DIST LABEL #{dist_label}"
#puts

        tool_release_id = "#{tool_id}-#{major}.#{minor}"
        tool_config_id = "#{tool_release_id}-#{config_name}"

#puts
#puts "BOOT_CONFIG"
#pp boot_config
#puts
        # We construct this along the way
        unless pxe_menu.key? tool_id
          pxe_menu[tool_id] = {}
        end

        unless pxe_menu[tool_id].key? 'dist_label'
          pxe_menu[tool_id]['dist_label'] = dist_label.to_s
        end

        unless pxe_menu[tool_id].key? 'versions'
          pxe_menu[tool_id]['versions'] = {}
        end

        unless pxe_menu[tool_id]['versions'].key? major
          pxe_menu[tool_id]['versions'][major] = {}
        end

        unless pxe_menu[tool_id]['versions'][major].key? minor
          pxe_menu[tool_id]['versions'][major][minor] = {}
        end

        unless pxe_menu[tool_id]['versions'][major][minor].key? group
          pxe_menu[tool_id]['versions'][major][minor][group] = {}
        end

        unless pxe_menu[tool_id]['versions'][major][minor][group].key? config_name
          pxe_menu[tool_id]['versions'][major][minor][group][config_name] = {}
        end

        # Handle options for specific types of net booting software
        case boot_config['tool_type']

          when 'clonezilla'

            pm = {
              'dist_label' => "#{netboot_config['dist_label']}",
              'menu_label' => "#{boot_config['menu_label']}",
              'kernel_text' => "#{config_pxe['default_kernel_dir']}/#{tool_id}/#{tool_release_id}/#{config_pxe['default_kernel_fname']}",
              'initrd_text' => "initrd=#{config_pxe['default_initrd_dir']}/#{tool_id}/#{tool_release_id}/#{config_pxe['default_initrd_fname']}",
              'bootloader_options' => "#{boot_config['bootloader_options']}",
              'append_text' => ""
            }

            # After hash constructed, concatenate these values together
            pm['append_text'] << "#{pm['initrd_text']} #{pm['bootloader_options']}"

            # Append all elements of clonezilla specific boot options
            boot_config['clonezilla']['kernel_options'].each do |opt|
              pm['append_text'] << " " + opt
            end

            # Construct a kernel option
            pm['append_text'] << " " +
              boot_config['clonezilla']['image_repo_command'] + " " +
              boot_config['clonezilla']['image_repo_proto'] + " " +
              boot_config['clonezilla']['image_repo_url'] + " " +
              boot_config['clonezilla']['image_repo_mountpoint'] + "'"

            pm['append_text'] << " " +
              boot_config['clonezilla']['squashfs_cmd'] +
              boot_config['clonezilla']['squashfs_url']

          # Ex: MS-DOS Firmware Upgrade Images
          when 'image'

            pm = {
             'dist_label' => "#{netboot_config['dist_label']}",
             'menu_label' => "#{boot_config['menu_label']}",
             'kernel_text' => "#{boot_config['image']['kernel']}",
             'initrd_text' => "#{boot_config['image']['append']}",
             'bootloader_options' => "#{boot_config['bootloader_options']}",
              'append_text' => ""
            }

            # After hash constructed, concatenate these values together
            pm['append_text'] << "#{pm['initrd_text']} #{pm['bootloader_options']}"

        end

        pxe_menu[tool_id]['versions'][major][minor][group][config_name] = pm

      end
    end
  end
end

puts
puts "FINAL PXE_MENU"
pp pxe_menu
puts

# Create PXE menu directories as needed, but don't make /var/lib recursively
%W[
  #{config_pxe['pxelinux_cfg_root']}
  #{config_pxe['pxelinux_cfg_dir']}
].each do |dirname|
  directory dirname do
    owner config_pxe['user']
    group config_pxe['group']
    mode 0755
    recursive false
    action :create
  end
end

#
# Iterate through the pxe_menu hash and deploy PXE menu config files as needed
#

pxe_default_file = "#{config_pxe['pxelinux_cfg_dir']}/default"

# Ex: '/var/lib/tftpboot/pxelinux.cfg/default"
template pxe_default_file do

  source "pxelinux.cfg/pxe_default.erb"
  owner config_pxe['user']
  group config_pxe['group']
  mode 0755

  variables(
    pxe_menu: pxe_menu,
    config_pxe: config_pxe
  )
end

pxe_menu.each do |dist_id, dist_cfg|

  # Ex: Create /var/lib/tftpboot/pxelinux.cfg/redhat
  directory "#{config_pxe['pxelinux_cfg_dir']}/#{dist_id}" do
    action :create
    owner config_pxe['user']
    group config_pxe['group']
    mode 0755
  end

  menu_main = "#{config_pxe['pxelinux_cfg_dir']}/#{dist_id}/main.conf"
puts
puts "DEBUG DIST_CFG FOR MENUS"
pp dist_cfg
puts

  # Ex: '/var/lib/tftpboot/pxelinux.cfg/rhel/main.conf
  template menu_main do

    source "pxelinux.cfg/pxe_menu_main.conf.erb"
    owner config_pxe['user']
    group config_pxe['group']
    mode 0755

    variables(
      dist_label: dist_cfg['dist_label'],
      dist_id: dist_id,
      dist_cfg: dist_cfg
    )
  end

  # All major versions, all minor versions, iterate over unique configs
  dist_cfg['versions'].each do |major, major_cfg|
    major_cfg.each do |minor, config_groups|

      linux_release_id = "#{dist_id}-#{major}.#{minor}"

      menu_release = "#{config_pxe['pxelinux_cfg_dir']}/#{dist_id}/main.conf"

      # Ex: '/var/lib/tftpboot/pxelinux.cfg/redhat/redhat81.conf'
      template "#{config_pxe['pxelinux_cfg_dir']}/#{dist_id}/#{linux_release_id}.conf" do

        source "pxelinux.cfg/pxe_menu_dist_version.conf.erb"
        owner config_pxe['user']
        group config_pxe['group']
        mode 0744

        variables(
          linux_release_id: linux_release_id,
          dist_id: dist_id,
          dist_label: dist_cfg['dist_label'],
          major: major,
          minor: minor,
          config_pxe: config_pxe,
          config_groups: config_groups
        )
      end

    end
  end
end
