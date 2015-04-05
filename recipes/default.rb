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

include_recipe 'minecraft::java'
include_recipe 'minecraft::user'

directory node['minecraft']['install_dir'] do
  recursive true
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0755
  action :create
end

jar_name = minecraft_file(node['minecraft']['url'])

remote_file "#{node['minecraft']['install_dir']}/#{jar_name}" do
  source node['minecraft']['url']
  checksum node['minecraft']['checksum']
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create_if_missing
end

include_recipe 'minecraft::service'
include_recipe "minecraft::#{node['minecraft']['install_type']}"

template "#{node['minecraft']['install_dir']}/server.properties" do
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create
  notifies :restart, node['minecraft']['notify_resource'], :delayed if node['minecraft']['autorestart']
end

minecraft_server_files.each do |f|
  file "#{node['minecraft']['install_dir']}/#{f}.#{minecraft_file_format}" do
    owner node['minecraft']['user']
    group node['minecraft']['group']
    mode 0644
    action :create
    content node['minecraft'][f].join("\n") + "\n"
    notifies :restart, node['minecraft']['notify_resource'], :delayed if node['minecraft']['autorestart']
  end
end

file "#{node['minecraft']['install_dir']}/eula.txt" do
  content "eula=#{node['minecraft']['accept_eula']}\n"
  mode 0644
  action :create
  notifies :restart, node['minecraft']['notify_resource'], :delayed if node['minecraft']['autorestart']
end
