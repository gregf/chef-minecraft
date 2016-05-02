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

# The following four options are what it takes to build and install spigot properly.

default['spigot']['build_dir'] = '/srv/spigot_build'
default['spigot']['buildtools_url'] = 'https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar'
default['spigot']['buildtools_checksum'] = ''
default['spigot']['install_dir'] = '/srv/minecraft'

# The following are all the config bits that came from the old spigot config.
#
default['minecraft']['spigot']['config'].tap do |spigot_config|
  spigot_config['config-version'] = 5
  spigot_config['commands'].tap do |commands|
    commands['replace-commands'] = %w(setblock summon testforblock tellraw)
    commands['tab-complete'] = true
    commands['silent-commandblock-console'] = true
    commands['spam-exclusions'] = %w(/skill)
    commands['log'] = true
  end

  spigot_config['settings'].tap do |settings|
    settings['netty-threads'] = 4
    settings['timeout-time'] = 60
    settings['restart-on-crash'] = true
    settings['restart-script'] = './start.sh'
    settings['player-shuffle'] = 0
    settings['late-bind'] = false
    settings['bungeecord'] = false
    settings['filter-creative-items'] = true
    settings['sample-count'] = 12
  end

  spigot_config['messages'].tap do |messages|
    messages['restart'] = 'Server is restarting'
    messages['whitelist'] = 'You are not whitelisted on this server!'
    messages['unknown-commands'] = 'Unknown command. Type "/help" for help.'
    messages['server-full'] = 'The server is full!'
    messages['outdated-client'] = 'Outdated client! Please use {}'
    messages['outdated-server'] = "Outdated server! I'm still on {0}"
  end

  spigot_config['stats'].tap do |stats|
    stats['disable-saving'] = false
    stats['forced-stats'] = {}
  end

  spigot_config['world-settings']['default'].tap do |world_settings|
    world_settings['verbose'] = true
    world_settings['growth'].tap do |growth|
      growth['cactus-modifier'] = 100
      growth['cane-modifier'] = 100
      growth['melon-modifier'] = 100
      growth['mushroom-modifier'] = 100
      growth['pumpkin-modifier'] = 100
      growth['sapling-modifier'] = 100
      growth['wheat-modifier'] = 100
    end
    world_settings['anti-xray'].tap do |anti_xray|
      anti_xray['enabled'] = true
      anti_xray['engine-mode'] = 1
      anti_xray['hide-blocks'] = [14, 15, 16, 21, 48, 49, 54, 56, 73, 74, 82, 129, 130]
      anti_xray['replace-blocks'] = [1, 5]
    end
    world_settings['entity-activation-range'].tap do |entity_activation_range|
      entity_activation_range['players'] = 48
      entity_activation_range['animals'] = 48
      entity_activation_range['monsters'] = 48
      entity_activation_range['misc'] = 32
      entity_activation_range['other'] = 64
    end
    world_settings['ticks-per'].tap do |ticks_per|
      ticks_per['hopper-transfer'] = 8
      ticks_per['hopper-check'] = 8
    end
    world_settings['random-light-updates'] = false
    world_settings['save-structure-info'] = true
    world_settings['max-bulk-chunks'] = 5
    world_settings['max-entity-collisions'] = 8
    world_settings['view-distance'] = 10
    world_settings['chunks-per-tick'] = 650
    world_settings['clear-tick-list'] = false
    world_settings['merge-radius'].tap do |merge_radius|
      merge_radius['exp'] = 3.0
      merge_radius['item'] = 2.5
    end
    world_settings['mob-spawn-range'] = 4
    world_settings['nerf-spawner-mobs'] = false
    world_settings['arrow-despawn-rate'] = 1200
    world_settings['item-despawn-rate'] = 6000
    world_settings['enable-zombie-pigmen-portal-spawns'] = true
    world_settings['zombie-aggressive-towards-villager'] = true
  end
end
