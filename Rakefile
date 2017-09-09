require 'rspec/core/rake_task'
require 'foodcritic'
require 'kitchen'
require 'stove/rake_task'
require 'cookstyle'
require 'rubocop/rake_task'
RuboCop::RakeTask.new do |task|
  task.options << '--display-cop-names'
end

# Cookbook Releases
Stove::RakeTask.new

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

# Integration tests. Kitchen.ci
namespace :integration do
  desc 'Run Test Kitchen with Digital Ocean'
  task :digitalocean do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
end

desc 'Run all tests on Travis'
task travis: %w(rubocop spec)

# Default
task default: ['rubocop', 'spec', 'integration:digitalocean']
