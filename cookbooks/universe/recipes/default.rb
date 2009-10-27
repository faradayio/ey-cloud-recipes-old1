#
# Cookbook Name:: universe
# Recipe:: default
#

template "/etc/universe" do
  owner 'root'
  group 'root'
  mode '0644'
  source 'universe.erb'
  variables :name => node[:environment][:name]
end
