# LmTest

lm_test is a gem used to create a CSV file from a JSON one.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lm_test'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lm_test

## Usage

**Note :** You can find JSON samples in the gem repo root https://github.com/MatthieuGC/lm_test

To use the gem directly as command line in your terminal and create a CSV file from a JSON one :

    $ lm_test <json_file_path>

To use the gem into a project :

```ruby
LmTest::Convert.to_csv(json_file_path)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LmTest project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lm_test/blob/master/CODE_OF_CONDUCT.md).
