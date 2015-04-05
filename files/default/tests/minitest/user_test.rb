require 'minitest/spec'
#
## Cookbook Name:: minecraft
## Spec:: user

describe_recipe 'minecraft::user' do
  let(:is_windows) { node['platform_family'] == 'windows' }

  it 'ensures minecraft group exists' do
    group(node['minecraft']['group']).must_exist unless is_windows
  end

  it 'ensures minecraft user exists' do
    user(node['minecraft']['user']).must_exist.with(:home, node['minecraft']['install_dir'])
  end
end
