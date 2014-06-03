expect = require("chai").expect
Caphe = require("../lib/caphe")


describe "Include", ->
  beforeEach ->
    @module =
      fullDescription: ->
        "#{@name} - #{@age} from #{@city}"

  it "assigns methods of module to the user class", ->
    myModule = @module
    class Person extends Caphe
      @include myModule

      constructor: (@name, @age, @city) ->

    person = new Person("Foo", 10, "Bar")

    expect(person.fullDescription()).to.eq("Foo - 10 from Bar")

  it "recieves multiple modules", ->
    firstModule = @module
    secondModule =
      shortDescription: ->
        "#{@name} (#{@age}), #{@city}"

    class Person extends Caphe
      @include firstModule, secondModule

      constructor: (@name, @age, @city) ->

    person = new Person("Foo", 10, "Bar")

    expect(person.fullDescription()).to.eq("Foo - 10 from Bar")
    expect(person.shortDescription()).to.eq("Foo (10), Bar")
