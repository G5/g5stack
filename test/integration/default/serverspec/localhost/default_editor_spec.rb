require 'spec_helper'

describe 'Default editor' do
  describe 'vim package' do
    subject(:vim) { package('vim') }

    it 'should be installed' do
      expect(vim).to be_installed
    end
  end

  describe 'default editor' do
    subject(:editor) { command('update-alternatives --query editor') }

    it 'should be set to use vim' do
      expect(editor).to return_stdout(/Value: \/usr\/bin\/vim.basic/)
    end
  end
end
