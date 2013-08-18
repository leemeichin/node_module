# node_module

> **I'll often drop down to node.js if I really need to be close to the metal**
>
> &mdash; <cite>https://twitter.com/shit_hn_says/status/234856345579446272</cite>

Ruby is a pretty high level language, so isn't perfectly suited to
things such as:

1. Systems programming
2. Being web-scale

It's also difficult to represent basic concepts in Ruby, as the sheer
amount of dynamism and expressivity baked into the language compels
the programmer to only think of code in terms of objects and
orientation, and Dijkstra. This is way too high level.

Thankfully, there is a burgeoning language on the scene that empowers
the programmer to really think about the nuts and bolts of their
implementation. Your code no longer explains to you what you want to
happen, but how it should do it.

Naturally, issuing commands to a computer -- typically in the form of
an assembly language, compiled C code, or JavaScript -- allows the
program to scale effortlessly under extreme loads, and allows you to reason
about what exactly your hardware is doing.

To that end, this library lets you drop down to JavaScript at the method level,
so parts of your class can be executed more efficiently. This makes Ruby *perfectly*
suited to things such as:

1. Systems programming
2. Being web-scale

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

  def pythagoras_theorem
    a, b, c = [3, 4, 5]
    a**2 + b**2 == c**2
  end
end
```

Any method you define after `node_module` will be converted to JavaScript before being
executed.

This is a ridiculous proof of concept, so there are a few issues...

## Current limitations

- Things might break if your methods aren't fully self-contained. This
  is because they're currently compiled outside of the scope of the
  class they were defined in. (Although there's nothing preventing an entire class
  being parsed as javascript in future).

- It doesn't actually use Node yet

- It buggers up IRB

- It probably can't handle anything too clever.

- [You can't use 1.9 syntax](https://github.com/quix/live_ast#description)

## What Ruby code will work?

Check [Opal](http://opalrb.org) for that. It's what does all the hard work.
