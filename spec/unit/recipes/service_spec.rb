require 'spec_helper'

describe 'minecraft::service' do
  context 'starts the minecraft service on with runit' do
    let(:chef_run) do
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.set['minecraft']['init_style'] = 'runit'
      end.converge(described_recipe)
    end

    it 'includes the runit recipe' do
      expect(chef_run).to include_recipe('runit')
    end

    it 'enables the service' do
      expect(chef_run).to enable_runit_service('minecraft')
    end

    it 'starts the runit service' do
      expect(chef_run).to start_runit_service('minecraft')
    end
  end

  context 'starts the minecraft service with windows task' do
    let(:chef_run) do
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.set['minecraft']['init_style'] = 'windows_task'
      end.converge(described_recipe)
    end

    it 'enables the windows_task' do
      expect(chef_run).to enable_minecraft_windows_task('minecraft')
    end

    it 'starts the windows task' do
      expect(chef_run).to start_minecraft_windows_task('minecraft')
    end
  end
end
