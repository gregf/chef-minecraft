default['minecraft']['mark2']['url'] = "https://github.com/mcdevs/mark2/archive/master.tar.gz"
default['minecraft']['mark2']['install_dir'] = "/opt/mark2"
default['minecraft']['mark2']['properties']['shutdown-timeout'] = "60"
default['minecraft']['mark2']['properties']['log.rotate-mode'] = "size"
default['minecraft']['mark2']['properties']['log.rotate-size'] = "1000000"
default['minecraft']['mark2']['properties']['log.rotate-limit'] = "10"
default['minecraft']['mark2']['java']['cli.X.ms'] = node['minecraft']['xms']
default['minecraft']['mark2']['java']['cli.X.mx'] = node['minecraft']['xmx']
default['minecraft']['mark2']['java']['cli.X.incgc'] = "true"
default['minecraft']['mark2']['plugin']['backup.enabled'] = "true"
