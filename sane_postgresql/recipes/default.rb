template '/etc/default/locale' do
  source 'locale'
  mode '0644'
end

include_recipe 'postgresql::apt_pgdg_postgresql'
include_recipe 'postgresql::server'

execute 'Create a vagrant db user' do
  command 'sudo -u postgres psql -c "CREATE USER vagrant CREATEDB SUPERUSER"'
end
