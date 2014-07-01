# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'readme-score/version'

Gem::Specification.new do |spec|
  spec.name          = "readme-score"
  spec.version       = ReadmeScore::VERSION
  spec.authors       = ["Clay Allsopp"]
  spec.email         = ["clay.allsopp@gmail.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", ">= 1.6.0"
  spec.add_dependency "unirest", ">= 1.1.0"
  spec.add_dependency "redcarpet", ">= 3.1.0"
  spec.add_dependency "octokit", ">= 3.2.0"
  spec.add_dependency "statsample", ">= 1.3.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "dotenv"
end