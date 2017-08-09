require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require_relative 'config/environment'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Will load a console with the environment'
task :console do
  def reload!
    load_all 'lib'
  end

  Pry.start
end
