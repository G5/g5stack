default[:postgresql][:version] = '9.3'
default[:postgresql][:enable_pgdg_apt] = true
default[:postgresql][:client][:packages] = ["postgresql-client-#{node[:postgresql][:version]}","libpq-dev"]
default[:postgresql][:server][:packages] = ["postgresql-#{node[:postgresql][:version]}"]
default[:postgresql][:contrib][:packages] = ["postgresql-contrib-#{node[:postgresql][:version]}"]
default[:postgresql][:dir] = "/etc/postgresql/#{node[:postgresql][:version]}/main"
default[:postgresql][:config][:data_directory] = "/var/lib/postgresql/#{node[:postgresql][:version]}/main"
default[:postgresql][:config][:hba_file] = "/etc/postgresql/#{node[:postgresql][:version]}/main/pg_hba.conf"
default[:postgresql][:config][:ident_file] = "/etc/postgresql/#{node[:postgresql][:version]}/main/pg_ident.conf"
default[:postgresql][:config][:external_pid_file] = "/var/run/postgresql/#{node[:postgresql][:version]}-main.pid"
default[:postgresql][:config].delete(:unix_socket_directory)
default[:postgresql][:config][:unix_socket_directories] = '/var/run/postgresql'
default[:postgresql][:config][:ssl_key_file]  = '/etc/ssl/private/ssl-cert-snakeoil.key'
default[:postgresql][:config][:ssl_cert_file] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'

default[:postgresql][:pg_hba] << {
  :type => 'local',
  :db => 'all',
  :user => 'vagrant',
  :addr => nil,
  :method => 'ident'
}
