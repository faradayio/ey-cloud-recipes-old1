#
# Cookbook Name:: delayed_job
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    [
      "/data/#{app_name}/shared/log/delayed_job",
      "/data/#{app_name}/shared/pids", # no subdir
    ].each do |name|
      directory name do
        owner node[:owner_name]
        group node[:owner_name]
        mode '0755'
        recursive true
      end
    end
  end

end