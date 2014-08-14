include_recipe 'apt'
include_recipe 'g5-postgresql'
include_recipe 'g5-rbenv'
include_recipe 'phantomjs'

include_recipe 'nodejs'

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

[ 'vim', 'libsqlite3-dev', 'sqlite3'].each do |package_name|
  package package_name
end

execute 'Set default editor' do
  command "update-alternatives --set editor #{node['editor']['default']}"
end
