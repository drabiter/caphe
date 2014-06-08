expect = require("chai").expect
mixin = require("../lib/caphe").mixin

class Consumer
  constructor: (@firstName, @lastName, @city) ->


shouldMix = (consumer) ->
  it "assigns all methods of provider to consumer", ->
    mixin(consumer, @provider1)

    expect(consumer.fullName()).to.eq("Foo Bar")
    expect(consumer.description()).to.eq("Foo Bar lives at Baz")

  it "recieves multiple providers", ->
    mixin(consumer, @provider1, @provider2)

    expect(consumer.shortDescription()).to.eq("Foo Bar from Baz")

  it "maintains previous mix", ->
    mixin(consumer, @provider1)
    mixin(consumer, @provider2)

    expect(consumer.fullName).to.be.defined
    expect(consumer.shortDescription).to.be.defined

describe "Mixin", ->
  beforeEach ->
    @provider1 =
      fullName: -> "#{@firstName} #{@lastName}"
      description: -> "#{@fullName()} lives at #{@city}"
    @provider2 =
      shortDescription: -> "#{@fullName()} from #{@city}"

  describe "with hash consumer", ->
    shouldMix({ firstName: "Foo", lastName: "Bar", city: "Baz" })

  describe "with class instance consumer", ->
    shouldMix(new Consumer("Foo", "Bar", "Baz"))

  it "uses early bound", ->
    consumer = { firstName: "Foo", lastName: "Bar", city: "Baz" }
    mixin(consumer, @provider1)
    @provider1["fullName"] = -> "#{@lastName} #{@firstName}"

    expect(consumer.fullName()).to.not.eq("Bar Foo")
    expect(consumer.fullName()).to.eq("Foo Bar")
