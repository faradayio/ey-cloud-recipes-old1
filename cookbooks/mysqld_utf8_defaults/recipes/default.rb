#
# Cookbook Name:: mysqld_utf8_defaults
# Recipe:: default
#

if %w{solo db_slave db_master}.include?(node[:instance_role])

  remote_file "/etc/mysql.d/utf8_defaults.cnf" do
    owner 'root'
    group 'root'
    mode '0644'
    source "utf8_defaults.cnf"
  end

end
