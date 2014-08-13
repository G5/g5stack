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

  describe '/usr/lib/node_modules' do
    subject(:node_modules) { file('/usr/lib/node_modules') }

    it 'should be a directory' do
      expect(node_modules).to be_directory
    end

    it 'should be owned by nobody' do
      expect(node_modules).to be_owned_by('nobody')
    end

    it 'should be grouped into vagrant' do
      expect(node_modules).to be_grouped_into('vagrant')
    end

    it 'should be writable by the group' do
      expect(node_modules).to be_writable.by('group')
    end
  end

  describe '/home/vagrant/.npm' do
    subject(:local_npm) { file('/home/vagrant/.npm') }

    it 'should be a directory' do
      expect(local_npm).to be_directory
    end

    it 'should be owned by vagrant' do
      expect(local_npm).to be_owned_by('vagrant')
    end

    it 'should be grouped into vagrant' do
      expect(local_npm).to be_grouped_into('vagrant')
    end
  end

  describe '/home/vagrant/.config' do
    subject(:local_config) { file('/home/vagrant/.config') }

    it 'should be a directory' do
      expect(local_config).to be_directory
    end

    it 'should be owned by vagrant' do
      expect(local_config).to be_owned_by('vagrant')
    end

    it 'should be grouped into vagrant' do
      expect(local_config).to be_grouped_into('vagrant')
    end
  end
end
