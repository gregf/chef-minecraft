# This recipe downloads, builds, and copies spigot and craftbukkit jars to a sane location.
# You *HAVE* to do these builds - archiving them somewhere and reinstalling that jar file instead
# is very against the license.  That said - maybe let people add a dropbox URL as a node attribute,
# as a convenience for installing if someone's already done the  build?

jar_name = "BuildTools.jar"

# jar_name = minecraft_file(node['spigot_buildtools']['url'])

directory node['spigot']['build_dir'] do
  recursive true
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0755
  action :create
end

remote_file "#{node['spigot']['build_dir']}/#{jar_name}" do
  source node['spigot']['buildtools_url']
  #checksum node['spigot']['buildtools_checksum']
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create_if_missing
end

# This should already have been created by the default recipe, but just in case...
directory node['spigot']['install_dir'] do
  recursive true
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0755
  action :create
end

execute 'build spigot and craftbukkit' do
  cwd node['spigot']['build_dir']
  command 'java -jar BuildTools.jar --rev 1.8.8'
  creates "#{node['spigot']['build_dir']}/spigot-1.8.8.jar"
  not_if do ::File.exists?("#{node['spigot']['build_dir']}/spigot.jar") end 
end


## What was in the old spigot recipe.

#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2013, Greg Fitzgerald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'minecraft::bukkit'

template "#{node['minecraft']['install_dir']}/spigot.yml" do
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create
  notifies :restart, 'runit_service[minecraft]', :delayed if node['minecraft']['autorestart']
end

