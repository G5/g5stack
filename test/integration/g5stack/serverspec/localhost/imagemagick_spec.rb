require 'spec_helper'

describe 'ImageMagick' do
  describe command('which convert') do
    its(:stdout) { is_expected.to match(/\A\S+\Z/) }
  end

  describe package('imagemagick') do
    it { is_expected.to be_installed }
  end

  describe package('libmagickwand-dev') do
    it { is_expected.to be_installed }
  end
end
