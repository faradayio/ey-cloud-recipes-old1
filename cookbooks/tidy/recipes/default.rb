#
# Cookbook Name:: tidy
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  package 'app-text/htmltidy' do
    action :install
  end

end
