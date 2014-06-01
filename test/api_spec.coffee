expect = require("chai").expect
Coru = require("../lib/coru")


shouldEncapsule = (methodName) ->
  it "shows as class method", ->
    expect(Coru[methodName]?).to.be.true

  it "shows as instance method", ->
    coru = new Coru()
    expect(coru[methodName]?).to.be.false

  it "doesn't show as prototype method", ->
    expect(Coru::[methodName]?).to.be.false

describe "API", ->
  describe "mixin", ->
    shouldEncapsule("mixin")

  describe "include", ->
    shouldEncapsule("include")

  describe "attrAccessor", ->
    shouldEncapsule("attrAccessor")
