require_relative './lib/playform/version'

Gem::Specification.new do |s|
  s.name        = 'playform'
  s.version     = Playform::VERSION
  s.date        = '2020-10-09'
  s.summary     = "Quickest way to find game info for all types of games!"
  s.description = "Gives you a quick way to find information about trending, top sellers, played and upcoming games!"
  s.authors     = ["Ken Barlow"]
  s.email       = 'sample-email@gmail.com'
  s.files       = ["lib/playform.rb", "lib/playform/cli.rb", "lib/playform/scraper.rb", "lib/playform/game.rb", "config/environment.rb"]
  s.homepage    = 'http://www.knbrlo.com'
  s.license     = 'MIT'
  s.executables << 'playform'

  s.add_development_dependency "bundler", "~> 2.2.9"
  s.add_development_dependency "rake", "~> 13.0.1"
  s.add_development_dependency "rspec", ">= 3.9.0"
  s.add_development_dependency "nokogiri", ">= 1.10.10"
  s.add_development_dependency "pry", ">= 0.13.1"
  s.add_development_dependency "colorize", ">= 0.8.1"
end