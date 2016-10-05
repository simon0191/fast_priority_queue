require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'thermite/tasks'

RSpec::Core::RakeTask.new(:spec)
Thermite::Tasks.new

desc 'Run Rust & Ruby testsuites'
task test: ['thermite:build', 'thermite:test', :spec]

task :default => :test
