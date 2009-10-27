execute "testing" do
  command %Q{
    echo "i ran at #{Time.now}" >> /root/cheftime
  }
end

begin
  require 'active_support'
rescue LoadError
  execute "installing activesupport" do
    user 'root'
    command 'gem install activesupport --no-rdoc --no-ri'
  end
  require 'active_support'
end
  
execute "making /etc/chef/dna.json accessible" do
  user 'root'
  command 'chmod a+r /etc/chef/dna.json'
end

IO.readlines('/etc/engine_yard_cloud_custom_recipes').map(&:strip).each do |name|
  require_recipe name
end if File.readable?('/etc/engine_yard_cloud_custom_recipes')
