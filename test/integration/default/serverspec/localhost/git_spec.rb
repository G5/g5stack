require 'spec_helper'

describe 'git' do
  describe 'package' do
    subject(:git) { package('git') }

    it 'should be installed' do
      expect(git).to be_installed
    end
  end
end
