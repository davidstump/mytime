# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mytime/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Stump"]
  gem.email         = ["david@davidstump.net"]
  gem.description   = %q{Git commit log based timesheet powered by Freshbooks}
  gem.summary       = %q{MyTime is a simple command line utility for submitting git commit history to a timesheet. Powered by the Freshbooks API.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mytime"
  gem.require_paths = ["lib"]
  gem.version       = Mytime::VERSION

  gem.add_runtime_dependency('ruby-freshbooks')
end
