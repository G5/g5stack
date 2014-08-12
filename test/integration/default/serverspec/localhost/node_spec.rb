require 'spec_helper'

describe 'nodejs' do
  describe 'package' do
    subject(:node) { package('nodejs') }

    it 'should be installed' do
      expect(node).to be_installed
    end
  end

  describe 'npm executable' do
    subject(:npm) { command('npm --help') }

    it 'should be installed' do
      expect(npm).to return_stdout(/Usage: npm/)
    end
  end

  describe 'ember-cli' do
    subject(:ember_cli) { command('npm list -g ember-cli') }

    it 'should be installed' do
      expect(ember_cli).to return_exit_status(0)
    end
  end

  describe 'ember executable' do
    subject(:ember) { command('ember --help') }

    it 'should be installed' do
      expect(ember).to return_stdout(/Available commands in ember-cli/)
    end
  end
end
