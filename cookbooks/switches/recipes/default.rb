#
# Cookbook Name:: switches
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    Dir["/data/#{app_name}/current/config/switches/*.#{node[:environment][:name]}.yml"].each do |replacement_path|
      original_path = replacement_path.gsub ".#{node[:environment][:name]}", ''
      execute "copying #{replacement_path} over #{original_path}" do
        user 'root'
        command "cp #{replacement_path} #{original_path}; chown #{node[:owner_name]} #{original_path}; chown 0644 #{original_path}"
      end
    end
  end

end
