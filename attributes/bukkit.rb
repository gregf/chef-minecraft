default['minecraft']['bukkit']['config'].tap do |bukkit_config|
  bukkit_config['settings'].tap do |settings|
    settings['allow-end'] = true
    settings['warn-on-overload'] = true
    settings['update-folder'] = 'update'
    settings['ping-packet-limit'] = 100
    settings['use-exact-login-location'] = false
    settings['plugin-profiling'] = false
    settings['connection-throttle'] = 4000
    settings['query-plugins'] = true
    settings['deprecated-verbose'] = 'default'
    settings['shutdown-message'] = 'Server closed'
  end

  bukkit_config['minecraft']['bukkit']['spawn-limits'].tap do |spawn_limits|
    spawn_limits['monsters'] = 70
    spawn_limits['animals'] = 15
    spawn_limits['water-animals'] = 5
    spawn_limits['ambient'] = 15
  end

  bukkit_config['minecraft']['bukkit']['chunk-gc'].tap do |chunk_gc|
    chunk_gc['period-in-tickets'] = 600
    chunk_gc['load-threshold'] = 0
  end

  bukkit_config['minecraft']['bukkit']['ticks-per'].tap do |ticks_per|
    ticks_per['animal-spawns'] = 400
    ticks_per['monster-spawns'] = 1
    ticks_per['autosave'] = 6000
  end

  bukkit_config['minecraft']['bukkit']['auto-updater'].tap do |auto_updater|
    auto_updater['enabled'] = true
    auto_updater['on-broken'] = %w(warn-console warn-ops)
    auto_updater['on-update'] = %w(warn-console warn-ops)
    auto_updater['preferred-channel'] = 'rb'
    auto_updater['host'] = 'dl.bukkit.org'
    auto_updater['suggest-channels'] = true
  end

  bukkit_config['minecraft']['bukkit']['database'].tap do |database|
    database['username'] = 'bukkit'
    database['isolation'] = 'SERIALIZABLE'
    database['driver'] = 'org.sqlite.JBDC'
    database['password'] = 'walrus'
    database['url'] = 'jbdc:sqlite:{DIR}{NAME}.db'
  end
end

default['minecraft']['bukkit']['commands'].tap do |bukkit_commands|
  bukkit_commands['command-block-overrides'] = []
  bukkit_commands['aliases'].tap do |aliases|
    aliases['icanhasbukkit'] = ['version $1-']
  end
end

default['minecraft']['bukkit']['help'] = {}
default['minecraft']['bukkit']['permissions'] = {}
