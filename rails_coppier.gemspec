
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_coppier/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_coppier"
  spec.version       = RailsCoppier::VERSION
  spec.authors       = ["Léo Santos"]
  spec.email         = ["aleotory@gmail.com"]

  spec.summary       = "A simple gem that allows you to copy a rails project"
  spec.homepage      = "https://github.com/leodcs/rails_coppier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
end
