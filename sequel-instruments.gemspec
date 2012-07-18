Gem::Specification.new do |gem|
  gem.name        = "sequel-instruments"
  gem.version     = "0.1.0"

  gem.author      = "Brandur"
  gem.email       = "brandur@mutelight.org"
  gem.homepage    = "https://github.com/brandur/rack-instruments"
  gem.license     = "MIT"
  gem.summary     = "Basic instrumentation for Sequel."

  gem.files       = %w{lib/sequel/instruments.rb}

  gem.add_dependency "slides", "~> 0.1"
end
