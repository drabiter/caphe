expect = require("chai").expect
Coru = require("../lib/coru")


describe "API", ->
  describe "mixin", ->
    it "shows as class method", ->
      expect(Coru.mixin).to.be.defined

    it "shows as instance method", ->
      coru = new Coru()
      expect(coru.mixin).to.be.defined

    it "doesn't show as prototype method", ->
      expect(Coru::mixin).to.be.not.defined

  describe "include", ->
    it "shows as class method", ->
      expect(Coru.include).to.be.defined

    it "shows as instance method", ->
      coru = new Coru()
      expect(coru.include).to.be.defined

    it "doesn't show as prototype method", ->
      expect(Coru::include).to.be.not.defined
