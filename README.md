# Spine::Mappings

[![Gem Version](https://badge.fury.io/rb/spine-mappings.svg)](http://badge.fury.io/rb/spine-mappings)
[![Dependency Status](https://gemnasium.com/rspine/mappings.svg)](https://gemnasium.com/rspine/mappings)
[![Test Coverage](https://codeclimate.com/github/rspine/mappings/badges/coverage.svg)](https://codeclimate.com/github/rspine/mappings/coverage)
[![Code Climate](https://codeclimate.com/github/rspine/mappings/badges/gpa.svg)](https://codeclimate.com/github/rspine/mappings)
[![Codeship Status for rspine/mappings](https://codeship.com/projects/90a03900-e41c-0132-2cdb-16773c71d38d/status?branch=master)](https://codeship.com/projects/81788)

Maps object to hashes using DSL. You can give different namespaces for mappings
by extending module or class with `Spine::Mappings::Repository`.

## Installation

To install it, add the gem to your Gemfile:

```ruby
gem 'spine-mappings'
```

Then run `bundle`. If you're not using Bundler, just `gem install spine-mappings`.

## Usage

```ruby
Spine::Mappings.define :tag do
  integer :id, from: identity
  string :name
end

Spine::Mappings.define :product do
  integer :id, from: :identity
  string :name
  decimal :price
  boolean :is_available, { |source| source.available? }
  date :available_from
  date :available_until
  tag :tags, nullable: true
end

Spine::Mapings.define :timestamps do
  timestamp :created_at
  timestamp :updated_at
end

Spine::Mappings.find(:product, :timestamps).map(product)

Spine::Mappings.find(:product, :timestamps).map_all(products)
```

You can provide also `comapct` or `strict` strategy for mapping. First adds
value only when it is not nil, second adds everything what was defined. Default
is `strict`.

```ruby
Spine::Mappings.find(:product, :timestamps).map(product, strategy: :compact)
```
