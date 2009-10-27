#
# Cookbook Name:: rails_2_3_gems
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    IO.readlines("/data/#{app_name}/current/config/environment.rb").grep(/config\.gem/).each do |line|
      if /config\.gem ['"](.*?)['"],.*\:version => ['"](.*?)['"]/.match line
        name_and_version = "\"#{$1}\" --version \"#{$2}\""
      elsif /config\.gem ['"](.*?)['"]/.match line
        name_and_version = "\"#{$1}\""
      else
        raise "Can't read #{line}"
      end
      execute "install #{name_and_version}" do
        user 'root'
        command "gem install #{name_and_version} --no-rdoc --no-ri --ignore-dependencies --force --source http://gemcutter.org --source http://gems.github.com --source http://gems.rubyforge.org"
        not_if "gem list #{name_and_version} --installed"
      end
    end
  end

end
