# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ngannotate/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "ngannotate-rails"
  spec.version       = Ngannotate::Rails::VERSION
  spec.authors       = ["Kari Ikonen"]
  spec.email         = ["mr.kari.ikonen@gmail.com"]
  spec.description   = %q{Use ngannotate in the Rails asset pipeline.}
  spec.summary       = %q{Summary: Use ngannotate in the Rails asset pipeline.}
  spec.homepage      = "https://github.com/kikonen/ngannotate-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/).reject {|f| f.match /example/ }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 3.1"
  spec.add_runtime_dependency "execjs"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
