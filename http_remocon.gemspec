# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'http_remocon/version'

Gem::Specification.new do |spec|
  spec.name          = "http_remocon"
  spec.version       = HttpRemocon::VERSION
  spec.authors       = ["Takuto Komazaki"]
  spec.email         = ["komazarari@gmail.com"]

  spec.summary       = %q{Rack HTTP server to execute commands.}
  spec.description   = %q{Rack HTTP server to execute commands.}
  spec.homepage      = "https://github.com/komazarari/http_remocon"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra", "~> 1.0"
  spec.add_dependency "sucker_punch", "~> 1.0"
#  spec.add_dependency "sinatra-contrib", "~> 1.0"
#  spec.add_dependency

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
