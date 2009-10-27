#
# Cookbook Name:: whenever
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    directory "/data/#{app_name}/shared/log/cron" do
      owner node[:owner_name]
      group node[:owner_name]
      mode '0755'
      recursive true
    end
  
    execute "setting up cron jobs based for instance role #{node[:instance_role]}" do
      user node[:users].first[:username]
      cwd "/data/#{app_name}/current"
      command "whenever --load-file deploy/cron/#{node[:instance_role]}.#{node[:environment][:name]}.whenever --update-crontab #{app_name}"
    end
  end

end
