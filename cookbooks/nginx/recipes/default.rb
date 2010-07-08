#
# Cookbook Name:: nginx
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])
  node[:applications].each do |app_name, data|
    Dir["/data/#{app_name}/current/deploy/nginx/*.#{node[:environment][:name]}.conf"].each do |path|
      basename = File.basename(path).gsub ".#{node[:environment][:name]}", ''
      new_path = "/etc/nginx/servers/#{basename}"
      execute "copying in server conf #{basename} for #{app_name}" do
        user 'root'
        command "cp #{path} #{new_path}"
      end
    end
  end
end
