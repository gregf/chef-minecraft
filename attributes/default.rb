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
# Currently vanilla, bukkit, spigot
default['minecraft']['install_type']        = 'vanilla'

default['java']['install_flavor']           = 'openjdk'

case node['minecraft']['install_type']
when 'vanilla'
  default['minecraft']['version']             = '1.8.1'
  default['minecraft']['url']                 = "https://s3.amazonaws.com/Minecraft.Download/versions/#{node['minecraft']['version']}/minecraft_server.#{node['minecraft']['version']}.jar"
  default['minecraft']['checksum']            = 'ef5f5a1a1a78087859b18153acf97efc6ecb12540ac08d82b9c95024249b9845'
  default['minecraft']['server_opts']         = 'nogui'
when 'bukkit'
  default['minecraft']['version']             = '1.6.4'
  default['minecraft']['url']                 = "http://dl.bukkit.org/downloads/craftbukkit/get/02389_#{node['minecraft']['version']}-R2.0/craftbukkit.jar"
  default['minecraft']['checksum']            = '29c26ec69dcaf8c1214f90f5fa5609fc451aae5fe0d22fd4ce37a505684545b3'
  default['minecraft']['server_opts']         = '--noconsole --online-mode true'
when 'spigot'
  default['minecraft']['url']                 = 'http://ci.md-5.net/view/Spigot/job/Spigot/lastStableBuild/artifact/Spigot-Server/target/spigot.jar'
  default['minecraft']['checksum']            = '13abb884cb8f1bc8dfcd110fa3616f03b7ec5e23eb4b2e903b054c0ad23c4ac5'
  default['minecraft']['server_opts']         = ''
end

# Defaults to 40% of your total memory.
default['minecraft']['xms']                 = "#{(total_memory * 0.4).floor / 1024}M"
# Defaults to 60% of your total memory.
default['minecraft']['xmx']                 = "#{(total_memory * 0.6).floor / 1024}M"

# Additional options to be passed to java, for runit only
default['minecraft']['java-options']        = ''

minecraft_server_files.each do |file|
  default['minecraft'][file]                 = []
end

# Stop minecraft from binding to ipv6 by default
default['minecraft']['prefer_ipv4'] = true

# See the readme for an explanation
default['minecraft']['autorestart'] = true

case node['platform_family']
when 'windows'
  # Prevent errors from installing chocolatey on first run until the
  # chocolatey cookbook is fixed to handle recent chocolatey changes
  default['chocolatey']['upgrade'] = false
  default['chocolatey']['Uri'] = 'https://chocolatey.org/Install-LastPoshClient.ps1'

  default['minecraft']['init_style']          = 'windows_task'
  default['minecraft']['install_dir']         = "#{ENV['programdata']}/minecraft"
  default['minecraft']['user_password']       = 'Pass@word1'
else
  default['minecraft']['init_style']          = 'runit'
  default['minecraft']['install_dir']         = '/srv/minecraft'
end
