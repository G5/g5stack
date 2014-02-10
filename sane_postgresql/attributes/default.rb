include_attribute 'postgresql'

default[:postgresql][:version] = '9.3'
default[:postgresql][:pg_hba] << {
  :type => 'local',
  :db => 'all',
  :user => 'vagrant',
  :addr => nil,
  :method => 'ident'
}
