# rfc

Ruby gem to generate Mexican **RFC** tax identifiers for **natural persons** (personas físicas), following the [SAT](https://www.sat.gob.mx/) algorithm.

Legal entity support (personas morales) is planned for a future release.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "rfc", git: "https://github.com/elosnaya/rfc.git"
```

Or install locally after cloning:

```bash
bundle exec rake install
```

## Usage

```ruby
require "rfc"

rfc = Rfc::Generator.new.generate(
  name: "Luis Alberto",
  first_last_name: "Osnaya",
  second_last_name: "Balderas",
  date_of_birth: "21/07/1986"
)

puts rfc # => "OABL8607213H6"
```

You can also pass the birth date as separate values:

```ruby
Rfc::Generator.new.generate(
  name: "Luis Alberto",
  first_last_name: "Osnaya",
  second_last_name: "Balderas",
  day: 21,
  month: 7,
  year: 1986
)
```

`date_of_birth` accepts `DD/MM/YYYY` format or any string parseable by Ruby's `Date`.

### Errors

```ruby
begin
  Rfc::Generator.new.generate(name: "Ana", first_last_name: "Lopez", second_last_name: "Garcia")
rescue Rfc::Generator::InvalidDateError => e
  puts e.message # => "Date information missing"
end
```

## Development

```bash
bin/setup          # install dependencies
bundle exec rspec  # run tests
bin/console        # interactive console
```

Example in the console:

```ruby
Rfc::Generator.new.generate(
  name: "Luis Alberto",
  first_last_name: "Osnaya",
  second_last_name: "Balderas",
  date_of_birth: "21/07/1986"
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [elosnaya/rfc](https://github.com/elosnaya/rfc).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
