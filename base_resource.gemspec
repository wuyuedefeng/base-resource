$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "base_resource/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "base_resource"
  s.version     = BaseResource::VERSION
  s.authors     = ["mars"]
  s.email       = ["578595193@qq.com"]
  s.homepage    = "https://github.com/wuyuedefeng/base-resource"
  s.summary     = "Controller base Resource."
  s.description = "Controller base Resource."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "< 6"
  s.add_dependency "reform"
  s.add_dependency "reform-rails"
  s.add_dependency "kaminari"
  s.add_dependency "ransack"

  s.add_development_dependency "sqlite3"
end
