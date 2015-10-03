require "bundler/gem_tasks"

require "cucumber/rake/task"
Cucumber::Rake::Task.new do |t|
  t.cucumber_opts = "--format progress"
end

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new do |t|
  t.fail_on_error = true
end

task default: [:spec, :cucumber]
