set[:postgresql][:version] = '9.3'
set[:postgresql][:enable_pgdg_apt] = true

include_attribute 'postgresql'

default[:postgresql][:config][:ssl_key_file]  = '/etc/ssl/private/ssl-cert-snakeoil.key'
default[:postgresql][:config][:ssl_cert_file] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'

# The postgresql recipe has a tricky bug where it doesn't consistently
# use the 9.3 config syntax, due to the fact that it casts the version
# string to a float for comparison.
default[:postgresql][:config].delete(:unix_socket_directory)
default[:postgresql][:config][:unix_socket_directories] = '/var/run/postgresql'

default[:postgresql][:pg_hba] << {
  :type => 'local',
  :db => 'all',
  :user => 'vagrant',
  :addr => nil,
  :method => 'ident'
}
