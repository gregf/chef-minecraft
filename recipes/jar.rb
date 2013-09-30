#
# Cookbook Name:: minecraft
# Recipe:: jar
#
# Copyright 2013, Sean Escriva
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node['minecraft']['mark2']['flavor']
  log "assuming mark2 init style required for using alternate flavors"
  node.override['minecraft']['init_style'] = 'mark2'

  include_recipe "minecraft::mark2"

  execute "fetching flavored minecraft" do
    cwd node['minecraft']['install_dir']
    command "mark2 jar-get #{node['minecraft']['mark2']['flavor']}"
    not_if { File.exists? "#{node['minecraft']['install_dir']}/#{node['minecraft']['mark2']['flavor']}.jar" }
  end

  # annoying, but done so we have a known filename for idempotency
  execute "rename fetched jar" do
    cwd node['minecraft']['install_dir']
    command "mv *.jar #{node['minecraft']['mark2']['flavor']}.jar"
    not_if { File.exists? "#{node['minecraft']['install_dir']}/#{node['minecraft']['mark2']['flavor']}.jar" }
  end

  node.override['minecraft']['mark2']['properties']['jar-path'] = "*.jar"

else

  node.default['minecraft']['jar_name'] = jar_name

  jar_name = "#{node['minecraft']['jar']}.#{node['minecraft']['version']}.jar"
  minecraft_jar = "#{Chef::Config['file_cache_path']}/#{jar_name}"

  source_url = "#{node['minecraft']['base_url']}/#{node['minecraft']['version']}/#{jar_name}"
  log "Using #{jar_name}, stored locally as #{minecraft_jar} and fetched from #{source_url}"

  remote_file minecraft_jar do
    source source_url
    checksum node['minecraft']['checksum']
    owner node['minecraft']['user']
    group node['minecraft']['group']
    mode 0644
    action :create_if_missing
  end

  execute 'copy-minecraft_server.jar' do
    cwd node['minecraft']['install_dir']
    command "cp -p #{minecraft_jar} ."
    creates "#{node['minecraft']['install_dir']}/#{jar_name}"
  end

end
