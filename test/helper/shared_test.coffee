expect = require("chai").expect
Caphe = require("../../lib/caphe")

class Person extends Caphe

person = new Person()

module.exports =
  methodVisibility: (funcName) ->
    it "is not visible on instance level", ->
      expect(person[funcName]).to.be.undefined

    it "is visible on class level", ->
      expect(Person[funcName]).to.not.be.undefined

    it "is not visible on prototype level", ->
      expect(Person.prototype[funcName]).to.be.undefined
