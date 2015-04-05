require 'spec_helper'

describe 'minecraft::java' do
  context 'installs java on debian' do
    let(:chef_run) do
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.automatic['memory']['total'] = '2097152kB'
      end.converge(described_recipe)
    end

    it 'includes the default java recipe' do
      expect(chef_run).to include_recipe('java::default')
    end
  end

  context 'intalls java via chocolatey on windows' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'windows', :version  => '2008R2').converge('minecraft::default') }
    let(:memory) { double('win32_memory', :capacity => 2_097_152 * 1_024) }
    let(:wmi) { double('wmi', :ExecQuery => [memory]) }
    before do
      begin
        require 'win32ole'
      rescue LoadError
        class WIN32OLE
        end
      end

      allow(WIN32OLE).to receive(:connect).with('winmgmts://').and_return(wmi)
    end

    it 'includes the default chocolatey recipe' do
      expect(chef_run).to include_recipe('chocolatey::default')
    end
  end
end
