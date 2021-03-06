expect = require("chai").expect
Caphe = require("../lib/caphe")

methodVisibility = require("./helper/shared_test").methodVisibility


describe "AttrAccessor", ->
  beforeEach ->
    class Person extends Caphe
      @attrAccessor "name", "age"

      constructor: (@city, @job) ->

    @person = new Person("Bar", "Baz")
    @person.setName("Foo")
    @person.setAge(2)

  describe "visibility", ->
    methodVisibility("attrAccessor")

  it "creates getter setter for listed variables", ->
    expect(@person.getAge()).to.eq(2)
    @person.setAge(1)
    expect(@person.getAge()).to.eq(1)
    expect(@person.getName()).to.eq("Foo")
    @person.setName("_Foo")
    expect(@person.getName()).to.eq("_Foo")

    expect(@person.getCity).to.be.undefined
    expect(@person.setCity).to.be.undefined
    expect(@person.getJob).to.be.undefined
    expect(@person.setJob).to.be.undefined

  it "hides the listed variables from public", ->
    expect(@person.name).to.be.undefined
    expect(@person.age).to.be.undefined
    expect(@person.city).to.not.be.undefined
    expect(@person.job).to.not.be.undefined
