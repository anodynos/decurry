###
  @param arity number of arguments the function (curried or not) expects.
         This is crucial, cause its impossible to know from the curried function how many arguments are expected.

  @param curriedFunction the original curried function

  @return the "decurried" function
###

module.exports = decurry = (arity, curriedFunction) ->
  if typeof arity isnt 'number'
    throw new Error 'decurry(arity, curriedFunction): arity was not a number'

  (args...) ->
    result = curriedFunction
    for arg, i in args when i < arity
      result = result arg

    if args.length < arity
      result = decurry arity - args.length, result

    result
