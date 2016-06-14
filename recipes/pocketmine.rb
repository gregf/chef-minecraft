#
##
#
#  https://github.com/PocketMine/PocketMine-MP

include_recipe 'runit'
include_recipe 'minecraft::user'

include_recipe 'php::default'

git node['minecraft']['install_dir'] do
  repository node[:pocketmine][:git_repository]
  revision node[:pocketmine][:git_revision]
  action :sync
end

