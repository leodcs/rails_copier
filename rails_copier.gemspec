
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_copier/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails_copier'
  spec.version       = RailsCopier::VERSION
  spec.authors       = ['Leonardo Santos']
  spec.email         = ['aleotory@gmail.com']

  spec.summary       = 'A simple gem that allows you to copy a rails project'
  spec.homepage      = 'https://github.com/leodcs/rails_copier'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*.rb', 'ext/*.rb']

  spec.executables   = ['rails_copier']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'slop', '~> 4.6.1'
end
