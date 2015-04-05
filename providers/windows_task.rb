use_inline_resources

action :enable do
  batch_path = ::File.join(node['minecraft']['install_dir'], 'minecraft.bat')

  template batch_path do
    source 'minecraft.bat.erb'
    owner node['minecraft']['user']
    action :create
    variables(
      :jar => ::File.join(node['minecraft']['install_dir'], minecraft_file(node['minecraft']['url']))
    )
  end

  task = windows_task 'minecraft' do
    user node['minecraft']['user']
    password node['minecraft']['user_password']
    cwd node['minecraft']['install_dir']
    command batch_path
    frequency :onstart
  end

  new_resource.updated_by_last_action(task.updated_by_last_action?)
end

action :start do
  minecraft_start
end

action :stop do
  action_stop
end

action :restart do
  minecraft_stop
  minecraft_start
end

def minecraft_start
  pid = find_server_proc_id
  if pid.nil?
    converge_by('starting minecraft batch file') do
      windows_task 'minecraft' do
        action :run
      end

      ruby_block 'wait for java' do
        block do
          Timeout.timeout(60) do
            sleep 5 while find_server_proc_id.nil?
          end
        end
      end

      @new_resource.updated_by_last_action(true)
    end
  else
    Chef::Log.info("minecraft already running as pid #{pid}")
    @new_resource.updated_by_last_action(false)
  end
end

def minecraft_stop
  pid = find_server_proc_id

  if !pid.nil?
    converge_by("Sending interrupt signal to pid #{pid}") do
      Process.kill :KILL, pid

      Timeout.timeout(60) do
        sleep 5 until find_server_proc_id.nil?
      end
    end
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info('no minecraft server to stop')
    new_resource.updated_by_last_action(false)
  end
end

def find_server_proc_id
  jar_path = minecraft_file(node['minecraft']['url'])
  Chef::Log.info("searching for process running #{jar_path}")

  res = wmi.ExecQuery("select ProcessId from Win32_Process where name = 'java.exe' and CommandLine like '%#{jar_path}%'")
  res.each.next.ProcessId if res.each.count > 0
end

def wmi
  @wmi ||= ::WIN32OLE.connect('winmgmts://')
  @wmi
end
