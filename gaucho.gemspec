$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gaucho/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gaucho"
  s.version     = Gaucho::VERSION
  s.authors     = ["Mariano González"]
  s.email       = ["marianoggf@gmail.com"]
  s.homepage    = ""
  s.summary     = "Argentinian gem for accouting"
  s.description = "Argentinian gem for accouting managment"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency 'mysql2', '~> 0.3.18'
  s.add_development_dependency 'rails-api'

end