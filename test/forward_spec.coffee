expect = require("chai").expect
Caphe = require("../lib/caphe")

forward = Caphe.forward


describe "Forward", ->
  beforeEach ->
    @consumer = {}
    @provider =
      name: "Foo",
      city: "Bar",
      getName: -> "I am #{@name}"
      getCity: -> "I live at #{@city}"

  it "forwards the provider methods to the consumer", ->
    forward(@consumer, @provider)

    expect(@consumer.getName).to.not.be.undefined
    expect(@consumer.getCity).to.not.be.undefined
    expect(@consumer.getName()).to.eq("I am Foo")
    expect(@consumer.getCity()).to.eq("I live at Bar")

  it "uses late bound", ->
    forward(@consumer, @provider)
    @provider.getCity = -> "I work at #{@city}"

    expect(@consumer.getCity).to.not.be.undefined
    expect(@consumer.getCity()).to.eq("I work at Bar")
