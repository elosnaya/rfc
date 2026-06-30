# sat_rfc

Ruby gem to generate Mexican **RFC** tax identifiers for **natural persons** (personas físicas), following the [SAT](https://www.sat.gob.mx/) algorithm.

Legal entity support (personas morales) is planned for a future release.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "sat_rfc"
```

Or install from the repository:

```ruby
gem "sat_rfc", git: "https://github.com/elosnaya/rfc.git"
```

Local development install:

```bash
bundle exec rake install
```

## Usage

```ruby
require "sat_rfc"

rfc = Rfc::Generator.new.for_natural_person(
  name: "Juan Carlos",
  first_last_name: "Perez",
  second_last_name: "Garcia",
  date_of_birth: "15/03/1990"
)

puts rfc # => "PEGJ900315PE9"
```

You can also pass the birth date as separate values:

```ruby
Rfc::Generator.new.for_natural_person(
  name: "Juan Carlos",
  first_last_name: "Perez",
  second_last_name: "Garcia",
  day: 15,
  month: 3,
  year: 1990
)
```

`date_of_birth` accepts `DD/MM/YYYY` format or any string parseable by Ruby's `Date`.

### Errors

```ruby
begin
  Rfc::Generator.new.for_natural_person(name: "Ana", first_last_name: "Lopez", second_last_name: "Garcia")
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
Rfc::Generator.new.for_natural_person(
  name: "Juan Carlos",
  first_last_name: "Perez",
  second_last_name: "Garcia",
  date_of_birth: "15/03/1990"
)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [elosnaya/rfc](https://github.com/elosnaya/rfc).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
