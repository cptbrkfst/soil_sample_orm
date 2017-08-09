# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soil_sample_orm/version'

Gem::Specification.new do |spec|
  spec.name          = 'soil_sample_orm'
  spec.version       = SoilSampleOrm::VERSION
  spec.authors       = ['Dylan Bromell']
  spec.email         = ['dmbromell@gmail.com']

  spec.summary       = 'A Dynamic ORM for Soil Sample DB'
  spec.description   = 'Dynamic CRUD functionality for soil sample db'
  spec.homepage      = 'https://rubygems.org/gems/soil_sample_orm'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'require_all', '~> 1.4'
  spec.add_runtime_dependency     'sqlite3', '~> 1.3', '>= 1.3.13'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'pry', '~> 0.10.4'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
