#Minecraft [![Build Status](https://secure.travis-ci.org/gregf/cookbook-minecraft.png)](http://travis-ci.org/gregf/cookbook-minecraft)

##Description

Installs vanilla [Minecraft](http://www.minecraft.net) server.

##Requirements

Requires the [java](http://community.opscode.com/cookbooks/java) and [tmux](http://community.opscode.com/cookbooks/tmux) cookbooks.

###Platform

Supported platforms:

* Debian 6
* Ubuntu 12.04
* Centos 6.4

##Attributes

See `attributes/default.rb` for default values.

#### Server setup options

* `default['minecraft']['user']`
* `default['minecraft']['install_dir']`
* `default['minecraft']['base_url']`
* `default['minecraft']['jar']`

#### Server properties

Here are some example properties that are set in the attributes now, however you
can set any of the properties defined here as well:
http://www.minecraftwiki.net/wiki/Server.properties#Minecraft_server_properties

* `default['minecraft']['properties']['banned-ips']`
* `default['minecraft']['properties']['banned-players']`
* `default['minecraft']['properties']['white-list-users']`
* `default['minecraft']['properties']['ops']`

* `default['minecraft']['properties']['allow-nether']`
* `default['minecraft']['properties']['level-name']`
* `default['minecraft']['properties']['enable-query']`
* `default['minecraft']['properties']['allow-flight']`
* `default['minecraft']['properties']['server-port']`
* `default['minecraft']['properties']['level-type']`
* `default['minecraft']['properties']['enable_rcon']`
* `default['minecraft']['properties']['level-seed']`
* `default['minecraft']['properties']['server-ip']`
* `default['minecraft']['properties']['max-build-height']`
* `default['minecraft']['properties']['spawn-npcs']`
* `default['minecraft']['properties']['white-list']`
* `default['minecraft']['properties']['spawn-animals'] `
* `default['minecraft']['properties']['online-mode']`
* `default['minecraft']['properties']['pvp']`
* `default['minecraft']['properties']['difficulty']`
* `default['minecraft']['properties']['gamemode']`
* `default['minecraft']['properties']['max-players']`
* `default['minecraft']['properties']['spawn-monsters']`
* `default['minecraft']['properties']['generate-structures']`
* `default['minecraft']['properties']['view-distance']`
* `default['minecraft']['properties']['motd']`

##Usage

Include the `minecraft` recipe and modify your run list and set any attributes
you would like changed.

    run_list [
      "recipe[minecraft]"
    ]
    "minecraft":{
      "motd": "Welcome all griefers!"
      "max-players": 9001
      "ops": ["nappa", "goku"]
    }


##Recipes

###default

Include the default recipe into your run_list to install `minecraft` server.
Configuration files are prepopulated based on values in attributes. I will keep
the defaults in sync with upstream.

##TODO

* Clean up attributes
* Test kitchen
* Bukkit support or just wait for 1.5?

##License

Copyright 2012, Greg Fitzgerald
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
the following conditions:
permit persons to whom the Software is furnished to do so, subject to

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

