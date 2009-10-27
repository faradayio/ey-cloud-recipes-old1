#
# Cookbook Name:: deploy_copy_exclude
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  gem_lib_path = `gem which --quiet chef-deploy`

  execute "setting copy_exclude on #{gem_lib_path}" do
    user 'root'
    command ('sed --expression="s/@copy_exclude = \[\]/@copy_exclude = \[\'.git\/*\'\]/" --in-place="" ' + gem_lib_path)
  end

end
