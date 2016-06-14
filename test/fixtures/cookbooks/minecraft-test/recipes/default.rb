#
# Cookbook Name:: minecraft-test
# Recipe:: default
#

include_recipe 'minecraft'

minecraft_plugin 'http://dev.bukkit.org/media/files/778/990/AutoBackup.jar'
minecraft_plugin 'http://dev.bukkit.org/media/files/778/980/CmdSigns.jar'

minecraft_plugin 'AutoBackup' do
  url 'http://dev.bukkit.org/media/files/778/990/AutoBackup.jar'
  action :remove
end
