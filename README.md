Caphe
=====

Various design utils for [htpp://coffeescript.org](CoffeeScript).

## Features

**mixin**

Mix modules' behaviors to the model.
```
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

**include**

Like mixin but do it Ruby style.
```
# Refer to previous example
class Person extends Caphe
  @include Talkable, Moveable

person = new Person()

# `person` has speak(), run(), walk() functions now

**attrAccessor**

Create getter & setter methods in Ruby style and hide the properties from public access.
```
class Person extends Caphe
  @attrReader "name", "age"

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
