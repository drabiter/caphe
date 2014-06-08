expect = require("chai").expect
Caphe = require("../lib/caphe")


shouldEncapsule = (methodName) ->
  it "shows as class method", ->
    expect(Caphe[methodName]?).to.be.true

  it "shows as instance method", ->
    caphe = new Caphe()
    expect(caphe[methodName]?).to.be.false

  it "doesn't show as prototype method", ->
    expect(Caphe::[methodName]?).to.be.false

describe "API", ->
  describe "mixin", ->
    shouldEncapsule("mixin")

  describe "include", ->
    shouldEncapsule("include")

  describe "attrAccessor", ->
    shouldEncapsule("attrAccessor")

  describe "CONST", ->
    shouldEncapsule("CONST")

  describe "forward", ->
    shouldEncapsule("forward")
