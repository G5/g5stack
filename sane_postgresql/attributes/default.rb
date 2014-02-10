set[:postgresql][:version] = '9.3'
set[:postgresql][:enable_pgdg_apt] = true

include_attribute 'postgresql'

default[:postgresql][:pg_hba] << {
  :type => 'local',
  :db => 'all',
  :user => 'vagrant',
  :addr => nil,
  :method => 'ident'
}
