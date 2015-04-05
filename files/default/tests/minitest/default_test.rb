require 'minitest/spec'
#
## Cookbook Name:: minecraft
## Spec:: default

describe_recipe 'minecraft::default' do
  let(:is_windows) { node['platform_family'] == 'windows' }

  describe 'ensures the install directory is present' do
    let(:dir) { directory(node['minecraft']['install_dir']) }
    it { dir.must_exist }
    it { dir.must_have(:mode, '0755') unless is_windows }
    it { dir.must_have(:owner, node['minecraft']['user']) unless is_windows }
    it { dir.must_have(:group, node['minecraft']['group']) unless is_windows }
  end

  describe 'ensures minecraft jar exists' do
    let(:jar) { file("#{node['minecraft']['install_dir']}/#{minecraft_file(node['minecraft']['url'])}") }
    it { jar.must_exist }
    it { jar.must_have(:mode, '0644') unless is_windows }
    it { jar.must_have(:owner, node['minecraft']['user']) unless is_windows }
    it { jar.must_have(:group, node['minecraft']['group']) unless is_windows }
  end

  describe 'ensures server.properties is present' do
    let(:config) { file("#{node['minecraft']['install_dir']}/server.properties") }
    it { config.must_exist }
    it { config.must_have(:mode, '0644') unless is_windows }
    it { config.must_have(:owner, node['minecraft']['user']) unless is_windows }
    it { config.must_have(:group, node['minecraft']['group']) unless is_windows }
  end

  it 'ensures minecraft is running' do
    service('minecraft').must_be_running unless is_windows
    if is_windows
      wmi = ::WIN32OLE.connect('winmgmts://')
      jar_path = minecraft_file(node['minecraft']['url'])
      proc = wmi.ExecQuery("select ProcessId from Win32_Process where name = 'java.exe' and CommandLine like '%#{jar_path}%'")
      proc.each.count.must_be :==, 1
    end
  end
end
