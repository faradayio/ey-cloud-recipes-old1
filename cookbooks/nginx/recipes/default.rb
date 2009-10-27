#
# Cookbook Name:: nginx
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    Dir["/data/#{app_name}/current/deploy/nginx/*.#{node[:environment][:name]}.patch"].each do |path|
      execute "applying patch #{path}" do
        user 'root'
        command "patch -p0 --forward --input=#{path}"
        ignore_failure true
      end
    end
    Dir["/data/#{app_name}/current/deploy/nginx/*.#{node[:environment][:name]}.conf"].each do |path|
      basename = File.basename(path).gsub ".#{node[:environment][:name]}", ''
      new_path = "/etc/nginx/servers/#{basename}"
      execute "copying in server conf #{basename}" do
        user 'root'
        command "cp #{path} #{new_path}"
      end
    end
  end

  execute "restart nginx" do
    user 'root'
    command "nohup /etc/init.d/nginx restart > /dev/null"
  end

end
