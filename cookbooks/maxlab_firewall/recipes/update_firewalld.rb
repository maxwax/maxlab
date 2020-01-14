#
# Cookbook:: maxlab_firewall
# Recipe:: base_firewall
#
# Copyright:: 2019, The Authors, All Rights Reserved.

=begin
#<
Using node['maxlab_firewall'] attribute as a list of services, sources and ports to configure, call 'firewall-cmd' to configure firewalld.
#>
=end

puts
puts "DEBUG maxlab_firewall::update_firewall EXISTING node['maxlab_firewall']['zones'] #{node['maxlab_firewall']['zones']}"
puts

# Iterate over each zone configuration
node['maxlab_firewall']['zones'].each do |zone, zone_config|

  # Iterate over each service defined for this zone
  zone_config['services'].each do |service_name|

    # Construct commands to add the services to runtime and permanent configs
    cmd_rtime = "firewall-cmd --add-service=#{service_name} --zone=#{zone}"
    cmd_perm = "firewall-cmd --permanent --add-service=#{service_name} --zone=#{zone}"

    execute "add-service-#{service_name}-permanent" do
      command cmd_perm
      action :run
    end

    execute "add-service-#{service_name}-runtime" do
      command cmd_rtime
      action :run
    end
  end

  # Iterate over each service defined for this zone
  zone_config['sources'].each do |source_string|

    # Construct commands to add the sources to runtime and permanent configs
    cmd_rtime = "firewall-cmd --add-source=#{source_string} --zone=#{zone}"
    cmd_perm = "firewall-cmd --permanent --add-source=#{source_string} --zone=#{zone}"

    execute "add-source-#{source_string}-permanent" do
      command cmd_perm
      action :run
    end

    execute "add-source-#{source_string}-runtime" do
      command cmd_rtime
      action :run
    end
  end

  puts
  puts "DEBUG maxlab_firewall::update_firewall zone_config"
  pp zone_config
  puts

  # Iterate over each port defined for this zone
  zone_config['ports'].each do |port_string|

    puts
    puts "DEBUG maxlab_firewall::update_firewall port_string"
    pp port_string
    puts

    # Construct commands to add the ports to runtime and permanent configs
    cmd_rtime = "firewall-cmd --add-port=#{port_string} --zone=#{zone}"
    cmd_perm = "firewall-cmd --permanent --add-port=#{port_string} --zone=#{zone}"

    execute "add-port-#{port_string}-permanent" do
      command cmd_perm
      action :run
    end

    execute "add-port-#{port_string}-runtime" do
      command cmd_rtime
      action :run
    end
  end

end
