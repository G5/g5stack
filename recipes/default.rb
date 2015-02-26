include_recipe 'apt'
include_recipe 'g5-postgresql'
include_recipe 'g5-rbenv'
include_recipe 'g5-nodejs'
include_recipe 'phantomjs'
include_recipe 'redisio'
include_recipe 'redisio::enable'
include_recipe 'imagemagick::devel'

[ 'vim', 'libsqlite3-dev', 'sqlite3'].each do |package_name|
  package package_name
end

execute 'Set default editor' do
  command "update-alternatives --set editor #{node['editor']['default']}"
end
