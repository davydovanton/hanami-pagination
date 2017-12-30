# Hanami::Pagination
Pagination gem for your hanami applications. Based on ROM::Pagination plugin.

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
    include Hanami::Pagination::Action

    def call(params)
      # ...
    end
  end
end
```

```ruby
# in view
module Web::Views::Books
  class Index
    include Web::View
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
This helper takes **only rom/hanami relation** and sets `pager` expose. Returns array. Example:

```ruby
module Web::Controllers::Books
  class Index
    include Web::Action
    include Hanami::Pagination::Action

    expose :books

    def call(params)
      repo = BookRepository.new
      @books = all_for_page(repo.books)
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
      @books = all_for_page(repo.books)
    end

    def limit
      25
    end
  end
end
```

#### `pager` expose
When you include `Pagination::Action` to your action you get `pager` getter with `Hanami::Pagination::Pager` instance. Please check source code for this class. In future I'll add full documentation. Now we support this methods:

- `next_page`
- `prev_page`
- `total`
- `total_pages`
- `current_page?`
- `pages_range`
- `all_pages`
- `first_page?`
- `last_page?`
- `previous_page_path`
- `next_page_path`
- `n_page_path`
- `paginate`


### View

#### `paginate(page)`

Returns `<nav>` tag with links to first, last and closest pages. For example:

```ruby
paginate(:items) # where `:items` is a named route
```

when there is 11 pages, will returns:

```html
<nav class="pagination">
  <a href="/items?page=1" class="pagination-first-page">
    1
  </a>
  <span class="pagination-ellipsis">
    ...
  </span>
  <a href="/items?page=4" class="pagination-previous-page">
    4
  </a>
  <span class="pagination-current-page">
    5
  </span>
  <a href="/items?page=6" class="pagination-next-page">
    6
  </a>
  <span class="pagination-ellipsis">
    ...
  </span>
  <a href="/items?page=11" class="pagination-last-page">
    11
  </a>
</nav>

```
Every elements has special css-classes, so it is easy to change pagination look.

#### `next_page_url`
Returns string with url to next page. Example:

```ruby
next_page_url # => '/books?page=3'
```

#### `prev_page_url`
Returns string with url to prev page. Example:

```ruby
prev_page_url # => '/books?page=1'
```

#### `page_url(page)`
Returns string with url to specific page. Example:

```ruby
page_url(4) # => '/books?page=4'
```

#### `previous_page_path(page)`
Returns string with `page` path and current `params` to prev page. Example:

```ruby
# params => { status: 'active' }
# pager.current_page?(2) => true
previous_page_path(:books) # => '/books?status=active&page=1'
```

#### `next_page_path(page)`
Returns string with `page` path and current `params` to next page. Example:

```ruby
# params => { status: 'inactive' }
# pager.current_page?(1) => true
previous_page_path(:users) # => '/books?status=inactive&page=2'
```

#### `n_page_path(page, n)`
Returns string with `page` path and current `params` to specific page. Example:

```ruby
# params => { status: 'active' }
previous_page_path(:books, 10) # => '/books?status=active&page=10'
```

### Testing

You can use `Hanami::Pagination::MockPager` class for testing you apps.

#### View testing
```ruby
RSpec.describe Web::Views::Books::Show do
  let(:mock_pager) { Hanami::Pagination::MockPager.new(current_page, total_pages) }
  let(:pager) { Hanami::Pagination::Pager.new(mock_pager) }
  let(:exposures) { Hash[pager: pager] }

  let(:current_page) { 1 }
  let(:total_pages) { 10 }

  # ...
end
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
