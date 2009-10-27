#
# Cookbook Name:: chmod
# Recipe:: default
#

if %w{app app_master solo}.include?(node[:instance_role])

  node[:applications].each do |app_name, data|
    app_root = "/data/#{app_name}/current"
    config_file = "#{app_root}/deploy/chmod.yml"
    if File.exists?(config_file) and config = YAML.load(IO.read(config_file)) and config.is_a?(Hash)
      config.each do |filename, ownership|
        execute "chmod'ing #{filename}" do
          user 'root'
          cwd app_root
          command "chmod #{ownership} #{filename}"
        end
      end
    end
  end

end
