# frozen_string_literal: true

require_relative "lib/rfc/version"

Gem::Specification.new do |spec|
  spec.name = "sat_rfc"
  spec.version = Rfc::VERSION
  spec.authors = ["elOsnaya"]
  spec.email = ["luisosnet@gmail.com"]

  spec.summary = "Generate Mexican RFC codes for natural persons (personas físicas)."
  spec.description = "Ruby library that generates RFC tax identifiers for Mexican natural persons using the SAT algorithm documented by the IFAI (INFOMEX folio 0610100135506). Inspired by rfc-facil (josketres) and rfc_facil (acrogenesis). Supports name normalization, homoclave, and verification digit calculation."
  spec.homepage = "https://github.com/elosnaya/rfc"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/elosnaya/rfc"
  spec.metadata["documentation_uri"] = "https://www.mariovaldez.net/files/IFAI%200610100135506%20065%20Algoritmo%20para%20generar%20el%20RFC%20con%20homoclave%20para%20personas%20fisicas%20y%20morales.pdf"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "i18n", "~> 1.0"
end
