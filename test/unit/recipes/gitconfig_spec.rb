require 'spec_helper'

describe 'g5stack::gitconfig' do
  let(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates a .gitconfig with the correct permissions' do
    expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
      mode: 0640,
      owner: 'vagrant',
      group: 'vagrant'
    )
  end

  context 'with default config' do
    it 'passes in the default user config to gitconfig template' do
      expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
        variables: hash_including(user_name: 'vagrant', user_email: 'vagrant')
      )
    end

    it 'passes in the default color config to gitconfig template' do
      expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
        variables: hash_including(color_ui: 'auto')
      )
    end

    it 'passes in the default push config to gitconfig template' do
      expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
        variables: hash_including(push_default: 'current')
      )
    end
  end

  context 'with config overrides' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['git']['user']['name'] = user_name
        node.set['git']['user']['email'] = user_email
        node.set['git']['color']['ui'] = color_ui
        node.set['git']['push']['default'] = push_default
      end.converge(described_recipe)
    end

    let(:user_name) { 'whatever' }
    let(:user_email) { 'foo@bar.net' }
    let(:color_ui) { 'false' }
    let(:push_default) { 'matching' }

    it 'passes in the correct user config to gitconfig template' do
      expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
        variables: hash_including(user_name: user_name, user_email: user_email)
      )
    end

    it 'passes in the correct color config to gitconfig template' do
      expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
        variables: hash_including(color_ui: color_ui)
      )
    end

    it 'passes in the correct push config to gitconfig template' do
      expect(chef_run).to create_template('/home/vagrant/.gitconfig').with(
        variables: hash_including(push_default: push_default)
      )
    end
  end
end
