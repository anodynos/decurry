chai = require 'chai'
expect = chai.expect

decurry = require '../code/decurry'

describe 'Given a composed / curried function that expects 4 arguments strictly passed one at a time, it returns a function that can be called as:', ->

  addOneSingleArgumentCurried =
    (a) ->
      (b) ->
        (c) ->
          (d) -> a + b + c + d


  addDecurried = decurry addOneSingleArgumentCurried, 4

  it 'the original curried way, one arg at a time', ->
    expect(addDecurried(5)(3)(2)(1)).to.equal 11

  it 'all arg at once', ->
    expect(addDecurried(5, 3, 2, 1)).to.equal 11

  it 'in other configurations', ->
    expect(addDecurried(5, 3)(2, 1)).to.equal 11
    expect(addDecurried(5)(3, 2)(1)).to.equal 11
    expect(addDecurried(5, 3, 2)(1)).to.equal 11
    expect(addDecurried(5)(3, 2, 1)).to.equal 11
