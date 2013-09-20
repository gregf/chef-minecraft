default['minecraft']['user']                = 'minecraft'
default['minecraft']['install_dir']         = '/srv/minecraft'
default['minecraft']['base_url']            = 'https://s3.amazonaws.com/Minecraft.Download/versions'
default['minecraft']['jar']                 = 'minecraft_server'
default['minecraft']['version']             = '1.6.2'
default['minecraft']['checksum']            = '99a7f4088226f5574ec47fa69fda4779376499e5c9c5b8c2342563c7ac35368e'

default['minecraft']['xms']                 = '512M'
default['minecraft']['xmx']                 = '512M'
default['minecraft']['ipv6']                = false

default['minecraft']['banned-ips']          = []
default['minecraft']['banned-players']      = []
default['minecraft']['white-list-users']    = []
default['minecraft']['ops']                 = []

# Default server properties
default['minecraft']['properties']['allow-nether']        = true
default['minecraft']['properties']['level-name']          = 'world'
default['minecraft']['properties']['enable-query']        = false
default['minecraft']['properties']['allow-flight']        = false
default['minecraft']['properties']['server-port']         = 25565
default['minecraft']['properties']['level-type']          = 'DEFAULT'
default['minecraft']['properties']['enable_rcon']         = false
default['minecraft']['properties']['level-seed']          = ''
default['minecraft']['properties']['server-ip']           = ''
default['minecraft']['properties']['max-build-height']    = 256
default['minecraft']['properties']['spawn-npcs']          = true
default['minecraft']['properties']['white-list']          = false
default['minecraft']['properties']['spawn-animals']       = true
default['minecraft']['properties']['online-mode']         = true
default['minecraft']['properties']['pvp']                 = true
default['minecraft']['properties']['difficulty']          = 1
default['minecraft']['properties']['gamemode']            = 0
default['minecraft']['properties']['max-players']         = 20
default['minecraft']['properties']['spawn-monsters']      = true
default['minecraft']['properties']['generate-structures'] = true
default['minecraft']['properties']['view-distance']       = 10
default['minecraft']['properties']['motd']                = 'A Minecraft Server'
