#
# Cookbook Name:: ssmtp
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  package "ssmtp" do
    action :install
  end

  node[:applications].each do |app_name, data|
    ssmtp_config_path = "/data/#{app_name}/current/deploy/ssmtp/ssmtp.#{node[:environment][:name]}.yml"
    template "/etc/ssmtp/ssmtp.conf" do
      owner 'root'
      group 'root'
      mode 0644
      source 'ssmtp.conf.erb'
      variables YAML.load(IO.read(ssmtp_config_path))
    end
  end

end
