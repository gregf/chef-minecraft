require ::File.expand_path('../../spec_helper', __FILE__)

describe user('mcserver') do
  it { should exist }
  it { should belong_to_group 'mcserver' }
  it { should have_home_directory '/srv/minecraft' }
  it { should have_login_shell '/bin/false' }
end

describe file('/srv/minecraft') do
  it { should be_directory }
  it { should be_mode 755 }
  it { should be_grouped_into 'mcserver' }
  it { should be_owned_by 'mcserver' }
end

describe file('/srv/minecraft/minecraft_server.1.12.1.jar') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'mcserver' }
  it { should be_grouped_into 'mcserver' }
end

describe file('/srv/minecraft/server.properties') do
  it { should be_file }
  it { should be_mode 644 }
  it { should be_owned_by 'mcserver' }
  it { should be_grouped_into 'mcserver' }
end

describe process('java') do
  its(:user) { should eq 'mcserver' }
  its(:args) { should match(/-Xms195M -Xmx292M -Djava.net.preferIPv4Stack=true -jar\b/i) }
end
