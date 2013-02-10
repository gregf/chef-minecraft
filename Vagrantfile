require 'berkshelf/vagrant'

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # The path to the Knife config to use with Vagrant Berkshelf
  # config.berkshelf.config_path = "~/.chef/knife.rb"

  # A client name (node_name) to use with the Chef Client provisioner to upload
  # cookbooks installed by Berkshelf.
  # config.berkshelf.node_name = "reset"

  # A path to a client key on disk to use with the Chef Client provisioner to
  # upload cookbooks installed by Berkshelf.
  # config.berkshelf.client_key = "~/.chef/reset.pem"

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.host_name = "minecraft-cookbook"

  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-10.18.2.box"

  config.vm.network :hostonly, "33.33.33.10"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.vm.forward_port 25565, 25565

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :minecraft => {
        :xms => "256M",
        :xmx => "256M"
      }
    }
    chef.run_list = [
      "recipe[apt]",
      "recipe[minecraft]"
    ]
  end

end
