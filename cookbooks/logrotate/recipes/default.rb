#
# Cookbook Name:: logrotate
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  # i don't like how it's called "passenger" but it's linked to /data/your-app/shared/log, which seems more general
  execute "remove engineyard logrotate on /var/log/engineyard/passenger" do
    user 'root'
    command 'rm -f /etc/logrotate.d/passenger'
  end

  execute "modify engineyard logrotate for nginx logs to keep logs for 3 years" do
    user 'root'
    command 'sed --expression="s/rotate 30/rotate 1095/" --in-place="" /etc/logrotate.d/nginx'
  end

  node[:applications].each do |app_name, data|
    Dir["/etc/logrotate.d/*.#{node[:environment][:name]}.logrotate"].each do |path|
      execute "removing old #{File.basename path}" do
        user 'root'
        command "rm -f #{path}"
      end
    end
  
    Dir["/data/#{app_name}/current/deploy/logrotate/*.#{node[:environment][:name]}.logrotate"].each do |path|
      basename = File.basename path
      new_path = "/etc/logrotate.d/#{basename}"
      execute "installing #{basename}" do
        user 'root'
        command "cp #{path} #{new_path}; chown root #{new_path}; chmod 0644 #{new_path}"
      end
    end
  end

end
