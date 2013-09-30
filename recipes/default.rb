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

include_recipe 'java::default'

include_recipe 'minecraft::user'

directory node['minecraft']['install_dir'] do
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode '0755'
  action :create
  recursive true
end

include_recipe 'minecraft::jar'
include_recipe 'minecraft::service'

%w[ops.txt server.properties banned-ips.txt
   banned-players.txt white-list.txt].each do |template|
  template "#{node['minecraft']['install_dir']}/#{template}" do
    source "#{template}.erb"
    owner node['minecraft']['user']
    group node['minecraft']['group']
    mode 0644
    action :create
    notifies :reload, 'service[minecraft]' if node['minecraft']['autorestart']
  end
end
