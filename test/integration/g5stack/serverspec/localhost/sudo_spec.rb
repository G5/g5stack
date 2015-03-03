require 'spec_helper'

describe 'sudo' do
  describe package('sudo') do
    it { is_expected.to be_installed }
  end

  describe file('/etc/sudoers.d/vagrant') do
    it { is_expected.to be_mode('440') }
    its(:content) { should match(/vagrant ALL=\(ALL\) NOPASSWD:ALL/) }
  end
end
