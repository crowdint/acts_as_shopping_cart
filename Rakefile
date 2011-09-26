require "bundler/gem_tasks"

require "spec/rake/spectask"
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec
