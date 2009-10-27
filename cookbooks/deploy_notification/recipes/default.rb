#
# Cookbook Name:: deploy_notification
# Recipe:: default
#

if %w{app_master solo}.include?(node[:instance_role]) and File.exists?('/etc/universe')

  universe = IO.readlines('/etc/universe').first.chomp

  node[:applications].each do |app_name, data|
    Time.zone = IO.readlines("/data/#{app_name}/current/config/timezone").first.chomp
    time = Time.zone.now
    deploy_notification_config = YAML.load(IO.read("/data/#{app_name}/current/deploy/deploy_notification.yml"))
    commit = IO.readlines("/data/#{app_name}/current/REVISION").first.chomp
    subject = "Deployed #{app_name} in #{universe} at #{commit}"
    email_path = "/data/#{app_name}/current/DEPLOY_NOTIFICATION.#{time.iso8601.gsub(/[^a-z0-9\-_]+/, '-')}"
  
    template email_path do
      owner node[:owner_name]
      group node[:owner_name]
      mode '0644'
      source 'deploy_notification.erb'
      variables :node           => node,
                :app_name       => app_name,
                :universe       => universe,
                :commit         => commit,
                :to             => deploy_notification_config['to'],
                :from           => deploy_notification_config['from'],
                :subject        => subject,
                :time           => time,
                :run_migrations => data[:run_migrations],
                :run_deploy     => data[:run_deploy]
    end
  
    execute "sending deploy notification" do
      user 'root'
      cwd "/data/#{app_name}/current"
      command "/usr/sbin/ssmtp #{deploy_notification_config['to']} < #{email_path}"
      ignore_failure true
    end
  end

end