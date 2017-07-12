# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tsumamigui/version'

Gem::Specification.new do |spec|
  spec.name          = 'tsumamigui'
  spec.version       = Tsumamigui::VERSION
  spec.authors       = ['obiyuta']
  spec.email         = ['obi.yuta@gmail.com']

  spec.summary       = 'The simple and hussle-free Ruby web scraper'
  spec.description   = 'Tsumamigui（つまみぐい） is a simple and hussle-free Ruby web scraping library.'
  spec.homepage      = 'https://github.com/obiyuta/tsumamigui'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'nokogiri'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'
end
