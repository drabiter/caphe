expect = require("chai").expect
Caphe = require("../lib/caphe")

delegate = Caphe.delegate


describe "Delegate", ->
  beforeEach ->
    @consumer =
      name: "Foo"
      city: "Bar"
    @provider =
      getName: -> "I am #{@name}"
      getCity: -> "I live at #{@city}"

  it "delegates the provider methods to the consumer", ->
    delegate(@consumer, @provider)

    expect(@consumer.getName).to.not.be.undefined
    expect(@consumer.getCity).to.not.be.undefined
    expect(@consumer.getName()).to.eq("I am Foo")
    expect(@consumer.getCity()).to.eq("I live at Bar")

  it "maintains last delegate", ->
    delegate(@consumer, @provider)
    expect(@consumer.getName).to.not.be.undefined

    @consumer["age"] = 2
    provider =
      getAge: -> @age
    delegate(@consumer, provider)

    expect(@consumer.getAge).to.not.be.undefined
    expect(@consumer.getAge()).to.eq(2)

  it "uses late bound", ->
    delegate(@consumer, @provider)
    @provider.getCity = -> "I work at #{@city}"

    expect(@consumer.getCity).to.not.be.undefined
    expect(@consumer.getCity()).to.eq("I work at Bar")
