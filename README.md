# Minecraft
[![Build Status](https://travis-ci.org/gregf/chef-minecraft.svg?branch=master)](https://travis-ci.org/gregf/chef-minecraft)
[![Cookbook Version](https://img.shields.io/cookbook/v/minecraft.svg)](https://supermarket.chef.io/cookbooks/minecraft)

## Description

Installs and configures a [Minecraft](http://www.minecraft.net) server.

* Opscode Community Site: http://community.opscode.com/cookbooks/minecraft
* Source Code: http://github.com/gregf/cookbook-minecraft

## Requirements

### Chef

Tested on chef 11

### Cookbooks

* [java](http://community.opscode.com/cookbooks/java)
* [runit](http://community.opscode.com/cookbooks/runit)

### Platforms

* Debian 6+
* Ubuntu 12.04+
* Centos 6.4+
* Windows 8/2012 (may work on previous versions)

## Recipes

### default

The default recipe ensures a vanilla minecraft is installed, and configured based on attributes you have specified.

### user

The user recipe is called by default, and creates a new user/group `mcserver` for the server to run as.

### service

The service recipe enables the runit service for minecraft.

## Attributes

### Default

* `minecraft['user']`
  - The user the minecraft server runs under, default `mcserver`

* `minecraft['group']`
  - The group the minecraft server runs under, default `mcserver`
  - Not applicable to windows

* `minecraft['install_dir']`
  - The default location minecraft is installed to, default `/srv/minecraft` (`%ProgramData%\minecraft` on windows)

* `minecraft['install_type']`
  - Supports 'vanilla' and 'bukkit', default 'vanilla'
  - Only 'vanilla' is currently supported on windows

* `minecraft['url']`
  - The url to fetch minecarft releases from, default `https://s3.amazonaws.com/Minecraft.Download/versions`

* `minecraft['checksum']`
  - The sha256 checksum of minecraft_server.jar

* `minecraft['xms']`
  - The minimum ammount of ram java allow minecraft to consume, defaults to %40 of your total memory.

* `minecraft['xmx']`
  - The maximum ammount of ram java allow minecraft to consume, defaults to %60 of your total memory.

* `minecraft['java-options']`
  - You can use this to pass additional options to java, default blank

* `minecraft['init_style']`
  - Currently only `runit` is support on linux and `windows_task` on windows

* `minecraft['banned-ips']`
  - An array of ips you would like banned, default blank

* `minecraft['banned-players']`
  - An array of players you would like banned, default blank

* `minecraft['white-list]`
  - An array of users you would like to white-list, default blank

* `minecraft['ops']`
  - An array of admins, default blank

* `minecraft['accept_eula']`
  - Boolean whether to accept the EULA, required for [Minecraft 1.7.10](https://account.mojang.com/documents/minecraft_eula) (a Reddit thread with
    more information [is here](http://www.reddit.com/r/admincraft/comments/27dy0q/1710_forces_you_to_accept_the_eula_before_you_can/)). The default
    is false. It must be set to true (meaning you are consciously acknowledging and accepting the agreement) for the server to start.

### Properties

You can can customize any of the settings from server.properties. They are kept up to date with upstream and you can read about each setting in more
detail [here](http://minecraft.gamepedia.com/Server.properties#Minecraft_server_properties)

### Known issues

Minecraft internally regenerates all of its configuration files every startup. The order of server.properties sometimes changes, timestamps are
and headers are injected into all the configuration files.

This in turn causes chef to notice configuration files have been changed and will automatically restart the server again to pick up those changes. This may
cause your server to restart frequently, without notice.

This leaves you with two work arounds for now.

1. Only run chef-client once a day or manually as  you need to.
2. Set minecraft['autorestart'] = false and restart minecraft manually when you make configuration changes.

I am hoping I can get this changed upstream. I will attempt to come up with a better work around in the mean time.

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

Author: Greg Fitzgerald <greg@gregf.org>
Author: Sean Escriva <sean.escriva@gmail.com>

Copyright 2013, Greg Fitzgerald.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
