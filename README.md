# node_module

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

  def existentialism
    self.name = "me"
  end

  def solipsism
    (constants - [self.class]).map(&:remove_const)
  end

  node_module

  def pythagoras_theorm
    a, b, c = [3, 4, 5]
    a**2 + b**2 == c**2
  end
end
```

Any method you define after `node_module` will be converted to JavaScript before being
executed.

This is a ridiculous proof of concept, so there are a few issues...

## Caveats

- Only the body of a method is used, so there is no access to the name
  or arguments passed.

- References to the rest of the class will fail, because it all falls
  out of scope when converted.

- Node isn't actually being used yet, so calls to `puts` will blow up
  as V8 doesn't have the `console` object.

- It buggers up IRB

- No tests. Yet ... !?

- Probably lots of other stuff I don't know about, because I haven't
  felt insane enough to check everything out


## What Ruby code will work?

Check [Opal](http://opalrb.org) for that. It's what does all the hard work.

## WHY!??

> **I'll often drop down to node.js if I really need to be close to the metal**
> https://twitter.com/shit_hn_says/status/234856345579446272

'nuff said.
