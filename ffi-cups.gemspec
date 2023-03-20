require_relative 'lib/ffi-cups/version'

Gem::Specification.new do |s|
  s.name        = "ffi-cups"
  s.version     = Cups::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Hugo Marquez", "Nathan Ehresman"]
  s.email       = ["hugomarquez.dev@gmail.com"]
  s.homepage    = "https://github.com/hugomarquez/ffi-cups"
  s.summary     = "FFI wrapper around libcups"
  s.description = "Simple wrapper around libcups to give CUPS printing capabilities to Ruby apps."
  s.license     = "MIT"
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  s.add_runtime_dependency "ffi", "~> 1.15.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }

  s.require_paths = ["lib"]

  # development dependencies
  s.add_development_dependency 'byebug', '~> 11.1.3'
end
