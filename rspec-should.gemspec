# frozen_string_literal: true

require_relative "lib/rspec/should/version"

Gem::Specification.new do |spec|
  spec.name = "rspec-should"
  spec.version = RSpec::Should::Version::STRING
  spec.authors = ["Jon Rowe"]
  spec.email = "rspec@googlegroups.com"

  spec.summary = "rspec-should-#{RSpec::Should::Version::STRING}"
  spec.description = "`should` syntax for RSpec 4.0.x"
  spec.homepage = "https://rspec.info"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["bug_tracker_uri"] = "https://github.com/rspec/rspec-should/issues"
  spec.metadata["changelog_uri"] = "https://github.com/rspec/rspec-should/tree/v#{spec.version}/Changelog.md"
  spec.metadata["documentation_uri"] = "https://rspec.info/documentation/"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["mailing_list_uri"] = "https://groups.google.com/forum/#!forum/rspec"
  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["source_code_uri"] = "https://github.com/rspec/rspec-should"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore .rspec spec/ .rubocop.yml])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  private_key = File.expand_path("~/.gem/rspec-gem-private_key.pem")
  if File.exist?(private_key)
    spec.signing_key = private_key
    spec.cert_chain = [File.expand_path("~/.gem/rspec-gem-public_cert.pem")]
  end
end
