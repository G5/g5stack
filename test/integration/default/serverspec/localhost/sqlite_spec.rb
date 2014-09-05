require 'spec_helper'

describe 'SQLite' do
  describe 'main package' do
    let(:sqlite) { package('sqlite3') }

    it 'should be installed' do
      expect(sqlite).to be_installed
    end
  end

  describe 'development library' do
    let(:dev_lib) { package('libsqlite3-dev') }

    it 'should be installed' do
      expect(dev_lib).to be_installed
    end
  end
end
