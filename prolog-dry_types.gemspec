
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'prolog/dry_types/version'

Gem::Specification.new do |spec|
  spec.name                  = "prolog-dry_types"
  spec.version               = Prolog::DryTypes::VERSION
  spec.required_ruby_version = '>= 2.3.0'
  spec.authors               = ["Jeff Dickey"]
  spec.email                 = ["jdickey@seven-sigma.com"]

  spec.summary               = %q{Dry::Types typedefs found to be generally useful. Replaces deprecated prolog-dry-types.}
  # spec.description         = %q{TODO: Write a longer description or delete this line.}
  spec.homepage              = "https://github.com/TheProlog/prolog-dry_types"
  spec.metadata["yard.run"] = "yri" # use "yard" to build full HTML docs.

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files                 = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir                = "exe"
  spec.executables           = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths         = ["lib"]

  spec.add_dependency "dry-struct", "0.1.1"
  spec.add_dependency "dry-types", "0.9.2"
  spec.add_dependency "uuid", "2.3.8"

  spec.add_development_dependency "bundler", "1.13.6"
  spec.add_development_dependency "rake", "11.3.0"
  spec.add_development_dependency "minitest", "5.9.1"

  spec.add_development_dependency "minitest-matchers", "1.4.1"
  spec.add_development_dependency "minitest-reporters", "1.1.12"
  spec.add_development_dependency "minitest-tagz", "1.5.2"

  spec.add_development_dependency "awesome_print", "1.7.0"
  spec.add_development_dependency "flay", "2.8.1"
  spec.add_development_dependency "flog", "4.4.0"
  spec.add_development_dependency "reek", "4.5.2"
  spec.add_development_dependency "rubocop", "0.46.0"
  spec.add_development_dependency "simplecov", "0.12.0"
  spec.add_development_dependency "pry-byebug", "3.4.1"
  spec.add_development_dependency "pry-doc", "0.9.0"
end
