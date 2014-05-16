require "bundler/gem_tasks"
require 'json'

def clean_ngannotate
  `rm -rf node_modules`
end

def install_ngannotate
  `npm install ng-annotate browserify`
end

def generate_ngannotate
  `./node_modules/.bin/browserify ./node_modules/ng-annotate/build/es5/ng-annotate-main.js | sed -e's/module.exports = function ngAnnotate/window.annotate = function ngAnnotate/' > vendor/ngannotate.js`
end

def update_version
  package = JSON.parse(File.open('./node_modules/ng-annotate/package.json').read)
  write_version(package["version"])
end

def write_version(version)
  text = <<-FILE
module Ngannotate
  module Rails
    VERSION = "#{version}"
  end
end
  FILE

  File.open('lib/ngannotate/rails/version.rb', 'w') { |f| f.write text }
end

namespace :ngannotate do
  desc "Build a new version of ngannotate-browserified.js"
  task :build do
    clean_ngannotate && install_ngannotate && generate_ngannotate && update_version
  end
end
