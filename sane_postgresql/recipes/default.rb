# Intended for postgres, who completely ignores it, but still a good idea.
template "/etc/default/locale" do
  source "locale"
  mode "0644"
end

include_recipe "postgresql::server"

execute "tear down postgres to rebuild it with UTF-8 encoding by default" do
  user "root"
  command %{
    touch /home/vagrant/.encoding-fixed
    cp /etc/postgresql/9.1/main/pg_hba.conf /tmp/
    cp /etc/postgresql/9.1/main/postgresql.conf /tmp/
    pg_dropcluster --stop 9.1 main
    pg_createcluster --start -e UTF-8 9.1 main
    cp /tmp/pg_hba.conf /etc/postgresql/9.1/main/
    cp /tmp/postgresql.conf /etc/postgresql/9.1/main/
    /etc/init.d/postgresql restart
    sudo -u postgres psql -c "CREATE USER vagrant CREATEDB SUPERUSER"
  }

  not_if { File.exist?("/home/vagrant/.encoding-fixed") }
end
