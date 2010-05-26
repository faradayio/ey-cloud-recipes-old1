#
# Cookbook Name:: memcached
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  MEMCACHED_SERVER_VERSION="1.4.4"
  MEMCACHED_MONIT_GROUP="memcached"

  execute "make sure memcached #{MEMCACHED_SERVER_VERSION} is available" do
    user 'root'
    command "/usr/bin/string_replacer.rb /etc/portage/package.keywords/local \"=net-misc/memcached-#{MEMCACHED_SERVER_VERSION}\" \"make sure memcached #{MEMCACHED_SERVER_VERSION} is available\""
  end

  package "net-misc/memcached" do
    version MEMCACHED_SERVER_VERSION
  end

  node[:applications].each do |app_name, data|
    memcached_config_path = "/data/#{app_name}/current/deploy/memcached/memcached.#{node[:environment][:name]}.yml"
    template "/etc/conf.d/memcached" do
      owner 'root'
      group 'root'
      mode 0644
      source "memcached.erb"
      variables YAML.load(IO.read(memcached_config_path))
    end
  
    # execute "ensure-running-memcached-version-is-correct" do
    #   command %Q{
    #     monit restart all -g #{MEMCACHED_MONIT_GROUP}
    #   }
    #   not_if "memcached-tool localhost stats | grep -E \"version[ ]+#{Regexp.escape MEMCACHED_SERVER_VERSION}\""
    # end
  end

end
