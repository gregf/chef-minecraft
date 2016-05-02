require 'spec_helper'

describe 'minecraft::build' do
  context 'builds spigot and bukkit jars' do
    let(:spigot_run) do
      ChefSpec::SoloRunner.new(:platform => 'debian', :version => '7.0') do |node|
        node.set['minecraft']['install_type'] = 'spigot'
        node.automatic['memory']['total'] = '2097152kB'
      end.converge(described_recipe)
    end

    it 'creates a directory for the spigot build working files to live' do
      expect(spigot_run).to create_directory('/srv/spigot_build')
    end

    it 'installs buildtools.jar' do
      expect(spigot_run).to create_remote_file_if_missing('/srv/spigot_build/BuildTools.jar')
    end

    it 'runs an execute resource to build spigot and craftbukkit' do
      expect(spigot_run).to run_execute('build spigot and craftbukkit')
    end

    #    it 'creates /srv/spigot_build/spigot-1.8.8.jar' do
    #      expect(spigot_run).to create_remote_file_if_missing('/srv/spigot_build/spigot-1.8.8.jar')
    #    end

    #    it 'creates /srv/spigot_build/craftbukkit-1.8.8.jar' do
    #      expect(spigot_run).to create_file('/srv/spigot_build/craftbukkit-1.8.8.jar')
    #  end
  end
end
