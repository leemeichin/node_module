# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'node_module/version'

Gem::Specification.new do |spec|
  spec.name          = "node_module"
  spec.version       = NodeModule::VERSION
  spec.authors       = ["Lee Machin"]
  spec.email         = ["lee@new-bamboo.co.uk"]
  spec.description   = %q{Evaluate methods in Ruby as Javascript instead}
  spec.summary       = %q{Get really close to the metal in Ruby}
  spec.homepage      = "http://github.com/leemachin/node_module"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "live_ast"
  spec.add_dependency "therubyracer"
  spec.add_dependency "opal", "~> 0.5"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.2.3"
end
