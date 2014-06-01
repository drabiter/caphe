expect = require("chai").expect
mixin = require("../lib/coru").mixin


describe "Mixin", ->
  beforeEach ->
    @consumer = { first_name: "Foo", last_name: "Bar", city: "Baz" }
    @provider =
      fullName: ->
        "#{@first_name} #{@last_name}"
      description: ->
        "#{@fullName()} lives at #{@city}"
    @_provider =
      shortDescription: ->
        "#{@fullName()} from #{@city}"

  it "assigns all methods of provider to consumer", ->
    mixin(@consumer, @provider)

    expect(@consumer.fullName()).to.eq("Foo Bar")
    expect(@consumer.description()).to.eq("Foo Bar lives at Baz")

  it "recieves multiple providers", ->
    mixin(@consumer, @provider, @_provider)

    expect(@consumer.shortDescription()).to.eq("Foo Bar from Baz")

  it "maintains previous mix", ->
    mixin(@consumer, @provider)
    mixin(@consumer, @_provider)

    expect(@consumer.fullName).to.be.defined
    expect(@consumer.shortDescription).to.be.defined
