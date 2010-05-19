# needs activesupport 2!
active_support_path = [ '/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.5/lib', '/usr/lib/ruby/gems/1.8/gems/activesupport-2.3.4/lib' ].detect { |active_support_path| File.readable? active_support_path }
$:.unshift active_support_path
$:.unshift File.join(active_support_path, 'active_support')

require 'active_support'
  
execute "making /etc/chef/dna.json accessible" do
  user 'root'
  command 'chmod a+r /etc/chef/dna.json'
end

IO.readlines('/etc/engine_yard_cloud_custom_recipes').map(&:strip).each do |name|
  require_recipe name
end if File.readable?('/etc/engine_yard_cloud_custom_recipes')
