# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "acts_as_uuid/version"

Gem::Specification.new do |s|
  s.name        = "acts_as_uuid"
  s.version     = ActsAsUuid::VERSION
  s.authors     = ["Cristiano Betta"]
  s.email       = ["cristiano@emberads.com"]
  s.homepage    = "https://github.com/EmberAds/acts_as_uuid"
  s.summary     = %q{TODO: Allows ActiveRecord to use (native) UUIDs }
  s.description = %q{TODO: Allows ActiveRecord to use (native) UUIDs, even as primary keys. Currently only works with PostgreSQL. }

  s.rubyforge_project = "acts_as_uuid"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_runtime_dependency "uuid"
end
