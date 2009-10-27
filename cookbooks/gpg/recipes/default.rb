#
# Cookbook Name:: gpg
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  package "app-crypt/gnupg"

end
