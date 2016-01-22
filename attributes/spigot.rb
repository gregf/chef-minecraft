#
# Cookbook Name:: minecraft
# Attributes:: spigot
#
# Copyright 2016, Elijah Wright
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

default['spigot']['build_dir']         = '/srv/spigot_build'

default['spigot']['buildtools_url']         = 'https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar'
default['spigot']['buildtools_checksum']            = ''

default['spigot']['install_dir'] = '/srv/minecraft'

