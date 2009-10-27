#
# Cookbook Name:: robots_txt
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    path = "/data/#{app_name}/current/deploy/robots_txt/robots.#{node[:environment][:name]}.txt"
    new_path = "/data/#{app_name}/current/public/robots.txt"
    execute "installing robots.txt" do
      user 'root'
      command "cp #{path} #{new_path}"
    end
  end

end
