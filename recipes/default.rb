include_recipe 'apt'
include_recipe 'g5-postgresql'
include_recipe 'g5-rbenv'
include_recipe 'phantomjs'

include_recipe 'nodejs'

execute 'Set node_modules directory group permissions' do
  command 'chmod -R 775 /usr/lib/node_modules'
end

execute 'Set node_modules directory ownership' do
  command 'chown -R nobody:vagrant /usr/lib/node_modules'
end

execute 'Set local npm directory ownership' do
  command 'chown -R vagrant:vagrant /home/vagrant/.npm'
end

nodejs_npm 'ember-cli'
nodejs_npm 'bower'

execute 'Set bower config directory ownership' do
  command 'chown -R vagrant:vagrant /home/vagrant/.config'
end

[ 'vim', 'libsqlite3-dev', 'sqlite3'].each do |package_name|
  package package_name
end

execute 'Set default editor' do
  command "update-alternatives --set editor #{node['editor']['default']}"
end
