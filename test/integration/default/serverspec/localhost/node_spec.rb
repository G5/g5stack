require 'spec_helper'

describe 'nodejs' do
  let(:pre_command) { 'sudo -iu vagrant' }

  describe 'package' do
    subject(:node) { package('nodejs') }

    it { is_expected.to be_installed }
  end

  describe 'npm' do
    subject(:npm) { command("#{pre_command} npm --help") }

    its(:stdout) { is_expected.to match(/Usage: npm/) }
  end

  describe 'ember cli' do
    subject(:ember) { command("#{pre_command} ember --help") }

    its(:stdout) { is_expected.to match(/Available commands in ember-cli/) }
  end

  describe 'bower' do
    subject(:bower) { command("#{pre_command} bower --help --config.interactive=false") }

    its(:stdout) { is_expected.to match(/bower <command>/) }
  end

  describe 'grunt-cli' do
    subject(:grunt_cli) { command("#{pre_command} grunt -v") }

    its(:stdout) { is_expected.to match(/grunt-cli: The grunt command line interface/) }
  end

  describe 'global prefix dir' do
    subject(:node_modules) { file('/home/vagrant/.node') }

    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by('nobody') }
    it { is_expected.to be_grouped_into('vagrant') }
    it { is_expected.to be_writable.by('group') }
  end

  describe 'npm cache' do
    subject(:npm_cache) { file('/home/vagrant/.npm') }

    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by('vagrant') }
    it { is_expected.to be_grouped_into('vagrant') }

    it 'should be empty' do
      expect(command('ls /home/vagrant/.npm | wc -l').stdout).to match(/^0$/)
    end
  end
end
