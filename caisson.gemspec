$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "caisson"
  s.version     = "0.0.1"
  s.authors     = ["Sebastien Rosa"]
  s.email       = ["sebastien@demarque.com"]
  s.extra_rdoc_files = ["LICENSE", "README.md"]
  s.licenses    = ["MIT"]
  s.homepage    = "https://github.com/demarque/caisson"
  s.summary     = "Rails helpers for Zurb-Foundation Framework."
  s.description = "Caisson will provide a set of tools to facilitate the integration of Zurb-Foundation to your Rails project."

  s.rubyforge_project = "caisson"

  s.files         = Dir.glob('{app,lib,spec}/**/*') + %w(LICENSE README.md Rakefile Gemfile)
  s.require_paths = ["lib"]

  s.add_development_dependency('rake', ['>= 0.8.7'])
  s.add_development_dependency('rspec', ['>= 2.0'])
end
