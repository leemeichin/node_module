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

Wouldn't it be nice if you could drop down to Node... *implicitly*?
You wouldn't need to significantly change anything to fine-tune
portions of your app, right down to the individual method level.

Enter `node_module`, which does just that. All you need to do is add the gem, and
tell it which methods you want to run as javascript instead of Ruby.

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

  node_module

  def pythagorean_triplet?(a, b, c)
    a**2 + b**2 == c**2
  end
end
```

Any method you define after `node_module` will be converted to JavaScript before being
executed.

This is a ridiculous proof of concept, so there are a few issues...

## Current limitations

- Sharing state between methods or across a class is unpredictable,
  and will probably cause bad things to happen.

- It doesn't actually use Node yet

- It probably can't handle anything too clever.

- [You can't use 1.9 syntax](https://github.com/quix/live_ast#description)

## What Ruby code will work?

Check [Opal](http://opalrb.org) for that. It's what does all the hard work.
