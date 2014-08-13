require 'spec_helper'

describe 'nodejs' do
  describe 'package' do
    subject(:node) { package('nodejs') }

    it 'should be installed' do
      expect(node).to be_installed
    end
  end

  describe 'npm' do
    subject(:npm) { command('npm --help') }

    it 'should be installed' do
      expect(npm).to return_stdout(/Usage: npm/)
    end
  end

  describe 'ember cli' do
    subject(:ember) { command('ember --help') }

    it 'should be installed' do
      expect(ember).to return_stdout(/Available commands in ember-cli/)
    end
  end

  describe 'bower' do
    subject(:bower) { command('sudo -u vagrant bower --help --config.interactive=false') }

    it 'should be installed' do
      expect(bower).to return_stdout(/bower <command>/)
    end
  end
end
