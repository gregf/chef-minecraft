if defined?(ChefSpec)
  def enable_minecraft_windows_task(task_name)
    ChefSpec::Matchers::ResourceMatcher.new(:minecraft_windows_task, :enable, task_name)
  end

  def start_minecraft_windows_task(task_name)
    ChefSpec::Matchers::ResourceMatcher.new(:minecraft_windows_task, :start, task_name)
  end
end
