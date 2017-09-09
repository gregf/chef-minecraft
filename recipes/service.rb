#
# Cookbook Name:: minecraft
# Recipe:: service
#
# Copyright 2013, Greg Fitzgerald
# Copyright 2013, Sean Escriva
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

case node['minecraft']['init_style']
when 'runit'
  runit_service 'minecraft' do
    sv_bin 'sleep 5 && /usr/bin/sv'
    options({
      install_dir: node['minecraft']['install_dir'],
      xms: node['minecraft']['xms'],
      xmx: node['minecraft']['xmx'],
      prefer_ipv4: node['minecraft']['prefer_ipv4'],
      user: node['minecraft']['user'],
      group: node['minecraft']['group'],
      java_opts: node['minecraft']['java-options'],
      server_opts: node['minecraft']['server_opts'],
      jar_name: minecraft_file(node['minecraft']['url']),
    }.merge(params))
    action %i(enable start)
  end
end
