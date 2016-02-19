$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "gaucho/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "gaucho"
  s.version     = Gaucho::VERSION
  s.authors     = ["Mariano González"]
  s.email       = ["marianoggf@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Gaucho."
  s.description = "TODO: Description of Gaucho."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.5.1"

  s.add_development_dependency "sqlite3"
end
