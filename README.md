absolver
===

Absolver is a small little gem that allows setting the cause of a Ruby exception. Consider this example:

```ruby
err = begin
  begin
    1 / 0
  rescue => e
    raise RuntimeError, 'foo'
  end
rescue => e
  e
end
```

Notice that I raised a `RuntimeError` _inside_ a `rescue` block. In Ruby 2.1 and later, doing so will set the inner exception's `#cause` attribute to the outer exception. In other words:

```ruby
err        # => #<RuntimeError: foo>
err.cause  # => #<ZeroDivisionError: divided by 0>
```

Cool, thanks Ruby!

What if I want to change the cause though? Maybe I don't really want to include the cause when reporting to an external error monitoring service, for example. Sadly, Ruby doesn't let you do that:

```ruby
err.cause = nil
# NoMethodError (undefined method `cause=' for #<RuntimeError: foo>)
```

What's a programmer to do? Use absolver!

```ruby
require 'absolver'

Absolver.set_cause(err, nil)

err.cause  # => nil
```

Absolver uses [Fiddle](https://ruby-doc.org/stdlib-2.5.0/libdoc/fiddle/rdoc/Fiddle.html) to safely set the `cause` attribute of the `Exception` object. Basically it reaches down into Ruby's internals to adjust the value of the `cause` instance variable, which normally isn't exposed to your program.

Absolver also includes a small monkeypatch that adds `cause=` to `Exception`. Because many people dislike monkeypatches, you have to opt-in:

```ruby
require 'absolver/exception'
err.cause = nil
```

## License

Licensed under the MIT license. See LICENSE for details.

## Authors

* Cameron C. Dutro: http://github.com/camertron
