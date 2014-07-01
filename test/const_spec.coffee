expect = require("chai").expect
Caphe = require("../lib/caphe")

methodVisibility = require("./helper/shared_test").methodVisibility


describe "Const", ->
  describe "visibility", ->
    methodVisibility("CONST")

  describe "class constant", ->
    it "creates the constant getter for every key-value pair", ->
      class Person extends Caphe
        @CONST EYE: 2, SPECIES: "homo sapiens"

      expect(Person::EYE()).to.eq(2)
      expect(Person::SPECIES()).to.eq("homo sapiens")

      Person::EYE(3)
      expect(Person::EYE()).to.eq(2)

    it "uses uppercase word", ->
      class Person extends Caphe
        @CONST eye: 2, SPECIES: "homo sapiens"

      expect(Person::EYE()).to.eq(2)
      expect(Person::SPECIES()).to.eq("homo sapiens")

      Person::EYE(3)
      expect(Person::EYE()).to.eq(2)
