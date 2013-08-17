#!/usr/bin/env rake

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "lib" << "lib/node_module" << "spec"
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose = true
end
