#
# Cookbook:: maxlab_samba
# Recipe:: server
#
# Copyright:: 2020, The Authors, All Rights Reserved.

=begin
#<
Deloy a basic SAMBA file server.
#>
=end

package node['samba']['packages'] do
  action :install
end

config_id = node['instance_config_samba']['instance']

# Retrieve the data bag with samba config information for this node
config_samba_server = data_bag_item('config_samba_server',  config_id)

config_sections = {}
config_block = []

config_samba_server['cfg']['sections'].each do | section_name, section_details|

  config_block = []

  section_details.each do |setting, value|

    # If array, Append array elements separated by spaces
    # else just append value which should be a string
    if value.class.to_s == "Array"
      mystr = ""
      value.each do |e|
        mystr << "#{e} "
      end
      config_block << "#{setting} = #{mystr}"
    else
      config_block << "#{setting} = #{value}"
    end
  end

  config_sections[section_name] = config_block
end

template '/etc/samba/smb.conf' do
  source 'smb.conf.erb'

  owner 'root'
  group 'root'
  mode '0644'

  variables ({
    config_sections: config_sections,
    config_id: config_id
  })

  action :create
end

# Warning - firewalld specific, won't work on Red hat < 7, Debian, etc
#---

# Allow this service via the default interface's firewalld zone
service_zone = node['maxlab_firewall']['default_interface_zone']

# Add the service to this node's firewalld service requirements
# Ex: Append 'dns' to 'ssh http https' (list of already allowed services)
if node['samba']['firewalld'].key?('services')
  node['samba']['firewalld']['services'].each do |service_string|

    if not node['maxlab_firewall']['zones'][service_zone]['services'].include? service_string
      node.normal['maxlab_firewall']['zones'][service_zone]['services'] << service_string
    end

  end
end

# Append individual port definitions
if node['samba']['firewalld'].key?('ports')
  node['samba']['firewalld']['ports'].each do |port_string|

    if not node['maxlab_firewall']['zones'][service_zone]['ports'].include? port_string
      node.normal['maxlab_firewall']['zones'][service_zone]['ports'] << port_string
    end

  end
end

# Append individual sources definitions
if node['samba']['firewalld'].key?('sources')
  node['samba']['firewalld']['sources'].each do |source_string|

    if not node['maxlab_firewall']['zones'][source_zone]['sources'].include? source_string
      node.normal['maxlab_firewall']['zones'][source_zone]['sources'] << source_string
    end

  end
end

#---

node['samba']['services'].each do |service_name|
  service service_name do
    action [ :enable, :start, :reload ]
  end
end

tag('samba')
tag('samba-server')
