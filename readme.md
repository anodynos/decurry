# decurry v2.0.1

[![Build Status](https://travis-ci.org/anodynos/decurry.svg?branch=master)](https://travis-ci.org/anodynos/decurry)

The `decurry` higher order function, is like the the _reverse_ of `curry`.

## Motivation

It works the same as Ramda's [`R.uncurryN`](http://ramdajs.com/docs/#uncurryN) BUT unlike it, it works ALWAYS - for both manual and `R.compose` curried functions. See the 2nd test in [decurry-spec](https://github.com/anodynos/decurry/blob/master/source/spec/decurry-spec.coffee) where `R.uncurryN` fails (as of December 2017, v0.25.0). Why, I dont know, TBO I haven't checked their code, but the documentation says "Returns a function of arity n from a (manually) curried function."!

## Why do we need decurry?

When we compose a 'curried' function, due to composition (eg with `R.compose` or lodash's [`flowRight`](https://lodash.com/docs/4.17.2#flowRight) ), the curried function has to be called strictly as `fn(arg1)(arg2)(arg3)` etc, to yield its final result. Each argument has to be passed one by one, which seems tedious and unnatural.

With `decurry` we get back a `decurried` function that can be called as one-by-one, but also in any combination of arguments  arrangements, for example:

  `fn(arg1)(arg2)(arg3)`

  `fn(arg1, arg2, arg3)`

  `fn(arg1)(arg2, arg3)`

  `fn(arg1, arg2)(arg3)`

  `fn(arg1)(arg2)(arg3)`

  etc, are all equivalent.

Usage:

    var _f = require('lodash/fp');

    var tasks = [
      {
        username: 'Michael', title: 'Curry stray functions',
        complete: true, effort: 'low', priority: 'high'
      },
      {
        username: 'Scott', title: 'Add `fork` function',
        complete: true, effort: 'low', priority: 'low'
      },
    ];

    project = _f.flowRight([_f.map, _f.pick]);

    project(['title', 'priority'])(tasks);
    // works fine, as its called with (arg1)(arg2) and it returns
    // [ { title: 'Curry stray functions', priority: 'high' },
    //   { title: 'Add `fork` function', priority: 'low' }    ]

    project(['title', 'priority'], tasks);
    // doesn't work, `tasks` is completely ignored and it returns a function that is waiting for `tasks` to yield results

    decurriedProject = decurry(2, project);

    decurriedProject(['title', 'priority'], tasks); // works fine
    decurriedProject(['title', 'priority'])(tasks); // works fine also

The same goes for functions with larger arity.

Copyright(c) 2016-2017 Angelos Pikoulas (agelos.pikoulas@gmail.com)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
