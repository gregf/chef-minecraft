require 'spec_helper'

describe 'minecraft::service' do
  context 'starts the minecraft service' do
    let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'debian', version: '9.0').converge(described_recipe) }
    it 'enables the service' do
      expect(chef_run).to enable_runit_service('minecraft')
    end

    it 'starts the service' do
      expect(chef_run).to start_runit_service('minecraft')
    end
  end
end
