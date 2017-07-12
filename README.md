# Tsumamigui
[![Gem Version](https://badge.fury.io/rb/tsumamigui.svg)](https://badge.fury.io/rb/tsumamigui) [![circleci](https://circleci.com/gh/obiyuta/tsumamigui.svg?&style=shield&circle-token=8e2bda0f04504c2fe43d3fe70ea8ab1b6184806f)](https://circleci.com/gh/obiyuta/tsumamigui/tree/master) [![Code Climate](https://codeclimate.com/github/obiyuta/tsumamigui/badges/gpa.svg)](https://codeclimate.com/github/obiyuta/tsumamigui) [![Test Coverage](https://codeclimate.com/github/obiyuta/tsumamigui/badges/coverage.svg)](https://codeclimate.com/github/obiyuta/tsumamigui/coverage) [![Dependency Status](https://gemnasium.com/badges/github.com/obiyuta/tsumamigui.svg)](https://gemnasium.com/github.com/obiyuta/tsumamigui) [![Inline docs](http://inch-ci.org/github/obiyuta/tsumamigui.svg?branch=master)](http://inch-ci.org/github/obiyuta/tsumamigui)

Tsumamigui（つまみぐい） is a simple and hussle-free Ruby web scraping library.

## Requirement

Ruby 2.1+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tsumamigui'
```

Or install it yourself as:

```
$ gem install tsumamigui
```

## Usage

You just give it a URL(or URLs) and Xpath to data you want to get with its label as a hash.
Then you can get scraped and parsed data as array.

```ruby
Tsumamigui.scrape('http://example.com', {h1: 'html/body/div/h1/text()'})

# Returns:
# [
#   {h1: 'Example Domain', scraped_from: 'http://example.com'}
# ]
```

You can specify multiple URLs if you want to scrape different pages which they have the same HTML structure.

```ruby
urls = ['http://example.com/page/1', 'http://example.com/page/2']
Tsumamigui.scrape(urls, {h1: 'html/body/div/h1/text()'})

# Returns:
# [
#   {h1: 'Example Domain 1', scraped_from: 'http://example.com/page/1'}
#   {h1: 'Example Domain 2', scraped_from: 'http://example.com/page/2'}
# ]
```
___Important:___ Tsumamigui requests each urls at intervals of 1.0~3.0sec automatically.

## TODO

- [ ] Custom request headers.

etc...

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/obiyuta/tsumamigui](https://github.com/obiyuta/tsumamigui). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

### Guideline

1. Fork it ( http://github.com/obiyuta/tsumamigui )
1. Create your feature branch (git checkout -b my-new-feature)
1. Write codes and specs.
   - Run test suite with `bundle exec rspec` and confirm that it passes
   - Run lint checker with the `bundle exec rubocop` and confirm that it passes 
1. Commit your changes (git commit -am 'Add some feature')
1. Push to the branch (git push origin my-new-feature)
1. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Copyright (c) 2017 Obi Yuta. See MIT-LICENSE for details.