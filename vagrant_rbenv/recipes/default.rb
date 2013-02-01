include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"

execute "Set rbenv directory group permissions" do
  command "chmod -R 775 /opt/rbenv"
  action :run
end
