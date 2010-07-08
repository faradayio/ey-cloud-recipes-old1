#
# Cookbook Name:: patch
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    Dir["/data/#{app_name}/current/deploy/patch/*.#{node[:environment][:name]}.patch"].each do |path|
      execute "applying patch #{path} for #{app_name}" do
        user 'root'
        command "patch -p0 --forward --input=#{path}"
        ignore_failure true
      end
    end
  end
end
