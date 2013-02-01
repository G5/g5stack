default[:postgresql][:version] = "9.1"
default[:postgresql][:pg_hba] << {
  :type => 'local',
  :db => 'all',
  :user => 'vagrant',
  :addr => nil,
  :method => 'ident'
}
