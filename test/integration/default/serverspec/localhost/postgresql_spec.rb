require 'spec_helper'

describe 'PostgreSQL' do
  describe 'service' do
    subject(:postgres) { service('postgresql') }

    it 'should be enabled' do
      expect(postgres).to be_enabled
    end
  end

  describe 'process' do
    subject(:postgres) { process('postgres') }

    it 'should be running' do
      expect(postgres).to be_running
    end

    it 'should be owned by the postgres user' do
      expect(postgres.user).to eq('postgres')
    end
  end

  describe 'default port' do
    subject(:default_port) { port(5432) }

    it 'should be listening' do
      expect(default_port).to be_listening
    end
  end

  describe 'client version' do
    subject(:client_version) { command('psql --version') }

    it 'should be the correct version' do
      expect(client_version).to return_stdout(/psql \(PostgreSQL\) 9\.3/)
    end
  end

  describe 'server version' do
    subject(:server_version) { command('sudo -u postgres psql -c "select version();"') }

    it 'should be the correct version' do
      expect(server_version).to return_stdout(/PostgreSQL 9\.3/)
    end
  end

  describe 'vagrant db role' do
    subject(:vagrant_role) { command("sudo -u postgres psql -c \"SELECT rolname FROM pg_roles WHERE rolname='vagrant'\"") }

    it 'should have been created' do
      expect(vagrant_role).to return_stdout(/vagrant/)
    end
  end
end
