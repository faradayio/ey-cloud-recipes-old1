#
# Cookbook Name:: string_replacer
# Recipe:: default
#

remote_file "/usr/bin/string_replacer.rb" do
  source "string_replacer.rb"
  mode '755'
end
