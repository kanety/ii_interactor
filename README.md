# IIInteractor

A base interactor to support management of bussiness logic.

This gem is inspired by [interactor](https://github.com/collectiveidea/interactor) specs.

## Dependencies

* ruby 2.3+
* activesupport 5.0+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ii_interactor'
```

Then execute:

    $ bundle

## Usage

Create interactor with `call` method and call it as follows:

```ruby
class Interactor < IIInteractor::Base
  context_in :message
  context_out :result

  def call
    @context.result = "called by #{@context.message}"
  end
end

Interactor.call(message: 'something')
#=> #<IIInteractor::Context message="something", result="called by something">
```

The first argument of `Interactor.call` is set to `@context`.
The return value of `Interactor.call` is the same as `@context`.

You can define context variables used in interactor explicitly.
`context_in` copies context to instance variables of interactor,
while `context_out` copies instance variables of interactor to context.

### Context options

You can define required context as follows:

```ruby
class Interactor < IIInteractor::Base
  context_in :input, required: true
end

Interactor.call
#=> IIInteractor::RequiredContextError (missing required context: input2)
```

You can also define default value as follows:

```ruby
class Interactor < IIInteractor::Base
  context_in :input, default: 'input'

  def call
    puts @input
  end
end

Interactor.call
#=> input
```

You can also set context from return value of `call` method:

```ruby
class Interactor < IIInteractor::Base
  context_out :result, from_return: true

  def call
    'returned value'
  end
end

Interactor.call.result
#=> returned value
```

### Coactions

You can call other interactors in the same context using `coact`:

```ruby
class AInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end
end

class BInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end
end

class MainInteractor < IIInteractor::Base
  coact AInteractor
  coact BInteractor
end

MainInteractor.call
#=> AInteractor
#   BInteractor
```

See [coactive](https://github.com/kanety/coactive) for more `coact` examples:

### Stop interactions

You can stop interactions as follows:

```ruby
class AInteractor < IIInteractor::Base
  def call
    puts self.class.name
    stop!(message: "something happened!")
  end
end

class BInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end
end

class MainInteractor < IIInteractor::Base
  coact AInteractor
  coact BInteractor
end

context = MainInteractor.call
#=> AInteractor

context.message
#=> something happened!

context.stopped?
#=> true

context.success?
#=> true
```

### Fail interactions

You can fail interactions and rollback called interactors as follows:

```ruby
class AInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end

  def rollback
    puts "rollback #{self.class.name}"
  end
end

class BInteractor < IIInteractor::Base
  def call
    fail!(message: "something happened!")
  end

  def rollback
    puts "rollback #{self.class.name}"
  end
end

class MainInteractor < IIInteractor::Base
  coact AInteractor
  coact BInteractor
end

context = MainInteractor.call
#=> AInteractor
#   rollback AInteractor

context.message
#=> something happened!

context.failure?
#=> true
```

### Callbacks

Following callbacks are available:

* `before_all`, `around_all`, `after_all`
* `before_call`, `around_call`, `after_call`

`*_all` wraps all coactors, and `*_call` wraps `call` method.
That is, `before_all` is called before running all coactors, and `before_call` is called before running `call` method.
For example:

```ruby
class Interactor < IIInteractor::Base
  before_all do
    puts "before_all"
  end

  before_call do
    puts "before_call"
  end

  def call
    puts @context.message
  end
end

Interactor.call(message: 'something')
#=> before_all
#   before_call
#   something
```

### Pass a block

You can pass a block to `call` method of a interactor.
The block is kept in the context and you can call it by `inform` as you like:

```ruby
class AInteractor < IIInteractor::Base
  def call
    inform('called A')
  end
end

class BInteractor < IIInteractor::Base
  def call
    inform('called B')
  end
end

class MainInteractor < IIInteractor::Base
  coact AInteractor
  coact BInteractor
end

MainInteractor.call do |interactor, message|
  puts "#{interactor.class}: #{message}"
end
#=> AInteractor: called A
#   BInteractor: called B
```

### Logging

Interactor supports instrumentation hook supplied by `ActiveSupport::Notifications`.
You can enable log subscriber as follows:

```ruby
IIInteractor::LogSubscriber.attach_to :ii_interactor
```

This subscriber will write logs in debug mode as the following example:

```
Calling BasicInteractor with #<IIInteractor::Context ...>
...
Called BasicInteractor (Duration: 0.1ms, Allocations: 4)
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/ii_interactor.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
