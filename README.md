# StructuredNoise

This is a utility to generate Avro-schema-templated noise

### Features:

README-driven development ;)

* Reads an avro scheme indicated by `--schema` and writes noise to STDOUT
* If given `--base64` it converts the avro binary data to Basee64 before sending it to STDOUT
* Respects a `--messages-per-second` command

####TODO FEATURES:

* `--decode` should decode avro coming in via STDIN, respecting `--base64` flag, writing JSON hashes to STDOUT
* `--template filename` should support a JSON-structure template for Avro messages, with 'fill in the blanks' as like.. * or something.
* `--malicious-compliance` will toggle generating edge-case data compliant with given Avro types

## Installation

This is a debug tool. You probably don't want to install it in an applicaton

Install it with:

    $ gem install structured_noise

## Usage

Run from your console:

`structured_noise [OPTIONS]`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joshsz/structured_noise. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

