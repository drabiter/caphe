Caphe
=====

[![Build Status](https://travis-ci.org/drabiter/caphe.svg?branch=master)](https://travis-ci.org/drabiter/caphe)

Various design utils for [htpp://coffeescript.org](CoffeeScript). Implementation of Reg Braithwaite's [article](http://raganwald.com/2014/04/10/mixins-forwarding-delegation.html).

## Features

**> mixin** consumer, modules...

Mix modules' methods to the model.
```coffeescript
class Person

person = new Person()

Talkable =
  speak: ->
    console.log "Yeah!"

Moveable =
  walk: (speed) ->
    console.log "Walk by #{speed}"
  run: (speed) ->
    console.log "Run by #{speed}"

Caphe.mixin(person, Talkable, Moveable)


person.speak() # "Yeah!"
person.walk(8) # "Walk by 8"
person.run(5)  # "Run by 5"
```
----------

**> include** module[, names...]

Like mixin but do it Ruby style. Optionally, specify name of methods that will be included
```coffeescript
Talkable =
  speak: ->
    console.log "Yeah!"

class Person extends Caphe
  @include Talkable
  @include Moveable, 'run'

person = new Person()


person.speak() # "Yeah!"
person.run(6)  # "Run by 6"

person.walk(4) # undefined
```
----------

**> attrAccessor** names...

Create getter & setter methods in Ruby style and hide the properties from public access.
```coffeescript
class Person extends Caphe
  @attrAccessor "name", "age"

  constructor: (@job) ->


person = new Person("Bar")
person.setName("Foo")
person.getName()        # Foo
person.name             # undefined
person.getAge()         # undefined
person.setAge(5)
person.getAge()         # 5
person.age              # undefined
person.job              # Bar
```
----------

**> CONST** name: value, ...

Create constant getters in prototype level.
```coffeescript
class Person extends Caphe
  @CONST EYE: 2, SPECIES: 'homo sapiens'


Person::EYE()      # 2
Person::SPECIES()  # homo sapiens
```
----------

**> forward** consumer, providers...

Mixin with late bound. The forwarded methods have each own module as their context.
```coffeescript
module.foo = -> console.log "a"
module.bar = -> console.log @name
Caphe.forward(person, module)


person.foo()  # a
person.bar()  # undefined

module.bar = -> console.log "b"
person.bar()  # b
```
----------

**> delegate** consumer, providers...

Like `#forward`, but the forwarded methods have the consumer as their context.
```coffeescript
person.name = "John"
module.foo = -> console.log "a"
module.bar = -> console.log @name
Caphe.delegate(person, module)


person.foo()  # a
person.bar()  # John

module.foo = -> console.log "b"
person.foo()  # b
```
----------
