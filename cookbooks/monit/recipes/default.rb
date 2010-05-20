#
# Cookbook Name:: monit
# Recipe:: default
#

MONIT_POST_RELOAD_DELAY = 10

# if %w{app app_master solo}.include?(node[:instance_role])
# 
#   node[:applications].each do |app_name, data|
#     # remove obsolete files from this environment
#     Dir["/etc/monit.d/*.#{node[:environment][:name]}.monitrc"].each do |path|
#       execute "removing old #{File.basename path}" do
#         user 'root'
#         command "rm -f #{path}"
#       end
#     end
#   
#     monit_groups = []
#     Dir["/data/#{app_name}/current/deploy/monit/*.#{node[:environment][:name]}.monitrc"].each do |path|
#       basename = File.basename path
#       monit_group = File.basename basename, ".#{node[:environment][:name]}.monitrc"
#     
#       # remove obsolete files for this service, possibly from other environments
#       Dir["/etc/monit.d/#{monit_group}.*.monitrc"].each do |obsolete_path|
#         execute "removing obsolete #{monit_group}" do
#           user 'root'
#           command "rm -f #{obsolete_path}"
#         end
#       end
#     
#       # add new files
#       new_path = "/etc/monit.d/#{basename}"
#       execute "installing #{basename}" do
#         user 'root'
#         command "cp #{path} #{new_path}; chown root #{new_path}; chmod 0644 #{new_path}"
#       end
#     
#       # remember what it was called
#       monit_groups << monit_group
#     end
#     execute "nudging monit to update its config" do
#       user 'root'
#       command "monit reload"
#     end
#     execute "sleep for #{MONIT_POST_RELOAD_DELAY} seconds" do
#       user 'root'
#       command "sleep #{MONIT_POST_RELOAD_DELAY}"
#     end
#     monit_groups.each do |name|
#       execute "telling #{name} to restart" do
#         user 'root'
#         command "monit restart all -g #{name}"
#       end
#     end
#   end
# end
