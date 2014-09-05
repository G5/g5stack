template '/home/vagrant/.gitconfig' do
  source 'gitconfig.erb'
  mode 0640
  owner 'vagrant'
  group 'vagrant'
  variables({
     user_name: node['git']['user']['name'],
     user_email: node['git']['user']['email'],
     color_ui: node['git']['color']['ui'],
     push_default: node['git']['push']['default']
  })
end
