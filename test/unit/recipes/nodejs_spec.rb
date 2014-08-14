require 'spec_helper'

describe 'g5stack::nodejs' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end

  it 'includes the nodejs default recipe' do
    expect(chef_run).to include_recipe('nodejs::default')
  end

  it 'installs the ember-cli node package' do
    expect(chef_run).to install_nodejs_npm('ember-cli')
  end

  it 'installs the bower node package' do
    expect(chef_run).to install_nodejs_npm('bower')
  end

  it 'makes the node_modules directory writable by the group' do
    expect(chef_run).to run_execute('chmod -R 2775 /usr/lib/node_modules')
  end

  it 'assigns the node_modules directory to the vagrant group' do
    expect(chef_run).to run_execute('chown -R nobody:vagrant /usr/lib/node_modules')
  end

  it 'clears the npm cache' do
    expect(chef_run).to run_execute('npm cache clean')
  end
end
