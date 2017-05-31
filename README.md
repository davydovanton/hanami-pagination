# Hanami::Pagination
Pagination gem for your hanami applications

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hanami-pagination'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hanami-pagination

Include pagination helpers to view and action:

```ruby
# in action
module Web::Controllers::Books
  class Index
    include Web::Action

    # include Pagination::Action module
    include Hanami::Pagination::Action

    def call(params)
      ...
    end
  end
end
```

```ruby
# in view
module Web::Views::Books
  class Index
    include Web::View

    # include Pagination::View module
    include Hanami::Pagination::View
  end
end
```

After that you need to enable pagination for each repository class:
```ruby
# in config/initializers/enable_pagination.rb
BookRepository.enable_pagination!
PostRepository.enable_pagination!
# etc
```

## Usage
TODO: Write usage instructions here


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

