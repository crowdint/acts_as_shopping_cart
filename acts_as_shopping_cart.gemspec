# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_shopping_cart/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_shopping_cart"
  s.version     = ActsAsShoppingCart::VERSION
  s.authors     = ["David Padilla"]
  s.email       = ["david@crowdint.com"]
  s.homepage    = ""
  s.summary     = %q{Simple Shopping Cart implementation}
  s.description = %q{Simple Shopping Cart implementation}

  s.rubyforge_project = "acts_as_shopping_cart"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '~> 3.0'
  s.add_development_dependency "cucumber"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "simplecov"
end
