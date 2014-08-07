require 'spec_helper'

describe 'g5stack::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['postgresql']['password']['postgres'] = ''
    end.converge(described_recipe)
  end

  it 'includes the apt recipe' do
    expect(chef_run).to include_recipe('apt::default')
  end

  it 'includes the wrapper postgresql recipe' do
    expect(chef_run).to include_recipe('g5-postgresql::default')
  end

  it 'includes the wrapper rbenv recipe' do
    expect(chef_run).to include_recipe('g5-rbenv::default')
  end

  it 'installs the git package' do
    expect(chef_run).to install_package('git')
  end

  it 'installs the nodejs package' do
    expect(chef_run).to install_package('nodejs')
  end

  it 'installs the vim package' do
    expect(chef_run).to install_package('vim')
  end

  it 'installs the sqlite dev package' do
    expect(chef_run).to install_package('libsqlite3-dev')
  end

  it 'installs the sqlite3 package' do
    expect(chef_run).to install_package('sqlite3')
  end

  it 'sets vim as the default editor' do
    expect(chef_run).to run_execute('Set default editor').with(
      command: 'update-alternatives --set editor /usr/bin/vim.basic'
    )
  end

  it 'includes the phantomjs default recipe' do
    expect(chef_run).to include_recipe('phantomjs::default')
  end
end
