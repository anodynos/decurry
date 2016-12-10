# decurry v2.0.0

[![Build Status](https://travis-ci.org/anodynos/decurry.svg?branch=master)](https://travis-ci.org/anodynos/decurry)

The `decurry` higher order function, is like the the _reverse_ of `curry`. It works exactly the same as []Ramda's `uncurryN`](http://ramdajs.com/docs/#uncurryN).                                                                                   
Given a composed "curried" function, that due to composition (eg with lodash's [flowRight](https://lodash.com/docs/4.17.2#flowRight) ) has to be called strictly as `fn(arg1)(arg2)(arg3)` to yield its final result, `decurry` gives a "decurried" function that can be called both as the original one, but also in any combination of arguments arrangements, for example: 
  
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


Copyright(c) 2016 Angelos Pikoulas (agelos.pikoulas@gmail.com)

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
