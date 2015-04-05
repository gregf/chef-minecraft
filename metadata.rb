maintainer        'Greg Fitzgerald'
maintainer_email  'greg@gregf.org'
license           'Apache 2'
description       'Installs/Configures minecraft server'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.6.2'
name              'minecraft'

recipe 'minecraft', 'Installs and configures minecraft server.'

%w(java runit ohai apt yum chocolatey windows).each do |dep|
  depends dep
end

%w(debian ubuntu centos windows).each do |os|
  supports os
end
