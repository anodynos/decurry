R = require 'ramda'
chai = require 'chai'
expect = chai.expect

decurry = require '../code/decurry'

describe 'Given a composed / curried function that expects 4 arguments strictly passed one at a time, it returns a function that can be called as:', ->

  add4NumbersCurried =
    (a) ->
      (b) ->
        (c) ->
          (d) -> a + b + c + d

  R.flip(R.forEach) [
    ['decurry', decurry 4, add4NumbersCurried]
    ['R.uncurryN', R.uncurryN 4, add4NumbersCurried]
  ], ([decurryLabel, add4NumbersDecurried]) ->

    describe "Testing: #{decurryLabel}", ->

      it 'the original curried way, one arg at a time', ->
        expect(add4NumbersDecurried(5)(3)(2)(1)).to.equal 11

      it 'all args at once', ->
        expect(add4NumbersDecurried(5, 3, 2, 1)).to.equal 11

      it 'in other args configurations', ->
        expect(add4NumbersDecurried(5, 3)(2, 1)).to.equal 11
        expect(add4NumbersDecurried(5, 3)(2)(1)).to.equal 11
        expect(add4NumbersDecurried(5)(3, 2)(1)).to.equal 11
        expect(add4NumbersDecurried(5, 3, 2)(1)).to.equal 11
        expect(add4NumbersDecurried(5)(3, 2, 1)).to.equal 11

