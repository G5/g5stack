include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

# Install a global ruby and bundler
rbenv_ruby node[:rbenv][:ruby_version] do
  global true
end

rbenv_gem "bundler" do
  ruby_version node[:rbenv][:ruby_version]
end

# Should probably fix the apparently busted rbenv recipe.
execute "Set rbenv directory group permissions" do
  command "chmod -R 775 /opt/rbenv"
  action :run
end

# Should probably fix the apparently busted rbenv recipe.
execute "Add vagrant user to the rbenv group" do
  command "sudo usermod -a -G rbenv vagrant"
end
