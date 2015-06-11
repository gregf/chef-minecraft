#
# Cookbook Name:: minecraft
# Attributes:: default
#
# Copyright 2013, Greg Fitzgerald.
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

default['minecraft']['user']                = 'mcserver'
default['minecraft']['group']               = 'mcserver'
default['minecraft']['install_dir']         = '/srv/minecraft'
# Currently vanilla, bukkit, spigot
default['minecraft']['install_type']        = 'vanilla'

default['java']['install_flavor']           = 'default'

case node['minecraft']['install_type']
when 'vanilla'
  default['minecraft']['url']                 = 'https://s3.amazonaws.com/Minecraft.Download/versions/1.8.7/minecraft_server.1.8.7.jar'
  default['minecraft']['checksum']            = '5cf4a49762c996c94f6b8b119f1c80b4de3c12b2f5c53268801905bb7daa0644'
  default['minecraft']['server_opts']         = 'nogui'
when 'bukkit'
  default['minecraft']['url']                 = 'http://dl.bukkit.org/downloads/craftbukkit/get/02389_1.6.4-R2.0/craftbukkit.jar'
  default['minecraft']['checksum']            = '29c26ec69dcaf8c1214f90f5fa5609fc451aae5fe0d22fd4ce37a505684545b3'
  default['minecraft']['server_opts']         = '--noconsole --online-mode true'
when 'spigot'
  default['minecraft']['url']                 = 'http://ci.md-5.net/view/Spigot/job/Spigot/lastStableBuild/artifact/Spigot-Server/target/spigot.jar'
  default['minecraft']['checksum']            = '13abb884cb8f1bc8dfcd110fa3616f03b7ec5e23eb4b2e903b054c0ad23c4ac5'
  default['minecraft']['server_opts']         = ''
end

# Defaults to 40% of your total memory.
default['minecraft']['xms']                 = "#{(node['memory']['total'].to_i * 0.4).floor / 1024}M"
# Defaults to 60% of your total memory.
default['minecraft']['xmx']                 = "#{(node['memory']['total'].to_i * 0.6).floor / 1024}M"

# Additional options to be passed to java, for runit only
default['minecraft']['java-options']        = ''
default['minecraft']['init_style']          = 'runit'

default['minecraft']['ops']                 = []
default['minecraft']['banned-ips']          = []
default['minecraft']['banned-players']      = []
default['minecraft']['white-list']          = []

# Stop minecraft from binding to ipv6 by default
default['minecraft']['prefer_ipv4'] = true

# See the readme for an explanation
default['minecraft']['autorestart'] = true
