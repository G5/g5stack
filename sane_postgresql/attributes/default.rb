set[:postgresql][:version] = '9.3'
set[:postgresql][:enable_pgdg_apt] = true

include_attribute 'postgresql'

default[:postgresql][:config][:ssl_key_file]  = '/etc/ssl/private/ssl-cert-snakeoil.key'
default[:postgresql][:config][:ssl_cert_file] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'

default[:postgresql][:pg_hba] << {
  :type => 'local',
  :db => 'all',
  :user => 'vagrant',
  :addr => nil,
  :method => 'ident'
}
