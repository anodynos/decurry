R = require 'ramda'
chai = require 'chai'
expect = chai.expect

decurry = require '../code/decurry'

describe '''
  Given a manually curried function that expects 4 arguments,
  strictly passed one by one, it returns a function that can be called as: ''', ->

    add4NumbersCurried =
      (a) ->
        (b) ->
          (c) ->
            (d) -> a + b + c + d

    R.flip(R.forEach) [
      ['decurry', decurry(4, add4NumbersCurried)]
      ['R.uncurryN', R.uncurryN(4, add4NumbersCurried)]
    ], ([decurryLabel, add4NumbersDecurried]) ->

      describe "Testing: #{decurryLabel}", ->
        it '1 + 1 + 1 +1 (one arg at a time)', ->
          expect(add4NumbersDecurried(5)(3)(2)(1)).to.equal 11
        it '4 (args at once)', ->
          expect(add4NumbersDecurried(5, 3, 2, 1)).to.equal 11
        it '3 + 1', ->
          expect(add4NumbersDecurried(5, 3, 2)(1)).to.equal 11
        it '1 + 3', ->
          expect(add4NumbersDecurried(5)(3, 2, 1)).to.equal 11
        it '2 + 2', ->
          expect(add4NumbersDecurried(5, 3)(2, 1)).to.equal 11
        it '2 + 1 + 1', ->
          expect(add4NumbersDecurried(5, 3)(2)(1)).to.equal 11
        it '1 + 1 + 2', ->
          expect(add4NumbersDecurried(5)(3)(2, 1)).to.equal 11
        it '1 + 2 + 1', ->
          expect(add4NumbersDecurried(5)(3, 2)(1)).to.equal 11


describe '''
  Given an `R.compose` function that expects 2 arguments (passed one by one),
  it returns a function that can be called as: ''', ->

    projectComposed = R.compose(R.map, R.pick)

    data = [
      {name: 'angelos', surname: 'pikoulas', age: 42},
      {name: 'anodynos', surname: 'thanatos', age: 43}
    ]

    fields = ['name', 'age']

    resultData = [
      {name: 'angelos', age: 42 },
      {name: 'anodynos', age: 43}
    ]

    it 'decurry gives the expected result', ->
      projectUncurried = decurry(2, projectComposed)
      expect(projectUncurried fields, data).to.deep.equal resultData

    it 'R.uncurryN DOES NOT give the expected result', ->
      projectUncurried = R.uncurryN(2, projectComposed)
      expect(projectUncurried fields, data).to.not.deep.equal resultData
