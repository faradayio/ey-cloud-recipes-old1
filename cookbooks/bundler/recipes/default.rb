#
# Cookbook Name:: bundler
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    execute "run bundle install" do
      user 'root'
      cwd "/data/#{app_name}/current"
      command 'sudo bundle install'
    end
  end

end
