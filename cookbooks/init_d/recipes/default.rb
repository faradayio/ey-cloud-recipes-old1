#
# Cookbook Name:: init_d
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    Dir["/etc/init.d/*.#{node[:environment][:name]}"].each do |path|
      execute "removing old #{File.basename path} for #{app_name}" do
        user 'root'
        command "rm -f #{path}"
      end
    end
  
    Dir["/data/#{app_name}/current/deploy/init_d/*.#{node[:environment][:name]}"].each do |path|
      basename = File.basename path
      new_path = "/etc/init.d/#{basename}"
      execute "installing #{basename} and giving ownership to app user for #{app_name}" do
        user 'root'
        command "cp #{path} #{new_path}; chown #{node[:owner_name]} #{new_path}; chgrp #{node[:owner_name]} #{new_path}; chmod 0755 #{new_path}"
      end
    end
  end

end
