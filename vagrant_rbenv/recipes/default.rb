include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

# Should probably fix the apparently busted rbenv recipe.
execute "Set rbenv directory group permissions" do
  command "chmod -R 775 /opt/rbenv"
  action :run
end

# Should probably fix the apparently busted rbenv recipe.
execute "Add vagrant user to the rbenv group" do
  command "sudo usermod -a -G rbenv vagrant"
end
