# Prolog::DryTypes

**NOTE:** This Gem **supersedes** the previous `prolog-dry-types` Gem, which suffered from two major problems:

1. It was tied to the now-obsolete `dry-types` Gem Release 0.7.2, in a bid to avoid (or at least defer) several breaking changes that were encountered by Prolog applications upgrading to Release 0.8.0. This bit us later when using this Gem in conjunction with other `dry-rb` Gems and finding that the current docu­mentation and available support no longer matched the code we were using; and
2. It required that all uses of the root-level `Dry` or `Types` namespace modules, conventional in `dry-types`, be explicitly marked as root-level; e.g., that value objects subclass `::Dry::Types::Value` rather than simply `Dry::Types::Value`.

The document that follows is the README from `prolog-dry-types` Release 0.3.0, modified only as needed to reflect the change from `prolog-dry-types` to `prolog-dry_types`.

----

----

This Gem defines some fairly general-purpose types using the [`dry-types`](https://github.com/dry-rb/dry-types) Gem which, for those not familiar with it yet, is the successor to the venerable [Virtus](https://github.com/solnic/virtus) Gem, originally created by [Piotr Solnica](http://solnic.eu) and contributors. As part of the [`dry-rb`](http://dry-rb.org) collection of Gems, `dry-types` is an extremely useful tool that quickly becomes habit-forming. Side-effects may include more explicit, therefore more understandable code; increased developer happiness, and decreased baldness. (One of those has yet to be proven in actual use.)

`Prolog::DryTypes` leverages `dry-types`, defining several types in the `Dry::Types` module namespace as documented below under [Usage](#usage). They can be used individually by your code or all type definitions may be included by requiring `'prolog/dry_types'`,

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'prolog-dry_types'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install prolog-dry_types

## Usage

This Gem uses `dry-types` to define (currently) four basic data types suitable for declaring attributes in a `Dry::Types::Struct` (mutable) data structure or a `Dry::Types::Value` immutable value object. These are `Types::Range` and its [`Strict`](http://dry-rb.org/gems/dry-types/strict/) equivalent, `Types::Strict::Range`; `Types::IntegerRange`, `Types::TimeOrNow`, and `Types::UUID`. Each of these is presented in greater detail below.

### `Types::Range` and `Types::Strict::Range`

**Declared in** `prolog/dry_types/range.rb`

#### Example usage

```ruby
# in your `range_demo.rb` file

require 'prolog/dry_types/range' # or 'prolog/dry_types'

class RangeDemo < Dry::Types::Value
  attribute :name, Types::Strict::String
  attribute :range, Types::Strict::Range
end

# Let's be interactive...

$ pry
[1] pry(main)> require '/path/to/range_demo'
true
[2] pry(main)> range = RangeDemo.new name: 'Some Name', range: 2..5
{
     :name => "Some Name",
    :range => 2..5
}
[3] pry(main)> range.range.include? 5
true
[4] exit
$
```

#### Notes

The attribute value *is* a `Range` instance; it has all the quirks and behaviours that a `Range` instance declared more "conventionally" would have. In particular, a `Range` whose lower bound exceeds its upper bound (such as `(5..2)`) will always be empty. As one would reasonably expect, this attribute may be initialised by either an inclusive (e.g., `0..5`) or exclusive (`0...5`) `Range`, which respectively includes or excludes the upper bound.

### `Types::IntegerRange`

**Declared in** `prolog/dry_types/integer_range.rb`

#### Example usage

```ruby
# in your 'demo_range.rb' file

require 'prolog/dry_types/integer_range' # or 'prolog/dry_types'

class DemoRange < Dry::Types::Struct
  attribute :name, Types::Strict::String
  attribute range: Types::IntegerRange
end

# Let's be interactive...
$ pry
[1] pry(main)> require '/path/to/demo_range'
true
[2] pry(main)> range1 = DemoRange.new name: 'A Name', range: nil # defaults to 0..0
{
     :name => "A Name",
    :range => 0..0
}
[2] pry(main)> range2 = DemoRange.new name: 'Another Name', range: 8
{
     :name => "Another Name",
    :range => 0..8
}
[3] pry(main)> range3 = DemoRange.new name: 'One More', range: (-1..1)
{
    :name => "One More",
   :range => -1..1
}
[4] pry(main)> range3.range.to_a
[
    [0] -1,
    [1] 0,
    [2] 1
]
[5] pry(main)> exit
$
```

#### Notes

`Types::IntegerRange` *can* be used as though it were a `Types::Range`, with the attribute initialisation using a standard `Range` instance. It was initially developed, however, to provide an easy shorthand for a `Range` with a lower bound of zero, for which one only need supply the upper bound.

### `Types::TimeOrNow`

**Declared in** `prolog/dry_types/time_or_now.rb`

#### Example usage

```ruby
# In your 'time_demo.rb' file

require 'prolog/dry_types/time_or_now'

class TimeDemo < Dry::Types::Value
  attribute :when, Types::TimeOrNow
end

# Interactive again
$ pry
[1] pry(main)> require '/path/to/time_demo'
true
[2] pry(main)> t0 = Time.now; t1 = TimeDemo.new when: nil
{
    :when => 2016-07-31 01:56:11 +0800
}
[3] pry(main)> t1.when - t0
1.3e-05                    # 13 microseconds on this system
[4] pry(main)> t2 = TimeDemo.new when: Time.parse('23 Jan 2016 12:34:56 SGT')
{
    :when => 2016-01-23 12:34:56 +0800
}
[5] pry(main)> t3 = TimeDemo.new when: '23 Jan 2016 12:34:56 SGT'
Dry::Types::StructError: [TimeDemo.new] "23 Jan 2016 12:34:56 SGT" (String) has invalid type for :when
  from (...omitted...):in 'rescue in new'
[6] pry(main)> exit
$
```

#### Notes

This attribute class was originally `Types::DateTimeOrNow`, wrapping a `DateTime` instance rather than a `Time` instance. The change was made in line with recently-updated [community coding guidelines](https://github.com/bbatsov/ruby-style-guide#no-datetime) which recommend against use of `DateTime` unless a need exists "to account for historical calendar reform".

### `Types::UUID`

**Declared in** `prolog/dry_types/uuid.rb`

#### Example usage

```ruby
# In your 'uuid_demo.rb' file

require 'prolog/dry_types/uuid'

class UuidDemo < Dry::Types::Value
  attribute :id, Types::UUID
end

# Once again, interactive demo
$ pry
[1] pry(main)> require '/path/to/uuid_demo'
true
[2] pry(main)> demo1 = UuidDemo.new id: nil
{
    :id => "419c7d80-38b0-0134-4fad-3c0754526993"
}
[3] pry(main)> puts demo1.id
419c7d80-38b0-0134-4fad-3c0754526993
nil
[4] pry(main)> demo2 = UuidDemo.new id: '12345678-1234-5678-123456789012'
{
    :id => "12345678-1234-5678-4fad-123456789012"
}
[5] pry(main)> demo3 = UuidDemo.new id: '12345678123456784fad123456789012'
Dry::Types::StructError: [UuidDemo.new] "12345678123456784fad123456789012" (String) has invalid type for :id
from (omitted):in 'rescue in new'
[6] pry(main)> exit
$
```

#### Notes

Remember that UUIDs, by definition, are for all practical purposes never generated with  the same value twice; one common source of grief is to have your test code generate a UUID, then test your code under test which *also* generates a UUID, and from there, [hilarity ensues](http://tvtropes.org/pmwiki/pmwiki.php/Main/HilarityEnsues?from=Main.HilarityEnsued) as you try to figure out why your tests never pass.

Also remember that the only valid format for a UUID is as a string; if you want to work with the value as though it were a vector of bytes, integers, etc, then you are On Your Own with the existing code.

## Development

After checking out the repo, run `bin/setup` to create a `Gemfile.lock` file which identifies specific versions of runtime and development dependencies of this Gem (which as of now must already be installed on your local system). Then, run `bin/rake test` to run the tests, or `bin/rake` to run tests and, if tests are successful, further static-analysis tools ([RuboCop](https://github.com/bbatsov/rubocop), [Flay](https://github.com/seattlerb/flay), [Flog](https://github.com/seattlerb/flog), and [Reek](https://github.com/troessner/reek)).

To install *your build* of this Gem onto your local machine, run `bin/rake install`. We recommend that you uninstall any previously-installed "official" Gem to increase your confidence that your tests are running against your build.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TheProlog/prolog-dry-types. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
