###
 Given a composed "curried" function, that due to composition it has to be called strictly as fn(arg1)(arg2)(arg3) to yield its result,
 it gives a "decurried" function that can be called both as the original one, but also in any combination of arguments arrangement,

  eg `fn(arg1)(arg2)(arg3)` or `fn(arg1, arg2, arg3)` or `fn(arg1)(arg2, arg3)` or `fn(arg1, arg2)(arg3)` or `fn(arg1)(arg2)(arg3)` etc


 Usage:

    var _f = require('lodash/fp');

    var tasks = [
      {
        username: 'Michael', title: 'Curry stray functions',
        complete: true, effort: 'low', priority: 'low'
      },
      {
        username: 'Scott', title: 'Add `fork` function',
        complete: true, effort: 'low', priority: 'low'
      },
    ]

    project = _f.flowRight([_f.map, _f.pick]);

    project(['title', 'dueDate'])(tasks);
    // works fine, as its called with (arg1)(arg2) and it returns
    // [ { title: 'Curry stray functions' },
    //   { title: 'Add `fork` function' }    ]

    project(['title', 'dueDate'], tasks);
    // doesn't work, `tasks` is completely ignored and it returns a function that is waiting for `tasks` to yield results

    decurriedProject = decurry(project, 2);

    decurriedProject(['title', 'dueDate'], tasks); // works fine
    decurriedProject(['title', 'dueDate'])(tasks); // works fine also


 @param fn the curriedFunction

 @param maxArguments the number of arguments the function (curried or not) expects. This is crucial, cause its impossible to know from the curried function how many arguments are expected

 @return the "decurried" function
###
decurry = (curriedFunction, maxArguments = Infinity) ->
  (args...) ->
    result = curriedFunction
    for arg, i in args when i < maxArguments
      result = result arg

    if args.length < maxArguments
      result = decurry result, maxArguments - args.length

    result

module.exports = decurry
