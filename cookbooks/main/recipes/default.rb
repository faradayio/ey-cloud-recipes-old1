execute "making /etc/chef/dna.json accessible" do
  user 'root'
  command 'chmod a+r /etc/chef/dna.json'
end

IO.readlines('/etc/engine_yard_cloud_custom_recipes').each do |name|
  require_recipe name.strip
end if File.readable?('/etc/engine_yard_cloud_custom_recipes')
