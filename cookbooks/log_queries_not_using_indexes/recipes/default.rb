#
# Cookbook Name:: log_queries_not_using_indexes
# Recipe:: default
#

if %w{db_master solo}.include?(node[:instance_role])

  path = '/root/log_queries_not_using_indexes.patch'

  remote_file path do
    source 'log_queries_not_using_indexes.patch'
    owner 'root'
    group 'root'
    mode 0644
  end

  execute "applying patch #{path}" do
    user 'root'
    command "patch -p0 --forward --input=#{path}"
    ignore_failure true
  end

end
