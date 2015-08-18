# -*- encoding: utf-8 -*-
# stub: em-synchrony 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "em-synchrony"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ilya Grigorik"]
  s.date = "2015-01-18"
  s.description = "Fiber aware EventMachine libraries"
  s.email = ["ilya@igvita.com"]
  s.homepage = "http://github.com/igrigorik/em-synchrony"
  s.licenses = ["MIT"]
  s.rubyforge_project = "em-synchrony"
  s.rubygems_version = "2.4.5"
  s.summary = "Fiber aware EventMachine libraries"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 1.0.0.beta.1"])
    else
      s.add_dependency(%q<eventmachine>, [">= 1.0.0.beta.1"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 1.0.0.beta.1"])
  end
end
