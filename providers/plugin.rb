# Author:: Greg Fitzgerald (greg@gregf.org)
# Copyright:: Copyright (c) 2014 Greg Fitzgerald
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

action :install do
  plugin_jar = minecraft_file(new_resource.url)

  if node['minecraft']['install_type'] == 'vanilla'
    Chef::Log.warn('The minecraft_plugin LWRP only works if your install_type is set to bukkit or spigot')
  end

  directory "#{node['minecraft']['install_dir']}/plugins" do
    recursive true
    owner node['minecraft']['user']
    group node['minecraft']['group']
    mode 0755
    action :create
  end

  r = remote_file "#{node['minecraft']['install_dir']}/plugins/#{plugin_jar}" do
    Chef::Log.debug('DEBUG: new_resource.url')
    source new_resource.url
    checksum new_resource.checksum
    owner node['minecraft']['user']
    group node['minecraft']['group']
    mode 0644
    notifies :restart, 'runit_service[minecraft]', :delayed
    case new_resource.update
    when false
      action :create_if_missing
    when true
      action :create
    end
  end
  new_resource.updated_by_last_action(r.updated_by_last_action?)
end

action :remove do
  plugin_jar = minecraft_file(new_resource.url)

  f = file plugin_jar do
    path "#{node['minecraft']['install_dir']}/plugins/#{plugin_jar}"
    notifies :restart, 'runit_service[minecraft]', :delayed
    action :delete
  end
  new_resource.updated_by_last_action(f.updated_by_last_action?)
end
