# frozen_string_literal: true

require_relative "lib/lineageblock/version"

Gem::Specification.new do |spec|
  spec.name = "lineage_block"
  spec.version = LineageBlock::VERSION
  spec.authors = ["Mark Wilkinson"]
  spec.email = ["markw@illuminae.com"]

  spec.summary = "A blockchain for tracking lineages."
  spec.description = "A blockchain for tracking lineages in, for example, a germplasm bank."
  spec.homepage = "https://github.com/markwilkinson/LineageBlock"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/markwilkinson/LineageBlock"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.11"

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "blockchain-lite", "~> 1.4", ">= 1.4.1"
  spec.add_dependency "digest", "~> 3.1.0"
  spec.add_dependency "ledger-lite", "~> 1.1", ">= 1.1.1" 
  
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
