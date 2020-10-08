# node_module

> **I'll often drop down to node.js if I really need to be close to the metal**
>
> &mdash; <cite>https://twitter.com/shit_hn_says/status/234856345579446272</cite>

Dropping down to node.js has a number of problems:

1. You introduce a new, fairly large dependency to your codebase
2. You have to maintain certain stuff in a different language
3. You open yourself up to various debates about callbacks and promises

On the other hand, it has a couple of major advantages over every other language ever:

1. It's web-scale
2. It's *web-scale*!

Wouldn't it be nice if you could drop down to Node... *implicitly*? You wouldn't need to significantly change anything to fine-tune portions of your app, right down to the individual method level.

Enter `node_module`, which does just that. All you need to do is add the gem, and
tell it which methods or classes you want to run as JavaScript instead of Ruby.

## How to install

If you use Bundler, add it to your `Gemfile`, then run `bundle install`.

```ruby
gem 'node_module'
```

If you don't, install the gem manually.

```shell
gem install node_module
```

## How to use

### Turn certain methods into JavaScript
```ruby
require 'node_module'

class AbstractConcepts

  include NodeModule

  def existentialism
    self.name = "me"
  end

  def solipsism
    (constants - [self.class]).map(&:remove_const)
  end

  # using Ruby 2.0 or earlier?
  def meaning_of_life
    42
  end
  
  node_module :meaning_of_life
  
  # using Ruby 2.1 or later?
  node_module def meaning_of_life
    42
  end

  # run everything after this point as JavaScript
  node_module

  def pythagorean_triplet?(a, b, c)
    a**2 + b**2 == c**2
  end
end
```

`node_module` behaves like the `public`, `private`, and `protected` methods Ruby gives you. You can pass in specific methods as symbols, or call it without any arguments to change every subsequently defined method.

If you're using Ruby 2.1 you can also turn a single method into JS like this:

```ruby
node_module def method
  # stuff
end
```

### Turn an *entire class* into JavaScript

Your mileage may vary with this one. Use it at your own risk.

```ruby
require 'node_module'

class MentalState < NodeModule::Compiled

  def initialize(mental_state)
    @mental_state = mental_state
  end

  def happy?
    @mental_state == "happy"
  end

  def sad?
    @mental_state == "sad"
  end

  def utterly_fucking_bonkers?
    true
  end

end
```

Note that you might have a lot of difficulty getting classes to talk to each
other, because of the way objects are scoped when executing methods.


## Current limitations

This is a ridiculous proof of concept, so there are a few issues...

- Calling one compiled method/class in the context of another will blow up, so no dependency injection or any of that.

- It's destructive, so you'll lose the body of the original method.

- It doesn't actually use Node yet, just V8.

- It probably can't handle anything too clever.

- [You can't use 1.9 syntax](https://github.com/quix/live_ast#description)

## What Ruby code will work?

Check [Opal](https://opalrb.com) for that. It's what does all the hard work.
