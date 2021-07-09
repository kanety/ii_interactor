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

Create interactor with `call` method:

```ruby
class Interactor < IIInteractor::Base
  def call
    @context.result = "called by #{@context.message}"
  end
end
```

Then call:

```ruby
Interactor.call(message: 'something')
#=> #<IIInteractor::Context message="something", result="called by something">
```

The first argument of `call` is set to `@context`.
The return value of `call` is the same as `@context`.

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

### Interaction

You can interact with other interactors in the same context:

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

You can also interact with other interactors by using named interaction:

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

* Files in `app/interactors` are loaded to lookup interactors having same name in case of development mode.
* The called interactors are unordered.

#### Object based interaction

You can also interact with object based interactors:

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

Note that the called interactors are looked up from the namespace corresponding with caller interactor.

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

### Rollback

You can fail a interactor and rollback called interactors as follows:

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
    puts self.class.name
  end

  def rollback
    puts "rollback #{self.class.name}"
  end
end

class MainInteractor < IIInteractor::Base
  interact AInteractor
  interact BInteractor

  def call
    fail!(message: "something happened!")
  end
end

context = MainInteractor.call
#=> AInteractor
#   BInteractor
#   rollback BInteractor
#   rollback AInteractor

context.message
#=> something happened!
```

## Contributing

Bug reports and pull requests are welcome at https://github.com/kanety/ii_interactor.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
