expect = require("chai").expect
Caphe = require("../lib/caphe")

methodVisibility = require("./helper/shared_test").methodVisibility


describe "Include", ->
  beforeEach ->
    @module =
      fullDescription: ->
        "#{@name} - #{@age} from #{@city}"
      anotherDescription: ->
        "#{@name} of #{@city}"

  describe "visibility", ->
    methodVisibility("include")

  it "assigns all methods of module to the user class", ->
    myModule = @module
    class Person extends Caphe
      @include myModule

      constructor: (@name, @age, @city) ->

    person = new Person("Foo", 10, "Bar")

    expect(person.fullDescription()).to.eq("Foo - 10 from Bar")
    expect(person.anotherDescription()).to.eq("Foo of Bar")

  it "receives partial methods", ->
    myModule = @module
    class Person extends Caphe
      @include myModule, 'anotherDescription'

      constructor: (@name, @age, @city) ->

    person = new Person("Foo", 10, "Bar")

    expect(person.fullDescription).to.be.undefined
    expect(person.anotherDescription).to.not.be.undefined
