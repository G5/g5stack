require 'spec_helper'

describe 'rbenv' do
  let(:pre_command) { 'sudo -u vagrant /bin/bash --login' }

  describe 'executable' do
    subject(:rbenv) { command("#{pre_command} which rbenv") }

    it 'should be installed' do
      expect(rbenv).to return_stdout('/opt/rbenv/bin/rbenv')
    end
  end

  describe 'directory' do
    subject(:rbenv) { file('/opt/rbenv/') }

    it 'should be in the rbenv group' do
      expect(rbenv).to be_grouped_into('rbenv')
    end

    it 'should be readable by the vagrant user' do
      expect(rbenv).to be_readable.by_user('vagrant')
    end

    it 'should be writable by the vagrant user' do
      expect(rbenv).to be_writable.by_user('vagrant')
    end

    it 'should be executable by the vagrant user' do
      expect(rbenv).to be_executable.by_user('vagrant')
    end
  end

  describe 'default ruby executable' do
    subject(:ruby) { command("#{pre_command} which ruby") }

    it 'should be managed by rbenv' do
      expect(ruby).to return_stdout('/opt/rbenv/shims/ruby')
    end
  end

  describe 'default ruby version' do
    subject(:ruby_version) { command("#{pre_command} ruby -v") }

    it 'should be correct' do
      expect(ruby_version).to return_stdout(/ruby 2\.1\.2/)
    end
  end

  describe 'bundler' do
    subject(:bundler) { command("#{pre_command} which bundle") }

    it 'should be installed by default' do
      expect(bundler).to return_stdout('/opt/rbenv/shims/bundle')
    end
  end

  describe 'PATH env var' do
    subject(:path) { command("#{pre_command} -c printenv") }

    it 'should favor local project binstubs over rbenv shims' do
      expect(path).to return_stdout(/PATH=bin\:.*\/opt\/rbenv\/shims/)
    end
  end

  describe 'rubygems' do
    subject(:rubygems) { command("#{pre_command} gem install rubygems-update") }

    it 'should allow the vagrant user to install gems' do
      expect(rubygems).to return_stdout(/1 gem installed/)
    end
  end
end
