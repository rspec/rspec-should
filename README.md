# RSpec::Should

This gem re-enables the `.should` syntax for RSpec gems (>= 4.0.0).

Please note that the RSpec team does not recommend this gem, we instead recommend the `expect` syntax.

## Why switch over from `should` to `expect`
The `should` and `should_not` methods work by being added to every object. However, RSpec
does not own every object and cannot ensure they work consistently on every object.
In particular, they can lead to surprising failures when used with BasicObject-subclassed
proxy objects.

`expect` avoids these problems altogether by not needing to be available on all objects.

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add rspec-should
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install rspec-should
```

Then either require `rspec/should/enable` or manually call `RSpec::Should.enable!` at your desired time.

## Usage

See the documentation in RSpec::Should.

## Contributing

This gem is considered legacy support, whilst bug reports are welcome, there is no guarantee a member of
the RSpec team will have time to attend to the issue. If you use this gem and encounter issues, please try
to fix them yourself and submit a pull request.

Contributors are expected to follow our [Code of Conduct](CODE_OF_CONDUCT.md).
