require 'spec_helper'

describe 'git' do
  describe 'package' do
    subject(:git) { package('git') }

    it 'should be installed' do
      expect(git).to be_installed
    end
  end

  describe 'config' do
    subject(:git_config) { command("git config #{config_opt}") }

    describe 'user.name' do
      let(:config_opt) { 'user.name' }

      it 'should be set' do
        expect(git_config).to return_stdout(/\A\S+\Z/)
      end
    end

    describe 'user.email' do
      let(:config_opt) { 'user.email' }

      it 'should be set' do
        expect(git_config).to return_stdout(/\A\S+\Z/)
      end
    end

    describe 'color.ui' do
      let(:config_opt) { 'color.ui' }

      it 'should be set to auto' do
        expect(git_config).to return_stdout('auto')
      end
    end

    describe 'push.default' do
      let(:config_opt) { 'push.default' }

      it 'should be set to current' do
        expect(git_config).to return_stdout('current')
      end
    end
  end
end
