# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mail2kannel/version"

Gem::Specification.new do |s|
  s.name        = "mail2kannel"
  s.version     = Mail2kannel::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jens Hilligsøe"]
  s.email       = ["jens@hilli.dk"]
  s.homepage    = ""
  s.summary     = %q{Transfers emails to the Kannel SMS gateway}
  s.description = %q{Monitors a Maildir for new messages and sends incomning emails off to a Kannel (http://www.kannel.org/) SMS gateway via http}

  s.rubyforge_project = "mail2kannel"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
