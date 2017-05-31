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
Now you have special methods for working with pagination in your app.

### Action
#### `all_for_page`
This helper takes rom/hanami relation and sets `pager` expose. Returns array. Example:

```ruby
module Web::Controllers::Books
  class Index
    include Web::Action
    include Hanami::Pagination::Action

    expose :books

    def call(params)
      repo = BookRepository.new
      @drugs = all_for_page(repo.all)
    end
  end
end
```

Also you can set `limit` (default 100) for each action:

```ruby
module Web::Controllers::Books
  class Index
    include Web::Action
    include Hanami::Pagination::Action

    expose :books

    def call(params)
      repo = BookRepository.new
      @drugs = all_for_page(repo.all)
    end

    def limit
      25
    end
  end
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
