# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'selleo-controller_tests/version'

Gem::Specification.new do |s|
  s.name          = "selleo-controller_tests"
  s.version       = Selleo::ControllerTests::VERSION
  s.authors       = ["stevo"]
  s.email         = ["blazejek@gmail.com"]
  s.homepage      = "https://github.com/Selleo/selleo-controller_tests"
  s.summary       = "Shared examples for controller tests"
  s.description   = "Shared examples for controller tests"

  s.files         = `git ls-files app lib`.split("\n")
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.rubyforge_project = '[none]'
end
