require 'spec_helper'

describe 'PhantomJS' do
  describe 'executable' do
    subject(:phantomjs) { command('which phantomjs') }

    it 'should be installed' do
      expect(phantomjs).to return_stdout(/\A\S+\Z/)
    end
  end

  describe 'fontconfig' do
    subject(:fontconfig) { package('fontconfig') }

    it 'should be installed' do
      expect(fontconfig).to be_installed
    end
  end

  describe 'libfreetype6' do
    subject(:freetype) { package('libfreetype6') }

    it 'should be installed' do
      expect(freetype).to be_installed
    end
  end
end
