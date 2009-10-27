#
# Cookbook Name:: thinking_sphinx
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|

    [
      "/data/#{app_name}/shared/log/sphinx",
      "/data/#{app_name}/shared/db/sphinx",
      "/data/#{app_name}/shared/pids", # no subdir
    ].each do |name|
      directory name do
        owner node[:owner_name]
        group node[:owner_name]
        mode '0755'
        recursive true
      end
    end
  
    execute "copy in sphinx.yml" do
      user node[:owner_name]
      group node[:owner_name]
      cwd "/data/#{app_name}/current"
      command "cp deploy/sphinx/sphinx.#{node[:environment][:name]}.yml config/sphinx.yml"
    end
  
    execute "configure sphinx" do
      user node[:owner_name]
      group node[:owner_name]
      cwd "/data/#{app_name}/current"
      command "rake thinking_sphinx:configure RAILS_ENV=production"
    end
  
    execute "index sphinx" do
      user node[:owner_name]
      group node[:owner_name]
      cwd "/data/#{app_name}/current"
      command "rake thinking_sphinx:index RAILS_ENV=production"
    end
  end

end
