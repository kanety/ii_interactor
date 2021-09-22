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
  def call
    @context.result = "called by #{@context.message}"
  end
end

Interactor.call(message: 'something')
#=> #<IIInteractor::Context message="something", result="called by something">
```

The first argument of `Interactor.call` is set to `@context`.
The return value of `Interactor.call` is the same as `@context`.

### Context variables

You can define context variables used in interactor explicitly.
For example:

```ruby
class Interactor < IIInteractor::Base
  context_in :input
  context_out :result

  def call
    puts @input
    @result = 'result value'
  end
end

puts Interactor.call(input: 'input').result
#=> input
#   result value
```

`context_in` copies context into instance variables of interactor,
while `context_out` copies instance variables of interactor into context.

You can also define required context as follows:

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

### Callbacks

Following callbacks are available:

* `before_call`
* `around_call`
* `after_call`

For example:

```ruby
class Interactor < IIInteractor::Base
  before_call do
    @message = @context.message
  end

  def call
    puts @message
  end
end

Interactor.call(message: 'something')
#=> something
```

### Interactions

You can call other interactors in the same context using `interact`:

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
  interact AInteractor
  interact BInteractor
end

MainInteractor.call
#=> AInteractor
#   BInteractor
```

#### Named interaction

You can also define named interactions.
The interactors to be called are looked up from all interactors.

```ruby
class AInteractor < IIInteractor::Base
  react :some_name

  def call
    puts self.class.name
  end
end

class BInteractor < IIInteractor::Base
  react :some_name

  def call
    puts self.class.name
  end
end

class MainInteractor < IIInteractor::Base
  interact :some_name
end

MainInteractor.call
#=> AInteractor
#   BInteractor
```

Note followings:

* All files in `app/interactors` are loaded in development mode to lookup interactors having same name.
* The called interactors are unordered.

#### Object based interaction

You can also define object based interactions.
The interactors to be called are looked up from the namespace corresponding with caller interactor.

```ruby
class A
end

class B
end

class Main::AInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end
end

class Main::BInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end
end

class MainInteractor < IIInteractor::Base
  interact A
  interact B
end

MainInteractor.call
#=> Main::AInteractor
#   Main::BInteractor
```

#### Custom interaction

You can also customize lookup of interactors as follows:

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
  # set block
  interact do
    if @context.condition == 'A'
      AInteractor
    else
      BInteractor
    end
  end

  # set method name
  interact :conditional_interactors

  def conditional_interactors
    if @context.condition == 'A'
      AInteractor
    else
      BInteractor
    end
  end
end

MainInteractor.call(condition: 'A')
#=> AInteractor

MainInteractor.call(condition: 'B')
#=> BInteractor
```

#### Nested interaction

You can define nested interactions as follows:

```ruby
class NestedAInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end
end

class NestedBInteractor < IIInteractor::Base
  def call
    puts self.class.name
  end
end

class AInteractor < IIInteractor::Base
  interact NestedAInteractor

  def call
    puts self.class.name
  end
end

class BInteractor < IIInteractor::Base
  interact NestedBInteractor

  def call
    puts self.class.name
  end
end

class MainInteractor < IIInteractor::Base
  interact AInteractor
  interact BInteractor
end

MainInteractor.call
#=> NestedAInteractor
#   AInteractor
#   NestedBInteractor
#   BInteractor
```

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
  interact AInteractor
  interact BInteractor
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
  interact AInteractor
  interact BInteractor
end

context = MainInteractor.call
#=> AInteractor
#   rollback AInteractor

context.message
#=> something happened!

context.failure?
#=> true
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
  interact AInteractor
  interact BInteractor
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
Called SimpleInteractor (Duration: 0.3ms, Allocations: 42)
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/ii_interactor.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
