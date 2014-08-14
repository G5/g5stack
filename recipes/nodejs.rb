include_recipe 'nodejs::default'

nodejs_npm 'ember-cli' do
  group 'vagrant'
end

nodejs_npm 'bower' do
  group 'vagrant'
end

execute 'Set node_modules directory group permissions' do
  command 'chmod -R 2775 /usr/lib/node_modules'
end

execute 'Set node_modules directory ownership' do
  command 'chown -R nobody:vagrant /usr/lib/node_modules'
end

execute 'Clear npm cache' do
  command 'npm cache clean'
end
