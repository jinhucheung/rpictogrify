$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rpictogrify/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rpictogrify"
  s.version     = Rpictogrify::VERSION
  s.authors     = ["Jim Cheung"]
  s.email       = ["hi.jinhu.zhang@gmail.com"]
  s.homepage    = "https://github.com/jinhucheung/rpictogrify"
  s.summary     = "Ruby version of the pictogrify to generate unique pictograms"
  s.license     = "MIT"

  s.files = Dir["{lib, assets}/**/*", "MIT-LICENSE", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "nokogiri", ">= 1.4.4"
end