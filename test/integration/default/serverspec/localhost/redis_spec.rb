require 'spec_helper'

describe 'Redis' do
  describe 'service' do
    subject(:redis) { service('redis6379') }

    it 'should be enabled' do
      expect(redis).to be_enabled
    end
  end

  describe 'process' do
    subject(:redis) { process('redis-server') }

    it 'should be running' do
      expect(redis).to be_running
    end

    it 'should be owned by the redis user' do
      expect(redis.user).to eq('redis')
    end
  end

  describe 'default port' do
    subject(:default_port) { port(6379) }

    it 'should be listening' do
      expect(default_port).to be_listening
    end
  end
end
