(function(scope){
'use strict';

function F(arity, fun, wrapper) {
  wrapper.a = arity;
  wrapper.f = fun;
  return wrapper;
}

function F2(fun) {
  return F(2, fun, function(a) { return function(b) { return fun(a,b); }; })
}
function F3(fun) {
  return F(3, fun, function(a) {
    return function(b) { return function(c) { return fun(a, b, c); }; };
  });
}
function F4(fun) {
  return F(4, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return fun(a, b, c, d); }; }; };
  });
}
function F5(fun) {
  return F(5, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return fun(a, b, c, d, e); }; }; }; };
  });
}
function F6(fun) {
  return F(6, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return fun(a, b, c, d, e, f); }; }; }; }; };
  });
}
function F7(fun) {
  return F(7, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return fun(a, b, c, d, e, f, g); }; }; }; }; }; };
  });
}
function F8(fun) {
  return F(8, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) {
    return fun(a, b, c, d, e, f, g, h); }; }; }; }; }; }; };
  });
}
function F9(fun) {
  return F(9, fun, function(a) { return function(b) { return function(c) {
    return function(d) { return function(e) { return function(f) {
    return function(g) { return function(h) { return function(i) {
    return fun(a, b, c, d, e, f, g, h, i); }; }; }; }; }; }; }; };
  });
}

function A2(fun, a, b) {
  return fun.a === 2 ? fun.f(a, b) : fun(a)(b);
}
function A3(fun, a, b, c) {
  return fun.a === 3 ? fun.f(a, b, c) : fun(a)(b)(c);
}
function A4(fun, a, b, c, d) {
  return fun.a === 4 ? fun.f(a, b, c, d) : fun(a)(b)(c)(d);
}
function A5(fun, a, b, c, d, e) {
  return fun.a === 5 ? fun.f(a, b, c, d, e) : fun(a)(b)(c)(d)(e);
}
function A6(fun, a, b, c, d, e, f) {
  return fun.a === 6 ? fun.f(a, b, c, d, e, f) : fun(a)(b)(c)(d)(e)(f);
}
function A7(fun, a, b, c, d, e, f, g) {
  return fun.a === 7 ? fun.f(a, b, c, d, e, f, g) : fun(a)(b)(c)(d)(e)(f)(g);
}
function A8(fun, a, b, c, d, e, f, g, h) {
  return fun.a === 8 ? fun.f(a, b, c, d, e, f, g, h) : fun(a)(b)(c)(d)(e)(f)(g)(h);
}
function A9(fun, a, b, c, d, e, f, g, h, i) {
  return fun.a === 9 ? fun.f(a, b, c, d, e, f, g, h, i) : fun(a)(b)(c)(d)(e)(f)(g)(h)(i);
}

console.warn('Compiled in DEV mode. Follow the advice at https://elm-lang.org/0.19.1/optimize for better performance and smaller assets.');


var _JsArray_empty = [];

function _JsArray_singleton(value)
{
    return [value];
}

function _JsArray_length(array)
{
    return array.length;
}

var _JsArray_initialize = F3(function(size, offset, func)
{
    var result = new Array(size);

    for (var i = 0; i < size; i++)
    {
        result[i] = func(offset + i);
    }

    return result;
});

var _JsArray_initializeFromList = F2(function (max, ls)
{
    var result = new Array(max);

    for (var i = 0; i < max && ls.b; i++)
    {
        result[i] = ls.a;
        ls = ls.b;
    }

    result.length = i;
    return _Utils_Tuple2(result, ls);
});

var _JsArray_unsafeGet = F2(function(index, array)
{
    return array[index];
});

var _JsArray_unsafeSet = F3(function(index, value, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[index] = value;
    return result;
});

var _JsArray_push = F2(function(value, array)
{
    var length = array.length;
    var result = new Array(length + 1);

    for (var i = 0; i < length; i++)
    {
        result[i] = array[i];
    }

    result[length] = value;
    return result;
});

var _JsArray_foldl = F3(function(func, acc, array)
{
    var length = array.length;

    for (var i = 0; i < length; i++)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_foldr = F3(function(func, acc, array)
{
    for (var i = array.length - 1; i >= 0; i--)
    {
        acc = A2(func, array[i], acc);
    }

    return acc;
});

var _JsArray_map = F2(function(func, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = func(array[i]);
    }

    return result;
});

var _JsArray_indexedMap = F3(function(func, offset, array)
{
    var length = array.length;
    var result = new Array(length);

    for (var i = 0; i < length; i++)
    {
        result[i] = A2(func, offset + i, array[i]);
    }

    return result;
});

var _JsArray_slice = F3(function(from, to, array)
{
    return array.slice(from, to);
});

var _JsArray_appendN = F3(function(n, dest, source)
{
    var destLen = dest.length;
    var itemsToCopy = n - destLen;

    if (itemsToCopy > source.length)
    {
        itemsToCopy = source.length;
    }

    var size = destLen + itemsToCopy;
    var result = new Array(size);

    for (var i = 0; i < destLen; i++)
    {
        result[i] = dest[i];
    }

    for (var i = 0; i < itemsToCopy; i++)
    {
        result[i + destLen] = source[i];
    }

    return result;
});



// LOG

var _Debug_log_UNUSED = F2(function(tag, value)
{
	return value;
});

var _Debug_log = F2(function(tag, value)
{
	console.log(tag + ': ' + _Debug_toString(value));
	return value;
});


// TODOS

function _Debug_todo(moduleName, region)
{
	return function(message) {
		_Debug_crash(8, moduleName, region, message);
	};
}

function _Debug_todoCase(moduleName, region, value)
{
	return function(message) {
		_Debug_crash(9, moduleName, region, value, message);
	};
}


// TO STRING

function _Debug_toString_UNUSED(value)
{
	return '<internals>';
}

function _Debug_toString(value)
{
	return _Debug_toAnsiString(false, value);
}

function _Debug_toAnsiString(ansi, value)
{
	if (typeof value === 'function')
	{
		return _Debug_internalColor(ansi, '<function>');
	}

	if (typeof value === 'boolean')
	{
		return _Debug_ctorColor(ansi, value ? 'True' : 'False');
	}

	if (typeof value === 'number')
	{
		return _Debug_numberColor(ansi, value + '');
	}

	if (value instanceof String)
	{
		return _Debug_charColor(ansi, "'" + _Debug_addSlashes(value, true) + "'");
	}

	if (typeof value === 'string')
	{
		return _Debug_stringColor(ansi, '"' + _Debug_addSlashes(value, false) + '"');
	}

	if (typeof value === 'object' && '$' in value)
	{
		var tag = value.$;

		if (typeof tag === 'number')
		{
			return _Debug_internalColor(ansi, '<internals>');
		}

		if (tag[0] === '#')
		{
			var output = [];
			for (var k in value)
			{
				if (k === '$') continue;
				output.push(_Debug_toAnsiString(ansi, value[k]));
			}
			return '(' + output.join(',') + ')';
		}

		if (tag === 'Set_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Set')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Set$toList(value));
		}

		if (tag === 'RBNode_elm_builtin' || tag === 'RBEmpty_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Dict')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Dict$toList(value));
		}

		if (tag === 'Array_elm_builtin')
		{
			return _Debug_ctorColor(ansi, 'Array')
				+ _Debug_fadeColor(ansi, '.fromList') + ' '
				+ _Debug_toAnsiString(ansi, $elm$core$Array$toList(value));
		}

		if (tag === '::' || tag === '[]')
		{
			var output = '[';

			value.b && (output += _Debug_toAnsiString(ansi, value.a), value = value.b)

			for (; value.b; value = value.b) // WHILE_CONS
			{
				output += ',' + _Debug_toAnsiString(ansi, value.a);
			}
			return output + ']';
		}

		var output = '';
		for (var i in value)
		{
			if (i === '$') continue;
			var str = _Debug_toAnsiString(ansi, value[i]);
			var c0 = str[0];
			var parenless = c0 === '{' || c0 === '(' || c0 === '[' || c0 === '<' || c0 === '"' || str.indexOf(' ') < 0;
			output += ' ' + (parenless ? str : '(' + str + ')');
		}
		return _Debug_ctorColor(ansi, tag) + output;
	}

	if (typeof DataView === 'function' && value instanceof DataView)
	{
		return _Debug_stringColor(ansi, '<' + value.byteLength + ' bytes>');
	}

	if (typeof File !== 'undefined' && value instanceof File)
	{
		return _Debug_internalColor(ansi, '<' + value.name + '>');
	}

	if (typeof value === 'object')
	{
		var output = [];
		for (var key in value)
		{
			var field = key[0] === '_' ? key.slice(1) : key;
			output.push(_Debug_fadeColor(ansi, field) + ' = ' + _Debug_toAnsiString(ansi, value[key]));
		}
		if (output.length === 0)
		{
			return '{}';
		}
		return '{ ' + output.join(', ') + ' }';
	}

	return _Debug_internalColor(ansi, '<internals>');
}

function _Debug_addSlashes(str, isChar)
{
	var s = str
		.replace(/\\/g, '\\\\')
		.replace(/\n/g, '\\n')
		.replace(/\t/g, '\\t')
		.replace(/\r/g, '\\r')
		.replace(/\v/g, '\\v')
		.replace(/\0/g, '\\0');

	if (isChar)
	{
		return s.replace(/\'/g, '\\\'');
	}
	else
	{
		return s.replace(/\"/g, '\\"');
	}
}

function _Debug_ctorColor(ansi, string)
{
	return ansi ? '\x1b[96m' + string + '\x1b[0m' : string;
}

function _Debug_numberColor(ansi, string)
{
	return ansi ? '\x1b[95m' + string + '\x1b[0m' : string;
}

function _Debug_stringColor(ansi, string)
{
	return ansi ? '\x1b[93m' + string + '\x1b[0m' : string;
}

function _Debug_charColor(ansi, string)
{
	return ansi ? '\x1b[92m' + string + '\x1b[0m' : string;
}

function _Debug_fadeColor(ansi, string)
{
	return ansi ? '\x1b[37m' + string + '\x1b[0m' : string;
}

function _Debug_internalColor(ansi, string)
{
	return ansi ? '\x1b[36m' + string + '\x1b[0m' : string;
}

function _Debug_toHexDigit(n)
{
	return String.fromCharCode(n < 10 ? 48 + n : 55 + n);
}


// CRASH


function _Debug_crash_UNUSED(identifier)
{
	throw new Error('https://github.com/elm/core/blob/1.0.0/hints/' + identifier + '.md');
}


function _Debug_crash(identifier, fact1, fact2, fact3, fact4)
{
	switch(identifier)
	{
		case 0:
			throw new Error('What node should I take over? In JavaScript I need something like:\n\n    Elm.Main.init({\n        node: document.getElementById("elm-node")\n    })\n\nYou need to do this with any Browser.sandbox or Browser.element program.');

		case 1:
			throw new Error('Browser.application programs cannot handle URLs like this:\n\n    ' + document.location.href + '\n\nWhat is the root? The root of your file system? Try looking at this program with `elm reactor` or some other server.');

		case 2:
			var jsonErrorString = fact1;
			throw new Error('Problem with the flags given to your Elm program on initialization.\n\n' + jsonErrorString);

		case 3:
			var portName = fact1;
			throw new Error('There can only be one port named `' + portName + '`, but your program has multiple.');

		case 4:
			var portName = fact1;
			var problem = fact2;
			throw new Error('Trying to send an unexpected type of value through port `' + portName + '`:\n' + problem);

		case 5:
			throw new Error('Trying to use `(==)` on functions.\nThere is no way to know if functions are "the same" in the Elm sense.\nRead more about this at https://package.elm-lang.org/packages/elm/core/latest/Basics#== which describes why it is this way and what the better version will look like.');

		case 6:
			var moduleName = fact1;
			throw new Error('Your page is loading multiple Elm scripts with a module named ' + moduleName + '. Maybe a duplicate script is getting loaded accidentally? If not, rename one of them so I know which is which!');

		case 8:
			var moduleName = fact1;
			var region = fact2;
			var message = fact3;
			throw new Error('TODO in module `' + moduleName + '` ' + _Debug_regionToString(region) + '\n\n' + message);

		case 9:
			var moduleName = fact1;
			var region = fact2;
			var value = fact3;
			var message = fact4;
			throw new Error(
				'TODO in module `' + moduleName + '` from the `case` expression '
				+ _Debug_regionToString(region) + '\n\nIt received the following value:\n\n    '
				+ _Debug_toString(value).replace('\n', '\n    ')
				+ '\n\nBut the branch that handles it says:\n\n    ' + message.replace('\n', '\n    ')
			);

		case 10:
			throw new Error('Bug in https://github.com/elm/virtual-dom/issues');

		case 11:
			throw new Error('Cannot perform mod 0. Division by zero error.');
	}
}

function _Debug_regionToString(region)
{
	if (region.start.line === region.end.line)
	{
		return 'on line ' + region.start.line;
	}
	return 'on lines ' + region.start.line + ' through ' + region.end.line;
}



// EQUALITY

function _Utils_eq(x, y)
{
	for (
		var pair, stack = [], isEqual = _Utils_eqHelp(x, y, 0, stack);
		isEqual && (pair = stack.pop());
		isEqual = _Utils_eqHelp(pair.a, pair.b, 0, stack)
		)
	{}

	return isEqual;
}

function _Utils_eqHelp(x, y, depth, stack)
{
	if (x === y)
	{
		return true;
	}

	if (typeof x !== 'object' || x === null || y === null)
	{
		typeof x === 'function' && _Debug_crash(5);
		return false;
	}

	if (depth > 100)
	{
		stack.push(_Utils_Tuple2(x,y));
		return true;
	}

	/**/
	if (x.$ === 'Set_elm_builtin')
	{
		x = $elm$core$Set$toList(x);
		y = $elm$core$Set$toList(y);
	}
	if (x.$ === 'RBNode_elm_builtin' || x.$ === 'RBEmpty_elm_builtin')
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	/**_UNUSED/
	if (x.$ < 0)
	{
		x = $elm$core$Dict$toList(x);
		y = $elm$core$Dict$toList(y);
	}
	//*/

	for (var key in x)
	{
		if (!_Utils_eqHelp(x[key], y[key], depth + 1, stack))
		{
			return false;
		}
	}
	return true;
}

var _Utils_equal = F2(_Utils_eq);
var _Utils_notEqual = F2(function(a, b) { return !_Utils_eq(a,b); });



// COMPARISONS

// Code in Generate/JavaScript.hs, Basics.js, and List.js depends on
// the particular integer values assigned to LT, EQ, and GT.

function _Utils_cmp(x, y, ord)
{
	if (typeof x !== 'object')
	{
		return x === y ? /*EQ*/ 0 : x < y ? /*LT*/ -1 : /*GT*/ 1;
	}

	/**/
	if (x instanceof String)
	{
		var a = x.valueOf();
		var b = y.valueOf();
		return a === b ? 0 : a < b ? -1 : 1;
	}
	//*/

	/**_UNUSED/
	if (typeof x.$ === 'undefined')
	//*/
	/**/
	if (x.$[0] === '#')
	//*/
	{
		return (ord = _Utils_cmp(x.a, y.a))
			? ord
			: (ord = _Utils_cmp(x.b, y.b))
				? ord
				: _Utils_cmp(x.c, y.c);
	}

	// traverse conses until end of a list or a mismatch
	for (; x.b && y.b && !(ord = _Utils_cmp(x.a, y.a)); x = x.b, y = y.b) {} // WHILE_CONSES
	return ord || (x.b ? /*GT*/ 1 : y.b ? /*LT*/ -1 : /*EQ*/ 0);
}

var _Utils_lt = F2(function(a, b) { return _Utils_cmp(a, b) < 0; });
var _Utils_le = F2(function(a, b) { return _Utils_cmp(a, b) < 1; });
var _Utils_gt = F2(function(a, b) { return _Utils_cmp(a, b) > 0; });
var _Utils_ge = F2(function(a, b) { return _Utils_cmp(a, b) >= 0; });

var _Utils_compare = F2(function(x, y)
{
	var n = _Utils_cmp(x, y);
	return n < 0 ? $elm$core$Basics$LT : n ? $elm$core$Basics$GT : $elm$core$Basics$EQ;
});


// COMMON VALUES

var _Utils_Tuple0_UNUSED = 0;
var _Utils_Tuple0 = { $: '#0' };

function _Utils_Tuple2_UNUSED(a, b) { return { a: a, b: b }; }
function _Utils_Tuple2(a, b) { return { $: '#2', a: a, b: b }; }

function _Utils_Tuple3_UNUSED(a, b, c) { return { a: a, b: b, c: c }; }
function _Utils_Tuple3(a, b, c) { return { $: '#3', a: a, b: b, c: c }; }

function _Utils_chr_UNUSED(c) { return c; }
function _Utils_chr(c) { return new String(c); }


// RECORDS

function _Utils_update(oldRecord, updatedFields)
{
	var newRecord = {};

	for (var key in oldRecord)
	{
		newRecord[key] = oldRecord[key];
	}

	for (var key in updatedFields)
	{
		newRecord[key] = updatedFields[key];
	}

	return newRecord;
}


// APPEND

var _Utils_append = F2(_Utils_ap);

function _Utils_ap(xs, ys)
{
	// append Strings
	if (typeof xs === 'string')
	{
		return xs + ys;
	}

	// append Lists
	if (!xs.b)
	{
		return ys;
	}
	var root = _List_Cons(xs.a, ys);
	xs = xs.b
	for (var curr = root; xs.b; xs = xs.b) // WHILE_CONS
	{
		curr = curr.b = _List_Cons(xs.a, ys);
	}
	return root;
}



var _List_Nil_UNUSED = { $: 0 };
var _List_Nil = { $: '[]' };

function _List_Cons_UNUSED(hd, tl) { return { $: 1, a: hd, b: tl }; }
function _List_Cons(hd, tl) { return { $: '::', a: hd, b: tl }; }


var _List_cons = F2(_List_Cons);

function _List_fromArray(arr)
{
	var out = _List_Nil;
	for (var i = arr.length; i--; )
	{
		out = _List_Cons(arr[i], out);
	}
	return out;
}

function _List_toArray(xs)
{
	for (var out = []; xs.b; xs = xs.b) // WHILE_CONS
	{
		out.push(xs.a);
	}
	return out;
}

var _List_map2 = F3(function(f, xs, ys)
{
	for (var arr = []; xs.b && ys.b; xs = xs.b, ys = ys.b) // WHILE_CONSES
	{
		arr.push(A2(f, xs.a, ys.a));
	}
	return _List_fromArray(arr);
});

var _List_map3 = F4(function(f, xs, ys, zs)
{
	for (var arr = []; xs.b && ys.b && zs.b; xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A3(f, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map4 = F5(function(f, ws, xs, ys, zs)
{
	for (var arr = []; ws.b && xs.b && ys.b && zs.b; ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A4(f, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_map5 = F6(function(f, vs, ws, xs, ys, zs)
{
	for (var arr = []; vs.b && ws.b && xs.b && ys.b && zs.b; vs = vs.b, ws = ws.b, xs = xs.b, ys = ys.b, zs = zs.b) // WHILE_CONSES
	{
		arr.push(A5(f, vs.a, ws.a, xs.a, ys.a, zs.a));
	}
	return _List_fromArray(arr);
});

var _List_sortBy = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		return _Utils_cmp(f(a), f(b));
	}));
});

var _List_sortWith = F2(function(f, xs)
{
	return _List_fromArray(_List_toArray(xs).sort(function(a, b) {
		var ord = A2(f, a, b);
		return ord === $elm$core$Basics$EQ ? 0 : ord === $elm$core$Basics$LT ? -1 : 1;
	}));
});



// MATH

var _Basics_add = F2(function(a, b) { return a + b; });
var _Basics_sub = F2(function(a, b) { return a - b; });
var _Basics_mul = F2(function(a, b) { return a * b; });
var _Basics_fdiv = F2(function(a, b) { return a / b; });
var _Basics_idiv = F2(function(a, b) { return (a / b) | 0; });
var _Basics_pow = F2(Math.pow);

var _Basics_remainderBy = F2(function(b, a) { return a % b; });

// https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/divmodnote-letter.pdf
var _Basics_modBy = F2(function(modulus, x)
{
	var answer = x % modulus;
	return modulus === 0
		? _Debug_crash(11)
		:
	((answer > 0 && modulus < 0) || (answer < 0 && modulus > 0))
		? answer + modulus
		: answer;
});


// TRIGONOMETRY

var _Basics_pi = Math.PI;
var _Basics_e = Math.E;
var _Basics_cos = Math.cos;
var _Basics_sin = Math.sin;
var _Basics_tan = Math.tan;
var _Basics_acos = Math.acos;
var _Basics_asin = Math.asin;
var _Basics_atan = Math.atan;
var _Basics_atan2 = F2(Math.atan2);


// MORE MATH

function _Basics_toFloat(x) { return x; }
function _Basics_truncate(n) { return n | 0; }
function _Basics_isInfinite(n) { return n === Infinity || n === -Infinity; }

var _Basics_ceiling = Math.ceil;
var _Basics_floor = Math.floor;
var _Basics_round = Math.round;
var _Basics_sqrt = Math.sqrt;
var _Basics_log = Math.log;
var _Basics_isNaN = isNaN;


// BOOLEANS

function _Basics_not(bool) { return !bool; }
var _Basics_and = F2(function(a, b) { return a && b; });
var _Basics_or  = F2(function(a, b) { return a || b; });
var _Basics_xor = F2(function(a, b) { return a !== b; });



var _String_cons = F2(function(chr, str)
{
	return chr + str;
});

function _String_uncons(string)
{
	var word = string.charCodeAt(0);
	return !isNaN(word)
		? $elm$core$Maybe$Just(
			0xD800 <= word && word <= 0xDBFF
				? _Utils_Tuple2(_Utils_chr(string[0] + string[1]), string.slice(2))
				: _Utils_Tuple2(_Utils_chr(string[0]), string.slice(1))
		)
		: $elm$core$Maybe$Nothing;
}

var _String_append = F2(function(a, b)
{
	return a + b;
});

function _String_length(str)
{
	return str.length;
}

var _String_map = F2(function(func, string)
{
	var len = string.length;
	var array = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = string.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			array[i] = func(_Utils_chr(string[i] + string[i+1]));
			i += 2;
			continue;
		}
		array[i] = func(_Utils_chr(string[i]));
		i++;
	}
	return array.join('');
});

var _String_filter = F2(function(isGood, str)
{
	var arr = [];
	var len = str.length;
	var i = 0;
	while (i < len)
	{
		var char = str[i];
		var word = str.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += str[i];
			i++;
		}

		if (isGood(_Utils_chr(char)))
		{
			arr.push(char);
		}
	}
	return arr.join('');
});

function _String_reverse(str)
{
	var len = str.length;
	var arr = new Array(len);
	var i = 0;
	while (i < len)
	{
		var word = str.charCodeAt(i);
		if (0xD800 <= word && word <= 0xDBFF)
		{
			arr[len - i] = str[i + 1];
			i++;
			arr[len - i] = str[i - 1];
			i++;
		}
		else
		{
			arr[len - i] = str[i];
			i++;
		}
	}
	return arr.join('');
}

var _String_foldl = F3(function(func, state, string)
{
	var len = string.length;
	var i = 0;
	while (i < len)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		i++;
		if (0xD800 <= word && word <= 0xDBFF)
		{
			char += string[i];
			i++;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_foldr = F3(function(func, state, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		state = A2(func, _Utils_chr(char), state);
	}
	return state;
});

var _String_split = F2(function(sep, str)
{
	return str.split(sep);
});

var _String_join = F2(function(sep, strs)
{
	return strs.join(sep);
});

var _String_slice = F3(function(start, end, str) {
	return str.slice(start, end);
});

function _String_trim(str)
{
	return str.trim();
}

function _String_trimLeft(str)
{
	return str.replace(/^\s+/, '');
}

function _String_trimRight(str)
{
	return str.replace(/\s+$/, '');
}

function _String_words(str)
{
	return _List_fromArray(str.trim().split(/\s+/g));
}

function _String_lines(str)
{
	return _List_fromArray(str.split(/\r\n|\r|\n/g));
}

function _String_toUpper(str)
{
	return str.toUpperCase();
}

function _String_toLower(str)
{
	return str.toLowerCase();
}

var _String_any = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (isGood(_Utils_chr(char)))
		{
			return true;
		}
	}
	return false;
});

var _String_all = F2(function(isGood, string)
{
	var i = string.length;
	while (i--)
	{
		var char = string[i];
		var word = string.charCodeAt(i);
		if (0xDC00 <= word && word <= 0xDFFF)
		{
			i--;
			char = string[i] + char;
		}
		if (!isGood(_Utils_chr(char)))
		{
			return false;
		}
	}
	return true;
});

var _String_contains = F2(function(sub, str)
{
	return str.indexOf(sub) > -1;
});

var _String_startsWith = F2(function(sub, str)
{
	return str.indexOf(sub) === 0;
});

var _String_endsWith = F2(function(sub, str)
{
	return str.length >= sub.length &&
		str.lastIndexOf(sub) === str.length - sub.length;
});

var _String_indexes = F2(function(sub, str)
{
	var subLen = sub.length;

	if (subLen < 1)
	{
		return _List_Nil;
	}

	var i = 0;
	var is = [];

	while ((i = str.indexOf(sub, i)) > -1)
	{
		is.push(i);
		i = i + subLen;
	}

	return _List_fromArray(is);
});


// TO STRING

function _String_fromNumber(number)
{
	return number + '';
}


// INT CONVERSIONS

function _String_toInt(str)
{
	var total = 0;
	var code0 = str.charCodeAt(0);
	var start = code0 == 0x2B /* + */ || code0 == 0x2D /* - */ ? 1 : 0;

	for (var i = start; i < str.length; ++i)
	{
		var code = str.charCodeAt(i);
		if (code < 0x30 || 0x39 < code)
		{
			return $elm$core$Maybe$Nothing;
		}
		total = 10 * total + code - 0x30;
	}

	return i == start
		? $elm$core$Maybe$Nothing
		: $elm$core$Maybe$Just(code0 == 0x2D ? -total : total);
}


// FLOAT CONVERSIONS

function _String_toFloat(s)
{
	// check if it is a hex, octal, or binary number
	if (s.length === 0 || /[\sxbo]/.test(s))
	{
		return $elm$core$Maybe$Nothing;
	}
	var n = +s;
	// faster isNaN check
	return n === n ? $elm$core$Maybe$Just(n) : $elm$core$Maybe$Nothing;
}

function _String_fromList(chars)
{
	return _List_toArray(chars).join('');
}




function _Char_toCode(char)
{
	var code = char.charCodeAt(0);
	if (0xD800 <= code && code <= 0xDBFF)
	{
		return (code - 0xD800) * 0x400 + char.charCodeAt(1) - 0xDC00 + 0x10000
	}
	return code;
}

function _Char_fromCode(code)
{
	return _Utils_chr(
		(code < 0 || 0x10FFFF < code)
			? '\uFFFD'
			:
		(code <= 0xFFFF)
			? String.fromCharCode(code)
			:
		(code -= 0x10000,
			String.fromCharCode(Math.floor(code / 0x400) + 0xD800, code % 0x400 + 0xDC00)
		)
	);
}

function _Char_toUpper(char)
{
	return _Utils_chr(char.toUpperCase());
}

function _Char_toLower(char)
{
	return _Utils_chr(char.toLowerCase());
}

function _Char_toLocaleUpper(char)
{
	return _Utils_chr(char.toLocaleUpperCase());
}

function _Char_toLocaleLower(char)
{
	return _Utils_chr(char.toLocaleLowerCase());
}



/**/
function _Json_errorToString(error)
{
	return $elm$json$Json$Decode$errorToString(error);
}
//*/


// CORE DECODERS

function _Json_succeed(msg)
{
	return {
		$: 0,
		a: msg
	};
}

function _Json_fail(msg)
{
	return {
		$: 1,
		a: msg
	};
}

function _Json_decodePrim(decoder)
{
	return { $: 2, b: decoder };
}

var _Json_decodeInt = _Json_decodePrim(function(value) {
	return (typeof value !== 'number')
		? _Json_expecting('an INT', value)
		:
	(-2147483647 < value && value < 2147483647 && (value | 0) === value)
		? $elm$core$Result$Ok(value)
		:
	(isFinite(value) && !(value % 1))
		? $elm$core$Result$Ok(value)
		: _Json_expecting('an INT', value);
});

var _Json_decodeBool = _Json_decodePrim(function(value) {
	return (typeof value === 'boolean')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a BOOL', value);
});

var _Json_decodeFloat = _Json_decodePrim(function(value) {
	return (typeof value === 'number')
		? $elm$core$Result$Ok(value)
		: _Json_expecting('a FLOAT', value);
});

var _Json_decodeValue = _Json_decodePrim(function(value) {
	return $elm$core$Result$Ok(_Json_wrap(value));
});

var _Json_decodeString = _Json_decodePrim(function(value) {
	return (typeof value === 'string')
		? $elm$core$Result$Ok(value)
		: (value instanceof String)
			? $elm$core$Result$Ok(value + '')
			: _Json_expecting('a STRING', value);
});

function _Json_decodeList(decoder) { return { $: 3, b: decoder }; }
function _Json_decodeArray(decoder) { return { $: 4, b: decoder }; }

function _Json_decodeNull(value) { return { $: 5, c: value }; }

var _Json_decodeField = F2(function(field, decoder)
{
	return {
		$: 6,
		d: field,
		b: decoder
	};
});

var _Json_decodeIndex = F2(function(index, decoder)
{
	return {
		$: 7,
		e: index,
		b: decoder
	};
});

function _Json_decodeKeyValuePairs(decoder)
{
	return {
		$: 8,
		b: decoder
	};
}

function _Json_mapMany(f, decoders)
{
	return {
		$: 9,
		f: f,
		g: decoders
	};
}

var _Json_andThen = F2(function(callback, decoder)
{
	return {
		$: 10,
		b: decoder,
		h: callback
	};
});

function _Json_oneOf(decoders)
{
	return {
		$: 11,
		g: decoders
	};
}


// DECODING OBJECTS

var _Json_map1 = F2(function(f, d1)
{
	return _Json_mapMany(f, [d1]);
});

var _Json_map2 = F3(function(f, d1, d2)
{
	return _Json_mapMany(f, [d1, d2]);
});

var _Json_map3 = F4(function(f, d1, d2, d3)
{
	return _Json_mapMany(f, [d1, d2, d3]);
});

var _Json_map4 = F5(function(f, d1, d2, d3, d4)
{
	return _Json_mapMany(f, [d1, d2, d3, d4]);
});

var _Json_map5 = F6(function(f, d1, d2, d3, d4, d5)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5]);
});

var _Json_map6 = F7(function(f, d1, d2, d3, d4, d5, d6)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6]);
});

var _Json_map7 = F8(function(f, d1, d2, d3, d4, d5, d6, d7)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7]);
});

var _Json_map8 = F9(function(f, d1, d2, d3, d4, d5, d6, d7, d8)
{
	return _Json_mapMany(f, [d1, d2, d3, d4, d5, d6, d7, d8]);
});


// DECODE

var _Json_runOnString = F2(function(decoder, string)
{
	try
	{
		var value = JSON.parse(string);
		return _Json_runHelp(decoder, value);
	}
	catch (e)
	{
		return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'This is not valid JSON! ' + e.message, _Json_wrap(string)));
	}
});

var _Json_run = F2(function(decoder, value)
{
	return _Json_runHelp(decoder, _Json_unwrap(value));
});

function _Json_runHelp(decoder, value)
{
	switch (decoder.$)
	{
		case 2:
			return decoder.b(value);

		case 5:
			return (value === null)
				? $elm$core$Result$Ok(decoder.c)
				: _Json_expecting('null', value);

		case 3:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('a LIST', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _List_fromArray);

		case 4:
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			return _Json_runArrayDecoder(decoder.b, value, _Json_toElmArray);

		case 6:
			var field = decoder.d;
			if (typeof value !== 'object' || value === null || !(field in value))
			{
				return _Json_expecting('an OBJECT with a field named `' + field + '`', value);
			}
			var result = _Json_runHelp(decoder.b, value[field]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, field, result.a));

		case 7:
			var index = decoder.e;
			if (!_Json_isArray(value))
			{
				return _Json_expecting('an ARRAY', value);
			}
			if (index >= value.length)
			{
				return _Json_expecting('a LONGER array. Need index ' + index + ' but only see ' + value.length + ' entries', value);
			}
			var result = _Json_runHelp(decoder.b, value[index]);
			return ($elm$core$Result$isOk(result)) ? result : $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, index, result.a));

		case 8:
			if (typeof value !== 'object' || value === null || _Json_isArray(value))
			{
				return _Json_expecting('an OBJECT', value);
			}

			var keyValuePairs = _List_Nil;
			// TODO test perf of Object.keys and switch when support is good enough
			for (var key in value)
			{
				if (value.hasOwnProperty(key))
				{
					var result = _Json_runHelp(decoder.b, value[key]);
					if (!$elm$core$Result$isOk(result))
					{
						return $elm$core$Result$Err(A2($elm$json$Json$Decode$Field, key, result.a));
					}
					keyValuePairs = _List_Cons(_Utils_Tuple2(key, result.a), keyValuePairs);
				}
			}
			return $elm$core$Result$Ok($elm$core$List$reverse(keyValuePairs));

		case 9:
			var answer = decoder.f;
			var decoders = decoder.g;
			for (var i = 0; i < decoders.length; i++)
			{
				var result = _Json_runHelp(decoders[i], value);
				if (!$elm$core$Result$isOk(result))
				{
					return result;
				}
				answer = answer(result.a);
			}
			return $elm$core$Result$Ok(answer);

		case 10:
			var result = _Json_runHelp(decoder.b, value);
			return (!$elm$core$Result$isOk(result))
				? result
				: _Json_runHelp(decoder.h(result.a), value);

		case 11:
			var errors = _List_Nil;
			for (var temp = decoder.g; temp.b; temp = temp.b) // WHILE_CONS
			{
				var result = _Json_runHelp(temp.a, value);
				if ($elm$core$Result$isOk(result))
				{
					return result;
				}
				errors = _List_Cons(result.a, errors);
			}
			return $elm$core$Result$Err($elm$json$Json$Decode$OneOf($elm$core$List$reverse(errors)));

		case 1:
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, decoder.a, _Json_wrap(value)));

		case 0:
			return $elm$core$Result$Ok(decoder.a);
	}
}

function _Json_runArrayDecoder(decoder, value, toElmValue)
{
	var len = value.length;
	var array = new Array(len);
	for (var i = 0; i < len; i++)
	{
		var result = _Json_runHelp(decoder, value[i]);
		if (!$elm$core$Result$isOk(result))
		{
			return $elm$core$Result$Err(A2($elm$json$Json$Decode$Index, i, result.a));
		}
		array[i] = result.a;
	}
	return $elm$core$Result$Ok(toElmValue(array));
}

function _Json_isArray(value)
{
	return Array.isArray(value) || (typeof FileList !== 'undefined' && value instanceof FileList);
}

function _Json_toElmArray(array)
{
	return A2($elm$core$Array$initialize, array.length, function(i) { return array[i]; });
}

function _Json_expecting(type, value)
{
	return $elm$core$Result$Err(A2($elm$json$Json$Decode$Failure, 'Expecting ' + type, _Json_wrap(value)));
}


// EQUALITY

function _Json_equality(x, y)
{
	if (x === y)
	{
		return true;
	}

	if (x.$ !== y.$)
	{
		return false;
	}

	switch (x.$)
	{
		case 0:
		case 1:
			return x.a === y.a;

		case 2:
			return x.b === y.b;

		case 5:
			return x.c === y.c;

		case 3:
		case 4:
		case 8:
			return _Json_equality(x.b, y.b);

		case 6:
			return x.d === y.d && _Json_equality(x.b, y.b);

		case 7:
			return x.e === y.e && _Json_equality(x.b, y.b);

		case 9:
			return x.f === y.f && _Json_listEquality(x.g, y.g);

		case 10:
			return x.h === y.h && _Json_equality(x.b, y.b);

		case 11:
			return _Json_listEquality(x.g, y.g);
	}
}

function _Json_listEquality(aDecoders, bDecoders)
{
	var len = aDecoders.length;
	if (len !== bDecoders.length)
	{
		return false;
	}
	for (var i = 0; i < len; i++)
	{
		if (!_Json_equality(aDecoders[i], bDecoders[i]))
		{
			return false;
		}
	}
	return true;
}


// ENCODE

var _Json_encode = F2(function(indentLevel, value)
{
	return JSON.stringify(_Json_unwrap(value), null, indentLevel) + '';
});

function _Json_wrap(value) { return { $: 0, a: value }; }
function _Json_unwrap(value) { return value.a; }

function _Json_wrap_UNUSED(value) { return value; }
function _Json_unwrap_UNUSED(value) { return value; }

function _Json_emptyArray() { return []; }
function _Json_emptyObject() { return {}; }

var _Json_addField = F3(function(key, value, object)
{
	object[key] = _Json_unwrap(value);
	return object;
});

function _Json_addEntry(func)
{
	return F2(function(entry, array)
	{
		array.push(_Json_unwrap(func(entry)));
		return array;
	});
}

var _Json_encodeNull = _Json_wrap(null);



// TASKS

function _Scheduler_succeed(value)
{
	return {
		$: 0,
		a: value
	};
}

function _Scheduler_fail(error)
{
	return {
		$: 1,
		a: error
	};
}

function _Scheduler_binding(callback)
{
	return {
		$: 2,
		b: callback,
		c: null
	};
}

var _Scheduler_andThen = F2(function(callback, task)
{
	return {
		$: 3,
		b: callback,
		d: task
	};
});

var _Scheduler_onError = F2(function(callback, task)
{
	return {
		$: 4,
		b: callback,
		d: task
	};
});

function _Scheduler_receive(callback)
{
	return {
		$: 5,
		b: callback
	};
}


// PROCESSES

var _Scheduler_guid = 0;

function _Scheduler_rawSpawn(task)
{
	var proc = {
		$: 0,
		e: _Scheduler_guid++,
		f: task,
		g: null,
		h: []
	};

	_Scheduler_enqueue(proc);

	return proc;
}

function _Scheduler_spawn(task)
{
	return _Scheduler_binding(function(callback) {
		callback(_Scheduler_succeed(_Scheduler_rawSpawn(task)));
	});
}

function _Scheduler_rawSend(proc, msg)
{
	proc.h.push(msg);
	_Scheduler_enqueue(proc);
}

var _Scheduler_send = F2(function(proc, msg)
{
	return _Scheduler_binding(function(callback) {
		_Scheduler_rawSend(proc, msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});

function _Scheduler_kill(proc)
{
	return _Scheduler_binding(function(callback) {
		var task = proc.f;
		if (task.$ === 2 && task.c)
		{
			task.c();
		}

		proc.f = null;

		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
}


/* STEP PROCESSES

type alias Process =
  { $ : tag
  , id : unique_id
  , root : Task
  , stack : null | { $: SUCCEED | FAIL, a: callback, b: stack }
  , mailbox : [msg]
  }

*/


var _Scheduler_working = false;
var _Scheduler_queue = [];


function _Scheduler_enqueue(proc)
{
	_Scheduler_queue.push(proc);
	if (_Scheduler_working)
	{
		return;
	}
	_Scheduler_working = true;
	while (proc = _Scheduler_queue.shift())
	{
		_Scheduler_step(proc);
	}
	_Scheduler_working = false;
}


function _Scheduler_step(proc)
{
	while (proc.f)
	{
		var rootTag = proc.f.$;
		if (rootTag === 0 || rootTag === 1)
		{
			while (proc.g && proc.g.$ !== rootTag)
			{
				proc.g = proc.g.i;
			}
			if (!proc.g)
			{
				return;
			}
			proc.f = proc.g.b(proc.f.a);
			proc.g = proc.g.i;
		}
		else if (rootTag === 2)
		{
			proc.f.c = proc.f.b(function(newRoot) {
				proc.f = newRoot;
				_Scheduler_enqueue(proc);
			});
			return;
		}
		else if (rootTag === 5)
		{
			if (proc.h.length === 0)
			{
				return;
			}
			proc.f = proc.f.b(proc.h.shift());
		}
		else // if (rootTag === 3 || rootTag === 4)
		{
			proc.g = {
				$: rootTag === 3 ? 0 : 1,
				b: proc.f.b,
				i: proc.g
			};
			proc.f = proc.f.d;
		}
	}
}



function _Process_sleep(time)
{
	return _Scheduler_binding(function(callback) {
		var id = setTimeout(function() {
			callback(_Scheduler_succeed(_Utils_Tuple0));
		}, time);

		return function() { clearTimeout(id); };
	});
}




// PROGRAMS


var _Platform_worker = F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function() { return function() {} }
	);
});



// INITIALIZE A PROGRAM


function _Platform_initialize(flagDecoder, args, init, update, subscriptions, stepperBuilder)
{
	var result = A2(_Json_run, flagDecoder, _Json_wrap(args ? args['flags'] : undefined));
	$elm$core$Result$isOk(result) || _Debug_crash(2 /**/, _Json_errorToString(result.a) /**/);
	var managers = {};
	var initPair = init(result.a);
	var model = initPair.a;
	var stepper = stepperBuilder(sendToApp, model);
	var ports = _Platform_setupEffects(managers, sendToApp);

	function sendToApp(msg, viewMetadata)
	{
		var pair = A2(update, msg, model);
		stepper(model = pair.a, viewMetadata);
		_Platform_enqueueEffects(managers, pair.b, subscriptions(model));
	}

	_Platform_enqueueEffects(managers, initPair.b, subscriptions(model));

	return ports ? { ports: ports } : {};
}



// TRACK PRELOADS
//
// This is used by code in elm/browser and elm/http
// to register any HTTP requests that are triggered by init.
//


var _Platform_preload;


function _Platform_registerPreload(url)
{
	_Platform_preload.add(url);
}



// EFFECT MANAGERS


var _Platform_effectManagers = {};


function _Platform_setupEffects(managers, sendToApp)
{
	var ports;

	// setup all necessary effect managers
	for (var key in _Platform_effectManagers)
	{
		var manager = _Platform_effectManagers[key];

		if (manager.a)
		{
			ports = ports || {};
			ports[key] = manager.a(key, sendToApp);
		}

		managers[key] = _Platform_instantiateManager(manager, sendToApp);
	}

	return ports;
}


function _Platform_createManager(init, onEffects, onSelfMsg, cmdMap, subMap)
{
	return {
		b: init,
		c: onEffects,
		d: onSelfMsg,
		e: cmdMap,
		f: subMap
	};
}


function _Platform_instantiateManager(info, sendToApp)
{
	var router = {
		g: sendToApp,
		h: undefined
	};

	var onEffects = info.c;
	var onSelfMsg = info.d;
	var cmdMap = info.e;
	var subMap = info.f;

	function loop(state)
	{
		return A2(_Scheduler_andThen, loop, _Scheduler_receive(function(msg)
		{
			var value = msg.a;

			if (msg.$ === 0)
			{
				return A3(onSelfMsg, router, value, state);
			}

			return cmdMap && subMap
				? A4(onEffects, router, value.i, value.j, state)
				: A3(onEffects, router, cmdMap ? value.i : value.j, state);
		}));
	}

	return router.h = _Scheduler_rawSpawn(A2(_Scheduler_andThen, loop, info.b));
}



// ROUTING


var _Platform_sendToApp = F2(function(router, msg)
{
	return _Scheduler_binding(function(callback)
	{
		router.g(msg);
		callback(_Scheduler_succeed(_Utils_Tuple0));
	});
});


var _Platform_sendToSelf = F2(function(router, msg)
{
	return A2(_Scheduler_send, router.h, {
		$: 0,
		a: msg
	});
});



// BAGS


function _Platform_leaf(home)
{
	return function(value)
	{
		return {
			$: 1,
			k: home,
			l: value
		};
	};
}


function _Platform_batch(list)
{
	return {
		$: 2,
		m: list
	};
}


var _Platform_map = F2(function(tagger, bag)
{
	return {
		$: 3,
		n: tagger,
		o: bag
	}
});



// PIPE BAGS INTO EFFECT MANAGERS
//
// Effects must be queued!
//
// Say your init contains a synchronous command, like Time.now or Time.here
//
//   - This will produce a batch of effects (FX_1)
//   - The synchronous task triggers the subsequent `update` call
//   - This will produce a batch of effects (FX_2)
//
// If we just start dispatching FX_2, subscriptions from FX_2 can be processed
// before subscriptions from FX_1. No good! Earlier versions of this code had
// this problem, leading to these reports:
//
//   https://github.com/elm/core/issues/980
//   https://github.com/elm/core/pull/981
//   https://github.com/elm/compiler/issues/1776
//
// The queue is necessary to avoid ordering issues for synchronous commands.


// Why use true/false here? Why not just check the length of the queue?
// The goal is to detect "are we currently dispatching effects?" If we
// are, we need to bail and let the ongoing while loop handle things.
//
// Now say the queue has 1 element. When we dequeue the final element,
// the queue will be empty, but we are still actively dispatching effects.
// So you could get queue jumping in a really tricky category of cases.
//
var _Platform_effectsQueue = [];
var _Platform_effectsActive = false;


function _Platform_enqueueEffects(managers, cmdBag, subBag)
{
	_Platform_effectsQueue.push({ p: managers, q: cmdBag, r: subBag });

	if (_Platform_effectsActive) return;

	_Platform_effectsActive = true;
	for (var fx; fx = _Platform_effectsQueue.shift(); )
	{
		_Platform_dispatchEffects(fx.p, fx.q, fx.r);
	}
	_Platform_effectsActive = false;
}


function _Platform_dispatchEffects(managers, cmdBag, subBag)
{
	var effectsDict = {};
	_Platform_gatherEffects(true, cmdBag, effectsDict, null);
	_Platform_gatherEffects(false, subBag, effectsDict, null);

	for (var home in managers)
	{
		_Scheduler_rawSend(managers[home], {
			$: 'fx',
			a: effectsDict[home] || { i: _List_Nil, j: _List_Nil }
		});
	}
}


function _Platform_gatherEffects(isCmd, bag, effectsDict, taggers)
{
	switch (bag.$)
	{
		case 1:
			var home = bag.k;
			var effect = _Platform_toEffect(isCmd, home, taggers, bag.l);
			effectsDict[home] = _Platform_insert(isCmd, effect, effectsDict[home]);
			return;

		case 2:
			for (var list = bag.m; list.b; list = list.b) // WHILE_CONS
			{
				_Platform_gatherEffects(isCmd, list.a, effectsDict, taggers);
			}
			return;

		case 3:
			_Platform_gatherEffects(isCmd, bag.o, effectsDict, {
				s: bag.n,
				t: taggers
			});
			return;
	}
}


function _Platform_toEffect(isCmd, home, taggers, value)
{
	function applyTaggers(x)
	{
		for (var temp = taggers; temp; temp = temp.t)
		{
			x = temp.s(x);
		}
		return x;
	}

	var map = isCmd
		? _Platform_effectManagers[home].e
		: _Platform_effectManagers[home].f;

	return A2(map, applyTaggers, value)
}


function _Platform_insert(isCmd, newEffect, effects)
{
	effects = effects || { i: _List_Nil, j: _List_Nil };

	isCmd
		? (effects.i = _List_Cons(newEffect, effects.i))
		: (effects.j = _List_Cons(newEffect, effects.j));

	return effects;
}



// PORTS


function _Platform_checkPortName(name)
{
	if (_Platform_effectManagers[name])
	{
		_Debug_crash(3, name)
	}
}



// OUTGOING PORTS


function _Platform_outgoingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		e: _Platform_outgoingPortMap,
		u: converter,
		a: _Platform_setupOutgoingPort
	};
	return _Platform_leaf(name);
}


var _Platform_outgoingPortMap = F2(function(tagger, value) { return value; });


function _Platform_setupOutgoingPort(name)
{
	var subs = [];
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Process_sleep(0);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, cmdList, state)
	{
		for ( ; cmdList.b; cmdList = cmdList.b) // WHILE_CONS
		{
			// grab a separate reference to subs in case unsubscribe is called
			var currentSubs = subs;
			var value = _Json_unwrap(converter(cmdList.a));
			for (var i = 0; i < currentSubs.length; i++)
			{
				currentSubs[i](value);
			}
		}
		return init;
	});

	// PUBLIC API

	function subscribe(callback)
	{
		subs.push(callback);
	}

	function unsubscribe(callback)
	{
		// copy subs into a new array in case unsubscribe is called within a
		// subscribed callback
		subs = subs.slice();
		var index = subs.indexOf(callback);
		if (index >= 0)
		{
			subs.splice(index, 1);
		}
	}

	return {
		subscribe: subscribe,
		unsubscribe: unsubscribe
	};
}



// INCOMING PORTS


function _Platform_incomingPort(name, converter)
{
	_Platform_checkPortName(name);
	_Platform_effectManagers[name] = {
		f: _Platform_incomingPortMap,
		u: converter,
		a: _Platform_setupIncomingPort
	};
	return _Platform_leaf(name);
}


var _Platform_incomingPortMap = F2(function(tagger, finalTagger)
{
	return function(value)
	{
		return tagger(finalTagger(value));
	};
});


function _Platform_setupIncomingPort(name, sendToApp)
{
	var subs = _List_Nil;
	var converter = _Platform_effectManagers[name].u;

	// CREATE MANAGER

	var init = _Scheduler_succeed(null);

	_Platform_effectManagers[name].b = init;
	_Platform_effectManagers[name].c = F3(function(router, subList, state)
	{
		subs = subList;
		return init;
	});

	// PUBLIC API

	function send(incomingValue)
	{
		var result = A2(_Json_run, converter, _Json_wrap(incomingValue));

		$elm$core$Result$isOk(result) || _Debug_crash(4, name, result.a);

		var value = result.a;
		for (var temp = subs; temp.b; temp = temp.b) // WHILE_CONS
		{
			sendToApp(temp.a(value));
		}
	}

	return { send: send };
}



// EXPORT ELM MODULES
//
// Have DEBUG and PROD versions so that we can (1) give nicer errors in
// debug mode and (2) not pay for the bits needed for that in prod mode.
//


function _Platform_export_UNUSED(exports)
{
	scope['Elm']
		? _Platform_mergeExportsProd(scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsProd(obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6)
				: _Platform_mergeExportsProd(obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}


function _Platform_export(exports)
{
	scope['Elm']
		? _Platform_mergeExportsDebug('Elm', scope['Elm'], exports)
		: scope['Elm'] = exports;
}


function _Platform_mergeExportsDebug(moduleName, obj, exports)
{
	for (var name in exports)
	{
		(name in obj)
			? (name == 'init')
				? _Debug_crash(6, moduleName)
				: _Platform_mergeExportsDebug(moduleName + '.' + name, obj[name], exports[name])
			: (obj[name] = exports[name]);
	}
}




// HELPERS


var _VirtualDom_divertHrefToApp;

var _VirtualDom_doc = typeof document !== 'undefined' ? document : {};


function _VirtualDom_appendChild(parent, child)
{
	parent.appendChild(child);
}

var _VirtualDom_init = F4(function(virtualNode, flagDecoder, debugMetadata, args)
{
	// NOTE: this function needs _Platform_export available to work

	/**_UNUSED/
	var node = args['node'];
	//*/
	/**/
	var node = args && args['node'] ? args['node'] : _Debug_crash(0);
	//*/

	node.parentNode.replaceChild(
		_VirtualDom_render(virtualNode, function() {}),
		node
	);

	return {};
});



// TEXT


function _VirtualDom_text(string)
{
	return {
		$: 0,
		a: string
	};
}



// NODE


var _VirtualDom_nodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 1,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_node = _VirtualDom_nodeNS(undefined);



// KEYED NODE


var _VirtualDom_keyedNodeNS = F2(function(namespace, tag)
{
	return F2(function(factList, kidList)
	{
		for (var kids = [], descendantsCount = 0; kidList.b; kidList = kidList.b) // WHILE_CONS
		{
			var kid = kidList.a;
			descendantsCount += (kid.b.b || 0);
			kids.push(kid);
		}
		descendantsCount += kids.length;

		return {
			$: 2,
			c: tag,
			d: _VirtualDom_organizeFacts(factList),
			e: kids,
			f: namespace,
			b: descendantsCount
		};
	});
});


var _VirtualDom_keyedNode = _VirtualDom_keyedNodeNS(undefined);



// CUSTOM


function _VirtualDom_custom(factList, model, render, diff)
{
	return {
		$: 3,
		d: _VirtualDom_organizeFacts(factList),
		g: model,
		h: render,
		i: diff
	};
}



// MAP


var _VirtualDom_map = F2(function(tagger, node)
{
	return {
		$: 4,
		j: tagger,
		k: node,
		b: 1 + (node.b || 0)
	};
});



// LAZY


function _VirtualDom_thunk(refs, thunk)
{
	return {
		$: 5,
		l: refs,
		m: thunk,
		k: undefined
	};
}

var _VirtualDom_lazy = F2(function(func, a)
{
	return _VirtualDom_thunk([func, a], function() {
		return func(a);
	});
});

var _VirtualDom_lazy2 = F3(function(func, a, b)
{
	return _VirtualDom_thunk([func, a, b], function() {
		return A2(func, a, b);
	});
});

var _VirtualDom_lazy3 = F4(function(func, a, b, c)
{
	return _VirtualDom_thunk([func, a, b, c], function() {
		return A3(func, a, b, c);
	});
});

var _VirtualDom_lazy4 = F5(function(func, a, b, c, d)
{
	return _VirtualDom_thunk([func, a, b, c, d], function() {
		return A4(func, a, b, c, d);
	});
});

var _VirtualDom_lazy5 = F6(function(func, a, b, c, d, e)
{
	return _VirtualDom_thunk([func, a, b, c, d, e], function() {
		return A5(func, a, b, c, d, e);
	});
});

var _VirtualDom_lazy6 = F7(function(func, a, b, c, d, e, f)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f], function() {
		return A6(func, a, b, c, d, e, f);
	});
});

var _VirtualDom_lazy7 = F8(function(func, a, b, c, d, e, f, g)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g], function() {
		return A7(func, a, b, c, d, e, f, g);
	});
});

var _VirtualDom_lazy8 = F9(function(func, a, b, c, d, e, f, g, h)
{
	return _VirtualDom_thunk([func, a, b, c, d, e, f, g, h], function() {
		return A8(func, a, b, c, d, e, f, g, h);
	});
});



// FACTS


var _VirtualDom_on = F2(function(key, handler)
{
	return {
		$: 'a0',
		n: key,
		o: handler
	};
});
var _VirtualDom_style = F2(function(key, value)
{
	return {
		$: 'a1',
		n: key,
		o: value
	};
});
var _VirtualDom_property = F2(function(key, value)
{
	return {
		$: 'a2',
		n: key,
		o: value
	};
});
var _VirtualDom_attribute = F2(function(key, value)
{
	return {
		$: 'a3',
		n: key,
		o: value
	};
});
var _VirtualDom_attributeNS = F3(function(namespace, key, value)
{
	return {
		$: 'a4',
		n: key,
		o: { f: namespace, o: value }
	};
});



// XSS ATTACK VECTOR CHECKS


function _VirtualDom_noScript(tag)
{
	return tag == 'script' ? 'p' : tag;
}

function _VirtualDom_noOnOrFormAction(key)
{
	return /^(on|formAction$)/i.test(key) ? 'data-' + key : key;
}

function _VirtualDom_noInnerHtmlOrFormAction(key)
{
	return key == 'innerHTML' || key == 'formAction' ? 'data-' + key : key;
}

function _VirtualDom_noJavaScriptUri_UNUSED(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,'')) ? '' : value;
}

function _VirtualDom_noJavaScriptUri(value)
{
	return /^javascript:/i.test(value.replace(/\s/g,''))
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}

function _VirtualDom_noJavaScriptOrHtmlUri_UNUSED(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value) ? '' : value;
}

function _VirtualDom_noJavaScriptOrHtmlUri(value)
{
	return /^\s*(javascript:|data:text\/html)/i.test(value)
		? 'javascript:alert("This is an XSS vector. Please use ports or web components instead.")'
		: value;
}



// MAP FACTS


var _VirtualDom_mapAttribute = F2(function(func, attr)
{
	return (attr.$ === 'a0')
		? A2(_VirtualDom_on, attr.n, _VirtualDom_mapHandler(func, attr.o))
		: attr;
});

function _VirtualDom_mapHandler(func, handler)
{
	var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

	// 0 = Normal
	// 1 = MayStopPropagation
	// 2 = MayPreventDefault
	// 3 = Custom

	return {
		$: handler.$,
		a:
			!tag
				? A2($elm$json$Json$Decode$map, func, handler.a)
				:
			A3($elm$json$Json$Decode$map2,
				tag < 3
					? _VirtualDom_mapEventTuple
					: _VirtualDom_mapEventRecord,
				$elm$json$Json$Decode$succeed(func),
				handler.a
			)
	};
}

var _VirtualDom_mapEventTuple = F2(function(func, tuple)
{
	return _Utils_Tuple2(func(tuple.a), tuple.b);
});

var _VirtualDom_mapEventRecord = F2(function(func, record)
{
	return {
		message: func(record.message),
		stopPropagation: record.stopPropagation,
		preventDefault: record.preventDefault
	}
});



// ORGANIZE FACTS


function _VirtualDom_organizeFacts(factList)
{
	for (var facts = {}; factList.b; factList = factList.b) // WHILE_CONS
	{
		var entry = factList.a;

		var tag = entry.$;
		var key = entry.n;
		var value = entry.o;

		if (tag === 'a2')
		{
			(key === 'className')
				? _VirtualDom_addClass(facts, key, _Json_unwrap(value))
				: facts[key] = _Json_unwrap(value);

			continue;
		}

		var subFacts = facts[tag] || (facts[tag] = {});
		(tag === 'a3' && key === 'class')
			? _VirtualDom_addClass(subFacts, key, value)
			: subFacts[key] = value;
	}

	return facts;
}

function _VirtualDom_addClass(object, key, newClass)
{
	var classes = object[key];
	object[key] = classes ? classes + ' ' + newClass : newClass;
}



// RENDER


function _VirtualDom_render(vNode, eventNode)
{
	var tag = vNode.$;

	if (tag === 5)
	{
		return _VirtualDom_render(vNode.k || (vNode.k = vNode.m()), eventNode);
	}

	if (tag === 0)
	{
		return _VirtualDom_doc.createTextNode(vNode.a);
	}

	if (tag === 4)
	{
		var subNode = vNode.k;
		var tagger = vNode.j;

		while (subNode.$ === 4)
		{
			typeof tagger !== 'object'
				? tagger = [tagger, subNode.j]
				: tagger.push(subNode.j);

			subNode = subNode.k;
		}

		var subEventRoot = { j: tagger, p: eventNode };
		var domNode = _VirtualDom_render(subNode, subEventRoot);
		domNode.elm_event_node_ref = subEventRoot;
		return domNode;
	}

	if (tag === 3)
	{
		var domNode = vNode.h(vNode.g);
		_VirtualDom_applyFacts(domNode, eventNode, vNode.d);
		return domNode;
	}

	// at this point `tag` must be 1 or 2

	var domNode = vNode.f
		? _VirtualDom_doc.createElementNS(vNode.f, vNode.c)
		: _VirtualDom_doc.createElement(vNode.c);

	if (_VirtualDom_divertHrefToApp && vNode.c == 'a')
	{
		domNode.addEventListener('click', _VirtualDom_divertHrefToApp(domNode));
	}

	_VirtualDom_applyFacts(domNode, eventNode, vNode.d);

	for (var kids = vNode.e, i = 0; i < kids.length; i++)
	{
		_VirtualDom_appendChild(domNode, _VirtualDom_render(tag === 1 ? kids[i] : kids[i].b, eventNode));
	}

	return domNode;
}



// APPLY FACTS


function _VirtualDom_applyFacts(domNode, eventNode, facts)
{
	for (var key in facts)
	{
		var value = facts[key];

		key === 'a1'
			? _VirtualDom_applyStyles(domNode, value)
			:
		key === 'a0'
			? _VirtualDom_applyEvents(domNode, eventNode, value)
			:
		key === 'a3'
			? _VirtualDom_applyAttrs(domNode, value)
			:
		key === 'a4'
			? _VirtualDom_applyAttrsNS(domNode, value)
			:
		((key !== 'value' && key !== 'checked') || domNode[key] !== value) && (domNode[key] = value);
	}
}



// APPLY STYLES


function _VirtualDom_applyStyles(domNode, styles)
{
	var domNodeStyle = domNode.style;

	for (var key in styles)
	{
		domNodeStyle[key] = styles[key];
	}
}



// APPLY ATTRS


function _VirtualDom_applyAttrs(domNode, attrs)
{
	for (var key in attrs)
	{
		var value = attrs[key];
		typeof value !== 'undefined'
			? domNode.setAttribute(key, value)
			: domNode.removeAttribute(key);
	}
}



// APPLY NAMESPACED ATTRS


function _VirtualDom_applyAttrsNS(domNode, nsAttrs)
{
	for (var key in nsAttrs)
	{
		var pair = nsAttrs[key];
		var namespace = pair.f;
		var value = pair.o;

		typeof value !== 'undefined'
			? domNode.setAttributeNS(namespace, key, value)
			: domNode.removeAttributeNS(namespace, key);
	}
}



// APPLY EVENTS


function _VirtualDom_applyEvents(domNode, eventNode, events)
{
	var allCallbacks = domNode.elmFs || (domNode.elmFs = {});

	for (var key in events)
	{
		var newHandler = events[key];
		var oldCallback = allCallbacks[key];

		if (!newHandler)
		{
			domNode.removeEventListener(key, oldCallback);
			allCallbacks[key] = undefined;
			continue;
		}

		if (oldCallback)
		{
			var oldHandler = oldCallback.q;
			if (oldHandler.$ === newHandler.$)
			{
				oldCallback.q = newHandler;
				continue;
			}
			domNode.removeEventListener(key, oldCallback);
		}

		oldCallback = _VirtualDom_makeCallback(eventNode, newHandler);
		domNode.addEventListener(key, oldCallback,
			_VirtualDom_passiveSupported
			&& { passive: $elm$virtual_dom$VirtualDom$toHandlerInt(newHandler) < 2 }
		);
		allCallbacks[key] = oldCallback;
	}
}



// PASSIVE EVENTS


var _VirtualDom_passiveSupported;

try
{
	window.addEventListener('t', null, Object.defineProperty({}, 'passive', {
		get: function() { _VirtualDom_passiveSupported = true; }
	}));
}
catch(e) {}



// EVENT HANDLERS


function _VirtualDom_makeCallback(eventNode, initialHandler)
{
	function callback(event)
	{
		var handler = callback.q;
		var result = _Json_runHelp(handler.a, event);

		if (!$elm$core$Result$isOk(result))
		{
			return;
		}

		var tag = $elm$virtual_dom$VirtualDom$toHandlerInt(handler);

		// 0 = Normal
		// 1 = MayStopPropagation
		// 2 = MayPreventDefault
		// 3 = Custom

		var value = result.a;
		var message = !tag ? value : tag < 3 ? value.a : value.message;
		var stopPropagation = tag == 1 ? value.b : tag == 3 && value.stopPropagation;
		var currentEventNode = (
			stopPropagation && event.stopPropagation(),
			(tag == 2 ? value.b : tag == 3 && value.preventDefault) && event.preventDefault(),
			eventNode
		);
		var tagger;
		var i;
		while (tagger = currentEventNode.j)
		{
			if (typeof tagger == 'function')
			{
				message = tagger(message);
			}
			else
			{
				for (var i = tagger.length; i--; )
				{
					message = tagger[i](message);
				}
			}
			currentEventNode = currentEventNode.p;
		}
		currentEventNode(message, stopPropagation); // stopPropagation implies isSync
	}

	callback.q = initialHandler;

	return callback;
}

function _VirtualDom_equalEvents(x, y)
{
	return x.$ == y.$ && _Json_equality(x.a, y.a);
}



// DIFF


// TODO: Should we do patches like in iOS?
//
// type Patch
//   = At Int Patch
//   | Batch (List Patch)
//   | Change ...
//
// How could it not be better?
//
function _VirtualDom_diff(x, y)
{
	var patches = [];
	_VirtualDom_diffHelp(x, y, patches, 0);
	return patches;
}


function _VirtualDom_pushPatch(patches, type, index, data)
{
	var patch = {
		$: type,
		r: index,
		s: data,
		t: undefined,
		u: undefined
	};
	patches.push(patch);
	return patch;
}


function _VirtualDom_diffHelp(x, y, patches, index)
{
	if (x === y)
	{
		return;
	}

	var xType = x.$;
	var yType = y.$;

	// Bail if you run into different types of nodes. Implies that the
	// structure has changed significantly and it's not worth a diff.
	if (xType !== yType)
	{
		if (xType === 1 && yType === 2)
		{
			y = _VirtualDom_dekey(y);
			yType = 1;
		}
		else
		{
			_VirtualDom_pushPatch(patches, 0, index, y);
			return;
		}
	}

	// Now we know that both nodes are the same $.
	switch (yType)
	{
		case 5:
			var xRefs = x.l;
			var yRefs = y.l;
			var i = xRefs.length;
			var same = i === yRefs.length;
			while (same && i--)
			{
				same = xRefs[i] === yRefs[i];
			}
			if (same)
			{
				y.k = x.k;
				return;
			}
			y.k = y.m();
			var subPatches = [];
			_VirtualDom_diffHelp(x.k, y.k, subPatches, 0);
			subPatches.length > 0 && _VirtualDom_pushPatch(patches, 1, index, subPatches);
			return;

		case 4:
			// gather nested taggers
			var xTaggers = x.j;
			var yTaggers = y.j;
			var nesting = false;

			var xSubNode = x.k;
			while (xSubNode.$ === 4)
			{
				nesting = true;

				typeof xTaggers !== 'object'
					? xTaggers = [xTaggers, xSubNode.j]
					: xTaggers.push(xSubNode.j);

				xSubNode = xSubNode.k;
			}

			var ySubNode = y.k;
			while (ySubNode.$ === 4)
			{
				nesting = true;

				typeof yTaggers !== 'object'
					? yTaggers = [yTaggers, ySubNode.j]
					: yTaggers.push(ySubNode.j);

				ySubNode = ySubNode.k;
			}

			// Just bail if different numbers of taggers. This implies the
			// structure of the virtual DOM has changed.
			if (nesting && xTaggers.length !== yTaggers.length)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			// check if taggers are "the same"
			if (nesting ? !_VirtualDom_pairwiseRefEqual(xTaggers, yTaggers) : xTaggers !== yTaggers)
			{
				_VirtualDom_pushPatch(patches, 2, index, yTaggers);
			}

			// diff everything below the taggers
			_VirtualDom_diffHelp(xSubNode, ySubNode, patches, index + 1);
			return;

		case 0:
			if (x.a !== y.a)
			{
				_VirtualDom_pushPatch(patches, 3, index, y.a);
			}
			return;

		case 1:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKids);
			return;

		case 2:
			_VirtualDom_diffNodes(x, y, patches, index, _VirtualDom_diffKeyedKids);
			return;

		case 3:
			if (x.h !== y.h)
			{
				_VirtualDom_pushPatch(patches, 0, index, y);
				return;
			}

			var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
			factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

			var patch = y.i(x.g, y.g);
			patch && _VirtualDom_pushPatch(patches, 5, index, patch);

			return;
	}
}

// assumes the incoming arrays are the same length
function _VirtualDom_pairwiseRefEqual(as, bs)
{
	for (var i = 0; i < as.length; i++)
	{
		if (as[i] !== bs[i])
		{
			return false;
		}
	}

	return true;
}

function _VirtualDom_diffNodes(x, y, patches, index, diffKids)
{
	// Bail if obvious indicators have changed. Implies more serious
	// structural changes such that it's not worth it to diff.
	if (x.c !== y.c || x.f !== y.f)
	{
		_VirtualDom_pushPatch(patches, 0, index, y);
		return;
	}

	var factsDiff = _VirtualDom_diffFacts(x.d, y.d);
	factsDiff && _VirtualDom_pushPatch(patches, 4, index, factsDiff);

	diffKids(x, y, patches, index);
}



// DIFF FACTS


// TODO Instead of creating a new diff object, it's possible to just test if
// there *is* a diff. During the actual patch, do the diff again and make the
// modifications directly. This way, there's no new allocations. Worth it?
function _VirtualDom_diffFacts(x, y, category)
{
	var diff;

	// look for changes and removals
	for (var xKey in x)
	{
		if (xKey === 'a1' || xKey === 'a0' || xKey === 'a3' || xKey === 'a4')
		{
			var subDiff = _VirtualDom_diffFacts(x[xKey], y[xKey] || {}, xKey);
			if (subDiff)
			{
				diff = diff || {};
				diff[xKey] = subDiff;
			}
			continue;
		}

		// remove if not in the new facts
		if (!(xKey in y))
		{
			diff = diff || {};
			diff[xKey] =
				!category
					? (typeof x[xKey] === 'string' ? '' : null)
					:
				(category === 'a1')
					? ''
					:
				(category === 'a0' || category === 'a3')
					? undefined
					:
				{ f: x[xKey].f, o: undefined };

			continue;
		}

		var xValue = x[xKey];
		var yValue = y[xKey];

		// reference equal, so don't worry about it
		if (xValue === yValue && xKey !== 'value' && xKey !== 'checked'
			|| category === 'a0' && _VirtualDom_equalEvents(xValue, yValue))
		{
			continue;
		}

		diff = diff || {};
		diff[xKey] = yValue;
	}

	// add new stuff
	for (var yKey in y)
	{
		if (!(yKey in x))
		{
			diff = diff || {};
			diff[yKey] = y[yKey];
		}
	}

	return diff;
}



// DIFF KIDS


function _VirtualDom_diffKids(xParent, yParent, patches, index)
{
	var xKids = xParent.e;
	var yKids = yParent.e;

	var xLen = xKids.length;
	var yLen = yKids.length;

	// FIGURE OUT IF THERE ARE INSERTS OR REMOVALS

	if (xLen > yLen)
	{
		_VirtualDom_pushPatch(patches, 6, index, {
			v: yLen,
			i: xLen - yLen
		});
	}
	else if (xLen < yLen)
	{
		_VirtualDom_pushPatch(patches, 7, index, {
			v: xLen,
			e: yKids
		});
	}

	// PAIRWISE DIFF EVERYTHING ELSE

	for (var minLen = xLen < yLen ? xLen : yLen, i = 0; i < minLen; i++)
	{
		var xKid = xKids[i];
		_VirtualDom_diffHelp(xKid, yKids[i], patches, ++index);
		index += xKid.b || 0;
	}
}



// KEYED DIFF


function _VirtualDom_diffKeyedKids(xParent, yParent, patches, rootIndex)
{
	var localPatches = [];

	var changes = {}; // Dict String Entry
	var inserts = []; // Array { index : Int, entry : Entry }
	// type Entry = { tag : String, vnode : VNode, index : Int, data : _ }

	var xKids = xParent.e;
	var yKids = yParent.e;
	var xLen = xKids.length;
	var yLen = yKids.length;
	var xIndex = 0;
	var yIndex = 0;

	var index = rootIndex;

	while (xIndex < xLen && yIndex < yLen)
	{
		var x = xKids[xIndex];
		var y = yKids[yIndex];

		var xKey = x.a;
		var yKey = y.a;
		var xNode = x.b;
		var yNode = y.b;

		var newMatch = undefined;
		var oldMatch = undefined;

		// check if keys match

		if (xKey === yKey)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNode, localPatches, index);
			index += xNode.b || 0;

			xIndex++;
			yIndex++;
			continue;
		}

		// look ahead 1 to detect insertions and removals.

		var xNext = xKids[xIndex + 1];
		var yNext = yKids[yIndex + 1];

		if (xNext)
		{
			var xNextKey = xNext.a;
			var xNextNode = xNext.b;
			oldMatch = yKey === xNextKey;
		}

		if (yNext)
		{
			var yNextKey = yNext.a;
			var yNextNode = yNext.b;
			newMatch = xKey === yNextKey;
		}


		// swap x and y
		if (newMatch && oldMatch)
		{
			index++;
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			_VirtualDom_insertNode(changes, localPatches, xKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNextNode, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		// insert y
		if (newMatch)
		{
			index++;
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			_VirtualDom_diffHelp(xNode, yNextNode, localPatches, index);
			index += xNode.b || 0;

			xIndex += 1;
			yIndex += 2;
			continue;
		}

		// remove x
		if (oldMatch)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 1;
			continue;
		}

		// remove x, insert y
		if (xNext && xNextKey === yNextKey)
		{
			index++;
			_VirtualDom_removeNode(changes, localPatches, xKey, xNode, index);
			_VirtualDom_insertNode(changes, localPatches, yKey, yNode, yIndex, inserts);
			index += xNode.b || 0;

			index++;
			_VirtualDom_diffHelp(xNextNode, yNextNode, localPatches, index);
			index += xNextNode.b || 0;

			xIndex += 2;
			yIndex += 2;
			continue;
		}

		break;
	}

	// eat up any remaining nodes with removeNode and insertNode

	while (xIndex < xLen)
	{
		index++;
		var x = xKids[xIndex];
		var xNode = x.b;
		_VirtualDom_removeNode(changes, localPatches, x.a, xNode, index);
		index += xNode.b || 0;
		xIndex++;
	}

	while (yIndex < yLen)
	{
		var endInserts = endInserts || [];
		var y = yKids[yIndex];
		_VirtualDom_insertNode(changes, localPatches, y.a, y.b, undefined, endInserts);
		yIndex++;
	}

	if (localPatches.length > 0 || inserts.length > 0 || endInserts)
	{
		_VirtualDom_pushPatch(patches, 8, rootIndex, {
			w: localPatches,
			x: inserts,
			y: endInserts
		});
	}
}



// CHANGES FROM KEYED DIFF


var _VirtualDom_POSTFIX = '_elmW6BL';


function _VirtualDom_insertNode(changes, localPatches, key, vnode, yIndex, inserts)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		entry = {
			c: 0,
			z: vnode,
			r: yIndex,
			s: undefined
		};

		inserts.push({ r: yIndex, A: entry });
		changes[key] = entry;

		return;
	}

	// this key was removed earlier, a match!
	if (entry.c === 1)
	{
		inserts.push({ r: yIndex, A: entry });

		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(entry.z, vnode, subPatches, entry.r);
		entry.r = yIndex;
		entry.s.s = {
			w: subPatches,
			A: entry
		};

		return;
	}

	// this key has already been inserted or moved, a duplicate!
	_VirtualDom_insertNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, yIndex, inserts);
}


function _VirtualDom_removeNode(changes, localPatches, key, vnode, index)
{
	var entry = changes[key];

	// never seen this key before
	if (!entry)
	{
		var patch = _VirtualDom_pushPatch(localPatches, 9, index, undefined);

		changes[key] = {
			c: 1,
			z: vnode,
			r: index,
			s: patch
		};

		return;
	}

	// this key was inserted earlier, a match!
	if (entry.c === 0)
	{
		entry.c = 2;
		var subPatches = [];
		_VirtualDom_diffHelp(vnode, entry.z, subPatches, index);

		_VirtualDom_pushPatch(localPatches, 9, index, {
			w: subPatches,
			A: entry
		});

		return;
	}

	// this key has already been removed or moved, a duplicate!
	_VirtualDom_removeNode(changes, localPatches, key + _VirtualDom_POSTFIX, vnode, index);
}



// ADD DOM NODES
//
// Each DOM node has an "index" assigned in order of traversal. It is important
// to minimize our crawl over the actual DOM, so these indexes (along with the
// descendantsCount of virtual nodes) let us skip touching entire subtrees of
// the DOM if we know there are no patches there.


function _VirtualDom_addDomNodes(domNode, vNode, patches, eventNode)
{
	_VirtualDom_addDomNodesHelp(domNode, vNode, patches, 0, 0, vNode.b, eventNode);
}


// assumes `patches` is non-empty and indexes increase monotonically.
function _VirtualDom_addDomNodesHelp(domNode, vNode, patches, i, low, high, eventNode)
{
	var patch = patches[i];
	var index = patch.r;

	while (index === low)
	{
		var patchType = patch.$;

		if (patchType === 1)
		{
			_VirtualDom_addDomNodes(domNode, vNode.k, patch.s, eventNode);
		}
		else if (patchType === 8)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var subPatches = patch.s.w;
			if (subPatches.length > 0)
			{
				_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
			}
		}
		else if (patchType === 9)
		{
			patch.t = domNode;
			patch.u = eventNode;

			var data = patch.s;
			if (data)
			{
				data.A.s = domNode;
				var subPatches = data.w;
				if (subPatches.length > 0)
				{
					_VirtualDom_addDomNodesHelp(domNode, vNode, subPatches, 0, low, high, eventNode);
				}
			}
		}
		else
		{
			patch.t = domNode;
			patch.u = eventNode;
		}

		i++;

		if (!(patch = patches[i]) || (index = patch.r) > high)
		{
			return i;
		}
	}

	var tag = vNode.$;

	if (tag === 4)
	{
		var subNode = vNode.k;

		while (subNode.$ === 4)
		{
			subNode = subNode.k;
		}

		return _VirtualDom_addDomNodesHelp(domNode, subNode, patches, i, low + 1, high, domNode.elm_event_node_ref);
	}

	// tag must be 1 or 2 at this point

	var vKids = vNode.e;
	var childNodes = domNode.childNodes;
	for (var j = 0; j < vKids.length; j++)
	{
		low++;
		var vKid = tag === 1 ? vKids[j] : vKids[j].b;
		var nextLow = low + (vKid.b || 0);
		if (low <= index && index <= nextLow)
		{
			i = _VirtualDom_addDomNodesHelp(childNodes[j], vKid, patches, i, low, nextLow, eventNode);
			if (!(patch = patches[i]) || (index = patch.r) > high)
			{
				return i;
			}
		}
		low = nextLow;
	}
	return i;
}



// APPLY PATCHES


function _VirtualDom_applyPatches(rootDomNode, oldVirtualNode, patches, eventNode)
{
	if (patches.length === 0)
	{
		return rootDomNode;
	}

	_VirtualDom_addDomNodes(rootDomNode, oldVirtualNode, patches, eventNode);
	return _VirtualDom_applyPatchesHelp(rootDomNode, patches);
}

function _VirtualDom_applyPatchesHelp(rootDomNode, patches)
{
	for (var i = 0; i < patches.length; i++)
	{
		var patch = patches[i];
		var localDomNode = patch.t
		var newNode = _VirtualDom_applyPatch(localDomNode, patch);
		if (localDomNode === rootDomNode)
		{
			rootDomNode = newNode;
		}
	}
	return rootDomNode;
}

function _VirtualDom_applyPatch(domNode, patch)
{
	switch (patch.$)
	{
		case 0:
			return _VirtualDom_applyPatchRedraw(domNode, patch.s, patch.u);

		case 4:
			_VirtualDom_applyFacts(domNode, patch.u, patch.s);
			return domNode;

		case 3:
			domNode.replaceData(0, domNode.length, patch.s);
			return domNode;

		case 1:
			return _VirtualDom_applyPatchesHelp(domNode, patch.s);

		case 2:
			if (domNode.elm_event_node_ref)
			{
				domNode.elm_event_node_ref.j = patch.s;
			}
			else
			{
				domNode.elm_event_node_ref = { j: patch.s, p: patch.u };
			}
			return domNode;

		case 6:
			var data = patch.s;
			for (var i = 0; i < data.i; i++)
			{
				domNode.removeChild(domNode.childNodes[data.v]);
			}
			return domNode;

		case 7:
			var data = patch.s;
			var kids = data.e;
			var i = data.v;
			var theEnd = domNode.childNodes[i];
			for (; i < kids.length; i++)
			{
				domNode.insertBefore(_VirtualDom_render(kids[i], patch.u), theEnd);
			}
			return domNode;

		case 9:
			var data = patch.s;
			if (!data)
			{
				domNode.parentNode.removeChild(domNode);
				return domNode;
			}
			var entry = data.A;
			if (typeof entry.r !== 'undefined')
			{
				domNode.parentNode.removeChild(domNode);
			}
			entry.s = _VirtualDom_applyPatchesHelp(domNode, data.w);
			return domNode;

		case 8:
			return _VirtualDom_applyPatchReorder(domNode, patch);

		case 5:
			return patch.s(domNode);

		default:
			_Debug_crash(10); // 'Ran into an unknown patch!'
	}
}


function _VirtualDom_applyPatchRedraw(domNode, vNode, eventNode)
{
	var parentNode = domNode.parentNode;
	var newNode = _VirtualDom_render(vNode, eventNode);

	if (!newNode.elm_event_node_ref)
	{
		newNode.elm_event_node_ref = domNode.elm_event_node_ref;
	}

	if (parentNode && newNode !== domNode)
	{
		parentNode.replaceChild(newNode, domNode);
	}
	return newNode;
}


function _VirtualDom_applyPatchReorder(domNode, patch)
{
	var data = patch.s;

	// remove end inserts
	var frag = _VirtualDom_applyPatchReorderEndInsertsHelp(data.y, patch);

	// removals
	domNode = _VirtualDom_applyPatchesHelp(domNode, data.w);

	// inserts
	var inserts = data.x;
	for (var i = 0; i < inserts.length; i++)
	{
		var insert = inserts[i];
		var entry = insert.A;
		var node = entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u);
		domNode.insertBefore(node, domNode.childNodes[insert.r]);
	}

	// add end inserts
	if (frag)
	{
		_VirtualDom_appendChild(domNode, frag);
	}

	return domNode;
}


function _VirtualDom_applyPatchReorderEndInsertsHelp(endInserts, patch)
{
	if (!endInserts)
	{
		return;
	}

	var frag = _VirtualDom_doc.createDocumentFragment();
	for (var i = 0; i < endInserts.length; i++)
	{
		var insert = endInserts[i];
		var entry = insert.A;
		_VirtualDom_appendChild(frag, entry.c === 2
			? entry.s
			: _VirtualDom_render(entry.z, patch.u)
		);
	}
	return frag;
}


function _VirtualDom_virtualize(node)
{
	// TEXT NODES

	if (node.nodeType === 3)
	{
		return _VirtualDom_text(node.textContent);
	}


	// WEIRD NODES

	if (node.nodeType !== 1)
	{
		return _VirtualDom_text('');
	}


	// ELEMENT NODES

	var attrList = _List_Nil;
	var attrs = node.attributes;
	for (var i = attrs.length; i--; )
	{
		var attr = attrs[i];
		var name = attr.name;
		var value = attr.value;
		attrList = _List_Cons( A2(_VirtualDom_attribute, name, value), attrList );
	}

	var tag = node.tagName.toLowerCase();
	var kidList = _List_Nil;
	var kids = node.childNodes;

	for (var i = kids.length; i--; )
	{
		kidList = _List_Cons(_VirtualDom_virtualize(kids[i]), kidList);
	}
	return A3(_VirtualDom_node, tag, attrList, kidList);
}

function _VirtualDom_dekey(keyedNode)
{
	var keyedKids = keyedNode.e;
	var len = keyedKids.length;
	var kids = new Array(len);
	for (var i = 0; i < len; i++)
	{
		kids[i] = keyedKids[i].b;
	}

	return {
		$: 1,
		c: keyedNode.c,
		d: keyedNode.d,
		e: kids,
		f: keyedNode.f,
		b: keyedNode.b
	};
}




// ELEMENT


var _Debugger_element;

var _Browser_element = _Debugger_element || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var view = impl.view;
			/**_UNUSED/
			var domNode = args['node'];
			//*/
			/**/
			var domNode = args && args['node'] ? args['node'] : _Debug_crash(0);
			//*/
			var currNode = _VirtualDom_virtualize(domNode);

			return _Browser_makeAnimator(initialModel, function(model)
			{
				var nextNode = view(model);
				var patches = _VirtualDom_diff(currNode, nextNode);
				domNode = _VirtualDom_applyPatches(domNode, currNode, patches, sendToApp);
				currNode = nextNode;
			});
		}
	);
});



// DOCUMENT


var _Debugger_document;

var _Browser_document = _Debugger_document || F4(function(impl, flagDecoder, debugMetadata, args)
{
	return _Platform_initialize(
		flagDecoder,
		args,
		impl.init,
		impl.update,
		impl.subscriptions,
		function(sendToApp, initialModel) {
			var divertHrefToApp = impl.setup && impl.setup(sendToApp)
			var view = impl.view;
			var title = _VirtualDom_doc.title;
			var bodyNode = _VirtualDom_doc.body;
			var currNode = _VirtualDom_virtualize(bodyNode);
			return _Browser_makeAnimator(initialModel, function(model)
			{
				_VirtualDom_divertHrefToApp = divertHrefToApp;
				var doc = view(model);
				var nextNode = _VirtualDom_node('body')(_List_Nil)(doc.body);
				var patches = _VirtualDom_diff(currNode, nextNode);
				bodyNode = _VirtualDom_applyPatches(bodyNode, currNode, patches, sendToApp);
				currNode = nextNode;
				_VirtualDom_divertHrefToApp = 0;
				(title !== doc.title) && (_VirtualDom_doc.title = title = doc.title);
			});
		}
	);
});



// ANIMATION


var _Browser_cancelAnimationFrame =
	typeof cancelAnimationFrame !== 'undefined'
		? cancelAnimationFrame
		: function(id) { clearTimeout(id); };

var _Browser_requestAnimationFrame =
	typeof requestAnimationFrame !== 'undefined'
		? requestAnimationFrame
		: function(callback) { return setTimeout(callback, 1000 / 60); };


function _Browser_makeAnimator(model, draw)
{
	draw(model);

	var state = 0;

	function updateIfNeeded()
	{
		state = state === 1
			? 0
			: ( _Browser_requestAnimationFrame(updateIfNeeded), draw(model), 1 );
	}

	return function(nextModel, isSync)
	{
		model = nextModel;

		isSync
			? ( draw(model),
				state === 2 && (state = 1)
				)
			: ( state === 0 && _Browser_requestAnimationFrame(updateIfNeeded),
				state = 2
				);
	};
}



// APPLICATION


function _Browser_application(impl)
{
	var onUrlChange = impl.onUrlChange;
	var onUrlRequest = impl.onUrlRequest;
	var key = function() { key.a(onUrlChange(_Browser_getUrl())); };

	return _Browser_document({
		setup: function(sendToApp)
		{
			key.a = sendToApp;
			_Browser_window.addEventListener('popstate', key);
			_Browser_window.navigator.userAgent.indexOf('Trident') < 0 || _Browser_window.addEventListener('hashchange', key);

			return F2(function(domNode, event)
			{
				if (!event.ctrlKey && !event.metaKey && !event.shiftKey && event.button < 1 && !domNode.target && !domNode.hasAttribute('download'))
				{
					event.preventDefault();
					var href = domNode.href;
					var curr = _Browser_getUrl();
					var next = $elm$url$Url$fromString(href).a;
					sendToApp(onUrlRequest(
						(next
							&& curr.protocol === next.protocol
							&& curr.host === next.host
							&& curr.port_.a === next.port_.a
						)
							? $elm$browser$Browser$Internal(next)
							: $elm$browser$Browser$External(href)
					));
				}
			});
		},
		init: function(flags)
		{
			return A3(impl.init, flags, _Browser_getUrl(), key);
		},
		view: impl.view,
		update: impl.update,
		subscriptions: impl.subscriptions
	});
}

function _Browser_getUrl()
{
	return $elm$url$Url$fromString(_VirtualDom_doc.location.href).a || _Debug_crash(1);
}

var _Browser_go = F2(function(key, n)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		n && history.go(n);
		key();
	}));
});

var _Browser_pushUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.pushState({}, '', url);
		key();
	}));
});

var _Browser_replaceUrl = F2(function(key, url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function() {
		history.replaceState({}, '', url);
		key();
	}));
});



// GLOBAL EVENTS


var _Browser_fakeNode = { addEventListener: function() {}, removeEventListener: function() {} };
var _Browser_doc = typeof document !== 'undefined' ? document : _Browser_fakeNode;
var _Browser_window = typeof window !== 'undefined' ? window : _Browser_fakeNode;

var _Browser_on = F3(function(node, eventName, sendToSelf)
{
	return _Scheduler_spawn(_Scheduler_binding(function(callback)
	{
		function handler(event)	{ _Scheduler_rawSpawn(sendToSelf(event)); }
		node.addEventListener(eventName, handler, _VirtualDom_passiveSupported && { passive: true });
		return function() { node.removeEventListener(eventName, handler); };
	}));
});

var _Browser_decodeEvent = F2(function(decoder, event)
{
	var result = _Json_runHelp(decoder, event);
	return $elm$core$Result$isOk(result) ? $elm$core$Maybe$Just(result.a) : $elm$core$Maybe$Nothing;
});



// PAGE VISIBILITY


function _Browser_visibilityInfo()
{
	return (typeof _VirtualDom_doc.hidden !== 'undefined')
		? { hidden: 'hidden', change: 'visibilitychange' }
		:
	(typeof _VirtualDom_doc.mozHidden !== 'undefined')
		? { hidden: 'mozHidden', change: 'mozvisibilitychange' }
		:
	(typeof _VirtualDom_doc.msHidden !== 'undefined')
		? { hidden: 'msHidden', change: 'msvisibilitychange' }
		:
	(typeof _VirtualDom_doc.webkitHidden !== 'undefined')
		? { hidden: 'webkitHidden', change: 'webkitvisibilitychange' }
		: { hidden: 'hidden', change: 'visibilitychange' };
}



// ANIMATION FRAMES


function _Browser_rAF()
{
	return _Scheduler_binding(function(callback)
	{
		var id = _Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(Date.now()));
		});

		return function() {
			_Browser_cancelAnimationFrame(id);
		};
	});
}


function _Browser_now()
{
	return _Scheduler_binding(function(callback)
	{
		callback(_Scheduler_succeed(Date.now()));
	});
}



// DOM STUFF


function _Browser_withNode(id, doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			var node = document.getElementById(id);
			callback(node
				? _Scheduler_succeed(doStuff(node))
				: _Scheduler_fail($elm$browser$Browser$Dom$NotFound(id))
			);
		});
	});
}


function _Browser_withWindow(doStuff)
{
	return _Scheduler_binding(function(callback)
	{
		_Browser_requestAnimationFrame(function() {
			callback(_Scheduler_succeed(doStuff()));
		});
	});
}


// FOCUS and BLUR


var _Browser_call = F2(function(functionName, id)
{
	return _Browser_withNode(id, function(node) {
		node[functionName]();
		return _Utils_Tuple0;
	});
});



// WINDOW VIEWPORT


function _Browser_getViewport()
{
	return {
		scene: _Browser_getScene(),
		viewport: {
			x: _Browser_window.pageXOffset,
			y: _Browser_window.pageYOffset,
			width: _Browser_doc.documentElement.clientWidth,
			height: _Browser_doc.documentElement.clientHeight
		}
	};
}

function _Browser_getScene()
{
	var body = _Browser_doc.body;
	var elem = _Browser_doc.documentElement;
	return {
		width: Math.max(body.scrollWidth, body.offsetWidth, elem.scrollWidth, elem.offsetWidth, elem.clientWidth),
		height: Math.max(body.scrollHeight, body.offsetHeight, elem.scrollHeight, elem.offsetHeight, elem.clientHeight)
	};
}

var _Browser_setViewport = F2(function(x, y)
{
	return _Browser_withWindow(function()
	{
		_Browser_window.scroll(x, y);
		return _Utils_Tuple0;
	});
});



// ELEMENT VIEWPORT


function _Browser_getViewportOf(id)
{
	return _Browser_withNode(id, function(node)
	{
		return {
			scene: {
				width: node.scrollWidth,
				height: node.scrollHeight
			},
			viewport: {
				x: node.scrollLeft,
				y: node.scrollTop,
				width: node.clientWidth,
				height: node.clientHeight
			}
		};
	});
}


var _Browser_setViewportOf = F3(function(id, x, y)
{
	return _Browser_withNode(id, function(node)
	{
		node.scrollLeft = x;
		node.scrollTop = y;
		return _Utils_Tuple0;
	});
});



// ELEMENT


function _Browser_getElement(id)
{
	return _Browser_withNode(id, function(node)
	{
		var rect = node.getBoundingClientRect();
		var x = _Browser_window.pageXOffset;
		var y = _Browser_window.pageYOffset;
		return {
			scene: _Browser_getScene(),
			viewport: {
				x: x,
				y: y,
				width: _Browser_doc.documentElement.clientWidth,
				height: _Browser_doc.documentElement.clientHeight
			},
			element: {
				x: x + rect.left,
				y: y + rect.top,
				width: rect.width,
				height: rect.height
			}
		};
	});
}



// LOAD and RELOAD


function _Browser_reload(skipCache)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		_VirtualDom_doc.location.reload(skipCache);
	}));
}

function _Browser_load(url)
{
	return A2($elm$core$Task$perform, $elm$core$Basics$never, _Scheduler_binding(function(callback)
	{
		try
		{
			_Browser_window.location = url;
		}
		catch(err)
		{
			// Only Firefox can throw a NS_ERROR_MALFORMED_URI exception here.
			// Other browsers reload the page, so let's be consistent about that.
			_VirtualDom_doc.location.reload(false);
		}
	}));
}


// CREATE

var _Regex_never = /.^/;

var _Regex_fromStringWith = F2(function(options, string)
{
	var flags = 'g';
	if (options.multiline) { flags += 'm'; }
	if (options.caseInsensitive) { flags += 'i'; }

	try
	{
		return $elm$core$Maybe$Just(new RegExp(string, flags));
	}
	catch(error)
	{
		return $elm$core$Maybe$Nothing;
	}
});


// USE

var _Regex_contains = F2(function(re, string)
{
	return string.match(re) !== null;
});


var _Regex_findAtMost = F3(function(n, re, str)
{
	var out = [];
	var number = 0;
	var string = str;
	var lastIndex = re.lastIndex;
	var prevLastIndex = -1;
	var result;
	while (number++ < n && (result = re.exec(string)))
	{
		if (prevLastIndex == re.lastIndex) break;
		var i = result.length - 1;
		var subs = new Array(i);
		while (i > 0)
		{
			var submatch = result[i];
			subs[--i] = submatch
				? $elm$core$Maybe$Just(submatch)
				: $elm$core$Maybe$Nothing;
		}
		out.push(A4($elm$regex$Regex$Match, result[0], result.index, number, _List_fromArray(subs)));
		prevLastIndex = re.lastIndex;
	}
	re.lastIndex = lastIndex;
	return _List_fromArray(out);
});


var _Regex_replaceAtMost = F4(function(n, re, replacer, string)
{
	var count = 0;
	function jsReplacer(match)
	{
		if (count++ >= n)
		{
			return match;
		}
		var i = arguments.length - 3;
		var submatches = new Array(i);
		while (i > 0)
		{
			var submatch = arguments[i];
			submatches[--i] = submatch
				? $elm$core$Maybe$Just(submatch)
				: $elm$core$Maybe$Nothing;
		}
		return replacer(A4($elm$regex$Regex$Match, match, arguments[arguments.length - 2], count, _List_fromArray(submatches)));
	}
	return string.replace(re, jsReplacer);
});

var _Regex_splitAtMost = F3(function(n, re, str)
{
	var string = str;
	var out = [];
	var start = re.lastIndex;
	var restoreLastIndex = re.lastIndex;
	while (n--)
	{
		var result = re.exec(string);
		if (!result) break;
		out.push(string.slice(start, result.index));
		start = re.lastIndex;
	}
	out.push(string.slice(start));
	re.lastIndex = restoreLastIndex;
	return _List_fromArray(out);
});

var _Regex_infinity = Infinity;



var _Bitwise_and = F2(function(a, b)
{
	return a & b;
});

var _Bitwise_or = F2(function(a, b)
{
	return a | b;
});

var _Bitwise_xor = F2(function(a, b)
{
	return a ^ b;
});

function _Bitwise_complement(a)
{
	return ~a;
};

var _Bitwise_shiftLeftBy = F2(function(offset, a)
{
	return a << offset;
});

var _Bitwise_shiftRightBy = F2(function(offset, a)
{
	return a >> offset;
});

var _Bitwise_shiftRightZfBy = F2(function(offset, a)
{
	return a >>> offset;
});
var $elm$core$List$cons = _List_cons;
var $elm$core$Elm$JsArray$foldr = _JsArray_foldr;
var $elm$core$Array$foldr = F3(
	function (func, baseCase, _v0) {
		var tree = _v0.c;
		var tail = _v0.d;
		var helper = F2(
			function (node, acc) {
				if (node.$ === 'SubTree') {
					var subTree = node.a;
					return A3($elm$core$Elm$JsArray$foldr, helper, acc, subTree);
				} else {
					var values = node.a;
					return A3($elm$core$Elm$JsArray$foldr, func, acc, values);
				}
			});
		return A3(
			$elm$core$Elm$JsArray$foldr,
			helper,
			A3($elm$core$Elm$JsArray$foldr, func, baseCase, tail),
			tree);
	});
var $elm$core$Array$toList = function (array) {
	return A3($elm$core$Array$foldr, $elm$core$List$cons, _List_Nil, array);
};
var $elm$core$Dict$foldr = F3(
	function (func, acc, t) {
		foldr:
		while (true) {
			if (t.$ === 'RBEmpty_elm_builtin') {
				return acc;
			} else {
				var key = t.b;
				var value = t.c;
				var left = t.d;
				var right = t.e;
				var $temp$func = func,
					$temp$acc = A3(
					func,
					key,
					value,
					A3($elm$core$Dict$foldr, func, acc, right)),
					$temp$t = left;
				func = $temp$func;
				acc = $temp$acc;
				t = $temp$t;
				continue foldr;
			}
		}
	});
var $elm$core$Dict$toList = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, list) {
				return A2(
					$elm$core$List$cons,
					_Utils_Tuple2(key, value),
					list);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Dict$keys = function (dict) {
	return A3(
		$elm$core$Dict$foldr,
		F3(
			function (key, value, keyList) {
				return A2($elm$core$List$cons, key, keyList);
			}),
		_List_Nil,
		dict);
};
var $elm$core$Set$toList = function (_v0) {
	var dict = _v0.a;
	return $elm$core$Dict$keys(dict);
};
var $elm$core$Basics$EQ = {$: 'EQ'};
var $elm$core$Basics$GT = {$: 'GT'};
var $elm$core$Basics$LT = {$: 'LT'};
var $elm$core$Basics$False = {$: 'False'};
var $elm$core$Maybe$Just = function (a) {
	return {$: 'Just', a: a};
};
var $elm$core$Maybe$Nothing = {$: 'Nothing'};
var $elm$core$Basics$apL = F2(
	function (f, x) {
		return f(x);
	});
var $author$project$R10$Form$Internal$Conf$EntityField = function (a) {
	return {$: 'EntityField', a: a};
};
var $author$project$R10$Form$Internal$Conf$EntityMulti = F2(
	function (a, b) {
		return {$: 'EntityMulti', a: a, b: b};
	});
var $author$project$R10$Form$Internal$Conf$EntityNormal = F2(
	function (a, b) {
		return {$: 'EntityNormal', a: a, b: b};
	});
var $author$project$R10$Form$Internal$Conf$EntitySubTitle = F2(
	function (a, b) {
		return {$: 'EntitySubTitle', a: a, b: b};
	});
var $author$project$R10$Form$Internal$Conf$EntityTitle = F2(
	function (a, b) {
		return {$: 'EntityTitle', a: a, b: b};
	});
var $author$project$R10$Form$Internal$Conf$EntityWithBorder = F2(
	function (a, b) {
		return {$: 'EntityWithBorder', a: a, b: b};
	});
var $author$project$R10$Form$Internal$Conf$EntityWithTabs = F2(
	function (a, b) {
		return {$: 'EntityWithTabs', a: a, b: b};
	});
var $author$project$R10$Form$Internal$Conf$EntityWrappable = F2(
	function (a, b) {
		return {$: 'EntityWrappable', a: a, b: b};
	});
var $author$project$R10$Form$entity = {field: $author$project$R10$Form$Internal$Conf$EntityField, multi: $author$project$R10$Form$Internal$Conf$EntityMulti, normal: $author$project$R10$Form$Internal$Conf$EntityNormal, subTitle: $author$project$R10$Form$Internal$Conf$EntitySubTitle, title: $author$project$R10$Form$Internal$Conf$EntityTitle, withBorder: $author$project$R10$Form$Internal$Conf$EntityWithBorder, withTabs: $author$project$R10$Form$Internal$Conf$EntityWithTabs, wrappable: $author$project$R10$Form$Internal$Conf$EntityWrappable};
var $author$project$R10$Form$Internal$FieldConf$TypeBinary = function (a) {
	return {$: 'TypeBinary', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$TypeMulti = F2(
	function (a, b) {
		return {$: 'TypeMulti', a: a, b: b};
	});
var $author$project$R10$Form$Internal$FieldConf$TypeSingle = F2(
	function (a, b) {
		return {$: 'TypeSingle', a: a, b: b};
	});
var $author$project$R10$Form$Internal$FieldConf$TypeText = function (a) {
	return {$: 'TypeText', a: a};
};
var $author$project$R10$Form$fieldType = {binary: $author$project$R10$Form$Internal$FieldConf$TypeBinary, multi: $author$project$R10$Form$Internal$FieldConf$TypeMulti, single: $author$project$R10$Form$Internal$FieldConf$TypeSingle, text: $author$project$R10$Form$Internal$FieldConf$TypeText};
var $elm$core$Dict$RBEmpty_elm_builtin = {$: 'RBEmpty_elm_builtin'};
var $elm$core$Dict$empty = $elm$core$Dict$RBEmpty_elm_builtin;
var $elm$core$Basics$identity = function (x) {
	return x;
};
var $elm$core$Set$Set_elm_builtin = function (a) {
	return {$: 'Set_elm_builtin', a: a};
};
var $elm$core$Set$empty = $elm$core$Set$Set_elm_builtin($elm$core$Dict$empty);
var $author$project$R10$Form$Internal$QtySubmitAttempted$QtySubmitAttempted = function (a) {
	return {$: 'QtySubmitAttempted', a: a};
};
var $author$project$R10$Form$Internal$QtySubmitAttempted$fromInt = function (_int) {
	return $author$project$R10$Form$Internal$QtySubmitAttempted$QtySubmitAttempted(_int);
};
var $author$project$R10$Form$Internal$State$init = {
	active: $elm$core$Maybe$Nothing,
	activeTabs: $elm$core$Dict$empty,
	changesSinceLastSubmissions: false,
	fieldsState: $elm$core$Dict$empty,
	focused: $elm$core$Maybe$Nothing,
	multiplicableQuantities: $elm$core$Dict$empty,
	qtySubmitAttempted: $author$project$R10$Form$Internal$QtySubmitAttempted$fromInt(0),
	removed: $elm$core$Set$empty
};
var $author$project$R10$Form$initState = $author$project$R10$Form$Internal$State$init;
var $author$project$Main$requiredLabel = $elm$core$Maybe$Nothing;
var $author$project$R10$Form$Internal$FieldConf$TextEmail = {$: 'TextEmail'};
var $author$project$R10$Form$Internal$FieldConf$TextMultiline = {$: 'TextMultiline'};
var $author$project$R10$Form$Internal$FieldConf$TextPasswordCurrent = {$: 'TextPasswordCurrent'};
var $author$project$R10$Form$Internal$FieldConf$TextPasswordNew = {$: 'TextPasswordNew'};
var $author$project$R10$Form$Internal$FieldConf$TextPlain = {$: 'TextPlain'};
var $author$project$R10$Form$Internal$FieldConf$TextUsername = {$: 'TextUsername'};
var $author$project$R10$Form$Internal$FieldConf$TextWithPattern = function (a) {
	return {$: 'TextWithPattern', a: a};
};
var $author$project$R10$Form$text = {email: $author$project$R10$Form$Internal$FieldConf$TextEmail, multiline: $author$project$R10$Form$Internal$FieldConf$TextMultiline, passwordCurrent: $author$project$R10$Form$Internal$FieldConf$TextPasswordCurrent, passwordNew: $author$project$R10$Form$Internal$FieldConf$TextPasswordNew, plain: $author$project$R10$Form$Internal$FieldConf$TextPlain, username: $author$project$R10$Form$Internal$FieldConf$TextUsername, withPattern: $author$project$R10$Form$Internal$FieldConf$TextWithPattern};
var $author$project$R10$Form$Internal$FieldConf$AllOf = function (a) {
	return {$: 'AllOf', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$Dependant = F2(
	function (a, b) {
		return {$: 'Dependant', a: a, b: b};
	});
var $author$project$R10$Form$Internal$FieldConf$Empty = {$: 'Empty'};
var $author$project$R10$Form$Internal$FieldConf$Equal = function (a) {
	return {$: 'Equal', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$MaxLength = function (a) {
	return {$: 'MaxLength', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$MinLength = function (a) {
	return {$: 'MinLength', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$NoValidation = {$: 'NoValidation'};
var $author$project$R10$Form$Internal$FieldConf$Not = function (a) {
	return {$: 'Not', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$Regex = function (a) {
	return {$: 'Regex', a: a};
};
var $author$project$R10$Form$Internal$FieldConf$Required = {$: 'Required'};
var $author$project$R10$Form$Internal$FieldConf$WithMsg = F2(
	function (a, b) {
		return {$: 'WithMsg', a: a, b: b};
	});
var $author$project$R10$Form$validation = {allOf: $author$project$R10$Form$Internal$FieldConf$AllOf, dependant: $author$project$R10$Form$Internal$FieldConf$Dependant, empty: $author$project$R10$Form$Internal$FieldConf$Empty, equal: $author$project$R10$Form$Internal$FieldConf$Equal, maxLength: $author$project$R10$Form$Internal$FieldConf$MaxLength, minLength: $author$project$R10$Form$Internal$FieldConf$MinLength, noValidation: $author$project$R10$Form$Internal$FieldConf$NoValidation, not: $author$project$R10$Form$Internal$FieldConf$Not, oneOf: $author$project$R10$Form$Internal$FieldConf$OneOf, regex: $author$project$R10$Form$Internal$FieldConf$Regex, required: $author$project$R10$Form$Internal$FieldConf$Required, withMsg: $author$project$R10$Form$Internal$FieldConf$WithMsg};
var $author$project$R10$Form$Internal$FieldConf$ClearOrCheck = {$: 'ClearOrCheck'};
var $author$project$R10$Form$Internal$FieldConf$ErrorOrCheck = {$: 'ErrorOrCheck'};
var $author$project$R10$Form$Internal$FieldConf$NoIcon = {$: 'NoIcon'};
var $author$project$R10$Form$validationIcon = {clearOrCheck: $author$project$R10$Form$Internal$FieldConf$ClearOrCheck, errorOrCheck: $author$project$R10$Form$Internal$FieldConf$ErrorOrCheck, noIcon: $author$project$R10$Form$Internal$FieldConf$NoIcon};
var $author$project$Main$init = {
	form: {
		conf: _List_fromArray(
			[
				$author$project$R10$Form$entity.field(
				{
					helperText: $elm$core$Maybe$Nothing,
					id: 'cardNumber',
					idDom: $elm$core$Maybe$Nothing,
					label: 'Card Number',
					requiredLabel: $author$project$Main$requiredLabel,
					type_: $author$project$R10$Form$fieldType.text(
						$author$project$R10$Form$text.withPattern('____ ____ ____ ____')),
					validationSpecs: $elm$core$Maybe$Just(
						{
							hidePassedValidationStyle: false,
							showPassedValidationMessages: false,
							validation: _List_fromArray(
								[$author$project$R10$Form$validation.required]),
							validationIcon: $author$project$R10$Form$validationIcon.noIcon
						})
				}),
				$author$project$R10$Form$entity.field(
				{
					helperText: $elm$core$Maybe$Nothing,
					id: 'cardHolder',
					idDom: $elm$core$Maybe$Nothing,
					label: 'Card Holder',
					requiredLabel: $author$project$Main$requiredLabel,
					type_: $author$project$R10$Form$fieldType.text($author$project$R10$Form$text.plain),
					validationSpecs: $elm$core$Maybe$Just(
						{
							hidePassedValidationStyle: false,
							showPassedValidationMessages: false,
							validation: _List_fromArray(
								[$author$project$R10$Form$validation.required]),
							validationIcon: $author$project$R10$Form$validationIcon.noIcon
						})
				}),
				$author$project$R10$Form$entity.field(
				{
					helperText: $elm$core$Maybe$Nothing,
					id: 'expires',
					idDom: $elm$core$Maybe$Nothing,
					label: 'Expires (MM/YY)',
					requiredLabel: $author$project$Main$requiredLabel,
					type_: $author$project$R10$Form$fieldType.text(
						$author$project$R10$Form$text.withPattern('__/__')),
					validationSpecs: $elm$core$Maybe$Just(
						{
							hidePassedValidationStyle: false,
							showPassedValidationMessages: false,
							validation: _List_fromArray(
								[$author$project$R10$Form$validation.required]),
							validationIcon: $author$project$R10$Form$validationIcon.noIcon
						})
				}),
				$author$project$R10$Form$entity.field(
				{
					helperText: $elm$core$Maybe$Nothing,
					id: 'cvv',
					idDom: $elm$core$Maybe$Nothing,
					label: 'CVV',
					requiredLabel: $author$project$Main$requiredLabel,
					type_: $author$project$R10$Form$fieldType.text(
						$author$project$R10$Form$text.withPattern('___')),
					validationSpecs: $elm$core$Maybe$Just(
						{
							hidePassedValidationStyle: false,
							showPassedValidationMessages: false,
							validation: _List_fromArray(
								[$author$project$R10$Form$validation.required]),
							validationIcon: $author$project$R10$Form$validationIcon.noIcon
						})
				})
			]),
		state: $author$project$R10$Form$initState
	}
};
var $elm$core$Result$Err = function (a) {
	return {$: 'Err', a: a};
};
var $elm$json$Json$Decode$Failure = F2(
	function (a, b) {
		return {$: 'Failure', a: a, b: b};
	});
var $elm$json$Json$Decode$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$json$Json$Decode$Index = F2(
	function (a, b) {
		return {$: 'Index', a: a, b: b};
	});
var $elm$core$Result$Ok = function (a) {
	return {$: 'Ok', a: a};
};
var $elm$json$Json$Decode$OneOf = function (a) {
	return {$: 'OneOf', a: a};
};
var $elm$core$Basics$add = _Basics_add;
var $elm$core$String$all = _String_all;
var $elm$core$Basics$and = _Basics_and;
var $elm$core$Basics$append = _Utils_append;
var $elm$json$Json$Encode$encode = _Json_encode;
var $elm$core$String$fromInt = _String_fromNumber;
var $elm$core$String$join = F2(
	function (sep, chunks) {
		return A2(
			_String_join,
			sep,
			_List_toArray(chunks));
	});
var $elm$core$String$split = F2(
	function (sep, string) {
		return _List_fromArray(
			A2(_String_split, sep, string));
	});
var $elm$json$Json$Decode$indent = function (str) {
	return A2(
		$elm$core$String$join,
		'\n    ',
		A2($elm$core$String$split, '\n', str));
};
var $elm$core$List$foldl = F3(
	function (func, acc, list) {
		foldl:
		while (true) {
			if (!list.b) {
				return acc;
			} else {
				var x = list.a;
				var xs = list.b;
				var $temp$func = func,
					$temp$acc = A2(func, x, acc),
					$temp$list = xs;
				func = $temp$func;
				acc = $temp$acc;
				list = $temp$list;
				continue foldl;
			}
		}
	});
var $elm$core$List$length = function (xs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, i) {
				return i + 1;
			}),
		0,
		xs);
};
var $elm$core$List$map2 = _List_map2;
var $elm$core$Basics$le = _Utils_le;
var $elm$core$Basics$sub = _Basics_sub;
var $elm$core$List$rangeHelp = F3(
	function (lo, hi, list) {
		rangeHelp:
		while (true) {
			if (_Utils_cmp(lo, hi) < 1) {
				var $temp$lo = lo,
					$temp$hi = hi - 1,
					$temp$list = A2($elm$core$List$cons, hi, list);
				lo = $temp$lo;
				hi = $temp$hi;
				list = $temp$list;
				continue rangeHelp;
			} else {
				return list;
			}
		}
	});
var $elm$core$List$range = F2(
	function (lo, hi) {
		return A3($elm$core$List$rangeHelp, lo, hi, _List_Nil);
	});
var $elm$core$List$indexedMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$map2,
			f,
			A2(
				$elm$core$List$range,
				0,
				$elm$core$List$length(xs) - 1),
			xs);
	});
var $elm$core$Char$toCode = _Char_toCode;
var $elm$core$Char$isLower = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (97 <= code) && (code <= 122);
};
var $elm$core$Char$isUpper = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 90) && (65 <= code);
};
var $elm$core$Basics$or = _Basics_or;
var $elm$core$Char$isAlpha = function (_char) {
	return $elm$core$Char$isLower(_char) || $elm$core$Char$isUpper(_char);
};
var $elm$core$Char$isDigit = function (_char) {
	var code = $elm$core$Char$toCode(_char);
	return (code <= 57) && (48 <= code);
};
var $elm$core$Char$isAlphaNum = function (_char) {
	return $elm$core$Char$isLower(_char) || ($elm$core$Char$isUpper(_char) || $elm$core$Char$isDigit(_char));
};
var $elm$core$List$reverse = function (list) {
	return A3($elm$core$List$foldl, $elm$core$List$cons, _List_Nil, list);
};
var $elm$core$String$uncons = _String_uncons;
var $elm$json$Json$Decode$errorOneOf = F2(
	function (i, error) {
		return '\n\n(' + ($elm$core$String$fromInt(i + 1) + (') ' + $elm$json$Json$Decode$indent(
			$elm$json$Json$Decode$errorToString(error))));
	});
var $elm$json$Json$Decode$errorToString = function (error) {
	return A2($elm$json$Json$Decode$errorToStringHelp, error, _List_Nil);
};
var $elm$json$Json$Decode$errorToStringHelp = F2(
	function (error, context) {
		errorToStringHelp:
		while (true) {
			switch (error.$) {
				case 'Field':
					var f = error.a;
					var err = error.b;
					var isSimple = function () {
						var _v1 = $elm$core$String$uncons(f);
						if (_v1.$ === 'Nothing') {
							return false;
						} else {
							var _v2 = _v1.a;
							var _char = _v2.a;
							var rest = _v2.b;
							return $elm$core$Char$isAlpha(_char) && A2($elm$core$String$all, $elm$core$Char$isAlphaNum, rest);
						}
					}();
					var fieldName = isSimple ? ('.' + f) : ('[\'' + (f + '\']'));
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, fieldName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'Index':
					var i = error.a;
					var err = error.b;
					var indexName = '[' + ($elm$core$String$fromInt(i) + ']');
					var $temp$error = err,
						$temp$context = A2($elm$core$List$cons, indexName, context);
					error = $temp$error;
					context = $temp$context;
					continue errorToStringHelp;
				case 'OneOf':
					var errors = error.a;
					if (!errors.b) {
						return 'Ran into a Json.Decode.oneOf with no possibilities' + function () {
							if (!context.b) {
								return '!';
							} else {
								return ' at json' + A2(
									$elm$core$String$join,
									'',
									$elm$core$List$reverse(context));
							}
						}();
					} else {
						if (!errors.b.b) {
							var err = errors.a;
							var $temp$error = err,
								$temp$context = context;
							error = $temp$error;
							context = $temp$context;
							continue errorToStringHelp;
						} else {
							var starter = function () {
								if (!context.b) {
									return 'Json.Decode.oneOf';
								} else {
									return 'The Json.Decode.oneOf at json' + A2(
										$elm$core$String$join,
										'',
										$elm$core$List$reverse(context));
								}
							}();
							var introduction = starter + (' failed in the following ' + ($elm$core$String$fromInt(
								$elm$core$List$length(errors)) + ' ways:'));
							return A2(
								$elm$core$String$join,
								'\n\n',
								A2(
									$elm$core$List$cons,
									introduction,
									A2($elm$core$List$indexedMap, $elm$json$Json$Decode$errorOneOf, errors)));
						}
					}
				default:
					var msg = error.a;
					var json = error.b;
					var introduction = function () {
						if (!context.b) {
							return 'Problem with the given value:\n\n';
						} else {
							return 'Problem with the value at json' + (A2(
								$elm$core$String$join,
								'',
								$elm$core$List$reverse(context)) + ':\n\n    ');
						}
					}();
					return introduction + ($elm$json$Json$Decode$indent(
						A2($elm$json$Json$Encode$encode, 4, json)) + ('\n\n' + msg));
			}
		}
	});
var $elm$core$Array$branchFactor = 32;
var $elm$core$Array$Array_elm_builtin = F4(
	function (a, b, c, d) {
		return {$: 'Array_elm_builtin', a: a, b: b, c: c, d: d};
	});
var $elm$core$Elm$JsArray$empty = _JsArray_empty;
var $elm$core$Basics$ceiling = _Basics_ceiling;
var $elm$core$Basics$fdiv = _Basics_fdiv;
var $elm$core$Basics$logBase = F2(
	function (base, number) {
		return _Basics_log(number) / _Basics_log(base);
	});
var $elm$core$Basics$toFloat = _Basics_toFloat;
var $elm$core$Array$shiftStep = $elm$core$Basics$ceiling(
	A2($elm$core$Basics$logBase, 2, $elm$core$Array$branchFactor));
var $elm$core$Array$empty = A4($elm$core$Array$Array_elm_builtin, 0, $elm$core$Array$shiftStep, $elm$core$Elm$JsArray$empty, $elm$core$Elm$JsArray$empty);
var $elm$core$Elm$JsArray$initialize = _JsArray_initialize;
var $elm$core$Array$Leaf = function (a) {
	return {$: 'Leaf', a: a};
};
var $elm$core$Basics$apR = F2(
	function (x, f) {
		return f(x);
	});
var $elm$core$Basics$eq = _Utils_equal;
var $elm$core$Basics$floor = _Basics_floor;
var $elm$core$Elm$JsArray$length = _JsArray_length;
var $elm$core$Basics$gt = _Utils_gt;
var $elm$core$Basics$max = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) > 0) ? x : y;
	});
var $elm$core$Basics$mul = _Basics_mul;
var $elm$core$Array$SubTree = function (a) {
	return {$: 'SubTree', a: a};
};
var $elm$core$Elm$JsArray$initializeFromList = _JsArray_initializeFromList;
var $elm$core$Array$compressNodes = F2(
	function (nodes, acc) {
		compressNodes:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodes);
			var node = _v0.a;
			var remainingNodes = _v0.b;
			var newAcc = A2(
				$elm$core$List$cons,
				$elm$core$Array$SubTree(node),
				acc);
			if (!remainingNodes.b) {
				return $elm$core$List$reverse(newAcc);
			} else {
				var $temp$nodes = remainingNodes,
					$temp$acc = newAcc;
				nodes = $temp$nodes;
				acc = $temp$acc;
				continue compressNodes;
			}
		}
	});
var $elm$core$Tuple$first = function (_v0) {
	var x = _v0.a;
	return x;
};
var $elm$core$Array$treeFromBuilder = F2(
	function (nodeList, nodeListSize) {
		treeFromBuilder:
		while (true) {
			var newNodeSize = $elm$core$Basics$ceiling(nodeListSize / $elm$core$Array$branchFactor);
			if (newNodeSize === 1) {
				return A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, nodeList).a;
			} else {
				var $temp$nodeList = A2($elm$core$Array$compressNodes, nodeList, _List_Nil),
					$temp$nodeListSize = newNodeSize;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue treeFromBuilder;
			}
		}
	});
var $elm$core$Array$builderToArray = F2(
	function (reverseNodeList, builder) {
		if (!builder.nodeListSize) {
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail),
				$elm$core$Array$shiftStep,
				$elm$core$Elm$JsArray$empty,
				builder.tail);
		} else {
			var treeLen = builder.nodeListSize * $elm$core$Array$branchFactor;
			var depth = $elm$core$Basics$floor(
				A2($elm$core$Basics$logBase, $elm$core$Array$branchFactor, treeLen - 1));
			var correctNodeList = reverseNodeList ? $elm$core$List$reverse(builder.nodeList) : builder.nodeList;
			var tree = A2($elm$core$Array$treeFromBuilder, correctNodeList, builder.nodeListSize);
			return A4(
				$elm$core$Array$Array_elm_builtin,
				$elm$core$Elm$JsArray$length(builder.tail) + treeLen,
				A2($elm$core$Basics$max, 5, depth * $elm$core$Array$shiftStep),
				tree,
				builder.tail);
		}
	});
var $elm$core$Basics$idiv = _Basics_idiv;
var $elm$core$Basics$lt = _Utils_lt;
var $elm$core$Array$initializeHelp = F5(
	function (fn, fromIndex, len, nodeList, tail) {
		initializeHelp:
		while (true) {
			if (fromIndex < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					false,
					{nodeList: nodeList, nodeListSize: (len / $elm$core$Array$branchFactor) | 0, tail: tail});
			} else {
				var leaf = $elm$core$Array$Leaf(
					A3($elm$core$Elm$JsArray$initialize, $elm$core$Array$branchFactor, fromIndex, fn));
				var $temp$fn = fn,
					$temp$fromIndex = fromIndex - $elm$core$Array$branchFactor,
					$temp$len = len,
					$temp$nodeList = A2($elm$core$List$cons, leaf, nodeList),
					$temp$tail = tail;
				fn = $temp$fn;
				fromIndex = $temp$fromIndex;
				len = $temp$len;
				nodeList = $temp$nodeList;
				tail = $temp$tail;
				continue initializeHelp;
			}
		}
	});
var $elm$core$Basics$remainderBy = _Basics_remainderBy;
var $elm$core$Array$initialize = F2(
	function (len, fn) {
		if (len <= 0) {
			return $elm$core$Array$empty;
		} else {
			var tailLen = len % $elm$core$Array$branchFactor;
			var tail = A3($elm$core$Elm$JsArray$initialize, tailLen, len - tailLen, fn);
			var initialFromIndex = (len - tailLen) - $elm$core$Array$branchFactor;
			return A5($elm$core$Array$initializeHelp, fn, initialFromIndex, len, _List_Nil, tail);
		}
	});
var $elm$core$Basics$True = {$: 'True'};
var $elm$core$Result$isOk = function (result) {
	if (result.$ === 'Ok') {
		return true;
	} else {
		return false;
	}
};
var $elm$json$Json$Decode$map = _Json_map1;
var $elm$json$Json$Decode$map2 = _Json_map2;
var $elm$json$Json$Decode$succeed = _Json_succeed;
var $elm$virtual_dom$VirtualDom$toHandlerInt = function (handler) {
	switch (handler.$) {
		case 'Normal':
			return 0;
		case 'MayStopPropagation':
			return 1;
		case 'MayPreventDefault':
			return 2;
		default:
			return 3;
	}
};
var $elm$browser$Browser$External = function (a) {
	return {$: 'External', a: a};
};
var $elm$browser$Browser$Internal = function (a) {
	return {$: 'Internal', a: a};
};
var $elm$browser$Browser$Dom$NotFound = function (a) {
	return {$: 'NotFound', a: a};
};
var $elm$url$Url$Http = {$: 'Http'};
var $elm$url$Url$Https = {$: 'Https'};
var $elm$url$Url$Url = F6(
	function (protocol, host, port_, path, query, fragment) {
		return {fragment: fragment, host: host, path: path, port_: port_, protocol: protocol, query: query};
	});
var $elm$core$String$contains = _String_contains;
var $elm$core$String$length = _String_length;
var $elm$core$String$slice = _String_slice;
var $elm$core$String$dropLeft = F2(
	function (n, string) {
		return (n < 1) ? string : A3(
			$elm$core$String$slice,
			n,
			$elm$core$String$length(string),
			string);
	});
var $elm$core$String$indexes = _String_indexes;
var $elm$core$String$isEmpty = function (string) {
	return string === '';
};
var $elm$core$String$left = F2(
	function (n, string) {
		return (n < 1) ? '' : A3($elm$core$String$slice, 0, n, string);
	});
var $elm$core$String$toInt = _String_toInt;
var $elm$url$Url$chompBeforePath = F5(
	function (protocol, path, params, frag, str) {
		if ($elm$core$String$isEmpty(str) || A2($elm$core$String$contains, '@', str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, ':', str);
			if (!_v0.b) {
				return $elm$core$Maybe$Just(
					A6($elm$url$Url$Url, protocol, str, $elm$core$Maybe$Nothing, path, params, frag));
			} else {
				if (!_v0.b.b) {
					var i = _v0.a;
					var _v1 = $elm$core$String$toInt(
						A2($elm$core$String$dropLeft, i + 1, str));
					if (_v1.$ === 'Nothing') {
						return $elm$core$Maybe$Nothing;
					} else {
						var port_ = _v1;
						return $elm$core$Maybe$Just(
							A6(
								$elm$url$Url$Url,
								protocol,
								A2($elm$core$String$left, i, str),
								port_,
								path,
								params,
								frag));
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}
		}
	});
var $elm$url$Url$chompBeforeQuery = F4(
	function (protocol, params, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '/', str);
			if (!_v0.b) {
				return A5($elm$url$Url$chompBeforePath, protocol, '/', params, frag, str);
			} else {
				var i = _v0.a;
				return A5(
					$elm$url$Url$chompBeforePath,
					protocol,
					A2($elm$core$String$dropLeft, i, str),
					params,
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompBeforeFragment = F3(
	function (protocol, frag, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '?', str);
			if (!_v0.b) {
				return A4($elm$url$Url$chompBeforeQuery, protocol, $elm$core$Maybe$Nothing, frag, str);
			} else {
				var i = _v0.a;
				return A4(
					$elm$url$Url$chompBeforeQuery,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					frag,
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$url$Url$chompAfterProtocol = F2(
	function (protocol, str) {
		if ($elm$core$String$isEmpty(str)) {
			return $elm$core$Maybe$Nothing;
		} else {
			var _v0 = A2($elm$core$String$indexes, '#', str);
			if (!_v0.b) {
				return A3($elm$url$Url$chompBeforeFragment, protocol, $elm$core$Maybe$Nothing, str);
			} else {
				var i = _v0.a;
				return A3(
					$elm$url$Url$chompBeforeFragment,
					protocol,
					$elm$core$Maybe$Just(
						A2($elm$core$String$dropLeft, i + 1, str)),
					A2($elm$core$String$left, i, str));
			}
		}
	});
var $elm$core$String$startsWith = _String_startsWith;
var $elm$url$Url$fromString = function (str) {
	return A2($elm$core$String$startsWith, 'http://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Http,
		A2($elm$core$String$dropLeft, 7, str)) : (A2($elm$core$String$startsWith, 'https://', str) ? A2(
		$elm$url$Url$chompAfterProtocol,
		$elm$url$Url$Https,
		A2($elm$core$String$dropLeft, 8, str)) : $elm$core$Maybe$Nothing);
};
var $elm$core$Basics$never = function (_v0) {
	never:
	while (true) {
		var nvr = _v0.a;
		var $temp$_v0 = nvr;
		_v0 = $temp$_v0;
		continue never;
	}
};
var $elm$core$Task$Perform = function (a) {
	return {$: 'Perform', a: a};
};
var $elm$core$Task$succeed = _Scheduler_succeed;
var $elm$core$Task$init = $elm$core$Task$succeed(_Utils_Tuple0);
var $elm$core$List$foldrHelper = F4(
	function (fn, acc, ctr, ls) {
		if (!ls.b) {
			return acc;
		} else {
			var a = ls.a;
			var r1 = ls.b;
			if (!r1.b) {
				return A2(fn, a, acc);
			} else {
				var b = r1.a;
				var r2 = r1.b;
				if (!r2.b) {
					return A2(
						fn,
						a,
						A2(fn, b, acc));
				} else {
					var c = r2.a;
					var r3 = r2.b;
					if (!r3.b) {
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(fn, c, acc)));
					} else {
						var d = r3.a;
						var r4 = r3.b;
						var res = (ctr > 500) ? A3(
							$elm$core$List$foldl,
							fn,
							acc,
							$elm$core$List$reverse(r4)) : A4($elm$core$List$foldrHelper, fn, acc, ctr + 1, r4);
						return A2(
							fn,
							a,
							A2(
								fn,
								b,
								A2(
									fn,
									c,
									A2(fn, d, res))));
					}
				}
			}
		}
	});
var $elm$core$List$foldr = F3(
	function (fn, acc, ls) {
		return A4($elm$core$List$foldrHelper, fn, acc, 0, ls);
	});
var $elm$core$List$map = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, acc) {
					return A2(
						$elm$core$List$cons,
						f(x),
						acc);
				}),
			_List_Nil,
			xs);
	});
var $elm$core$Task$andThen = _Scheduler_andThen;
var $elm$core$Task$map = F2(
	function (func, taskA) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return $elm$core$Task$succeed(
					func(a));
			},
			taskA);
	});
var $elm$core$Task$map2 = F3(
	function (func, taskA, taskB) {
		return A2(
			$elm$core$Task$andThen,
			function (a) {
				return A2(
					$elm$core$Task$andThen,
					function (b) {
						return $elm$core$Task$succeed(
							A2(func, a, b));
					},
					taskB);
			},
			taskA);
	});
var $elm$core$Task$sequence = function (tasks) {
	return A3(
		$elm$core$List$foldr,
		$elm$core$Task$map2($elm$core$List$cons),
		$elm$core$Task$succeed(_List_Nil),
		tasks);
};
var $elm$core$Platform$sendToApp = _Platform_sendToApp;
var $elm$core$Task$spawnCmd = F2(
	function (router, _v0) {
		var task = _v0.a;
		return _Scheduler_spawn(
			A2(
				$elm$core$Task$andThen,
				$elm$core$Platform$sendToApp(router),
				task));
	});
var $elm$core$Task$onEffects = F3(
	function (router, commands, state) {
		return A2(
			$elm$core$Task$map,
			function (_v0) {
				return _Utils_Tuple0;
			},
			$elm$core$Task$sequence(
				A2(
					$elm$core$List$map,
					$elm$core$Task$spawnCmd(router),
					commands)));
	});
var $elm$core$Task$onSelfMsg = F3(
	function (_v0, _v1, _v2) {
		return $elm$core$Task$succeed(_Utils_Tuple0);
	});
var $elm$core$Task$cmdMap = F2(
	function (tagger, _v0) {
		var task = _v0.a;
		return $elm$core$Task$Perform(
			A2($elm$core$Task$map, tagger, task));
	});
_Platform_effectManagers['Task'] = _Platform_createManager($elm$core$Task$init, $elm$core$Task$onEffects, $elm$core$Task$onSelfMsg, $elm$core$Task$cmdMap);
var $elm$core$Task$command = _Platform_leaf('Task');
var $elm$core$Task$perform = F2(
	function (toMessage, task) {
		return $elm$core$Task$command(
			$elm$core$Task$Perform(
				A2($elm$core$Task$map, toMessage, task)));
	});
var $elm$core$Platform$Cmd$batch = _Platform_batch;
var $elm$core$Platform$Cmd$none = $elm$core$Platform$Cmd$batch(_List_Nil);
var $elm$core$Platform$Sub$batch = _Platform_batch;
var $elm$core$Platform$Sub$none = $elm$core$Platform$Sub$batch(_List_Nil);
var $elm$browser$Browser$sandbox = function (impl) {
	return _Browser_element(
		{
			init: function (_v0) {
				return _Utils_Tuple2(impl.init, $elm$core$Platform$Cmd$none);
			},
			subscriptions: function (_v1) {
				return $elm$core$Platform$Sub$none;
			},
			update: F2(
				function (msg, model) {
					return _Utils_Tuple2(
						A2(impl.update, msg, model),
						$elm$core$Platform$Cmd$none);
				}),
			view: impl.view
		});
};
var $author$project$R10$Form$Msg$OnSingleMsg = F4(
	function (a, b, c, d) {
		return {$: 'OnSingleMsg', a: a, b: b, c: c, d: d};
	});
var $elm$core$Basics$compare = _Utils_compare;
var $elm$core$Dict$get = F2(
	function (targetKey, dict) {
		get:
		while (true) {
			if (dict.$ === 'RBEmpty_elm_builtin') {
				return $elm$core$Maybe$Nothing;
			} else {
				var key = dict.b;
				var value = dict.c;
				var left = dict.d;
				var right = dict.e;
				var _v1 = A2($elm$core$Basics$compare, targetKey, key);
				switch (_v1.$) {
					case 'LT':
						var $temp$targetKey = targetKey,
							$temp$dict = left;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
					case 'EQ':
						return $elm$core$Maybe$Just(value);
					default:
						var $temp$targetKey = targetKey,
							$temp$dict = right;
						targetKey = $temp$targetKey;
						dict = $temp$dict;
						continue get;
				}
			}
		}
	});
var $author$project$R10$Form$Internal$Key$separator = '/';
var $author$project$R10$Form$Internal$Key$toString = function (_v0) {
	var keys = _v0.a;
	return A2(
		$elm$core$String$join,
		$author$project$R10$Form$Internal$Key$separator,
		$elm$core$List$reverse(keys));
};
var $author$project$R10$Form$Internal$Dict$get = function (key) {
	return $elm$core$Dict$get(
		$author$project$R10$Form$Internal$Key$toString(key));
};
var $author$project$R10$Form$Msg$isChangingValues = function (msg) {
	switch (msg.$) {
		case 'ChangeValue':
			return true;
		case 'AddEntity':
			return true;
		case 'RemoveEntity':
			return true;
		default:
			return false;
	}
};
var $author$project$R10$Form$Msg$handleChangesSinceLastSubmissions = F2(
	function (changesSinceLastSubmissions, msg) {
		if (msg.$ === 'Submit') {
			return false;
		} else {
			return $author$project$R10$Form$Msg$isChangingValues(msg) ? true : changesSinceLastSubmissions;
		}
	});
var $elm$core$Basics$not = _Basics_not;
var $author$project$R10$Form$Internal$FieldState$NotYetValidated = {$: 'NotYetValidated'};
var $author$project$R10$Form$Internal$FieldState$init = {dirty: false, disabled: false, lostFocusOneOrMoreTime: false, scroll: 0, search: '', select: '', showPassword: false, validation: $author$project$R10$Form$Internal$FieldState$NotYetValidated, value: ''};
var $elm$core$Maybe$withDefault = F2(
	function (_default, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return value;
		} else {
			return _default;
		}
	});
var $author$project$R10$Form$Internal$Update$stateWithDefault = function (maybeFieldState) {
	return A2($elm$core$Maybe$withDefault, $author$project$R10$Form$Internal$FieldState$init, maybeFieldState);
};
var $author$project$R10$Form$Internal$Update$helperToggleShowPassword = function (maybeFieldState) {
	var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
	return $elm$core$Maybe$Just(
		_Utils_update(
			fieldState,
			{showPassword: !fieldState.showPassword}));
};
var $elm$core$Dict$Black = {$: 'Black'};
var $elm$core$Dict$RBNode_elm_builtin = F5(
	function (a, b, c, d, e) {
		return {$: 'RBNode_elm_builtin', a: a, b: b, c: c, d: d, e: e};
	});
var $elm$core$Dict$Red = {$: 'Red'};
var $elm$core$Dict$balance = F5(
	function (color, key, value, left, right) {
		if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Red')) {
			var _v1 = right.a;
			var rK = right.b;
			var rV = right.c;
			var rLeft = right.d;
			var rRight = right.e;
			if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
				var _v3 = left.a;
				var lK = left.b;
				var lV = left.c;
				var lLeft = left.d;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					key,
					value,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					rK,
					rV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, left, rLeft),
					rRight);
			}
		} else {
			if ((((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) && (left.d.$ === 'RBNode_elm_builtin')) && (left.d.a.$ === 'Red')) {
				var _v5 = left.a;
				var lK = left.b;
				var lV = left.c;
				var _v6 = left.d;
				var _v7 = _v6.a;
				var llK = _v6.b;
				var llV = _v6.c;
				var llLeft = _v6.d;
				var llRight = _v6.e;
				var lRight = left.e;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Red,
					lK,
					lV,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, key, value, lRight, right));
			} else {
				return A5($elm$core$Dict$RBNode_elm_builtin, color, key, value, left, right);
			}
		}
	});
var $elm$core$Dict$insertHelp = F3(
	function (key, value, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, $elm$core$Dict$RBEmpty_elm_builtin, $elm$core$Dict$RBEmpty_elm_builtin);
		} else {
			var nColor = dict.a;
			var nKey = dict.b;
			var nValue = dict.c;
			var nLeft = dict.d;
			var nRight = dict.e;
			var _v1 = A2($elm$core$Basics$compare, key, nKey);
			switch (_v1.$) {
				case 'LT':
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						A3($elm$core$Dict$insertHelp, key, value, nLeft),
						nRight);
				case 'EQ':
					return A5($elm$core$Dict$RBNode_elm_builtin, nColor, nKey, value, nLeft, nRight);
				default:
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						nLeft,
						A3($elm$core$Dict$insertHelp, key, value, nRight));
			}
		}
	});
var $elm$core$Dict$insert = F3(
	function (key, value, dict) {
		var _v0 = A3($elm$core$Dict$insertHelp, key, value, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $author$project$R10$Form$Internal$Dict$insert = function (key) {
	return $elm$core$Dict$insert(
		$author$project$R10$Form$Internal$Key$toString(key));
};
var $elm$core$Set$insert = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return $elm$core$Set$Set_elm_builtin(
			A3($elm$core$Dict$insert, key, _Utils_Tuple0, dict));
	});
var $elm$core$Platform$Cmd$map = _Platform_map;
var $elm$core$Basics$neq = _Utils_notEqual;
var $author$project$R10$Form$Internal$Update$onActivate = F2(
	function (key, formState) {
		return _Utils_update(
			formState,
			{
				active: $elm$core$Maybe$Just(
					$author$project$R10$Form$Internal$Key$toString(key))
			});
	});
var $author$project$R10$Form$Internal$Update$helperUpdateSearch = F2(
	function (value, maybeFieldState) {
		var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
		return $elm$core$Maybe$Just(
			_Utils_update(
				fieldState,
				{search: value}));
	});
var $elm$core$Dict$getMin = function (dict) {
	getMin:
	while (true) {
		if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
			var left = dict.d;
			var $temp$dict = left;
			dict = $temp$dict;
			continue getMin;
		} else {
			return dict;
		}
	}
};
var $elm$core$Dict$moveRedLeft = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.e.d.$ === 'RBNode_elm_builtin') && (dict.e.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var lLeft = _v1.d;
			var lRight = _v1.e;
			var _v2 = dict.e;
			var rClr = _v2.a;
			var rK = _v2.b;
			var rV = _v2.c;
			var rLeft = _v2.d;
			var _v3 = rLeft.a;
			var rlK = rLeft.b;
			var rlV = rLeft.c;
			var rlL = rLeft.d;
			var rlR = rLeft.e;
			var rRight = _v2.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				rlK,
				rlV,
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					rlL),
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, rK, rV, rlR, rRight));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v4 = dict.d;
			var lClr = _v4.a;
			var lK = _v4.b;
			var lV = _v4.c;
			var lLeft = _v4.d;
			var lRight = _v4.e;
			var _v5 = dict.e;
			var rClr = _v5.a;
			var rK = _v5.b;
			var rV = _v5.c;
			var rLeft = _v5.d;
			var rRight = _v5.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$moveRedRight = function (dict) {
	if (((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) && (dict.e.$ === 'RBNode_elm_builtin')) {
		if ((dict.d.d.$ === 'RBNode_elm_builtin') && (dict.d.d.a.$ === 'Red')) {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v1 = dict.d;
			var lClr = _v1.a;
			var lK = _v1.b;
			var lV = _v1.c;
			var _v2 = _v1.d;
			var _v3 = _v2.a;
			var llK = _v2.b;
			var llV = _v2.c;
			var llLeft = _v2.d;
			var llRight = _v2.e;
			var lRight = _v1.e;
			var _v4 = dict.e;
			var rClr = _v4.a;
			var rK = _v4.b;
			var rV = _v4.c;
			var rLeft = _v4.d;
			var rRight = _v4.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				$elm$core$Dict$Red,
				lK,
				lV,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, llK, llV, llLeft, llRight),
				A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					lRight,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight)));
		} else {
			var clr = dict.a;
			var k = dict.b;
			var v = dict.c;
			var _v5 = dict.d;
			var lClr = _v5.a;
			var lK = _v5.b;
			var lV = _v5.c;
			var lLeft = _v5.d;
			var lRight = _v5.e;
			var _v6 = dict.e;
			var rClr = _v6.a;
			var rK = _v6.b;
			var rV = _v6.c;
			var rLeft = _v6.d;
			var rRight = _v6.e;
			if (clr.$ === 'Black') {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			} else {
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					$elm$core$Dict$Black,
					k,
					v,
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, lK, lV, lLeft, lRight),
					A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, rK, rV, rLeft, rRight));
			}
		}
	} else {
		return dict;
	}
};
var $elm$core$Dict$removeHelpPrepEQGT = F7(
	function (targetKey, dict, color, key, value, left, right) {
		if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Red')) {
			var _v1 = left.a;
			var lK = left.b;
			var lV = left.c;
			var lLeft = left.d;
			var lRight = left.e;
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				lK,
				lV,
				lLeft,
				A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Red, key, value, lRight, right));
		} else {
			_v2$2:
			while (true) {
				if ((right.$ === 'RBNode_elm_builtin') && (right.a.$ === 'Black')) {
					if (right.d.$ === 'RBNode_elm_builtin') {
						if (right.d.a.$ === 'Black') {
							var _v3 = right.a;
							var _v4 = right.d;
							var _v5 = _v4.a;
							return $elm$core$Dict$moveRedRight(dict);
						} else {
							break _v2$2;
						}
					} else {
						var _v6 = right.a;
						var _v7 = right.d;
						return $elm$core$Dict$moveRedRight(dict);
					}
				} else {
					break _v2$2;
				}
			}
			return dict;
		}
	});
var $elm$core$Dict$removeMin = function (dict) {
	if ((dict.$ === 'RBNode_elm_builtin') && (dict.d.$ === 'RBNode_elm_builtin')) {
		var color = dict.a;
		var key = dict.b;
		var value = dict.c;
		var left = dict.d;
		var lColor = left.a;
		var lLeft = left.d;
		var right = dict.e;
		if (lColor.$ === 'Black') {
			if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
				var _v3 = lLeft.a;
				return A5(
					$elm$core$Dict$RBNode_elm_builtin,
					color,
					key,
					value,
					$elm$core$Dict$removeMin(left),
					right);
			} else {
				var _v4 = $elm$core$Dict$moveRedLeft(dict);
				if (_v4.$ === 'RBNode_elm_builtin') {
					var nColor = _v4.a;
					var nKey = _v4.b;
					var nValue = _v4.c;
					var nLeft = _v4.d;
					var nRight = _v4.e;
					return A5(
						$elm$core$Dict$balance,
						nColor,
						nKey,
						nValue,
						$elm$core$Dict$removeMin(nLeft),
						nRight);
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			}
		} else {
			return A5(
				$elm$core$Dict$RBNode_elm_builtin,
				color,
				key,
				value,
				$elm$core$Dict$removeMin(left),
				right);
		}
	} else {
		return $elm$core$Dict$RBEmpty_elm_builtin;
	}
};
var $elm$core$Dict$removeHelp = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBEmpty_elm_builtin') {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		} else {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_cmp(targetKey, key) < 0) {
				if ((left.$ === 'RBNode_elm_builtin') && (left.a.$ === 'Black')) {
					var _v4 = left.a;
					var lLeft = left.d;
					if ((lLeft.$ === 'RBNode_elm_builtin') && (lLeft.a.$ === 'Red')) {
						var _v6 = lLeft.a;
						return A5(
							$elm$core$Dict$RBNode_elm_builtin,
							color,
							key,
							value,
							A2($elm$core$Dict$removeHelp, targetKey, left),
							right);
					} else {
						var _v7 = $elm$core$Dict$moveRedLeft(dict);
						if (_v7.$ === 'RBNode_elm_builtin') {
							var nColor = _v7.a;
							var nKey = _v7.b;
							var nValue = _v7.c;
							var nLeft = _v7.d;
							var nRight = _v7.e;
							return A5(
								$elm$core$Dict$balance,
								nColor,
								nKey,
								nValue,
								A2($elm$core$Dict$removeHelp, targetKey, nLeft),
								nRight);
						} else {
							return $elm$core$Dict$RBEmpty_elm_builtin;
						}
					}
				} else {
					return A5(
						$elm$core$Dict$RBNode_elm_builtin,
						color,
						key,
						value,
						A2($elm$core$Dict$removeHelp, targetKey, left),
						right);
				}
			} else {
				return A2(
					$elm$core$Dict$removeHelpEQGT,
					targetKey,
					A7($elm$core$Dict$removeHelpPrepEQGT, targetKey, dict, color, key, value, left, right));
			}
		}
	});
var $elm$core$Dict$removeHelpEQGT = F2(
	function (targetKey, dict) {
		if (dict.$ === 'RBNode_elm_builtin') {
			var color = dict.a;
			var key = dict.b;
			var value = dict.c;
			var left = dict.d;
			var right = dict.e;
			if (_Utils_eq(targetKey, key)) {
				var _v1 = $elm$core$Dict$getMin(right);
				if (_v1.$ === 'RBNode_elm_builtin') {
					var minKey = _v1.b;
					var minValue = _v1.c;
					return A5(
						$elm$core$Dict$balance,
						color,
						minKey,
						minValue,
						left,
						$elm$core$Dict$removeMin(right));
				} else {
					return $elm$core$Dict$RBEmpty_elm_builtin;
				}
			} else {
				return A5(
					$elm$core$Dict$balance,
					color,
					key,
					value,
					left,
					A2($elm$core$Dict$removeHelp, targetKey, right));
			}
		} else {
			return $elm$core$Dict$RBEmpty_elm_builtin;
		}
	});
var $elm$core$Dict$remove = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$removeHelp, key, dict);
		if ((_v0.$ === 'RBNode_elm_builtin') && (_v0.a.$ === 'Red')) {
			var _v1 = _v0.a;
			var k = _v0.b;
			var v = _v0.c;
			var l = _v0.d;
			var r = _v0.e;
			return A5($elm$core$Dict$RBNode_elm_builtin, $elm$core$Dict$Black, k, v, l, r);
		} else {
			var x = _v0;
			return x;
		}
	});
var $elm$core$Dict$update = F3(
	function (targetKey, alter, dictionary) {
		var _v0 = alter(
			A2($elm$core$Dict$get, targetKey, dictionary));
		if (_v0.$ === 'Just') {
			var value = _v0.a;
			return A3($elm$core$Dict$insert, targetKey, value, dictionary);
		} else {
			return A2($elm$core$Dict$remove, targetKey, dictionary);
		}
	});
var $author$project$R10$Form$Internal$Dict$update = function (key) {
	return $elm$core$Dict$update(
		$author$project$R10$Form$Internal$Key$toString(key));
};
var $author$project$R10$Form$Internal$Update$onChangeSearch = F3(
	function (key, string, formState) {
		return _Utils_update(
			formState,
			{
				fieldsState: A3(
					$author$project$R10$Form$Internal$Dict$update,
					key,
					$author$project$R10$Form$Internal$Update$helperUpdateSearch(string),
					formState.fieldsState)
			});
	});
var $author$project$R10$Form$Internal$Update$helperUpdateSelect = F2(
	function (value, maybeFieldState) {
		var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
		return $elm$core$Maybe$Just(
			_Utils_update(
				fieldState,
				{select: value}));
	});
var $author$project$R10$Form$Internal$Update$onChangeSelect = F3(
	function (key, string, formState) {
		return _Utils_update(
			formState,
			{
				fieldsState: A3(
					$author$project$R10$Form$Internal$Dict$update,
					key,
					$author$project$R10$Form$Internal$Update$helperUpdateSelect(string),
					formState.fieldsState)
			});
	});
var $author$project$R10$Form$Internal$Key$Key = function (a) {
	return {$: 'Key', a: a};
};
var $elm$core$Basics$composeL = F3(
	function (g, f, x) {
		return g(
			f(x));
	});
var $elm$core$List$filter = F2(
	function (isGood, list) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, xs) {
					return isGood(x) ? A2($elm$core$List$cons, x, xs) : xs;
				}),
			_List_Nil,
			list);
	});
var $author$project$R10$Form$Internal$Key$fromList = function (list) {
	return $author$project$R10$Form$Internal$Key$Key(
		A2(
			$elm$core$List$filter,
			A2($elm$core$Basics$composeL, $elm$core$Basics$not, $elm$core$String$isEmpty),
			list));
};
var $author$project$R10$Form$Internal$Key$empty = $author$project$R10$Form$Internal$Key$fromList(_List_Nil);
var $author$project$R10$Form$Internal$Key$composeKey = F2(
	function (_v0, extraKey) {
		var keys = _v0.a;
		return $elm$core$String$isEmpty(extraKey) ? $author$project$R10$Form$Internal$Key$Key(keys) : $author$project$R10$Form$Internal$Key$Key(
			A2($elm$core$List$cons, extraKey, keys));
	});
var $elm$core$List$append = F2(
	function (xs, ys) {
		if (!ys.b) {
			return xs;
		} else {
			return A3($elm$core$List$foldr, $elm$core$List$cons, ys, xs);
		}
	});
var $elm$core$List$concat = function (lists) {
	return A3($elm$core$List$foldr, $elm$core$List$append, _List_Nil, lists);
};
var $elm$core$Dict$member = F2(
	function (key, dict) {
		var _v0 = A2($elm$core$Dict$get, key, dict);
		if (_v0.$ === 'Just') {
			return true;
		} else {
			return false;
		}
	});
var $elm$core$Set$member = F2(
	function (key, _v0) {
		var dict = _v0.a;
		return A2($elm$core$Dict$member, key, dict);
	});
var $elm$core$List$repeatHelp = F3(
	function (result, n, value) {
		repeatHelp:
		while (true) {
			if (n <= 0) {
				return result;
			} else {
				var $temp$result = A2($elm$core$List$cons, value, result),
					$temp$n = n - 1,
					$temp$value = value;
				result = $temp$result;
				n = $temp$n;
				value = $temp$value;
				continue repeatHelp;
			}
		}
	});
var $elm$core$List$repeat = F2(
	function (n, value) {
		return A3($elm$core$List$repeatHelp, _List_Nil, n, value);
	});
var $elm$core$Tuple$second = function (_v0) {
	var y = _v0.b;
	return y;
};
var $author$project$R10$Form$Internal$MakerForValidationKeys$maker = F3(
	function (key, formState, formConf) {
		return $elm$core$List$concat(
			A2(
				$elm$core$List$map,
				function (entity) {
					switch (entity.$) {
						case 'EntityWrappable':
							var id = entity.a;
							var entities = entity.b;
							return A3(
								$author$project$R10$Form$Internal$MakerForValidationKeys$maker,
								A2($author$project$R10$Form$Internal$Key$composeKey, key, id),
								formState,
								entities);
						case 'EntityWithBorder':
							var id = entity.a;
							var entities = entity.b;
							return A3(
								$author$project$R10$Form$Internal$MakerForValidationKeys$maker,
								A2($author$project$R10$Form$Internal$Key$composeKey, key, id),
								formState,
								entities);
						case 'EntityNormal':
							var id = entity.a;
							var entities = entity.b;
							return A3(
								$author$project$R10$Form$Internal$MakerForValidationKeys$maker,
								A2($author$project$R10$Form$Internal$Key$composeKey, key, id),
								formState,
								entities);
						case 'EntityWithTabs':
							var id = entity.a;
							var titleEntityList = entity.b;
							return A3(
								$author$project$R10$Form$Internal$MakerForValidationKeys$maker,
								A2($author$project$R10$Form$Internal$Key$composeKey, key, id),
								formState,
								A2($elm$core$List$map, $elm$core$Tuple$second, titleEntityList));
						case 'EntityMulti':
							var entityId = entity.a;
							var entities = entity.b;
							return A3(
								$author$project$R10$Form$Internal$MakerForValidationKeys$viewEntityMulti,
								A2($author$project$R10$Form$Internal$Key$composeKey, key, entityId),
								formState,
								entities);
						case 'EntityField':
							var fieldConf = entity.a;
							return _List_fromArray(
								[
									_Utils_Tuple2(
									A2($author$project$R10$Form$Internal$Key$composeKey, key, fieldConf.id),
									fieldConf.validationSpecs)
								]);
						case 'EntityTitle':
							var entityId = entity.a;
							var textConf = entity.b;
							return _List_fromArray(
								[
									_Utils_Tuple2(
									A2($author$project$R10$Form$Internal$Key$composeKey, key, entityId),
									textConf.validationSpecs)
								]);
						default:
							var entityId = entity.a;
							var textConf = entity.b;
							return _List_fromArray(
								[
									_Utils_Tuple2(
									A2($author$project$R10$Form$Internal$Key$composeKey, key, entityId),
									textConf.validationSpecs)
								]);
					}
				},
				formConf));
	});
var $author$project$R10$Form$Internal$MakerForValidationKeys$viewEntityMulti = F3(
	function (key, formState, entities) {
		var quantity = A2(
			$elm$core$Maybe$withDefault,
			1,
			A2($author$project$R10$Form$Internal$Dict$get, key, formState.multiplicableQuantities));
		return $elm$core$List$concat(
			A2(
				$elm$core$List$indexedMap,
				F2(
					function (index, _v0) {
						var newKey = A2(
							$author$project$R10$Form$Internal$Key$composeKey,
							key,
							$elm$core$String$fromInt(index));
						var removed = A2(
							$elm$core$Set$member,
							$author$project$R10$Form$Internal$Key$toString(newKey),
							formState.removed);
						return removed ? _List_Nil : A3($author$project$R10$Form$Internal$MakerForValidationKeys$maker, newKey, formState, entities);
					}),
				A2($elm$core$List$repeat, quantity, _Utils_Tuple0)));
	});
var $author$project$R10$Form$Internal$Update$allValidationKeysMaker = F2(
	function (conf, state) {
		return A3($author$project$R10$Form$Internal$MakerForValidationKeys$maker, $author$project$R10$Form$Internal$Key$empty, state, conf);
	});
var $author$project$R10$Form$Internal$Update$helperUpdateDirty = function (maybeFieldState) {
	var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
	return $elm$core$Maybe$Just(
		_Utils_update(
			fieldState,
			{dirty: true}));
};
var $author$project$R10$Form$Internal$Update$helperUpdateValue = F2(
	function (value, maybeFieldState) {
		var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
		return $elm$core$Maybe$Just(
			_Utils_update(
				fieldState,
				{value: value}));
	});
var $author$project$R10$Form$Internal$FieldState$Validated = function (a) {
	return {$: 'Validated', a: a};
};
var $elm$core$List$maybeCons = F3(
	function (f, mx, xs) {
		var _v0 = f(mx);
		if (_v0.$ === 'Just') {
			var x = _v0.a;
			return A2($elm$core$List$cons, x, xs);
		} else {
			return xs;
		}
	});
var $elm$core$List$filterMap = F2(
	function (f, xs) {
		return A3(
			$elm$core$List$foldr,
			$elm$core$List$maybeCons(f),
			_List_Nil,
			xs);
	});
var $elm$core$Maybe$map = F2(
	function (f, maybe) {
		if (maybe.$ === 'Just') {
			var value = maybe.a;
			return $elm$core$Maybe$Just(
				f(value));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $author$project$R10$Form$Internal$FieldState$MessageErr = F2(
	function (a, b) {
		return {$: 'MessageErr', a: a, b: b};
	});
var $author$project$R10$Form$Internal$FieldState$MessageOk = F2(
	function (a, b) {
		return {$: 'MessageOk', a: a, b: b};
	});
var $elm$core$List$any = F2(
	function (isOkay, list) {
		any:
		while (true) {
			if (!list.b) {
				return false;
			} else {
				var x = list.a;
				var xs = list.b;
				if (isOkay(x)) {
					return true;
				} else {
					var $temp$isOkay = isOkay,
						$temp$list = xs;
					isOkay = $temp$isOkay;
					list = $temp$list;
					continue any;
				}
			}
		}
	});
var $elm$core$List$all = F2(
	function (isOkay, list) {
		return !A2(
			$elm$core$List$any,
			A2($elm$core$Basics$composeL, $elm$core$Basics$not, isOkay),
			list);
	});
var $author$project$R10$Form$Internal$Key$fromString = function (keyAsString) {
	return $author$project$R10$Form$Internal$Key$Key(
		$elm$core$List$reverse(
			A2($elm$core$String$split, $author$project$R10$Form$Internal$Key$separator, keyAsString)));
};
var $elm$core$List$isEmpty = function (xs) {
	if (!xs.b) {
		return true;
	} else {
		return false;
	}
};
var $author$project$R10$Form$Internal$Validation$isValid = function (outcome) {
	if (outcome.$ === 'MessageOk') {
		return true;
	} else {
		return false;
	}
};
var $author$project$R10$Form$Internal$Validation$skipValidationIfEmpty = F2(
	function (value, validationOutcome) {
		return $elm$core$String$isEmpty(value) ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(validationOutcome);
	});
var $author$project$R10$Form$Internal$ValidationCode$validationCodes = {allOf: 'ALL_OF', emailFormatInvalid: 'INVALID_EMAIL_FORMAT', emailFormatValid: 'VALID_EMAIL_FORMAT', empty: 'EMPTY', equalInvalid: 'INVALID_EQUAL', formatInvalid: 'INVALID_FORMAT', formatInvalidCharactersInvalid: 'INVALID_FORMAT_INVALID_CHARACTERS', formatNoNumberInvalid: 'INVALID_FORMAT_NO_NUMBER', formatNoSpecialCharactersInvalid: 'INVALID_FORMAT_NO_SPECIAL_CHARACTERS', formatNoUppercaseInvalid: 'INVALID_FORMAT_NO_UPPERCASE', formatValid: 'VALID_FORMAT', hexColorFormatInvalid: 'INVALID_HEX_COLOR_FORMAT', jsonFormatInvalid: 'INVALID_JSON_FORMAT', lengthTooLargeInvalid: 'INVALID_LENGTH_TOO_LARGE', lengthTooSmallInvalid: 'INVALID_LENGTH_TOO_SMALL', oneOf: 'ONE_OF', required: 'REQUIRED', requiredField: 'REQUIRED_FIELD', somethingWrong: 'SOMETHING_WENT_WRONG_DURING_VALIDATION', valueInvalid: 'INVALID_VALUE'};
var $author$project$R10$Form$Internal$Validation$validateEmpty = function (value) {
	return $elm$core$String$isEmpty(value) ? A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.empty, _List_Nil) : A2($author$project$R10$Form$Internal$FieldState$MessageErr, $author$project$R10$Form$Internal$ValidationCode$validationCodes.empty, _List_Nil);
};
var $author$project$R10$Form$Internal$Validation$validateEqual = F3(
	function (value, dependantKey, formState) {
		var dependantValue = A2(
			$elm$core$Maybe$withDefault,
			'',
			A2(
				$elm$core$Maybe$map,
				function ($) {
					return $.value;
				},
				A2($elm$core$Dict$get, dependantKey, formState.fieldsState)));
		return _Utils_eq(value, dependantValue) ? A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.equalInvalid, _List_Nil) : A2($author$project$R10$Form$Internal$FieldState$MessageErr, $author$project$R10$Form$Internal$ValidationCode$validationCodes.equalInvalid, _List_Nil);
	});
var $author$project$R10$Form$Internal$Validation$validateMaxLength = F2(
	function (value, length) {
		return (_Utils_cmp(
			$elm$core$String$length(value),
			length) > 0) ? A2(
			$author$project$R10$Form$Internal$FieldState$MessageErr,
			$author$project$R10$Form$Internal$ValidationCode$validationCodes.lengthTooLargeInvalid,
			_List_fromArray(
				[
					$elm$core$String$fromInt(length)
				])) : A2(
			$author$project$R10$Form$Internal$FieldState$MessageOk,
			$author$project$R10$Form$Internal$ValidationCode$validationCodes.lengthTooLargeInvalid,
			_List_fromArray(
				[
					$elm$core$String$fromInt(length)
				]));
	});
var $author$project$R10$Form$Internal$Validation$validateMinLength = F2(
	function (value, length) {
		return (_Utils_cmp(
			$elm$core$String$length(value),
			length) < 0) ? A2(
			$author$project$R10$Form$Internal$FieldState$MessageErr,
			$author$project$R10$Form$Internal$ValidationCode$validationCodes.lengthTooSmallInvalid,
			_List_fromArray(
				[
					$elm$core$String$fromInt(length)
				])) : A2(
			$author$project$R10$Form$Internal$FieldState$MessageOk,
			$author$project$R10$Form$Internal$ValidationCode$validationCodes.lengthTooSmallInvalid,
			_List_fromArray(
				[
					$elm$core$String$fromInt(length)
				]));
	});
var $author$project$R10$Form$Internal$Validation$NotValid = {$: 'NotValid'};
var $author$project$R10$Form$Internal$Validation$Valid = {$: 'Valid'};
var $elm$regex$Regex$Match = F4(
	function (match, index, number, submatches) {
		return {index: index, match: match, number: number, submatches: submatches};
	});
var $elm$regex$Regex$contains = _Regex_contains;
var $elm$regex$Regex$fromStringWith = _Regex_fromStringWith;
var $elm$regex$Regex$fromString = function (string) {
	return A2(
		$elm$regex$Regex$fromStringWith,
		{caseInsensitive: false, multiline: false},
		string);
};
var $author$project$R10$Form$Internal$Validation$runRegex = F2(
	function (pattern, value) {
		var _v0 = $elm$regex$Regex$fromString(pattern);
		if (_v0.$ === 'Just') {
			var regex = _v0.a;
			return A2($elm$regex$Regex$contains, regex, value) ? $author$project$R10$Form$Internal$Validation$Valid : $author$project$R10$Form$Internal$Validation$NotValid;
		} else {
			return $author$project$R10$Form$Internal$Validation$NotValid;
		}
	});
var $author$project$R10$Form$Internal$Validation$validateRegex = F2(
	function (value, regex) {
		var _v0 = A2($author$project$R10$Form$Internal$Validation$runRegex, regex, value);
		if (_v0.$ === 'Valid') {
			return A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.formatInvalid, _List_Nil);
		} else {
			return A2($author$project$R10$Form$Internal$FieldState$MessageErr, $author$project$R10$Form$Internal$ValidationCode$validationCodes.formatInvalid, _List_Nil);
		}
	});
var $author$project$R10$Form$Internal$Validation$validateRequired = function (value) {
	return $elm$core$String$isEmpty(value) ? A2($author$project$R10$Form$Internal$FieldState$MessageErr, $author$project$R10$Form$Internal$ValidationCode$validationCodes.required, _List_Nil) : A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.required, _List_Nil);
};
var $author$project$R10$Form$Internal$Validation$validateAllOf = F4(
	function (key, value, formState, validations) {
		var messages = A2(
			$elm$core$List$filterMap,
			$elm$core$Basics$identity,
			A2(
				$elm$core$List$map,
				A3($author$project$R10$Form$Internal$Validation$validateValidationSpecs, key, value, formState),
				validations));
		return $elm$core$List$isEmpty(messages) ? A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.allOf, _List_Nil) : (A2($elm$core$List$all, $author$project$R10$Form$Internal$Validation$isValid, messages) ? A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.allOf, _List_Nil) : A2($author$project$R10$Form$Internal$FieldState$MessageErr, $author$project$R10$Form$Internal$ValidationCode$validationCodes.allOf, _List_Nil));
	});
var $author$project$R10$Form$Internal$Validation$validateDependant = F4(
	function (value, dependantKey, formState, validation) {
		var newKey = $author$project$R10$Form$Internal$Key$fromString(dependantKey);
		var newContextValue = A2(
			$elm$core$Maybe$withDefault,
			'',
			A2(
				$elm$core$Maybe$map,
				function ($) {
					return $.value;
				},
				A2($elm$core$Dict$get, dependantKey, formState.fieldsState)));
		return A4($author$project$R10$Form$Internal$Validation$validateValidationSpecs, newKey, newContextValue, formState, validation);
	});
var $author$project$R10$Form$Internal$Validation$validateNot = F4(
	function (key, value, formState, validation) {
		var outcome = A4($author$project$R10$Form$Internal$Validation$validateValidationSpecs, key, value, formState, validation);
		if (outcome.$ === 'Just') {
			if (outcome.a.$ === 'MessageOk') {
				var _v3 = outcome.a;
				var a = _v3.a;
				var b = _v3.b;
				return $elm$core$Maybe$Just(
					A2($author$project$R10$Form$Internal$FieldState$MessageErr, a, b));
			} else {
				var _v4 = outcome.a;
				var a = _v4.a;
				var b = _v4.b;
				return $elm$core$Maybe$Just(
					A2($author$project$R10$Form$Internal$FieldState$MessageOk, a, b));
			}
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $author$project$R10$Form$Internal$Validation$validateOneOf = F4(
	function (key, value, formState, validations) {
		var messages = A2(
			$elm$core$List$filterMap,
			$elm$core$Basics$identity,
			A2(
				$elm$core$List$map,
				A3($author$project$R10$Form$Internal$Validation$validateValidationSpecs, key, value, formState),
				validations));
		return $elm$core$List$isEmpty(messages) ? A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.oneOf, _List_Nil) : (A2($elm$core$List$any, $author$project$R10$Form$Internal$Validation$isValid, messages) ? A2($author$project$R10$Form$Internal$FieldState$MessageOk, $author$project$R10$Form$Internal$ValidationCode$validationCodes.oneOf, _List_Nil) : A2($author$project$R10$Form$Internal$FieldState$MessageErr, $author$project$R10$Form$Internal$ValidationCode$validationCodes.oneOf, _List_Nil));
	});
var $author$project$R10$Form$Internal$Validation$validateValidationSpecs = F4(
	function (key, value, formState, validation) {
		switch (validation.$) {
			case 'WithMsg':
				var msg = validation.a;
				var validation_ = validation.b;
				return A5($author$project$R10$Form$Internal$Validation$validateWithMsg, key, value, msg, formState, validation_);
			case 'Dependant':
				var dependantKey = validation.a;
				var validation_ = validation.b;
				return A4($author$project$R10$Form$Internal$Validation$validateDependant, value, dependantKey, formState, validation_);
			case 'OneOf':
				var validations = validation.a;
				return $elm$core$Maybe$Just(
					A4($author$project$R10$Form$Internal$Validation$validateOneOf, key, value, formState, validations));
			case 'AllOf':
				var validations = validation.a;
				return $elm$core$Maybe$Just(
					A4($author$project$R10$Form$Internal$Validation$validateAllOf, key, value, formState, validations));
			case 'Required':
				return $elm$core$Maybe$Just(
					$author$project$R10$Form$Internal$Validation$validateRequired(value));
			case 'Empty':
				return $elm$core$Maybe$Just(
					$author$project$R10$Form$Internal$Validation$validateEmpty(value));
			case 'Regex':
				var regex = validation.a;
				return A2(
					$author$project$R10$Form$Internal$Validation$skipValidationIfEmpty,
					value,
					A2($author$project$R10$Form$Internal$Validation$validateRegex, value, regex));
			case 'MinLength':
				var length = validation.a;
				return A2(
					$author$project$R10$Form$Internal$Validation$skipValidationIfEmpty,
					value,
					A2($author$project$R10$Form$Internal$Validation$validateMinLength, value, length));
			case 'MaxLength':
				var length = validation.a;
				return A2(
					$author$project$R10$Form$Internal$Validation$skipValidationIfEmpty,
					value,
					A2($author$project$R10$Form$Internal$Validation$validateMaxLength, value, length));
			case 'Equal':
				var dependantKey = validation.a;
				return A2(
					$author$project$R10$Form$Internal$Validation$skipValidationIfEmpty,
					value,
					A3($author$project$R10$Form$Internal$Validation$validateEqual, value, dependantKey, formState));
			case 'Not':
				var validation_ = validation.a;
				return A4($author$project$R10$Form$Internal$Validation$validateNot, key, value, formState, validation_);
			default:
				return $elm$core$Maybe$Nothing;
		}
	});
var $author$project$R10$Form$Internal$Validation$validateWithMsg = F5(
	function (key, value, msg, formState, validation) {
		var maybeMessage = A4($author$project$R10$Form$Internal$Validation$validateValidationSpecs, key, value, formState, validation);
		if (maybeMessage.$ === 'Nothing') {
			return $elm$core$Maybe$Nothing;
		} else {
			var message = maybeMessage.a;
			return $author$project$R10$Form$Internal$Validation$isValid(message) ? $elm$core$Maybe$Just(
				A2($author$project$R10$Form$Internal$FieldState$MessageOk, msg.ok, _List_Nil)) : $elm$core$Maybe$Just(
				A2($author$project$R10$Form$Internal$FieldState$MessageErr, msg.err, _List_Nil));
		}
	});
var $author$project$R10$Form$Internal$Validation$validate = F4(
	function (key, maybeValidationSpec, formState, state) {
		return _Utils_update(
			state,
			{
				validation: $author$project$R10$Form$Internal$FieldState$Validated(
					A2(
						$elm$core$List$filterMap,
						$elm$core$Basics$identity,
						A2(
							$elm$core$List$map,
							A3($author$project$R10$Form$Internal$Validation$validateValidationSpecs, key, state.value, formState),
							A2(
								$elm$core$Maybe$withDefault,
								_List_fromArray(
									[$author$project$R10$Form$Internal$FieldConf$NoValidation]),
								A2(
									$elm$core$Maybe$map,
									function ($) {
										return $.validation;
									},
									maybeValidationSpec)))))
			});
	});
var $author$project$R10$Form$Internal$Update$helperValidateCreatingFieldsState = F4(
	function (key, maybeValidationSpec, formState, maybeFieldState) {
		var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
		return $elm$core$Maybe$Just(
			A4($author$project$R10$Form$Internal$Validation$validate, key, maybeValidationSpec, formState, fieldState));
	});
var $author$project$R10$Form$Internal$QtySubmitAttempted$toInt = function (_v0) {
	var _int = _v0.a;
	return _int;
};
var $author$project$R10$Form$Internal$Update$helperValidateOnChangeValue = F5(
	function (key, maybeValidationSpec, qtySubmitAttempted, formState, maybeFieldState) {
		var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
		return (fieldState.lostFocusOneOrMoreTime || ($author$project$R10$Form$Internal$QtySubmitAttempted$toInt(qtySubmitAttempted) > 0)) ? A4($author$project$R10$Form$Internal$Update$helperValidateCreatingFieldsState, key, maybeValidationSpec, formState, maybeFieldState) : maybeFieldState;
	});
var $author$project$R10$Form$Internal$Update$helperValidateWithoutCreatingFieldsState = F4(
	function (maybeValidationSpec, formState, key, maybeFieldState) {
		return A2(
			$elm$core$Maybe$map,
			A3($author$project$R10$Form$Internal$Validation$validate, key, maybeValidationSpec, formState),
			maybeFieldState);
	});
var $author$project$R10$Form$Internal$Update$runOnlyExistingValidations = F3(
	function (allKeys, formState, fieldsState) {
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, acc) {
					var key = _v0.a;
					var fieldConf = _v0.b;
					return A3(
						$author$project$R10$Form$Internal$Dict$update,
						key,
						A3($author$project$R10$Form$Internal$Update$helperValidateWithoutCreatingFieldsState, fieldConf, formState, key),
						acc);
				}),
			fieldsState,
			allKeys);
	});
var $author$project$R10$Form$Internal$Update$onChangeValue = F5(
	function (key, fieldConf, formConf, string, formState) {
		var newState = _Utils_update(
			formState,
			{
				fieldsState: A3(
					$author$project$R10$Form$Internal$Dict$update,
					key,
					A4($author$project$R10$Form$Internal$Update$helperValidateOnChangeValue, key, fieldConf.validationSpecs, formState.qtySubmitAttempted, formState),
					A3(
						$author$project$R10$Form$Internal$Dict$update,
						key,
						$author$project$R10$Form$Internal$Update$helperUpdateDirty,
						A3(
							$author$project$R10$Form$Internal$Dict$update,
							key,
							$author$project$R10$Form$Internal$Update$helperUpdateValue(string),
							formState.fieldsState))),
				focused: $elm$core$Maybe$Just(
					$author$project$R10$Form$Internal$Key$toString(key))
			});
		var allKeys = A2($author$project$R10$Form$Internal$Update$allValidationKeysMaker, formConf, newState);
		return _Utils_update(
			newState,
			{
				fieldsState: A3($author$project$R10$Form$Internal$Update$runOnlyExistingValidations, allKeys, newState, newState.fieldsState)
			});
	});
var $author$project$R10$Form$Internal$Update$onDeactivate = function (formState) {
	return _Utils_update(
		formState,
		{active: $elm$core$Maybe$Nothing});
};
var $author$project$R10$Form$Internal$Update$onGetFocus = F2(
	function (key, formState) {
		return _Utils_update(
			formState,
			{
				focused: $elm$core$Maybe$Just(
					$author$project$R10$Form$Internal$Key$toString(key))
			});
	});
var $author$project$R10$Form$Internal$Update$helperLostFocus = function (maybeFieldState) {
	var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeFieldState);
	return $elm$core$Maybe$Just(
		_Utils_update(
			fieldState,
			{lostFocusOneOrMoreTime: true}));
};
var $author$project$R10$Form$Internal$Update$onLoseFocus = F3(
	function (key, fieldConf, formState) {
		return _Utils_update(
			formState,
			{
				fieldsState: A3(
					$author$project$R10$Form$Internal$Dict$update,
					key,
					A3($author$project$R10$Form$Internal$Update$helperValidateCreatingFieldsState, key, fieldConf.validationSpecs, formState),
					A3($author$project$R10$Form$Internal$Dict$update, key, $author$project$R10$Form$Internal$Update$helperLostFocus, formState.fieldsState)),
				focused: $elm$core$Maybe$Nothing
			});
	});
var $author$project$R10$Form$Internal$Update$helperUpdateScroll = F2(
	function (value, maybeScroll) {
		var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(maybeScroll);
		return $elm$core$Maybe$Just(
			_Utils_update(
				fieldState,
				{scroll: value}));
	});
var $author$project$R10$Form$Internal$Update$onScroll = F3(
	function (key, scroll, formState) {
		return _Utils_update(
			formState,
			{
				fieldsState: A3(
					$author$project$R10$Form$Internal$Dict$update,
					key,
					$author$project$R10$Form$Internal$Update$helperUpdateScroll(scroll),
					formState.fieldsState)
			});
	});
var $author$project$R10$Form$Internal$QtySubmitAttempted$increment = function (qtySubmitAttempted) {
	return $author$project$R10$Form$Internal$QtySubmitAttempted$fromInt(
		$author$project$R10$Form$Internal$QtySubmitAttempted$toInt(qtySubmitAttempted) + 1);
};
var $author$project$R10$Form$Internal$Update$runAllValidations = F3(
	function (allKeys, formState, fieldsState) {
		return A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, acc) {
					var key = _v0.a;
					var validationSpec = _v0.b;
					return A3(
						$author$project$R10$Form$Internal$Dict$update,
						key,
						A3($author$project$R10$Form$Internal$Update$helperValidateCreatingFieldsState, key, validationSpec, formState),
						acc);
				}),
			fieldsState,
			allKeys);
	});
var $author$project$R10$Form$Internal$Update$validateEntireForm = F2(
	function (conf, state) {
		var allKeys = A2($author$project$R10$Form$Internal$Update$allValidationKeysMaker, conf, state);
		var newFieldsState = A3($author$project$R10$Form$Internal$Update$runAllValidations, allKeys, state, state.fieldsState);
		return _Utils_update(
			state,
			{fieldsState: newFieldsState});
	});
var $author$project$R10$Form$Internal$Update$submit = F2(
	function (conf, state) {
		var newQtySubmitAttempted = $author$project$R10$Form$Internal$QtySubmitAttempted$increment(state.qtySubmitAttempted);
		var newFieldsState = A2($author$project$R10$Form$Internal$Update$validateEntireForm, conf, state);
		return _Utils_update(
			newFieldsState,
			{qtySubmitAttempted: newQtySubmitAttempted});
	});
var $elm$core$Maybe$andThen = F2(
	function (callback, maybeValue) {
		if (maybeValue.$ === 'Just') {
			var value = maybeValue.a;
			return callback(value);
		} else {
			return $elm$core$Maybe$Nothing;
		}
	});
var $elm$core$List$drop = F2(
	function (n, list) {
		drop:
		while (true) {
			if (n <= 0) {
				return list;
			} else {
				if (!list.b) {
					return list;
				} else {
					var x = list.a;
					var xs = list.b;
					var $temp$n = n - 1,
						$temp$list = xs;
					n = $temp$n;
					list = $temp$list;
					continue drop;
				}
			}
		}
	});
var $elm$core$List$head = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(x);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm_community$list_extra$List$Extra$getAt = F2(
	function (idx, xs) {
		return (idx < 0) ? $elm$core$Maybe$Nothing : $elm$core$List$head(
			A2($elm$core$List$drop, idx, xs));
	});
var $elm_community$list_extra$List$Extra$findIndexHelp = F3(
	function (index, predicate, list) {
		findIndexHelp:
		while (true) {
			if (!list.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var x = list.a;
				var xs = list.b;
				if (predicate(x)) {
					return $elm$core$Maybe$Just(index);
				} else {
					var $temp$index = index + 1,
						$temp$predicate = predicate,
						$temp$list = xs;
					index = $temp$index;
					predicate = $temp$predicate;
					list = $temp$list;
					continue findIndexHelp;
				}
			}
		}
	});
var $elm_community$list_extra$List$Extra$findIndex = $elm_community$list_extra$List$Extra$findIndexHelp(0);
var $author$project$R10$FormComponents$Single$Update$getOptionIndex = F2(
	function (filteredOptions, value) {
		return A2(
			$elm_community$list_extra$List$Extra$findIndex,
			function (opt) {
				return _Utils_eq(opt.value, value);
			},
			filteredOptions);
	});
var $author$project$R10$FormComponents$Single$Update$dropdownHingeHeight = 10;
var $elm$core$Basics$ge = _Utils_ge;
var $elm$core$Basics$min = F2(
	function (x, y) {
		return (_Utils_cmp(x, y) < 0) ? x : y;
	});
var $author$project$R10$FormComponents$Single$Update$getDropdownHeight = F2(
	function (args, optionsCount) {
		var displayCount = A2(
			$elm$core$Basics$max,
			1,
			A2($elm$core$Basics$min, args.maxDisplayCount, optionsCount));
		var bottomHingeHeight = (_Utils_eq(displayCount, optionsCount) || (!optionsCount)) ? $author$project$R10$FormComponents$Single$Update$dropdownHingeHeight : 0;
		var dropdownHeight = ((args.selectOptionHeight * displayCount) + $author$project$R10$FormComponents$Single$Update$dropdownHingeHeight) + bottomHingeHeight;
		return dropdownHeight;
	});
var $elm$core$Basics$negate = function (n) {
	return -n;
};
var $author$project$R10$FormComponents$Single$Update$getOptionY = F4(
	function (scroll, args, optionIndex, optionsCount) {
		if (_Utils_eq(optionIndex, -1)) {
			return scroll;
		} else {
			if (!optionIndex) {
				return 0.0;
			} else {
				var maxViewport = {
					bottom: scroll + A2($author$project$R10$FormComponents$Single$Update$getDropdownHeight, args, optionsCount),
					top: scroll
				};
				var bottomHingeHeight = _Utils_eq(optionIndex, optionsCount - 1) ? $author$project$R10$FormComponents$Single$Update$dropdownHingeHeight : 0;
				var optionY = ((optionIndex * args.selectOptionHeight) + $author$project$R10$FormComponents$Single$Update$dropdownHingeHeight) + bottomHingeHeight;
				return (_Utils_cmp(optionY, maxViewport.bottom) > -1) ? (optionY - (A2($author$project$R10$FormComponents$Single$Update$getDropdownHeight, args, optionsCount) - args.selectOptionHeight)) : ((_Utils_cmp(optionY, maxViewport.top) < 1) ? optionY : scroll);
			}
		}
	});
var $author$project$R10$FormComponents$Single$Update$inboundIndex = F2(
	function (maxIdx, idx) {
		return ((idx < 0) || (_Utils_cmp(idx, maxIdx) > 0)) ? $elm$core$Maybe$Nothing : $elm$core$Maybe$Just(idx);
	});
var $author$project$R10$FormComponents$Single$Update$getNewSelectAndY_ = F4(
	function (step, _default, model, args) {
		var select = $elm$core$String$isEmpty(model.select) ? model.value : model.select;
		var newIndex = A2(
			$elm$core$Maybe$withDefault,
			_default,
			A2(
				$elm$core$Maybe$andThen,
				$author$project$R10$FormComponents$Single$Update$inboundIndex(
					$elm$core$List$length(args.fieldOptions) - 1),
				A2(
					$elm$core$Maybe$map,
					function (index) {
						return index + step;
					},
					A2($author$project$R10$FormComponents$Single$Update$getOptionIndex, args.fieldOptions, select))));
		var newValue = A2(
			$elm$core$Maybe$withDefault,
			'',
			A2(
				$elm$core$Maybe$map,
				function ($) {
					return $.value;
				},
				A2($elm_community$list_extra$List$Extra$getAt, newIndex, args.fieldOptions)));
		var newY = A4(
			$author$project$R10$FormComponents$Single$Update$getOptionY,
			model.scroll,
			args,
			newIndex,
			$elm$core$List$length(args.fieldOptions));
		return _Utils_Tuple2(newValue, newY);
	});
var $author$project$R10$FormComponents$Single$Update$getNextNewSelectAndY = F2(
	function (model, args) {
		return A4($author$project$R10$FormComponents$Single$Update$getNewSelectAndY_, 1, 0, model, args);
	});
var $elm_community$list_extra$List$Extra$find = F2(
	function (predicate, list) {
		find:
		while (true) {
			if (!list.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var first = list.a;
				var rest = list.b;
				if (predicate(first)) {
					return $elm$core$Maybe$Just(first);
				} else {
					var $temp$predicate = predicate,
						$temp$list = rest;
					predicate = $temp$predicate;
					list = $temp$list;
					continue find;
				}
			}
		}
	});
var $author$project$R10$FormComponents$Single$Update$getOptionByLabel = F2(
	function (fieldOptions, targetLabel) {
		return A2(
			$elm_community$list_extra$List$Extra$find,
			function (opt) {
				return _Utils_eq(opt.label, targetLabel);
			},
			fieldOptions);
	});
var $author$project$R10$FormComponents$Single$Update$getPrevNewSelectAndY = F2(
	function (model, args) {
		return A4(
			$author$project$R10$FormComponents$Single$Update$getNewSelectAndY_,
			-1,
			$elm$core$List$length(args.fieldOptions) - 1,
			model,
			args);
	});
var $author$project$R10$FormComponents$Single$Common$NoOp = {$: 'NoOp'};
var $elm$core$Basics$always = F2(
	function (a, _v0) {
		return a;
	});
var $elm$core$Task$onError = _Scheduler_onError;
var $elm$core$Task$attempt = F2(
	function (resultToMessage, task) {
		return $elm$core$Task$command(
			$elm$core$Task$Perform(
				A2(
					$elm$core$Task$onError,
					A2(
						$elm$core$Basics$composeL,
						A2($elm$core$Basics$composeL, $elm$core$Task$succeed, resultToMessage),
						$elm$core$Result$Err),
					A2(
						$elm$core$Task$andThen,
						A2(
							$elm$core$Basics$composeL,
							A2($elm$core$Basics$composeL, $elm$core$Task$succeed, resultToMessage),
							$elm$core$Result$Ok),
						task))));
	});
var $author$project$R10$FormComponents$Single$Common$dropdownContentId = function (key) {
	return 'dropdown-content-' + key;
};
var $elm$browser$Browser$Dom$setViewportOf = _Browser_setViewportOf;
var $author$project$R10$FormComponents$Single$Update$onArrowHelper = F3(
	function (model, value, _float) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{scroll: _float, select: value}),
			A2(
				$elm$core$Task$attempt,
				$elm$core$Basics$always($author$project$R10$FormComponents$Single$Common$NoOp),
				A3(
					$elm$browser$Browser$Dom$setViewportOf,
					$author$project$R10$FormComponents$Single$Common$dropdownContentId(''),
					0,
					_float)));
	});
var $author$project$R10$FormComponents$Single$Update$onOpenHelper = F2(
	function (model, _float) {
		return _Utils_Tuple2(
			_Utils_update(
				model,
				{opened: true, scroll: _float}),
			A2(
				$elm$core$Task$attempt,
				$elm$core$Basics$always($author$project$R10$FormComponents$Single$Common$NoOp),
				A3(
					$elm$browser$Browser$Dom$setViewportOf,
					$author$project$R10$FormComponents$Single$Common$dropdownContentId(''),
					0,
					_float)));
	});
var $author$project$R10$FormComponents$Single$Update$update = F2(
	function (msg, model) {
		switch (msg.$) {
			case 'NoOp':
				return _Utils_Tuple2(model, $elm$core$Platform$Cmd$none);
			case 'OnSearch':
				var fieldOptions = msg.a;
				var search = msg.b;
				var newVal = $elm$core$String$isEmpty(search) ? '' : model.value;
				var newSelect = $elm$core$String$isEmpty(search) ? '' : A2(
					$elm$core$Maybe$withDefault,
					'',
					A2(
						$elm$core$Maybe$map,
						function ($) {
							return $.value;
						},
						A2($author$project$R10$FormComponents$Single$Update$getOptionByLabel, fieldOptions, search)));
				var newModel = _Utils_update(
					model,
					{search: search, select: newSelect, value: newVal});
				return A2($author$project$R10$FormComponents$Single$Update$onOpenHelper, newModel, newModel.scroll);
			case 'OnOptionSelect':
				var value = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{opened: false, search: '', select: '', value: value}),
					$elm$core$Platform$Cmd$none);
			case 'OnScroll':
				var scroll = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{scroll: scroll}),
					$elm$core$Platform$Cmd$none);
			case 'OnInputClick':
				var scroll = msg.a;
				return model.opened ? _Utils_Tuple2(
					_Utils_update(
						model,
						{opened: false, scroll: scroll}),
					$elm$core$Platform$Cmd$none) : A2($author$project$R10$FormComponents$Single$Update$onOpenHelper, model, scroll);
			case 'OnLoseFocus':
				var value = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{focused: false, opened: false, search: '', select: '', value: value}),
					$elm$core$Platform$Cmd$none);
			case 'OnFocus':
				var value = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{focused: true, value: value}),
					$elm$core$Platform$Cmd$none);
			case 'OnArrowUp':
				var args = msg.a;
				return model.opened ? function (_v1) {
					var newValue = _v1.a;
					var newY = _v1.b;
					return A3($author$project$R10$FormComponents$Single$Update$onArrowHelper, model, newValue, newY);
				}(
					A2($author$project$R10$FormComponents$Single$Update$getPrevNewSelectAndY, model, args)) : A2($author$project$R10$FormComponents$Single$Update$onOpenHelper, model, model.scroll);
			case 'OnArrowDown':
				var args = msg.a;
				return model.opened ? function (_v2) {
					var newValue = _v2.a;
					var newY = _v2.b;
					return A3($author$project$R10$FormComponents$Single$Update$onArrowHelper, model, newValue, newY);
				}(
					A2($author$project$R10$FormComponents$Single$Update$getNextNewSelectAndY, model, args)) : A2($author$project$R10$FormComponents$Single$Update$onOpenHelper, model, model.scroll);
			default:
				return _Utils_Tuple2(
					_Utils_update(
						model,
						{opened: false, search: ''}),
					$elm$core$Platform$Cmd$none);
		}
	});
var $author$project$R10$Form$Internal$Update$update = F2(
	function (msg, formStateBeforeHandleChangesSinceLastSubmissions) {
		var formState = _Utils_update(
			formStateBeforeHandleChangesSinceLastSubmissions,
			{
				changesSinceLastSubmissions: A2($author$project$R10$Form$Msg$handleChangesSinceLastSubmissions, formStateBeforeHandleChangesSinceLastSubmissions.changesSinceLastSubmissions, msg)
			});
		switch (msg.$) {
			case 'NoOp':
				return _Utils_Tuple2(formState, $elm$core$Platform$Cmd$none);
			case 'Submit':
				var formConf = msg.a;
				return _Utils_Tuple2(
					A2($author$project$R10$Form$Internal$Update$submit, formConf, formState),
					$elm$core$Platform$Cmd$none);
			case 'GetFocus':
				var key = msg.a;
				return _Utils_Tuple2(
					A2($author$project$R10$Form$Internal$Update$onGetFocus, key, formState),
					$elm$core$Platform$Cmd$none);
			case 'LoseFocus':
				var key = msg.a;
				var fieldConf = msg.b;
				return _Utils_Tuple2(
					A3($author$project$R10$Form$Internal$Update$onLoseFocus, key, fieldConf, formState),
					$elm$core$Platform$Cmd$none);
			case 'TogglePasswordShow':
				var key = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						formState,
						{
							fieldsState: A3($author$project$R10$Form$Internal$Dict$update, key, $author$project$R10$Form$Internal$Update$helperToggleShowPassword, formState.fieldsState)
						}),
					$elm$core$Platform$Cmd$none);
			case 'ChangeTab':
				var key = msg.a;
				var string = msg.b;
				return _Utils_Tuple2(
					_Utils_update(
						formState,
						{
							activeTabs: A3($author$project$R10$Form$Internal$Dict$insert, key, string, formState.activeTabs)
						}),
					$elm$core$Platform$Cmd$none);
			case 'AddEntity':
				var key = msg.a;
				var presentQuantity = A2(
					$elm$core$Maybe$withDefault,
					1,
					A2($author$project$R10$Form$Internal$Dict$get, key, formState.multiplicableQuantities));
				return _Utils_Tuple2(
					_Utils_update(
						formState,
						{
							multiplicableQuantities: A3($author$project$R10$Form$Internal$Dict$insert, key, presentQuantity + 1, formState.multiplicableQuantities)
						}),
					$elm$core$Platform$Cmd$none);
			case 'RemoveEntity':
				var key = msg.a;
				return _Utils_Tuple2(
					_Utils_update(
						formState,
						{
							removed: A2(
								$elm$core$Set$insert,
								$author$project$R10$Form$Internal$Key$toString(key),
								formState.removed)
						}),
					$elm$core$Platform$Cmd$none);
			case 'ChangeValue':
				var key = msg.a;
				var fieldConf = msg.b;
				var formConf = msg.c;
				var string = msg.d;
				return _Utils_Tuple2(
					A5($author$project$R10$Form$Internal$Update$onChangeValue, key, fieldConf, formConf, string, formState),
					$elm$core$Platform$Cmd$none);
			default:
				var key = msg.a;
				var fieldConf = msg.b;
				var formConf = msg.c;
				var singleMsg = msg.d;
				var fieldState = $author$project$R10$Form$Internal$Update$stateWithDefault(
					A2($author$project$R10$Form$Internal$Dict$get, key, formState.fieldsState));
				var singleModel = {
					focused: _Utils_eq(
						formState.focused,
						$elm$core$Maybe$Just(
							$author$project$R10$Form$Internal$Key$toString(key))),
					opened: _Utils_eq(
						formState.active,
						$elm$core$Maybe$Just(
							$author$project$R10$Form$Internal$Key$toString(key))),
					scroll: fieldState.scroll,
					search: fieldState.search,
					select: fieldState.select,
					value: fieldState.value
				};
				var _v1 = A2($author$project$R10$FormComponents$Single$Update$update, singleMsg, singleModel);
				var newSingleModel = _v1.a;
				var singleCmd = _v1.b;
				var newFormState = ((!_Utils_eq(singleModel.opened, newSingleModel.opened)) ? (newSingleModel.opened ? $author$project$R10$Form$Internal$Update$onActivate(key) : $author$project$R10$Form$Internal$Update$onDeactivate) : $elm$core$Basics$identity)(
					((!_Utils_eq(singleModel.focused, newSingleModel.focused)) ? (newSingleModel.focused ? $author$project$R10$Form$Internal$Update$onGetFocus(key) : A2($author$project$R10$Form$Internal$Update$onLoseFocus, key, fieldConf)) : $elm$core$Basics$identity)(
						((!_Utils_eq(fieldState.scroll, newSingleModel.scroll)) ? A2($author$project$R10$Form$Internal$Update$onScroll, key, newSingleModel.scroll) : $elm$core$Basics$identity)(
							((!_Utils_eq(fieldState.select, newSingleModel.select)) ? A2($author$project$R10$Form$Internal$Update$onChangeSelect, key, newSingleModel.select) : $elm$core$Basics$identity)(
								((!_Utils_eq(fieldState.search, newSingleModel.search)) ? A2($author$project$R10$Form$Internal$Update$onChangeSearch, key, newSingleModel.search) : $elm$core$Basics$identity)(
									((!_Utils_eq(fieldState.value, newSingleModel.value)) ? A4($author$project$R10$Form$Internal$Update$onChangeValue, key, fieldConf, formConf, newSingleModel.value) : $elm$core$Basics$identity)(formState))))));
				return _Utils_Tuple2(
					newFormState,
					A2(
						$elm$core$Platform$Cmd$map,
						A3($author$project$R10$Form$Msg$OnSingleMsg, key, fieldConf, formConf),
						singleCmd));
		}
	});
var $author$project$R10$Form$update = $author$project$R10$Form$Internal$Update$update;
var $author$project$Main$update = F2(
	function (msg, model) {
		var msgForm = msg.a;
		var form = model.form;
		var newForm = _Utils_update(
			form,
			{
				state: A2($author$project$R10$Form$update, msgForm, form.state).a
			});
		return _Utils_update(
			model,
			{form: newForm});
	});
var $author$project$R10$Libu$Bu = function (a) {
	return {$: 'Bu', a: a};
};
var $author$project$Main$MsgForm = function (a) {
	return {$: 'MsgForm', a: a};
};
var $author$project$R10$Color$Internal$Derived$Background = {$: 'Background'};
var $mdgriffith$elm_ui$Internal$Model$Colored = F3(
	function (a, b, c) {
		return {$: 'Colored', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Model$StyleClass = F2(
	function (a, b) {
		return {$: 'StyleClass', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$Flag = function (a) {
	return {$: 'Flag', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$Second = function (a) {
	return {$: 'Second', a: a};
};
var $elm$core$Bitwise$shiftLeftBy = _Bitwise_shiftLeftBy;
var $mdgriffith$elm_ui$Internal$Flag$flag = function (i) {
	return (i > 31) ? $mdgriffith$elm_ui$Internal$Flag$Second(1 << (i - 32)) : $mdgriffith$elm_ui$Internal$Flag$Flag(1 << i);
};
var $mdgriffith$elm_ui$Internal$Flag$bgColor = $mdgriffith$elm_ui$Internal$Flag$flag(8);
var $elm$core$Basics$round = _Basics_round;
var $mdgriffith$elm_ui$Internal$Model$floatClass = function (x) {
	return $elm$core$String$fromInt(
		$elm$core$Basics$round(x * 255));
};
var $mdgriffith$elm_ui$Internal$Model$formatColorClass = function (_v0) {
	var red = _v0.a;
	var green = _v0.b;
	var blue = _v0.c;
	var alpha = _v0.d;
	return $mdgriffith$elm_ui$Internal$Model$floatClass(red) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(green) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(blue) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(alpha))))));
};
var $mdgriffith$elm_ui$Element$Background$color = function (clr) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$bgColor,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Colored,
			'bg-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(clr),
			'background-color',
			clr));
};
var $mdgriffith$elm_ui$Internal$Model$Rgba = F4(
	function (a, b, c, d) {
		return {$: 'Rgba', a: a, b: b, c: c, d: d};
	});
var $mdgriffith$elm_ui$Element$rgba = $mdgriffith$elm_ui$Internal$Model$Rgba;
var $avh4$elm_color$Color$toRgba = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	return {alpha: a, blue: b, green: g, red: r};
};
var $author$project$R10$Color$Utils$colorToElementColor = function (color) {
	var _v0 = $avh4$elm_color$Color$toRgba(color);
	var red = _v0.red;
	var green = _v0.green;
	var blue = _v0.blue;
	var alpha = _v0.alpha;
	return A4($mdgriffith$elm_ui$Element$rgba, red, green, blue, alpha);
};
var $author$project$R10$Color$Internal$Base$Background = {$: 'Background'};
var $author$project$R10$Color$Internal$Base$Error = {$: 'Error'};
var $author$project$R10$Color$Internal$Base$Font = {$: 'Font'};
var $author$project$R10$Color$Internal$Base$FontLink = {$: 'FontLink'};
var $author$project$R10$Color$Internal$Primary$LightBlue = {$: 'LightBlue'};
var $author$project$R10$Color$Internal$Base$Success = {$: 'Success'};
var $avh4$elm_color$Color$RgbaSpace = F4(
	function (a, b, c, d) {
		return {$: 'RgbaSpace', a: a, b: b, c: c, d: d};
	});
var $avh4$elm_color$Color$hsla = F4(
	function (hue, sat, light, alpha) {
		var _v0 = _Utils_Tuple3(hue, sat, light);
		var h = _v0.a;
		var s = _v0.b;
		var l = _v0.c;
		var m2 = (l <= 0.5) ? (l * (s + 1)) : ((l + s) - (l * s));
		var m1 = (l * 2) - m2;
		var hueToRgb = function (h__) {
			var h_ = (h__ < 0) ? (h__ + 1) : ((h__ > 1) ? (h__ - 1) : h__);
			return ((h_ * 6) < 1) ? (m1 + (((m2 - m1) * h_) * 6)) : (((h_ * 2) < 1) ? m2 : (((h_ * 3) < 2) ? (m1 + (((m2 - m1) * ((2 / 3) - h_)) * 6)) : m1));
		};
		var b = hueToRgb(h - (1 / 3));
		var g = hueToRgb(h);
		var r = hueToRgb(h + (1 / 3));
		return A4($avh4$elm_color$Color$RgbaSpace, r, g, b, alpha);
	});
var $elm$core$Basics$clamp = F3(
	function (low, high, number) {
		return (_Utils_cmp(number, low) < 0) ? low : ((_Utils_cmp(number, high) > 0) ? high : number);
	});
var $noahzgordon$elm_color_extra$Color$Manipulate$limit = A2($elm$core$Basics$clamp, 0, 1);
var $elm$core$Basics$isNaN = _Basics_isNaN;
var $avh4$elm_color$Color$toHsla = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	var minColor = A2(
		$elm$core$Basics$min,
		r,
		A2($elm$core$Basics$min, g, b));
	var maxColor = A2(
		$elm$core$Basics$max,
		r,
		A2($elm$core$Basics$max, g, b));
	var l = (minColor + maxColor) / 2;
	var s = _Utils_eq(minColor, maxColor) ? 0 : ((l < 0.5) ? ((maxColor - minColor) / (maxColor + minColor)) : ((maxColor - minColor) / ((2 - maxColor) - minColor)));
	var h1 = _Utils_eq(maxColor, r) ? ((g - b) / (maxColor - minColor)) : (_Utils_eq(maxColor, g) ? (2 + ((b - r) / (maxColor - minColor))) : (4 + ((r - g) / (maxColor - minColor))));
	var h2 = h1 * (1 / 6);
	var h3 = $elm$core$Basics$isNaN(h2) ? 0 : ((h2 < 0) ? (h2 + 1) : h2);
	return {alpha: a, hue: h3, lightness: l, saturation: s};
};
var $noahzgordon$elm_color_extra$Color$Manipulate$darken = F2(
	function (offset, cl) {
		var _v0 = $avh4$elm_color$Color$toHsla(cl);
		var hue = _v0.hue;
		var saturation = _v0.saturation;
		var lightness = _v0.lightness;
		var alpha = _v0.alpha;
		return A4(
			$avh4$elm_color$Color$hsla,
			hue,
			saturation,
			$noahzgordon$elm_color_extra$Color$Manipulate$limit(lightness - offset),
			alpha);
	});
var $noahzgordon$elm_color_extra$Color$Manipulate$lighten = F2(
	function (offset, cl) {
		return A2($noahzgordon$elm_color_extra$Color$Manipulate$darken, -offset, cl);
	});
var $noahzgordon$elm_color_extra$Color$Manipulate$saturate = F2(
	function (offset, cl) {
		var _v0 = $avh4$elm_color$Color$toHsla(cl);
		var hue = _v0.hue;
		var saturation = _v0.saturation;
		var lightness = _v0.lightness;
		var alpha = _v0.alpha;
		return A4(
			$avh4$elm_color$Color$hsla,
			hue,
			$noahzgordon$elm_color_extra$Color$Manipulate$limit(saturation + offset),
			lightness,
			alpha);
	});
var $noahzgordon$elm_color_extra$Color$Manipulate$desaturate = F2(
	function (offset, cl) {
		return A2($noahzgordon$elm_color_extra$Color$Manipulate$saturate, -offset, cl);
	});
var $avh4$elm_color$Color$fromRgba = function (components) {
	return A4($avh4$elm_color$Color$RgbaSpace, components.red, components.green, components.blue, components.alpha);
};
var $elm$core$Result$andThen = F2(
	function (callback, result) {
		if (result.$ === 'Ok') {
			var value = result.a;
			return callback(value);
		} else {
			var msg = result.a;
			return $elm$core$Result$Err(msg);
		}
	});
var $elm$core$Basics$composeR = F3(
	function (f, g, x) {
		return g(
			f(x));
	});
var $elm$regex$Regex$findAtMost = _Regex_findAtMost;
var $elm$core$String$fromList = _String_fromList;
var $elm$core$Result$fromMaybe = F2(
	function (err, maybe) {
		if (maybe.$ === 'Just') {
			var v = maybe.a;
			return $elm$core$Result$Ok(v);
		} else {
			return $elm$core$Result$Err(err);
		}
	});
var $elm$core$Result$map = F2(
	function (func, ra) {
		if (ra.$ === 'Ok') {
			var a = ra.a;
			return $elm$core$Result$Ok(
				func(a));
		} else {
			var e = ra.a;
			return $elm$core$Result$Err(e);
		}
	});
var $fredcy$elm_parseint$ParseInt$InvalidRadix = function (a) {
	return {$: 'InvalidRadix', a: a};
};
var $fredcy$elm_parseint$ParseInt$InvalidChar = function (a) {
	return {$: 'InvalidChar', a: a};
};
var $fredcy$elm_parseint$ParseInt$OutOfRange = function (a) {
	return {$: 'OutOfRange', a: a};
};
var $fredcy$elm_parseint$ParseInt$charOffset = F2(
	function (basis, c) {
		return $elm$core$Char$toCode(c) - $elm$core$Char$toCode(basis);
	});
var $fredcy$elm_parseint$ParseInt$isBetween = F3(
	function (lower, upper, c) {
		var ci = $elm$core$Char$toCode(c);
		return (_Utils_cmp(
			$elm$core$Char$toCode(lower),
			ci) < 1) && (_Utils_cmp(
			ci,
			$elm$core$Char$toCode(upper)) < 1);
	});
var $fredcy$elm_parseint$ParseInt$intFromChar = F2(
	function (radix, c) {
		var validInt = function (i) {
			return (_Utils_cmp(i, radix) < 0) ? $elm$core$Result$Ok(i) : $elm$core$Result$Err(
				$fredcy$elm_parseint$ParseInt$OutOfRange(c));
		};
		var toInt = A3(
			$fredcy$elm_parseint$ParseInt$isBetween,
			_Utils_chr('0'),
			_Utils_chr('9'),
			c) ? $elm$core$Result$Ok(
			A2(
				$fredcy$elm_parseint$ParseInt$charOffset,
				_Utils_chr('0'),
				c)) : (A3(
			$fredcy$elm_parseint$ParseInt$isBetween,
			_Utils_chr('a'),
			_Utils_chr('z'),
			c) ? $elm$core$Result$Ok(
			10 + A2(
				$fredcy$elm_parseint$ParseInt$charOffset,
				_Utils_chr('a'),
				c)) : (A3(
			$fredcy$elm_parseint$ParseInt$isBetween,
			_Utils_chr('A'),
			_Utils_chr('Z'),
			c) ? $elm$core$Result$Ok(
			10 + A2(
				$fredcy$elm_parseint$ParseInt$charOffset,
				_Utils_chr('A'),
				c)) : $elm$core$Result$Err(
			$fredcy$elm_parseint$ParseInt$InvalidChar(c))));
		return A2($elm$core$Result$andThen, validInt, toInt);
	});
var $fredcy$elm_parseint$ParseInt$parseIntR = F2(
	function (radix, rstring) {
		var _v0 = $elm$core$String$uncons(rstring);
		if (_v0.$ === 'Nothing') {
			return $elm$core$Result$Ok(0);
		} else {
			var _v1 = _v0.a;
			var c = _v1.a;
			var rest = _v1.b;
			return A2(
				$elm$core$Result$andThen,
				function (ci) {
					return A2(
						$elm$core$Result$andThen,
						function (ri) {
							return $elm$core$Result$Ok(ci + (ri * radix));
						},
						A2($fredcy$elm_parseint$ParseInt$parseIntR, radix, rest));
				},
				A2($fredcy$elm_parseint$ParseInt$intFromChar, radix, c));
		}
	});
var $elm$core$String$reverse = _String_reverse;
var $fredcy$elm_parseint$ParseInt$parseIntRadix = F2(
	function (radix, string) {
		return ((2 <= radix) && (radix <= 36)) ? A2(
			$fredcy$elm_parseint$ParseInt$parseIntR,
			radix,
			$elm$core$String$reverse(string)) : $elm$core$Result$Err(
			$fredcy$elm_parseint$ParseInt$InvalidRadix(radix));
	});
var $fredcy$elm_parseint$ParseInt$parseIntHex = $fredcy$elm_parseint$ParseInt$parseIntRadix(16);
var $avh4$elm_color$Color$rgb = F3(
	function (r, g, b) {
		return A4($avh4$elm_color$Color$RgbaSpace, r, g, b, 1.0);
	});
var $avh4$elm_color$Color$rgba = F4(
	function (r, g, b, a) {
		return A4($avh4$elm_color$Color$RgbaSpace, r, g, b, a);
	});
var $elm$core$Basics$pow = _Basics_pow;
var $noahzgordon$elm_color_extra$Color$Convert$roundToPlaces = F2(
	function (places, number) {
		var multiplier = A2($elm$core$Basics$pow, 10, places);
		return $elm$core$Basics$round(number * multiplier) / multiplier;
	});
var $elm$core$String$foldr = _String_foldr;
var $elm$core$String$toList = function (string) {
	return A3($elm$core$String$foldr, $elm$core$List$cons, _List_Nil, string);
};
var $elm$core$String$toLower = _String_toLower;
var $noahzgordon$elm_color_extra$Color$Convert$hexToColor = function () {
	var pattern = '' + ('^' + ('#?' + ('(?:' + ('(?:([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2}))' + ('|' + ('(?:([a-f\\d])([a-f\\d])([a-f\\d]))' + ('|' + ('(?:([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2})([a-f\\d]{2}))' + ('|' + ('(?:([a-f\\d])([a-f\\d])([a-f\\d])([a-f\\d]))' + (')' + '$')))))))))));
	var extend = function (token) {
		var _v6 = $elm$core$String$toList(token);
		if (_v6.b && (!_v6.b.b)) {
			var token_ = _v6.a;
			return $elm$core$String$fromList(
				_List_fromArray(
					[token_, token_]));
		} else {
			return token;
		}
	};
	return A2(
		$elm$core$Basics$composeR,
		$elm$core$String$toLower,
		A2(
			$elm$core$Basics$composeR,
			function (str) {
				return A2(
					$elm$core$Maybe$map,
					function (regex) {
						return A3($elm$regex$Regex$findAtMost, 1, regex, str);
					},
					$elm$regex$Regex$fromString(pattern));
			},
			A2(
				$elm$core$Basics$composeR,
				$elm$core$Maybe$andThen($elm$core$List$head),
				A2(
					$elm$core$Basics$composeR,
					$elm$core$Maybe$map(
						function ($) {
							return $.submatches;
						}),
					A2(
						$elm$core$Basics$composeR,
						$elm$core$Maybe$map(
							$elm$core$List$filterMap($elm$core$Basics$identity)),
						A2(
							$elm$core$Basics$composeR,
							$elm$core$Result$fromMaybe('Parsing hex regex failed'),
							$elm$core$Result$andThen(
								function (colors) {
									var _v0 = A2(
										$elm$core$List$map,
										A2(
											$elm$core$Basics$composeR,
											extend,
											A2(
												$elm$core$Basics$composeR,
												$fredcy$elm_parseint$ParseInt$parseIntHex,
												$elm$core$Result$map($elm$core$Basics$toFloat))),
										colors);
									_v0$2:
									while (true) {
										if (((((_v0.b && (_v0.a.$ === 'Ok')) && _v0.b.b) && (_v0.b.a.$ === 'Ok')) && _v0.b.b.b) && (_v0.b.b.a.$ === 'Ok')) {
											if (_v0.b.b.b.b) {
												if ((_v0.b.b.b.a.$ === 'Ok') && (!_v0.b.b.b.b.b)) {
													var r = _v0.a.a;
													var _v1 = _v0.b;
													var g = _v1.a.a;
													var _v2 = _v1.b;
													var b = _v2.a.a;
													var _v3 = _v2.b;
													var a = _v3.a.a;
													return $elm$core$Result$Ok(
														A4(
															$avh4$elm_color$Color$rgba,
															r / 255,
															g / 255,
															b / 255,
															A2($noahzgordon$elm_color_extra$Color$Convert$roundToPlaces, 2, a / 255)));
												} else {
													break _v0$2;
												}
											} else {
												var r = _v0.a.a;
												var _v4 = _v0.b;
												var g = _v4.a.a;
												var _v5 = _v4.b;
												var b = _v5.a.a;
												return $elm$core$Result$Ok(
													A3($avh4$elm_color$Color$rgb, r / 255, g / 255, b / 255));
											}
										} else {
											break _v0$2;
										}
									}
									return $elm$core$Result$Err('Parsing ints from hex failed');
								})))))));
}();
var $elm$core$Result$withDefault = F2(
	function (def, result) {
		if (result.$ === 'Ok') {
			var a = result.a;
			return a;
		} else {
			return def;
		}
	});
var $author$project$R10$Color$Utils$fromHex = function (hex) {
	var resultColor = $noahzgordon$elm_color_extra$Color$Convert$hexToColor(hex);
	var color = A2(
		$elm$core$Result$withDefault,
		$avh4$elm_color$Color$fromRgba(
			{alpha: 0, blue: 0, green: 0, red: 0}),
		resultColor);
	return color;
};
var $noahzgordon$elm_color_extra$Color$Manipulate$scale = F3(
	function (max, scaleAmount, value) {
		var clampedValue = A3($elm$core$Basics$clamp, 0, max, value);
		var clampedScale = A3($elm$core$Basics$clamp, -1.0, 1.0, scaleAmount);
		var diff = (clampedScale > 0) ? (max - clampedValue) : clampedValue;
		return clampedValue + (diff * clampedScale);
	});
var $noahzgordon$elm_color_extra$Color$Manipulate$scaleHsl = F2(
	function (scaleBy, color) {
		var hsl = $avh4$elm_color$Color$toHsla(color);
		var _v0 = scaleBy;
		var saturationScale = _v0.saturationScale;
		var lightnessScale = _v0.lightnessScale;
		var alphaScale = _v0.alphaScale;
		return A4(
			$avh4$elm_color$Color$hsla,
			hsl.hue,
			A3($noahzgordon$elm_color_extra$Color$Manipulate$scale, 1.0, saturationScale, hsl.saturation),
			A3($noahzgordon$elm_color_extra$Color$Manipulate$scale, 1.0, lightnessScale, hsl.lightness),
			A3($noahzgordon$elm_color_extra$Color$Manipulate$scale, 1.0, alphaScale, hsl.alpha));
	});
var $author$project$R10$Color$Utils$fromLightToDark = function (color) {
	return A2(
		$noahzgordon$elm_color_extra$Color$Manipulate$scaleHsl,
		{alphaScale: 0, lightnessScale: -0.04, saturationScale: -0.17},
		color);
};
var $author$project$R10$Color$Internal$Base$toColorLight_ = function (color) {
	switch (color.$) {
		case 'Font':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#000000'),
				'Hard coded as #000000');
		case 'FontReversed':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#ffffff'),
				'Hard coded as #ffffff');
		case 'FontLink':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#00a0f0'),
				'Hard coded as #00a0f0');
		case 'Error':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#df0101'),
				'Hard coded as #df0101');
		case 'Success':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#047205'),
				'Hard coded as #047205');
		default:
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#ebebeb'),
				'Hard coded as #f0f0f0');
	}
};
var $author$project$R10$Color$Internal$Base$toColorDark_ = function (color) {
	switch (color.$) {
		case 'Font':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#ffffff'),
				'Hard coded as #ffffff');
		case 'FontReversed':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#000000'),
				'Hard coded as #000000');
		case 'FontLink':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Base$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'Error':
			return _Utils_Tuple2(
				A2(
					$noahzgordon$elm_color_extra$Color$Manipulate$desaturate,
					0.4,
					A2(
						$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
						0.1,
						$author$project$R10$Color$Internal$Base$toColorLight_(color).a)),
				'Same as light mode but lighten (0.1) and desaturate (0.4)');
		case 'Success':
			return _Utils_Tuple2(
				A2(
					$noahzgordon$elm_color_extra$Color$Manipulate$desaturate,
					0.4,
					A2(
						$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
						0.15,
						$author$project$R10$Color$Internal$Base$toColorLight_(color).a)),
				'Same as light mode but lighten (0.15) and desaturate (0.4)');
		default:
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#121212'),
				'Hard coded as #121212');
	}
};
var $author$project$R10$Color$Internal$Base$toColor = function (theme) {
	var _v0 = theme.mode;
	if (_v0.$ === 'Light') {
		return function (c) {
			return $author$project$R10$Color$Internal$Base$toColorLight_(c).a;
		};
	} else {
		return function (c) {
			return $author$project$R10$Color$Internal$Base$toColorDark_(c).a;
		};
	}
};
var $author$project$R10$Color$Internal$Derived$backgroundButtonPrimaryDisabled_ = function (theme) {
	return function (color) {
		var _v0 = theme.mode;
		if (_v0.$ === 'Dark') {
			return A2($noahzgordon$elm_color_extra$Color$Manipulate$lighten, 0.2, color);
		} else {
			return A2($noahzgordon$elm_color_extra$Color$Manipulate$darken, 0.2, color);
		}
	}(
		A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
};
var $author$project$R10$Color$Internal$Base$FontReversed = {$: 'FontReversed'};
var $author$project$R10$Color$Utils$setAlpha = F2(
	function (newAlpha, color) {
		var c = $avh4$elm_color$Color$toRgba(color);
		return $avh4$elm_color$Color$fromRgba(
			{alpha: newAlpha, blue: c.blue, green: c.green, red: c.red});
	});
var $author$project$R10$Color$Internal$Derived$highEmphasisReversed_ = function (theme) {
	return A2(
		$author$project$R10$Color$Utils$setAlpha,
		0.87,
		A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$FontReversed));
};
var $author$project$R10$Color$Internal$Derived$highEmphasis_ = function (theme) {
	return A2(
		$author$project$R10$Color$Utils$setAlpha,
		0.87,
		A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Font));
};
var $noahzgordon$elm_color_extra$Color$Accessibility$luminance = function (cl) {
	var f = function (intensity) {
		return (intensity <= 0.03928) ? (intensity / 12.92) : A2($elm$core$Basics$pow, (intensity + 0.055) / 1.055, 2.4);
	};
	var _v0 = function (a) {
		return _Utils_Tuple3(
			f(a.red),
			f(a.green),
			f(a.blue));
	}(
		$avh4$elm_color$Color$toRgba(cl));
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	return ((0.2126 * r) + (0.7152 * g)) + (0.0722 * b);
};
var $noahzgordon$elm_color_extra$Color$Accessibility$contrastRatio = F2(
	function (c1, c2) {
		var b = $noahzgordon$elm_color_extra$Color$Accessibility$luminance(c2) + 0.05;
		var a = $noahzgordon$elm_color_extra$Color$Accessibility$luminance(c1) + 0.05;
		return (_Utils_cmp(a, b) > 0) ? (a / b) : (b / a);
	});
var $elm$core$List$sortWith = _List_sortWith;
var $noahzgordon$elm_color_extra$Color$Accessibility$maximumContrast = F2(
	function (base, options) {
		var compareContrast = F2(
			function (c1, c2) {
				return A2(
					$elm$core$Basics$compare,
					A2($noahzgordon$elm_color_extra$Color$Accessibility$contrastRatio, base, c2),
					A2($noahzgordon$elm_color_extra$Color$Accessibility$contrastRatio, base, c1));
			});
		return $elm$core$List$head(
			A2($elm$core$List$sortWith, compareContrast, options));
	});
var $author$project$R10$Color$Internal$Derived$maximumContrast = F2(
	function (color, listColor) {
		return A2(
			$noahzgordon$elm_color_extra$Color$Accessibility$maximumContrast,
			A2($noahzgordon$elm_color_extra$Color$Manipulate$darken, 0.16, color),
			listColor);
	});
var $author$project$R10$Color$Internal$Derived$mediumEmphasisReversed_ = function (theme) {
	return A2(
		$author$project$R10$Color$Utils$setAlpha,
		0.6,
		A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$FontReversed));
};
var $author$project$R10$Color$Internal$Derived$mediumEmphasis_ = function (theme) {
	return A2(
		$author$project$R10$Color$Utils$setAlpha,
		0.6,
		A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Font));
};
var $author$project$R10$Color$Internal$Primary$toColorLight_ = function (color) {
	switch (color.$) {
		case 'CrimsonRed':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#bf0000'),
				'Hard coded as #bf0000');
		case 'Orange':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#f59600'),
				'Hard coded as #f59600');
		case 'Yellow':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#ffcc00'),
				'Hard coded as #ffcc00');
		case 'Green':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#00b900'),
				'Hard coded as #00b900');
		case 'LightBlue':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#00a0f0'),
				'Hard coded as #00a0f0');
		case 'Blue':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#002896'),
				'Hard coded as #002896');
		case 'Purple':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#7d00be'),
				'Hard coded as #7d00be');
		case 'Pink':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#ff008c'),
				'Hard coded as #ff008c');
		default:
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromHex('#117bb4'),
				'Hard coded as #117bb4');
	}
};
var $author$project$R10$Color$Internal$Primary$toColorDark_ = function (color) {
	switch (color.$) {
		case 'CrimsonRed':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'Orange':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'Yellow':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'Green':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'LightBlue':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'Blue':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'Purple':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		case 'Pink':
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
		default:
			return _Utils_Tuple2(
				$author$project$R10$Color$Utils$fromLightToDark(
					$author$project$R10$Color$Internal$Primary$toColorLight_(color).a),
				'Converted from light mode using `R10.Color.Utils.fromLightToDark`');
	}
};
var $author$project$R10$Color$Internal$Primary$toColor = function (theme) {
	var _v0 = theme.mode;
	if (_v0.$ === 'Light') {
		return function (c) {
			return $author$project$R10$Color$Internal$Primary$toColorLight_(c).a;
		};
	} else {
		return function (c) {
			return $author$project$R10$Color$Internal$Primary$toColorDark_(c).a;
		};
	}
};
var $author$project$R10$Color$Internal$Derived$primary_ = function (theme) {
	return A2($author$project$R10$Color$Internal$Primary$toColor, theme, theme.primaryColor);
};
var $author$project$R10$Color$Internal$Derived$toColor_ = F2(
	function (theme, colorDerived) {
		switch (colorDerived.$) {
			case 'Success':
				return _Utils_Tuple2(
					A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Success),
					'same as base color `Succes`');
			case 'Logo':
				return _Utils_Tuple2(
					function () {
						var _v1 = theme.mode;
						if (_v1.$ === 'Light') {
							return $author$project$R10$Color$Internal$Derived$primary_(theme);
						} else {
							return $author$project$R10$Color$Internal$Derived$highEmphasis_(theme);
						}
					}(),
					'Logo color is the same as primary color in light mode and `highEmphasis` in dark mode');
			case 'Primary':
				return _Utils_Tuple2(
					$author$project$R10$Color$Internal$Derived$primary_(theme),
					'Just the primary color');
			case 'PrimaryVariant':
				return _Utils_Tuple2(
					A2(
						$noahzgordon$elm_color_extra$Color$Manipulate$scaleHsl,
						{alphaScale: -0.6, lightnessScale: 0, saturationScale: -0.4},
						$author$project$R10$Color$Internal$Derived$primary_(theme)),
					'Like the primary, but more subtle');
			case 'FontMediumEmphasis':
				return _Utils_Tuple2(
					$author$project$R10$Color$Internal$Derived$mediumEmphasis_(theme),
					'A color used for fonts when they carry a less important message. It is made changing the alpha channel to 0.6 so the result is that is going to be more similar to the background.');
			case 'FontHighEmphasis':
				return _Utils_Tuple2(
					$author$project$R10$Color$Internal$Derived$highEmphasis_(theme),
					'The default color for text. It is made changing the alpha channel to 0.87.');
			case 'FontLink':
				return _Utils_Tuple2(
					A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$FontLink),
					'The same as the base `FontLink` color');
			case 'Error':
				return _Utils_Tuple2(
					A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Error),
					'The same as the base `Error` color');
			case 'Debugger':
				return _Utils_Tuple2(
					A2($author$project$R10$Color$Internal$Primary$toColor, theme, $author$project$R10$Color$Internal$Primary$LightBlue),
					'The same as the base `LightBlue` color');
			case 'FontMediumEmphasisWithMaximumContrast':
				var goesOn = $author$project$R10$Color$Internal$Derived$primary_(theme);
				var color2 = $author$project$R10$Color$Internal$Derived$mediumEmphasisReversed_(theme);
				var color1 = $author$project$R10$Color$Internal$Derived$mediumEmphasis_(theme);
				var colorFont = A2(
					$elm$core$Maybe$withDefault,
					color1,
					A2(
						$author$project$R10$Color$Internal$Derived$maximumContrast,
						goesOn,
						_List_fromArray(
							[color1, color2])));
				return _Utils_Tuple2(colorFont, 'A `mediumEmphasis` color for less important text that goes above a primary color');
			case 'FontHighEmphasisWithMaximumContrast':
				var goesOn = $author$project$R10$Color$Internal$Derived$primary_(theme);
				var color2 = $author$project$R10$Color$Internal$Derived$highEmphasisReversed_(theme);
				var color1 = $author$project$R10$Color$Internal$Derived$highEmphasis_(theme);
				var colorFont = A2(
					$elm$core$Maybe$withDefault,
					color1,
					A2(
						$author$project$R10$Color$Internal$Derived$maximumContrast,
						goesOn,
						_List_fromArray(
							[color1, color2])));
				return _Utils_Tuple2(colorFont, 'A `highEmphasis` color for regular text that goes above a primary color');
			case 'Border':
				return _Utils_Tuple2(
					A2(
						$author$project$R10$Color$Utils$setAlpha,
						0.2,
						A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Font)),
					'Color for borders derived from the base `Font` changing the alpha channel to 0.2');
			case 'BackgroundPhoneDropdown':
				return _Utils_Tuple2(
					function () {
						var _v2 = theme.mode;
						if (_v2.$ === 'Light') {
							return A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background);
						} else {
							return A2(
								$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
								0.05,
								A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
						}
					}(),
					'A special background for the phone dropdown. On `light` mode is the same as the base `Background` but in `dark` mode is lighter 0.05 compared to the base `Background` so that it became visible.');
			case 'Background':
				return _Utils_Tuple2(
					A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background),
					'The same as the base `Background`.');
			case 'Surface':
				return _Utils_Tuple2(
					function () {
						var _v3 = theme.mode;
						if (_v3.$ === 'Light') {
							return A2(
								$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
								0.05,
								A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
						} else {
							return A2(
								$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
								0.05,
								A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
						}
					}(),
					'A color for surfaces above the background, 1dp (See https://material.io/design/color/dark-theme.html#anatomy)');
			case 'Surface2dp':
				return _Utils_Tuple2(
					function () {
						var _v4 = theme.mode;
						if (_v4.$ === 'Light') {
							return A2(
								$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
								0.1,
								A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
						} else {
							return A2(
								$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
								0.1,
								A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
						}
					}(),
					'A color for surfaces above the background, 2dp (See https://material.io/design/color/dark-theme.html#anatomy)');
			case 'BackgroundInputFieldText':
				return _Utils_Tuple2(
					function () {
						var _v5 = theme.mode;
						if (_v5.$ === 'Light') {
							return A2(
								$noahzgordon$elm_color_extra$Color$Manipulate$darken,
								0.05,
								A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
						} else {
							return A2(
								$noahzgordon$elm_color_extra$Color$Manipulate$lighten,
								0.05,
								A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background));
						}
					}(),
					'A special background color for input fields. In `light` mode is sligthly darken than normal background. In `dark` mode is sligthly lighten than normal background.');
			case 'BackgroundButtonPrimaryOver':
				return _Utils_Tuple2(
					A2(
						$noahzgordon$elm_color_extra$Color$Manipulate$scaleHsl,
						{alphaScale: 0, lightnessScale: 0.17, saturationScale: -0.15},
						A2($author$project$R10$Color$Internal$Primary$toColor, theme, theme.primaryColor)),
					'The mouse-over color for the primary button obtained adding a `scaleHsl` transformation to the primary color.');
			case 'BackgroundButtonPrimaryDisabledOver':
				return _Utils_Tuple2(
					A2(
						$noahzgordon$elm_color_extra$Color$Manipulate$scaleHsl,
						{alphaScale: 0, lightnessScale: 0.2, saturationScale: 0},
						$author$project$R10$Color$Internal$Derived$backgroundButtonPrimaryDisabled_(theme)),
					'The mouse-over color for the disabled primary button obtained adding a `scaleHsl` transformation to the primary color that has been already transformed to change it to disabled.');
			case 'BackgroundButtonPrimaryDisabled':
				return _Utils_Tuple2(
					$author$project$R10$Color$Internal$Derived$backgroundButtonPrimaryDisabled_(theme),
					'The background color of disabled primary button obtained. This is made making it ligher on Light mode and darker on Dark mode.');
			case 'BackgroundButtonPrimary':
				return _Utils_Tuple2(
					A2($author$project$R10$Color$Internal$Primary$toColor, theme, theme.primaryColor),
					'Just the primary color, extracted from the `theme`.');
			default:
				return _Utils_Tuple2(
					function (color) {
						var _v6 = theme.mode;
						if (_v6.$ === 'Dark') {
							return A2($noahzgordon$elm_color_extra$Color$Manipulate$lighten, 0.07, color);
						} else {
							return A2($noahzgordon$elm_color_extra$Color$Manipulate$darken, 0.08, color);
						}
					}(
						A2($author$project$R10$Color$Internal$Base$toColor, theme, $author$project$R10$Color$Internal$Base$Background)),
					'Background of minors buttons based on the normal background color. Just making it lighter in Dark mode and darker in Light mode');
		}
	});
var $author$project$R10$Color$Internal$Derived$toColor = F2(
	function (theme, colorDerived) {
		return A2($author$project$R10$Color$Internal$Derived$toColor_, theme, colorDerived).a;
	});
var $author$project$R10$Color$AttrsBackground$background = function (theme) {
	return $mdgriffith$elm_ui$Element$Background$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Background)));
};
var $mdgriffith$elm_ui$Internal$Model$AlignX = function (a) {
	return {$: 'AlignX', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$CenterX = {$: 'CenterX'};
var $mdgriffith$elm_ui$Element$centerX = $mdgriffith$elm_ui$Internal$Model$AlignX($mdgriffith$elm_ui$Internal$Model$CenterX);
var $mdgriffith$elm_ui$Internal$Model$AlignY = function (a) {
	return {$: 'AlignY', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$CenterY = {$: 'CenterY'};
var $mdgriffith$elm_ui$Element$centerY = $mdgriffith$elm_ui$Internal$Model$AlignY($mdgriffith$elm_ui$Internal$Model$CenterY);
var $mdgriffith$elm_ui$Internal$Model$Unkeyed = function (a) {
	return {$: 'Unkeyed', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$AsColumn = {$: 'AsColumn'};
var $mdgriffith$elm_ui$Internal$Model$asColumn = $mdgriffith$elm_ui$Internal$Model$AsColumn;
var $mdgriffith$elm_ui$Internal$Style$classes = {above: 'a', active: 'atv', alignBottom: 'ab', alignCenterX: 'cx', alignCenterY: 'cy', alignContainerBottom: 'acb', alignContainerCenterX: 'accx', alignContainerCenterY: 'accy', alignContainerRight: 'acr', alignLeft: 'al', alignRight: 'ar', alignTop: 'at', alignedHorizontally: 'ah', alignedVertically: 'av', any: 's', behind: 'bh', below: 'b', bold: 'w7', borderDashed: 'bd', borderDotted: 'bdt', borderNone: 'bn', borderSolid: 'bs', capturePointerEvents: 'cpe', clip: 'cp', clipX: 'cpx', clipY: 'cpy', column: 'c', container: 'ctr', contentBottom: 'cb', contentCenterX: 'ccx', contentCenterY: 'ccy', contentLeft: 'cl', contentRight: 'cr', contentTop: 'ct', cursorPointer: 'cptr', cursorText: 'ctxt', focus: 'fcs', focusedWithin: 'focus-within', fullSize: 'fs', grid: 'g', hasBehind: 'hbh', heightContent: 'hc', heightExact: 'he', heightFill: 'hf', heightFillPortion: 'hfp', hover: 'hv', imageContainer: 'ic', inFront: 'fr', inputLabel: 'lbl', inputMultiline: 'iml', inputMultilineFiller: 'imlf', inputMultilineParent: 'imlp', inputMultilineWrapper: 'implw', inputText: 'it', italic: 'i', link: 'lnk', nearby: 'nb', noTextSelection: 'notxt', onLeft: 'ol', onRight: 'or', opaque: 'oq', overflowHidden: 'oh', page: 'pg', paragraph: 'p', passPointerEvents: 'ppe', root: 'ui', row: 'r', scrollbars: 'sb', scrollbarsX: 'sbx', scrollbarsY: 'sby', seButton: 'sbt', single: 'e', sizeByCapital: 'cap', spaceEvenly: 'sev', strike: 'sk', text: 't', textCenter: 'tc', textExtraBold: 'w8', textExtraLight: 'w2', textHeavy: 'w9', textJustify: 'tj', textJustifyAll: 'tja', textLeft: 'tl', textLight: 'w3', textMedium: 'w5', textNormalWeight: 'w4', textRight: 'tr', textSemiBold: 'w6', textThin: 'w1', textUnitalicized: 'tun', transition: 'ts', transparent: 'clr', underline: 'u', widthContent: 'wc', widthExact: 'we', widthFill: 'wf', widthFillPortion: 'wfp', wrapped: 'wrp'};
var $mdgriffith$elm_ui$Internal$Model$Generic = {$: 'Generic'};
var $mdgriffith$elm_ui$Internal$Model$div = $mdgriffith$elm_ui$Internal$Model$Generic;
var $mdgriffith$elm_ui$Internal$Model$NoNearbyChildren = {$: 'NoNearbyChildren'};
var $mdgriffith$elm_ui$Internal$Model$columnClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.column);
var $mdgriffith$elm_ui$Internal$Model$gridClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.grid);
var $mdgriffith$elm_ui$Internal$Model$pageClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.page);
var $mdgriffith$elm_ui$Internal$Model$paragraphClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.paragraph);
var $mdgriffith$elm_ui$Internal$Model$rowClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.row);
var $mdgriffith$elm_ui$Internal$Model$singleClass = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.single);
var $mdgriffith$elm_ui$Internal$Model$contextClasses = function (context) {
	switch (context.$) {
		case 'AsRow':
			return $mdgriffith$elm_ui$Internal$Model$rowClass;
		case 'AsColumn':
			return $mdgriffith$elm_ui$Internal$Model$columnClass;
		case 'AsEl':
			return $mdgriffith$elm_ui$Internal$Model$singleClass;
		case 'AsGrid':
			return $mdgriffith$elm_ui$Internal$Model$gridClass;
		case 'AsParagraph':
			return $mdgriffith$elm_ui$Internal$Model$paragraphClass;
		default:
			return $mdgriffith$elm_ui$Internal$Model$pageClass;
	}
};
var $mdgriffith$elm_ui$Internal$Model$Keyed = function (a) {
	return {$: 'Keyed', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$NoStyleSheet = {$: 'NoStyleSheet'};
var $mdgriffith$elm_ui$Internal$Model$Styled = function (a) {
	return {$: 'Styled', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$Unstyled = function (a) {
	return {$: 'Unstyled', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$addChildren = F2(
	function (existing, nearbyChildren) {
		switch (nearbyChildren.$) {
			case 'NoNearbyChildren':
				return existing;
			case 'ChildrenBehind':
				var behind = nearbyChildren.a;
				return _Utils_ap(behind, existing);
			case 'ChildrenInFront':
				var inFront = nearbyChildren.a;
				return _Utils_ap(existing, inFront);
			default:
				var behind = nearbyChildren.a;
				var inFront = nearbyChildren.b;
				return _Utils_ap(
					behind,
					_Utils_ap(existing, inFront));
		}
	});
var $mdgriffith$elm_ui$Internal$Model$addKeyedChildren = F3(
	function (key, existing, nearbyChildren) {
		switch (nearbyChildren.$) {
			case 'NoNearbyChildren':
				return existing;
			case 'ChildrenBehind':
				var behind = nearbyChildren.a;
				return _Utils_ap(
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(key, x);
						},
						behind),
					existing);
			case 'ChildrenInFront':
				var inFront = nearbyChildren.a;
				return _Utils_ap(
					existing,
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(key, x);
						},
						inFront));
			default:
				var behind = nearbyChildren.a;
				var inFront = nearbyChildren.b;
				return _Utils_ap(
					A2(
						$elm$core$List$map,
						function (x) {
							return _Utils_Tuple2(key, x);
						},
						behind),
					_Utils_ap(
						existing,
						A2(
							$elm$core$List$map,
							function (x) {
								return _Utils_Tuple2(key, x);
							},
							inFront)));
		}
	});
var $mdgriffith$elm_ui$Internal$Model$AsEl = {$: 'AsEl'};
var $mdgriffith$elm_ui$Internal$Model$asEl = $mdgriffith$elm_ui$Internal$Model$AsEl;
var $mdgriffith$elm_ui$Internal$Model$AsParagraph = {$: 'AsParagraph'};
var $mdgriffith$elm_ui$Internal$Model$asParagraph = $mdgriffith$elm_ui$Internal$Model$AsParagraph;
var $mdgriffith$elm_ui$Internal$Flag$alignBottom = $mdgriffith$elm_ui$Internal$Flag$flag(41);
var $mdgriffith$elm_ui$Internal$Flag$alignRight = $mdgriffith$elm_ui$Internal$Flag$flag(40);
var $mdgriffith$elm_ui$Internal$Flag$centerX = $mdgriffith$elm_ui$Internal$Flag$flag(42);
var $mdgriffith$elm_ui$Internal$Flag$centerY = $mdgriffith$elm_ui$Internal$Flag$flag(43);
var $elm$json$Json$Encode$string = _Json_wrap;
var $elm$html$Html$Attributes$stringProperty = F2(
	function (key, string) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$string(string));
	});
var $elm$html$Html$Attributes$class = $elm$html$Html$Attributes$stringProperty('className');
var $elm$html$Html$div = _VirtualDom_node('div');
var $mdgriffith$elm_ui$Internal$Model$lengthClassName = function (x) {
	switch (x.$) {
		case 'Px':
			var px = x.a;
			return $elm$core$String$fromInt(px) + 'px';
		case 'Content':
			return 'auto';
		case 'Fill':
			var i = x.a;
			return $elm$core$String$fromInt(i) + 'fr';
		case 'Min':
			var min = x.a;
			var len = x.b;
			return 'min' + ($elm$core$String$fromInt(min) + $mdgriffith$elm_ui$Internal$Model$lengthClassName(len));
		default:
			var max = x.a;
			var len = x.b;
			return 'max' + ($elm$core$String$fromInt(max) + $mdgriffith$elm_ui$Internal$Model$lengthClassName(len));
	}
};
var $mdgriffith$elm_ui$Internal$Model$transformClass = function (transform) {
	switch (transform.$) {
		case 'Untransformed':
			return $elm$core$Maybe$Nothing;
		case 'Moved':
			var _v1 = transform.a;
			var x = _v1.a;
			var y = _v1.b;
			var z = _v1.c;
			return $elm$core$Maybe$Just(
				'mv-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(x) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(y) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(z))))));
		default:
			var _v2 = transform.a;
			var tx = _v2.a;
			var ty = _v2.b;
			var tz = _v2.c;
			var _v3 = transform.b;
			var sx = _v3.a;
			var sy = _v3.b;
			var sz = _v3.c;
			var _v4 = transform.c;
			var ox = _v4.a;
			var oy = _v4.b;
			var oz = _v4.c;
			var angle = transform.d;
			return $elm$core$Maybe$Just(
				'tfrm-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(tx) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(ty) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(tz) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(sx) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(sy) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(sz) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(ox) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(oy) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(oz) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(angle))))))))))))))))))));
	}
};
var $mdgriffith$elm_ui$Internal$Model$getStyleName = function (style) {
	switch (style.$) {
		case 'Shadows':
			var name = style.a;
			return name;
		case 'Transparency':
			var name = style.a;
			var o = style.b;
			return name;
		case 'Style':
			var _class = style.a;
			return _class;
		case 'FontFamily':
			var name = style.a;
			return name;
		case 'FontSize':
			var i = style.a;
			return 'font-size-' + $elm$core$String$fromInt(i);
		case 'Single':
			var _class = style.a;
			return _class;
		case 'Colored':
			var _class = style.a;
			return _class;
		case 'SpacingStyle':
			var cls = style.a;
			var x = style.b;
			var y = style.c;
			return cls;
		case 'PaddingStyle':
			var cls = style.a;
			var top = style.b;
			var right = style.c;
			var bottom = style.d;
			var left = style.e;
			return cls;
		case 'BorderWidth':
			var cls = style.a;
			var top = style.b;
			var right = style.c;
			var bottom = style.d;
			var left = style.e;
			return cls;
		case 'GridTemplateStyle':
			var template = style.a;
			return 'grid-rows-' + (A2(
				$elm$core$String$join,
				'-',
				A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.rows)) + ('-cols-' + (A2(
				$elm$core$String$join,
				'-',
				A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.columns)) + ('-space-x-' + ($mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.a) + ('-space-y-' + $mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.b)))))));
		case 'GridPosition':
			var pos = style.a;
			return 'gp grid-pos-' + ($elm$core$String$fromInt(pos.row) + ('-' + ($elm$core$String$fromInt(pos.col) + ('-' + ($elm$core$String$fromInt(pos.width) + ('-' + $elm$core$String$fromInt(pos.height)))))));
		case 'PseudoSelector':
			var selector = style.a;
			var subStyle = style.b;
			var name = function () {
				switch (selector.$) {
					case 'Focus':
						return 'fs';
					case 'Hover':
						return 'hv';
					default:
						return 'act';
				}
			}();
			return A2(
				$elm$core$String$join,
				' ',
				A2(
					$elm$core$List$map,
					function (sty) {
						var _v1 = $mdgriffith$elm_ui$Internal$Model$getStyleName(sty);
						if (_v1 === '') {
							return '';
						} else {
							var styleName = _v1;
							return styleName + ('-' + name);
						}
					},
					subStyle));
		default:
			var x = style.a;
			return A2(
				$elm$core$Maybe$withDefault,
				'',
				$mdgriffith$elm_ui$Internal$Model$transformClass(x));
	}
};
var $mdgriffith$elm_ui$Internal$Model$reduceStyles = F2(
	function (style, nevermind) {
		var cache = nevermind.a;
		var existing = nevermind.b;
		var styleName = $mdgriffith$elm_ui$Internal$Model$getStyleName(style);
		return A2($elm$core$Set$member, styleName, cache) ? nevermind : _Utils_Tuple2(
			A2($elm$core$Set$insert, styleName, cache),
			A2($elm$core$List$cons, style, existing));
	});
var $mdgriffith$elm_ui$Internal$Model$Property = F2(
	function (a, b) {
		return {$: 'Property', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$Style = F2(
	function (a, b) {
		return {$: 'Style', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$dot = function (c) {
	return '.' + c;
};
var $elm$core$String$fromFloat = _String_fromNumber;
var $mdgriffith$elm_ui$Internal$Model$formatColor = function (_v0) {
	var red = _v0.a;
	var green = _v0.b;
	var blue = _v0.c;
	var alpha = _v0.d;
	return 'rgba(' + ($elm$core$String$fromInt(
		$elm$core$Basics$round(red * 255)) + ((',' + $elm$core$String$fromInt(
		$elm$core$Basics$round(green * 255))) + ((',' + $elm$core$String$fromInt(
		$elm$core$Basics$round(blue * 255))) + (',' + ($elm$core$String$fromFloat(alpha) + ')')))));
};
var $mdgriffith$elm_ui$Internal$Model$formatBoxShadow = function (shadow) {
	return A2(
		$elm$core$String$join,
		' ',
		A2(
			$elm$core$List$filterMap,
			$elm$core$Basics$identity,
			_List_fromArray(
				[
					shadow.inset ? $elm$core$Maybe$Just('inset') : $elm$core$Maybe$Nothing,
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.offset.a) + 'px'),
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.offset.b) + 'px'),
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.blur) + 'px'),
					$elm$core$Maybe$Just(
					$elm$core$String$fromFloat(shadow.size) + 'px'),
					$elm$core$Maybe$Just(
					$mdgriffith$elm_ui$Internal$Model$formatColor(shadow.color))
				])));
};
var $elm$core$Tuple$mapFirst = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			func(x),
			y);
	});
var $elm$core$Tuple$mapSecond = F2(
	function (func, _v0) {
		var x = _v0.a;
		var y = _v0.b;
		return _Utils_Tuple2(
			x,
			func(y));
	});
var $mdgriffith$elm_ui$Internal$Model$renderFocusStyle = function (focus) {
	return _List_fromArray(
		[
			A2(
			$mdgriffith$elm_ui$Internal$Model$Style,
			$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.focusedWithin) + ':focus-within',
			A2(
				$elm$core$List$filterMap,
				$elm$core$Basics$identity,
				_List_fromArray(
					[
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'border-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.borderColor),
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'background-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.backgroundColor),
						A2(
						$elm$core$Maybe$map,
						function (shadow) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'box-shadow',
								$mdgriffith$elm_ui$Internal$Model$formatBoxShadow(
									{
										blur: shadow.blur,
										color: shadow.color,
										inset: false,
										offset: A2(
											$elm$core$Tuple$mapSecond,
											$elm$core$Basics$toFloat,
											A2($elm$core$Tuple$mapFirst, $elm$core$Basics$toFloat, shadow.offset)),
										size: shadow.size
									}));
						},
						focus.shadow),
						$elm$core$Maybe$Just(
						A2($mdgriffith$elm_ui$Internal$Model$Property, 'outline', 'none'))
					]))),
			A2(
			$mdgriffith$elm_ui$Internal$Model$Style,
			($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ':focus .focusable, ') + (($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + '.focusable:focus, ') + ('.ui-slide-bar:focus + ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ' .focusable-thumb'))),
			A2(
				$elm$core$List$filterMap,
				$elm$core$Basics$identity,
				_List_fromArray(
					[
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'border-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.borderColor),
						A2(
						$elm$core$Maybe$map,
						function (color) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'background-color',
								$mdgriffith$elm_ui$Internal$Model$formatColor(color));
						},
						focus.backgroundColor),
						A2(
						$elm$core$Maybe$map,
						function (shadow) {
							return A2(
								$mdgriffith$elm_ui$Internal$Model$Property,
								'box-shadow',
								$mdgriffith$elm_ui$Internal$Model$formatBoxShadow(
									{
										blur: shadow.blur,
										color: shadow.color,
										inset: false,
										offset: A2(
											$elm$core$Tuple$mapSecond,
											$elm$core$Basics$toFloat,
											A2($elm$core$Tuple$mapFirst, $elm$core$Basics$toFloat, shadow.offset)),
										size: shadow.size
									}));
						},
						focus.shadow),
						$elm$core$Maybe$Just(
						A2($mdgriffith$elm_ui$Internal$Model$Property, 'outline', 'none'))
					])))
		]);
};
var $elm$virtual_dom$VirtualDom$node = function (tag) {
	return _VirtualDom_node(
		_VirtualDom_noScript(tag));
};
var $elm$virtual_dom$VirtualDom$property = F2(
	function (key, value) {
		return A2(
			_VirtualDom_property,
			_VirtualDom_noInnerHtmlOrFormAction(key),
			_VirtualDom_noJavaScriptOrHtmlUri(value));
	});
var $mdgriffith$elm_ui$Internal$Style$AllChildren = F2(
	function (a, b) {
		return {$: 'AllChildren', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Batch = function (a) {
	return {$: 'Batch', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$Child = F2(
	function (a, b) {
		return {$: 'Child', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Class = F2(
	function (a, b) {
		return {$: 'Class', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Descriptor = F2(
	function (a, b) {
		return {$: 'Descriptor', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Left = {$: 'Left'};
var $mdgriffith$elm_ui$Internal$Style$Prop = F2(
	function (a, b) {
		return {$: 'Prop', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Right = {$: 'Right'};
var $mdgriffith$elm_ui$Internal$Style$Self = function (a) {
	return {$: 'Self', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$Supports = F2(
	function (a, b) {
		return {$: 'Supports', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Style$Content = function (a) {
	return {$: 'Content', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$Bottom = {$: 'Bottom'};
var $mdgriffith$elm_ui$Internal$Style$CenterX = {$: 'CenterX'};
var $mdgriffith$elm_ui$Internal$Style$CenterY = {$: 'CenterY'};
var $mdgriffith$elm_ui$Internal$Style$Top = {$: 'Top'};
var $mdgriffith$elm_ui$Internal$Style$alignments = _List_fromArray(
	[$mdgriffith$elm_ui$Internal$Style$Top, $mdgriffith$elm_ui$Internal$Style$Bottom, $mdgriffith$elm_ui$Internal$Style$Right, $mdgriffith$elm_ui$Internal$Style$Left, $mdgriffith$elm_ui$Internal$Style$CenterX, $mdgriffith$elm_ui$Internal$Style$CenterY]);
var $elm$core$List$concatMap = F2(
	function (f, list) {
		return $elm$core$List$concat(
			A2($elm$core$List$map, f, list));
	});
var $mdgriffith$elm_ui$Internal$Style$contentName = function (desc) {
	switch (desc.a.$) {
		case 'Top':
			var _v1 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentTop);
		case 'Bottom':
			var _v2 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentBottom);
		case 'Right':
			var _v3 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentRight);
		case 'Left':
			var _v4 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentLeft);
		case 'CenterX':
			var _v5 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentCenterX);
		default:
			var _v6 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY);
	}
};
var $mdgriffith$elm_ui$Internal$Style$selfName = function (desc) {
	switch (desc.a.$) {
		case 'Top':
			var _v1 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignTop);
		case 'Bottom':
			var _v2 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignBottom);
		case 'Right':
			var _v3 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignRight);
		case 'Left':
			var _v4 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignLeft);
		case 'CenterX':
			var _v5 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterX);
		default:
			var _v6 = desc.a;
			return $mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY);
	}
};
var $mdgriffith$elm_ui$Internal$Style$describeAlignment = function (values) {
	var createDescription = function (alignment) {
		var _v0 = values(alignment);
		var content = _v0.a;
		var indiv = _v0.b;
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$contentName(
					$mdgriffith$elm_ui$Internal$Style$Content(alignment)),
				content),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$selfName(
							$mdgriffith$elm_ui$Internal$Style$Self(alignment)),
						indiv)
					]))
			]);
	};
	return $mdgriffith$elm_ui$Internal$Style$Batch(
		A2($elm$core$List$concatMap, createDescription, $mdgriffith$elm_ui$Internal$Style$alignments));
};
var $mdgriffith$elm_ui$Internal$Style$elDescription = _List_fromArray(
	[
		A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
		A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'column'),
		A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre'),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Descriptor,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.hasBehind),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '-1')
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Descriptor,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.seButton),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'auto !important')
							]))
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightContent),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '100000')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Child,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthContent),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
			])),
		$mdgriffith$elm_ui$Internal$Style$describeAlignment(
		function (alignment) {
			switch (alignment.$) {
				case 'Top':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', '0 !important')
							]));
				case 'Bottom':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', '0 !important')
							]));
				case 'Right':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-end')
							]));
				case 'Left':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
							]));
				case 'CenterX':
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'center')
							]));
				default:
					return _Utils_Tuple2(
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto')
									]))
							]),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important')
							]));
			}
		})
	]);
var $mdgriffith$elm_ui$Internal$Style$gridAlignments = function (values) {
	var createDescription = function (alignment) {
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$selfName(
							$mdgriffith$elm_ui$Internal$Style$Self(alignment)),
						values(alignment))
					]))
			]);
	};
	return $mdgriffith$elm_ui$Internal$Style$Batch(
		A2($elm$core$List$concatMap, createDescription, $mdgriffith$elm_ui$Internal$Style$alignments));
};
var $mdgriffith$elm_ui$Internal$Style$Above = {$: 'Above'};
var $mdgriffith$elm_ui$Internal$Style$Behind = {$: 'Behind'};
var $mdgriffith$elm_ui$Internal$Style$Below = {$: 'Below'};
var $mdgriffith$elm_ui$Internal$Style$OnLeft = {$: 'OnLeft'};
var $mdgriffith$elm_ui$Internal$Style$OnRight = {$: 'OnRight'};
var $mdgriffith$elm_ui$Internal$Style$Within = {$: 'Within'};
var $mdgriffith$elm_ui$Internal$Style$locations = function () {
	var loc = $mdgriffith$elm_ui$Internal$Style$Above;
	var _v0 = function () {
		switch (loc.$) {
			case 'Above':
				return _Utils_Tuple0;
			case 'Below':
				return _Utils_Tuple0;
			case 'OnRight':
				return _Utils_Tuple0;
			case 'OnLeft':
				return _Utils_Tuple0;
			case 'Within':
				return _Utils_Tuple0;
			default:
				return _Utils_Tuple0;
		}
	}();
	return _List_fromArray(
		[$mdgriffith$elm_ui$Internal$Style$Above, $mdgriffith$elm_ui$Internal$Style$Below, $mdgriffith$elm_ui$Internal$Style$OnRight, $mdgriffith$elm_ui$Internal$Style$OnLeft, $mdgriffith$elm_ui$Internal$Style$Within, $mdgriffith$elm_ui$Internal$Style$Behind]);
}();
var $mdgriffith$elm_ui$Internal$Style$baseSheet = _List_fromArray(
	[
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		'html,body',
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'padding', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		_Utils_ap(
			$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
			_Utils_ap(
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.imageContainer))),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'block'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'img',
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'max-height', '100%'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'object-fit', 'cover')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'img',
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'max-width', '100%'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'object-fit', 'cover')
							]))
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ':focus',
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'outline', 'none')
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.root),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'min-height', '100%'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				_Utils_ap(
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill)),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Child,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inFront),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.nearby),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'fixed'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20')
							]))
					]))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.nearby),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'relative'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'row'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
				$mdgriffith$elm_ui$Internal$Style$elDescription),
				$mdgriffith$elm_ui$Internal$Style$Batch(
				function (fn) {
					return A2($elm$core$List$map, fn, $mdgriffith$elm_ui$Internal$Style$locations);
				}(
					function (loc) {
						switch (loc.$) {
							case 'Above':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.above),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'bottom', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto')
												])),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
												])),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							case 'Below':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.below),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'bottom', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												])),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', 'auto')
												]))
										]));
							case 'OnRight':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onRight),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							case 'OnLeft':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onLeft),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'right', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '20'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							case 'Within':
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inFront),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
							default:
								return A2(
									$mdgriffith$elm_ui$Internal$Style$Descriptor,
									$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
									_List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'absolute'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none'),
											A2(
											$mdgriffith$elm_ui$Internal$Style$Child,
											'*',
											_List_fromArray(
												[
													A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto')
												]))
										]));
						}
					}))
			])),
		A2(
		$mdgriffith$elm_ui$Internal$Style$Class,
		$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
		_List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'relative'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'row'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'resize', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-feature-settings', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'box-sizing', 'border-box'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'padding', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-width', '0'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'solid'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-size', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'color', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-family', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'line-height', '1'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', 'inherit'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'none'),
				A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-style', 'inherit'),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.wrapped),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-wrap', 'wrap')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.noTextSelection),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, '-moz-user-select', 'none'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, '-webkit-user-select', 'none'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, '-ms-user-select', 'none'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'user-select', 'none')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.cursorPointer),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'cursor', 'pointer')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.cursorText),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'cursor', 'text')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.passPointerEvents),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none !important')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.capturePointerEvents),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'auto !important')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.transparent),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.opaque),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.hover, $mdgriffith$elm_ui$Internal$Style$classes.transparent)) + ':hover',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.hover, $mdgriffith$elm_ui$Internal$Style$classes.opaque)) + ':hover',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.focus, $mdgriffith$elm_ui$Internal$Style$classes.transparent)) + ':focus',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.focus, $mdgriffith$elm_ui$Internal$Style$classes.opaque)) + ':focus',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.active, $mdgriffith$elm_ui$Internal$Style$classes.transparent)) + ':active',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot(
					_Utils_ap($mdgriffith$elm_ui$Internal$Style$classes.active, $mdgriffith$elm_ui$Internal$Style$classes.opaque)) + ':active',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'opacity', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.transition),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Prop,
						'transition',
						A2(
							$elm$core$String$join,
							', ',
							A2(
								$elm$core$List$map,
								function (x) {
									return x + ' 160ms';
								},
								_List_fromArray(
									['transform', 'opacity', 'filter', 'background-color', 'color', 'font-size']))))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.scrollbars),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow', 'auto'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.scrollbarsX),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-x', 'auto'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.scrollbarsY),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-y', 'auto'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.column),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-shrink', '1')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.clip),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow', 'hidden')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.clipX),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-x', 'hidden')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.clipY),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-y', 'hidden')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthContent),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', 'auto')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderNone),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-width', '0')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderDashed),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'dashed')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderDotted),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'dotted')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.borderSolid),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'border-style', 'solid')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-block')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputText),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'line-height', '1.05'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'background', 'transparent'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'inherit')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
				$mdgriffith$elm_ui$Internal$Style$elDescription),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'row'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', '0%'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthExact),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.link),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFillPortion),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '100000')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.container),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerRight,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterX),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-left', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterX),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-right', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:only-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX + ' ~ u'),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerRight + (' ~ s.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX)),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
											]));
								case 'Bottom':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-end')
											]));
								case 'Right':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
											]),
										_List_Nil);
								case 'Left':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
											]),
										_List_Nil);
								case 'CenterX':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'center')
											]),
										_List_Nil);
								default:
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'center')
											]));
							}
						}),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.spaceEvenly),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'space-between')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'baseline')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.column),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-direction', 'column'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', '0px'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'min-height', 'min-content'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightExact),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.heightFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '100000')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFill),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthContent),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerBottom,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:first-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', '0 !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', '0 !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:only-of-type.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '1'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.alignCenterY),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto !important'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto !important')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						's:last-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY + ' ~ u'),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'u:first-of-type.' + ($mdgriffith$elm_ui$Internal$Style$classes.alignContainerBottom + (' ~ s.' + $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY)),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-bottom', 'auto')
											]));
								case 'Bottom':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin-top', 'auto')
											]));
								case 'Right':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-end')
											]));
								case 'Left':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'flex-start')
											]));
								case 'CenterX':
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
											]),
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'center')
											]));
								default:
									return _Utils_Tuple2(
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'center')
											]),
										_List_Nil);
							}
						}),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.container),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-grow', '0'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-self', 'stretch !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.spaceEvenly),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'space-between')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.grid),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', '-ms-grid'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						'.gp',
						_List_fromArray(
							[
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Supports,
						_Utils_Tuple2('display', 'grid'),
						_List_fromArray(
							[
								_Utils_Tuple2('display', 'grid')
							])),
						$mdgriffith$elm_ui$Internal$Style$gridAlignments(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-start')
										]);
								case 'Bottom':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'flex-end')
										]);
								case 'Right':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-end')
										]);
								case 'Left':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'flex-start')
										]);
								case 'CenterX':
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'align-items', 'center')
										]);
								default:
									return _List_fromArray(
										[
											A2($mdgriffith$elm_ui$Internal$Style$Prop, 'justify-content', 'center')
										]);
							}
						})
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.page),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'block'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any + ':first-child'),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot(
							$mdgriffith$elm_ui$Internal$Style$classes.any + ($mdgriffith$elm_ui$Internal$Style$selfName(
								$mdgriffith$elm_ui$Internal$Style$Self($mdgriffith$elm_ui$Internal$Style$Left)) + (':first-child + .' + $mdgriffith$elm_ui$Internal$Style$classes.any))),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot(
							$mdgriffith$elm_ui$Internal$Style$classes.any + ($mdgriffith$elm_ui$Internal$Style$selfName(
								$mdgriffith$elm_ui$Internal$Style$Self($mdgriffith$elm_ui$Internal$Style$Right)) + (':first-child + .' + $mdgriffith$elm_ui$Internal$Style$classes.any))),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'margin', '0 !important')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Bottom':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Right':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'right'),
												A2(
												$mdgriffith$elm_ui$Internal$Style$Descriptor,
												'::after',
												_List_fromArray(
													[
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', '\"\"'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'table'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'clear', 'both')
													]))
											]));
								case 'Left':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'left'),
												A2(
												$mdgriffith$elm_ui$Internal$Style$Descriptor,
												'::after',
												_List_fromArray(
													[
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', '\"\"'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'table'),
														A2($mdgriffith$elm_ui$Internal$Style$Prop, 'clear', 'both')
													]))
											]));
								case 'CenterX':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								default:
									return _Utils_Tuple2(_List_Nil, _List_Nil);
							}
						})
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultiline),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre-wrap !important'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'background-color', 'transparent')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineWrapper),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'flex-basis', 'auto')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineParent),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre-wrap !important'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'cursor', 'text'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineFiller),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'pre-wrap !important'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'color', 'transparent')
							]))
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.paragraph),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'block'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'overflow-wrap', 'break-word'),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Descriptor,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.hasBehind),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '0'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'z-index', '-1')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$AllChildren,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$AllChildren,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.paragraph),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								'::after',
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', 'none')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								'::before',
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'content', 'none')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$AllChildren,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.single),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal'),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.widthExact),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-block')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.inFront),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.behind),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.above),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.below),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onRight),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Descriptor,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.onLeft),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'flex')
									])),
								A2(
								$mdgriffith$elm_ui$Internal$Style$Child,
								$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.text),
								_List_fromArray(
									[
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline'),
										A2($mdgriffith$elm_ui$Internal$Style$Prop, 'white-space', 'normal')
									]))
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.column),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-flex')
							])),
						A2(
						$mdgriffith$elm_ui$Internal$Style$Child,
						$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.grid),
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'inline-grid')
							])),
						$mdgriffith$elm_ui$Internal$Style$describeAlignment(
						function (alignment) {
							switch (alignment.$) {
								case 'Top':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Bottom':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								case 'Right':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'right')
											]));
								case 'Left':
									return _Utils_Tuple2(
										_List_Nil,
										_List_fromArray(
											[
												A2($mdgriffith$elm_ui$Internal$Style$Prop, 'float', 'left')
											]));
								case 'CenterX':
									return _Utils_Tuple2(_List_Nil, _List_Nil);
								default:
									return _Utils_Tuple2(_List_Nil, _List_Nil);
							}
						})
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				'.hidden',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'display', 'none')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textThin),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '100')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textExtraLight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '200')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textLight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '300')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textNormalWeight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '400')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textMedium),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '500')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textSemiBold),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '600')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.bold),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '700')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textExtraBold),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '800')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textHeavy),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-weight', '900')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.italic),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-style', 'italic')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.strike),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'line-through')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.underline),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'underline'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip-ink', 'auto'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip', 'ink')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				_Utils_ap(
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.underline),
					$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.strike)),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration', 'line-through underline'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip-ink', 'auto'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-decoration-skip', 'ink')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textUnitalicized),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-style', 'normal')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textJustify),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'justify')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textJustifyAll),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'justify-all')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textCenter),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'center')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textRight),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'right')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				$mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.textLeft),
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'text-align', 'left')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Descriptor,
				'.modal',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'position', 'fixed'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'left', '0'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'top', '0'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'width', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'height', '100%'),
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'pointer-events', 'none')
					]))
			]))
	]);
var $mdgriffith$elm_ui$Internal$Style$fontVariant = function (_var) {
	return _List_fromArray(
		[
			A2(
			$mdgriffith$elm_ui$Internal$Style$Class,
			'.v-' + _var,
			_List_fromArray(
				[
					A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-feature-settings', '\"' + (_var + '\"'))
				])),
			A2(
			$mdgriffith$elm_ui$Internal$Style$Class,
			'.v-' + (_var + '-off'),
			_List_fromArray(
				[
					A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-feature-settings', '\"' + (_var + '\" 0'))
				]))
		]);
};
var $mdgriffith$elm_ui$Internal$Style$commonValues = $elm$core$List$concat(
	_List_fromArray(
		[
			A2(
			$elm$core$List$map,
			function (x) {
				return A2(
					$mdgriffith$elm_ui$Internal$Style$Class,
					'.border-' + $elm$core$String$fromInt(x),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Style$Prop,
							'border-width',
							$elm$core$String$fromInt(x) + 'px')
						]));
			},
			A2($elm$core$List$range, 0, 6)),
			A2(
			$elm$core$List$map,
			function (i) {
				return A2(
					$mdgriffith$elm_ui$Internal$Style$Class,
					'.font-size-' + $elm$core$String$fromInt(i),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Style$Prop,
							'font-size',
							$elm$core$String$fromInt(i) + 'px')
						]));
			},
			A2($elm$core$List$range, 8, 32)),
			A2(
			$elm$core$List$map,
			function (i) {
				return A2(
					$mdgriffith$elm_ui$Internal$Style$Class,
					'.p-' + $elm$core$String$fromInt(i),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Style$Prop,
							'padding',
							$elm$core$String$fromInt(i) + 'px')
						]));
			},
			A2($elm$core$List$range, 0, 24)),
			_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Internal$Style$Class,
				'.v-smcp',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-variant', 'small-caps')
					])),
				A2(
				$mdgriffith$elm_ui$Internal$Style$Class,
				'.v-smcp-off',
				_List_fromArray(
					[
						A2($mdgriffith$elm_ui$Internal$Style$Prop, 'font-variant', 'normal')
					]))
			]),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('zero'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('onum'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('liga'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('dlig'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('ordn'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('tnum'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('afrc'),
			$mdgriffith$elm_ui$Internal$Style$fontVariant('frac')
		]));
var $mdgriffith$elm_ui$Internal$Style$explainer = '\n.explain {\n    border: 6px solid rgb(174, 121, 15) !important;\n}\n.explain > .' + ($mdgriffith$elm_ui$Internal$Style$classes.any + (' {\n    border: 4px dashed rgb(0, 151, 167) !important;\n}\n\n.ctr {\n    border: none !important;\n}\n.explain > .ctr > .' + ($mdgriffith$elm_ui$Internal$Style$classes.any + ' {\n    border: 4px dashed rgb(0, 151, 167) !important;\n}\n\n')));
var $mdgriffith$elm_ui$Internal$Style$inputTextReset = '\ninput[type="search"],\ninput[type="search"]::-webkit-search-decoration,\ninput[type="search"]::-webkit-search-cancel-button,\ninput[type="search"]::-webkit-search-results-button,\ninput[type="search"]::-webkit-search-results-decoration {\n  -webkit-appearance:none;\n}\n';
var $mdgriffith$elm_ui$Internal$Style$sliderReset = '\ninput[type=range] {\n  -webkit-appearance: none; \n  background: transparent;\n  position:absolute;\n  left:0;\n  top:0;\n  z-index:10;\n  width: 100%;\n  outline: dashed 1px;\n  height: 100%;\n  opacity: 0;\n}\n';
var $mdgriffith$elm_ui$Internal$Style$thumbReset = '\ninput[type=range]::-webkit-slider-thumb {\n    -webkit-appearance: none;\n    opacity: 0.5;\n    width: 80px;\n    height: 80px;\n    background-color: black;\n    border:none;\n    border-radius: 5px;\n}\ninput[type=range]::-moz-range-thumb {\n    opacity: 0.5;\n    width: 80px;\n    height: 80px;\n    background-color: black;\n    border:none;\n    border-radius: 5px;\n}\ninput[type=range]::-ms-thumb {\n    opacity: 0.5;\n    width: 80px;\n    height: 80px;\n    background-color: black;\n    border:none;\n    border-radius: 5px;\n}\ninput[type=range][orient=vertical]{\n    writing-mode: bt-lr; /* IE */\n    -webkit-appearance: slider-vertical;  /* WebKit */\n}\n';
var $mdgriffith$elm_ui$Internal$Style$trackReset = '\ninput[type=range]::-moz-range-track {\n    background: transparent;\n    cursor: pointer;\n}\ninput[type=range]::-ms-track {\n    background: transparent;\n    cursor: pointer;\n}\ninput[type=range]::-webkit-slider-runnable-track {\n    background: transparent;\n    cursor: pointer;\n}\n';
var $mdgriffith$elm_ui$Internal$Style$overrides = '@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row) + (' > ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + (' { flex-basis: auto !important; } ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.row) + (' > ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.container) + (' { flex-basis: auto !important; }}' + ($mdgriffith$elm_ui$Internal$Style$inputTextReset + ($mdgriffith$elm_ui$Internal$Style$sliderReset + ($mdgriffith$elm_ui$Internal$Style$trackReset + ($mdgriffith$elm_ui$Internal$Style$thumbReset + $mdgriffith$elm_ui$Internal$Style$explainer)))))))))))))));
var $elm$core$String$concat = function (strings) {
	return A2($elm$core$String$join, '', strings);
};
var $mdgriffith$elm_ui$Internal$Style$Intermediate = function (a) {
	return {$: 'Intermediate', a: a};
};
var $mdgriffith$elm_ui$Internal$Style$emptyIntermediate = F2(
	function (selector, closing) {
		return $mdgriffith$elm_ui$Internal$Style$Intermediate(
			{closing: closing, others: _List_Nil, props: _List_Nil, selector: selector});
	});
var $mdgriffith$elm_ui$Internal$Style$renderRules = F2(
	function (_v0, rulesToRender) {
		var parent = _v0.a;
		var generateIntermediates = F2(
			function (rule, rendered) {
				switch (rule.$) {
					case 'Prop':
						var name = rule.a;
						var val = rule.b;
						return _Utils_update(
							rendered,
							{
								props: A2(
									$elm$core$List$cons,
									_Utils_Tuple2(name, val),
									rendered.props)
							});
					case 'Supports':
						var _v2 = rule.a;
						var prop = _v2.a;
						var value = _v2.b;
						var props = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Internal$Style$Intermediate(
										{closing: '\n}', others: _List_Nil, props: props, selector: '@supports (' + (prop + (':' + (value + (') {' + parent.selector))))}),
									rendered.others)
							});
					case 'Adjacent':
						var selector = rule.a;
						var adjRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector + (' + ' + selector), ''),
										adjRules),
									rendered.others)
							});
					case 'Child':
						var child = rule.a;
						var childRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector + (' > ' + child), ''),
										childRules),
									rendered.others)
							});
					case 'AllChildren':
						var child = rule.a;
						var childRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector + (' ' + child), ''),
										childRules),
									rendered.others)
							});
					case 'Descriptor':
						var descriptor = rule.a;
						var descriptorRules = rule.b;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2(
											$mdgriffith$elm_ui$Internal$Style$emptyIntermediate,
											_Utils_ap(parent.selector, descriptor),
											''),
										descriptorRules),
									rendered.others)
							});
					default:
						var batched = rule.a;
						return _Utils_update(
							rendered,
							{
								others: A2(
									$elm$core$List$cons,
									A2(
										$mdgriffith$elm_ui$Internal$Style$renderRules,
										A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, parent.selector, ''),
										batched),
									rendered.others)
							});
				}
			});
		return $mdgriffith$elm_ui$Internal$Style$Intermediate(
			A3($elm$core$List$foldr, generateIntermediates, parent, rulesToRender));
	});
var $mdgriffith$elm_ui$Internal$Style$renderCompact = function (styleClasses) {
	var renderValues = function (values) {
		return $elm$core$String$concat(
			A2(
				$elm$core$List$map,
				function (_v3) {
					var x = _v3.a;
					var y = _v3.b;
					return x + (':' + (y + ';'));
				},
				values));
	};
	var renderClass = function (rule) {
		var _v2 = rule.props;
		if (!_v2.b) {
			return '';
		} else {
			return rule.selector + ('{' + (renderValues(rule.props) + (rule.closing + '}')));
		}
	};
	var renderIntermediate = function (_v0) {
		var rule = _v0.a;
		return _Utils_ap(
			renderClass(rule),
			$elm$core$String$concat(
				A2($elm$core$List$map, renderIntermediate, rule.others)));
	};
	return $elm$core$String$concat(
		A2(
			$elm$core$List$map,
			renderIntermediate,
			A3(
				$elm$core$List$foldr,
				F2(
					function (_v1, existing) {
						var name = _v1.a;
						var styleRules = _v1.b;
						return A2(
							$elm$core$List$cons,
							A2(
								$mdgriffith$elm_ui$Internal$Style$renderRules,
								A2($mdgriffith$elm_ui$Internal$Style$emptyIntermediate, name, ''),
								styleRules),
							existing);
					}),
				_List_Nil,
				styleClasses)));
};
var $mdgriffith$elm_ui$Internal$Style$rules = _Utils_ap(
	$mdgriffith$elm_ui$Internal$Style$overrides,
	$mdgriffith$elm_ui$Internal$Style$renderCompact(
		_Utils_ap($mdgriffith$elm_ui$Internal$Style$baseSheet, $mdgriffith$elm_ui$Internal$Style$commonValues)));
var $elm$virtual_dom$VirtualDom$text = _VirtualDom_text;
var $mdgriffith$elm_ui$Internal$Model$staticRoot = function (opts) {
	var _v0 = opts.mode;
	switch (_v0.$) {
		case 'Layout':
			return A3(
				$elm$virtual_dom$VirtualDom$node,
				'div',
				_List_Nil,
				_List_fromArray(
					[
						A3(
						$elm$virtual_dom$VirtualDom$node,
						'style',
						_List_Nil,
						_List_fromArray(
							[
								$elm$virtual_dom$VirtualDom$text($mdgriffith$elm_ui$Internal$Style$rules)
							]))
					]));
		case 'NoStaticStyleSheet':
			return $elm$virtual_dom$VirtualDom$text('');
		default:
			return A3(
				$elm$virtual_dom$VirtualDom$node,
				'elm-ui-static-rules',
				_List_fromArray(
					[
						A2(
						$elm$virtual_dom$VirtualDom$property,
						'rules',
						$elm$json$Json$Encode$string($mdgriffith$elm_ui$Internal$Style$rules))
					]),
				_List_Nil);
	}
};
var $elm$json$Json$Encode$list = F2(
	function (func, entries) {
		return _Json_wrap(
			A3(
				$elm$core$List$foldl,
				_Json_addEntry(func),
				_Json_emptyArray(_Utils_Tuple0),
				entries));
	});
var $elm$json$Json$Encode$object = function (pairs) {
	return _Json_wrap(
		A3(
			$elm$core$List$foldl,
			F2(
				function (_v0, obj) {
					var k = _v0.a;
					var v = _v0.b;
					return A3(_Json_addField, k, v, obj);
				}),
			_Json_emptyObject(_Utils_Tuple0),
			pairs));
};
var $mdgriffith$elm_ui$Internal$Model$fontName = function (font) {
	switch (font.$) {
		case 'Serif':
			return 'serif';
		case 'SansSerif':
			return 'sans-serif';
		case 'Monospace':
			return 'monospace';
		case 'Typeface':
			var name = font.a;
			return '\"' + (name + '\"');
		case 'ImportFont':
			var name = font.a;
			var url = font.b;
			return '\"' + (name + '\"');
		default:
			var name = font.a.name;
			return '\"' + (name + '\"');
	}
};
var $mdgriffith$elm_ui$Internal$Model$isSmallCaps = function (_var) {
	switch (_var.$) {
		case 'VariantActive':
			var name = _var.a;
			return name === 'smcp';
		case 'VariantOff':
			var name = _var.a;
			return false;
		default:
			var name = _var.a;
			var index = _var.b;
			return (name === 'smcp') && (index === 1);
	}
};
var $mdgriffith$elm_ui$Internal$Model$hasSmallCaps = function (typeface) {
	if (typeface.$ === 'FontWith') {
		var font = typeface.a;
		return A2($elm$core$List$any, $mdgriffith$elm_ui$Internal$Model$isSmallCaps, font.variants);
	} else {
		return false;
	}
};
var $mdgriffith$elm_ui$Internal$Model$renderProps = F3(
	function (force, _v0, existing) {
		var key = _v0.a;
		var val = _v0.b;
		return force ? (existing + ('\n  ' + (key + (': ' + (val + ' !important;'))))) : (existing + ('\n  ' + (key + (': ' + (val + ';')))));
	});
var $mdgriffith$elm_ui$Internal$Model$renderStyle = F4(
	function (options, maybePseudo, selector, props) {
		if (maybePseudo.$ === 'Nothing') {
			return _List_fromArray(
				[
					selector + ('{' + (A3(
					$elm$core$List$foldl,
					$mdgriffith$elm_ui$Internal$Model$renderProps(false),
					'',
					props) + '\n}'))
				]);
		} else {
			var pseudo = maybePseudo.a;
			switch (pseudo.$) {
				case 'Hover':
					var _v2 = options.hover;
					switch (_v2.$) {
						case 'NoHover':
							return _List_Nil;
						case 'ForceHover':
							return _List_fromArray(
								[
									selector + ('-hv {' + (A3(
									$elm$core$List$foldl,
									$mdgriffith$elm_ui$Internal$Model$renderProps(true),
									'',
									props) + '\n}'))
								]);
						default:
							return _List_fromArray(
								[
									selector + ('-hv:hover {' + (A3(
									$elm$core$List$foldl,
									$mdgriffith$elm_ui$Internal$Model$renderProps(false),
									'',
									props) + '\n}'))
								]);
					}
				case 'Focus':
					var renderedProps = A3(
						$elm$core$List$foldl,
						$mdgriffith$elm_ui$Internal$Model$renderProps(false),
						'',
						props);
					return _List_fromArray(
						[
							selector + ('-fs:focus {' + (renderedProps + '\n}')),
							('.' + ($mdgriffith$elm_ui$Internal$Style$classes.any + (':focus ' + (selector + '-fs  {')))) + (renderedProps + '\n}'),
							(selector + '-fs:focus-within {') + (renderedProps + '\n}'),
							('.ui-slide-bar:focus + ' + ($mdgriffith$elm_ui$Internal$Style$dot($mdgriffith$elm_ui$Internal$Style$classes.any) + (' .focusable-thumb' + (selector + '-fs {')))) + (renderedProps + '\n}')
						]);
				default:
					return _List_fromArray(
						[
							selector + ('-act:active {' + (A3(
							$elm$core$List$foldl,
							$mdgriffith$elm_ui$Internal$Model$renderProps(false),
							'',
							props) + '\n}'))
						]);
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$renderVariant = function (_var) {
	switch (_var.$) {
		case 'VariantActive':
			var name = _var.a;
			return '\"' + (name + '\"');
		case 'VariantOff':
			var name = _var.a;
			return '\"' + (name + '\" 0');
		default:
			var name = _var.a;
			var index = _var.b;
			return '\"' + (name + ('\" ' + $elm$core$String$fromInt(index)));
	}
};
var $mdgriffith$elm_ui$Internal$Model$renderVariants = function (typeface) {
	if (typeface.$ === 'FontWith') {
		var font = typeface.a;
		return $elm$core$Maybe$Just(
			A2(
				$elm$core$String$join,
				', ',
				A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$renderVariant, font.variants)));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$transformValue = function (transform) {
	switch (transform.$) {
		case 'Untransformed':
			return $elm$core$Maybe$Nothing;
		case 'Moved':
			var _v1 = transform.a;
			var x = _v1.a;
			var y = _v1.b;
			var z = _v1.c;
			return $elm$core$Maybe$Just(
				'translate3d(' + ($elm$core$String$fromFloat(x) + ('px, ' + ($elm$core$String$fromFloat(y) + ('px, ' + ($elm$core$String$fromFloat(z) + 'px)'))))));
		default:
			var _v2 = transform.a;
			var tx = _v2.a;
			var ty = _v2.b;
			var tz = _v2.c;
			var _v3 = transform.b;
			var sx = _v3.a;
			var sy = _v3.b;
			var sz = _v3.c;
			var _v4 = transform.c;
			var ox = _v4.a;
			var oy = _v4.b;
			var oz = _v4.c;
			var angle = transform.d;
			var translate = 'translate3d(' + ($elm$core$String$fromFloat(tx) + ('px, ' + ($elm$core$String$fromFloat(ty) + ('px, ' + ($elm$core$String$fromFloat(tz) + 'px)')))));
			var scale = 'scale3d(' + ($elm$core$String$fromFloat(sx) + (', ' + ($elm$core$String$fromFloat(sy) + (', ' + ($elm$core$String$fromFloat(sz) + ')')))));
			var rotate = 'rotate3d(' + ($elm$core$String$fromFloat(ox) + (', ' + ($elm$core$String$fromFloat(oy) + (', ' + ($elm$core$String$fromFloat(oz) + (', ' + ($elm$core$String$fromFloat(angle) + 'rad)')))))));
			return $elm$core$Maybe$Just(translate + (' ' + (scale + (' ' + rotate))));
	}
};
var $mdgriffith$elm_ui$Internal$Model$renderStyleRule = F3(
	function (options, rule, maybePseudo) {
		switch (rule.$) {
			case 'Style':
				var selector = rule.a;
				var props = rule.b;
				return A4($mdgriffith$elm_ui$Internal$Model$renderStyle, options, maybePseudo, selector, props);
			case 'Shadows':
				var name = rule.a;
				var prop = rule.b;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + name,
					_List_fromArray(
						[
							A2($mdgriffith$elm_ui$Internal$Model$Property, 'box-shadow', prop)
						]));
			case 'Transparency':
				var name = rule.a;
				var transparency = rule.b;
				var opacity = A2(
					$elm$core$Basics$max,
					0,
					A2($elm$core$Basics$min, 1, 1 - transparency));
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + name,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'opacity',
							$elm$core$String$fromFloat(opacity))
						]));
			case 'FontSize':
				var i = rule.a;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.font-size-' + $elm$core$String$fromInt(i),
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'font-size',
							$elm$core$String$fromInt(i) + 'px')
						]));
			case 'FontFamily':
				var name = rule.a;
				var typefaces = rule.b;
				var features = A2(
					$elm$core$String$join,
					', ',
					A2($elm$core$List$filterMap, $mdgriffith$elm_ui$Internal$Model$renderVariants, typefaces));
				var families = _List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Internal$Model$Property,
						'font-family',
						A2(
							$elm$core$String$join,
							', ',
							A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$fontName, typefaces))),
						A2($mdgriffith$elm_ui$Internal$Model$Property, 'font-feature-settings', features),
						A2(
						$mdgriffith$elm_ui$Internal$Model$Property,
						'font-variant',
						A2($elm$core$List$any, $mdgriffith$elm_ui$Internal$Model$hasSmallCaps, typefaces) ? 'small-caps' : 'normal')
					]);
				return A4($mdgriffith$elm_ui$Internal$Model$renderStyle, options, maybePseudo, '.' + name, families);
			case 'Single':
				var _class = rule.a;
				var prop = rule.b;
				var val = rule.c;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + _class,
					_List_fromArray(
						[
							A2($mdgriffith$elm_ui$Internal$Model$Property, prop, val)
						]));
			case 'Colored':
				var _class = rule.a;
				var prop = rule.b;
				var color = rule.c;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					'.' + _class,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							prop,
							$mdgriffith$elm_ui$Internal$Model$formatColor(color))
						]));
			case 'SpacingStyle':
				var cls = rule.a;
				var x = rule.b;
				var y = rule.c;
				var yPx = $elm$core$String$fromInt(y) + 'px';
				var xPx = $elm$core$String$fromInt(x) + 'px';
				var single = '.' + $mdgriffith$elm_ui$Internal$Style$classes.single;
				var row = '.' + $mdgriffith$elm_ui$Internal$Style$classes.row;
				var wrappedRow = '.' + ($mdgriffith$elm_ui$Internal$Style$classes.wrapped + row);
				var right = '.' + $mdgriffith$elm_ui$Internal$Style$classes.alignRight;
				var paragraph = '.' + $mdgriffith$elm_ui$Internal$Style$classes.paragraph;
				var page = '.' + $mdgriffith$elm_ui$Internal$Style$classes.page;
				var left = '.' + $mdgriffith$elm_ui$Internal$Style$classes.alignLeft;
				var halfY = $elm$core$String$fromFloat(y / 2) + 'px';
				var halfX = $elm$core$String$fromFloat(x / 2) + 'px';
				var column = '.' + $mdgriffith$elm_ui$Internal$Style$classes.column;
				var _class = '.' + cls;
				var any = '.' + $mdgriffith$elm_ui$Internal$Style$classes.any;
				return $elm$core$List$concat(
					_List_fromArray(
						[
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (row + (' > ' + (any + (' + ' + any)))),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-left', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (wrappedRow + (' > ' + any)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin', halfY + (' ' + halfX))
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (column + (' > ' + (any + (' + ' + any)))),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-top', yPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (page + (' > ' + (any + (' + ' + any)))),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-top', yPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (page + (' > ' + left)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-right', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (page + (' > ' + right)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-left', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_Utils_ap(_class, paragraph),
							_List_fromArray(
								[
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'line-height',
									'calc(1em + ' + ($elm$core$String$fromInt(y) + 'px)'))
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							'textarea' + (any + _class),
							_List_fromArray(
								[
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'line-height',
									'calc(1em + ' + ($elm$core$String$fromInt(y) + 'px)')),
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'height',
									'calc(100% + ' + ($elm$core$String$fromInt(y) + 'px)'))
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + (' > ' + left)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-right', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + (' > ' + right)),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'margin-left', xPx)
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + '::after'),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'content', '\'\''),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'display', 'block'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'height', '0'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'width', '0'),
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'margin-top',
									$elm$core$String$fromInt((-1) * ((y / 2) | 0)) + 'px')
								])),
							A4(
							$mdgriffith$elm_ui$Internal$Model$renderStyle,
							options,
							maybePseudo,
							_class + (paragraph + '::before'),
							_List_fromArray(
								[
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'content', '\'\''),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'display', 'block'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'height', '0'),
									A2($mdgriffith$elm_ui$Internal$Model$Property, 'width', '0'),
									A2(
									$mdgriffith$elm_ui$Internal$Model$Property,
									'margin-bottom',
									$elm$core$String$fromInt((-1) * ((y / 2) | 0)) + 'px')
								]))
						]));
			case 'PaddingStyle':
				var cls = rule.a;
				var top = rule.b;
				var right = rule.c;
				var bottom = rule.d;
				var left = rule.e;
				var _class = '.' + cls;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					_class,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'padding',
							$elm$core$String$fromFloat(top) + ('px ' + ($elm$core$String$fromFloat(right) + ('px ' + ($elm$core$String$fromFloat(bottom) + ('px ' + ($elm$core$String$fromFloat(left) + 'px')))))))
						]));
			case 'BorderWidth':
				var cls = rule.a;
				var top = rule.b;
				var right = rule.c;
				var bottom = rule.d;
				var left = rule.e;
				var _class = '.' + cls;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$renderStyle,
					options,
					maybePseudo,
					_class,
					_List_fromArray(
						[
							A2(
							$mdgriffith$elm_ui$Internal$Model$Property,
							'border-width',
							$elm$core$String$fromInt(top) + ('px ' + ($elm$core$String$fromInt(right) + ('px ' + ($elm$core$String$fromInt(bottom) + ('px ' + ($elm$core$String$fromInt(left) + 'px')))))))
						]));
			case 'GridTemplateStyle':
				var template = rule.a;
				var toGridLengthHelper = F3(
					function (minimum, maximum, x) {
						toGridLengthHelper:
						while (true) {
							switch (x.$) {
								case 'Px':
									var px = x.a;
									return $elm$core$String$fromInt(px) + 'px';
								case 'Content':
									var _v2 = _Utils_Tuple2(minimum, maximum);
									if (_v2.a.$ === 'Nothing') {
										if (_v2.b.$ === 'Nothing') {
											var _v3 = _v2.a;
											var _v4 = _v2.b;
											return 'max-content';
										} else {
											var _v6 = _v2.a;
											var maxSize = _v2.b.a;
											return 'minmax(max-content, ' + ($elm$core$String$fromInt(maxSize) + 'px)');
										}
									} else {
										if (_v2.b.$ === 'Nothing') {
											var minSize = _v2.a.a;
											var _v5 = _v2.b;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + 'max-content)'));
										} else {
											var minSize = _v2.a.a;
											var maxSize = _v2.b.a;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + ($elm$core$String$fromInt(maxSize) + 'px)')));
										}
									}
								case 'Fill':
									var i = x.a;
									var _v7 = _Utils_Tuple2(minimum, maximum);
									if (_v7.a.$ === 'Nothing') {
										if (_v7.b.$ === 'Nothing') {
											var _v8 = _v7.a;
											var _v9 = _v7.b;
											return $elm$core$String$fromInt(i) + 'fr';
										} else {
											var _v11 = _v7.a;
											var maxSize = _v7.b.a;
											return 'minmax(max-content, ' + ($elm$core$String$fromInt(maxSize) + 'px)');
										}
									} else {
										if (_v7.b.$ === 'Nothing') {
											var minSize = _v7.a.a;
											var _v10 = _v7.b;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + ($elm$core$String$fromInt(i) + ('fr' + 'fr)'))));
										} else {
											var minSize = _v7.a.a;
											var maxSize = _v7.b.a;
											return 'minmax(' + ($elm$core$String$fromInt(minSize) + ('px, ' + ($elm$core$String$fromInt(maxSize) + 'px)')));
										}
									}
								case 'Min':
									var m = x.a;
									var len = x.b;
									var $temp$minimum = $elm$core$Maybe$Just(m),
										$temp$maximum = maximum,
										$temp$x = len;
									minimum = $temp$minimum;
									maximum = $temp$maximum;
									x = $temp$x;
									continue toGridLengthHelper;
								default:
									var m = x.a;
									var len = x.b;
									var $temp$minimum = minimum,
										$temp$maximum = $elm$core$Maybe$Just(m),
										$temp$x = len;
									minimum = $temp$minimum;
									maximum = $temp$maximum;
									x = $temp$x;
									continue toGridLengthHelper;
							}
						}
					});
				var toGridLength = function (x) {
					return A3(toGridLengthHelper, $elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing, x);
				};
				var xSpacing = toGridLength(template.spacing.a);
				var ySpacing = toGridLength(template.spacing.b);
				var rows = function (x) {
					return 'grid-template-rows: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						' ',
						A2($elm$core$List$map, toGridLength, template.rows)));
				var msRows = function (x) {
					return '-ms-grid-rows: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						ySpacing,
						A2($elm$core$List$map, toGridLength, template.columns)));
				var msColumns = function (x) {
					return '-ms-grid-columns: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						ySpacing,
						A2($elm$core$List$map, toGridLength, template.columns)));
				var gapY = 'grid-row-gap:' + (toGridLength(template.spacing.b) + ';');
				var gapX = 'grid-column-gap:' + (toGridLength(template.spacing.a) + ';');
				var columns = function (x) {
					return 'grid-template-columns: ' + (x + ';');
				}(
					A2(
						$elm$core$String$join,
						' ',
						A2($elm$core$List$map, toGridLength, template.columns)));
				var _class = '.grid-rows-' + (A2(
					$elm$core$String$join,
					'-',
					A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.rows)) + ('-cols-' + (A2(
					$elm$core$String$join,
					'-',
					A2($elm$core$List$map, $mdgriffith$elm_ui$Internal$Model$lengthClassName, template.columns)) + ('-space-x-' + ($mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.a) + ('-space-y-' + $mdgriffith$elm_ui$Internal$Model$lengthClassName(template.spacing.b)))))));
				var modernGrid = _class + ('{' + (columns + (rows + (gapX + (gapY + '}')))));
				var supports = '@supports (display:grid) {' + (modernGrid + '}');
				var base = _class + ('{' + (msColumns + (msRows + '}')));
				return _List_fromArray(
					[base, supports]);
			case 'GridPosition':
				var position = rule.a;
				var msPosition = A2(
					$elm$core$String$join,
					' ',
					_List_fromArray(
						[
							'-ms-grid-row: ' + ($elm$core$String$fromInt(position.row) + ';'),
							'-ms-grid-row-span: ' + ($elm$core$String$fromInt(position.height) + ';'),
							'-ms-grid-column: ' + ($elm$core$String$fromInt(position.col) + ';'),
							'-ms-grid-column-span: ' + ($elm$core$String$fromInt(position.width) + ';')
						]));
				var modernPosition = A2(
					$elm$core$String$join,
					' ',
					_List_fromArray(
						[
							'grid-row: ' + ($elm$core$String$fromInt(position.row) + (' / ' + ($elm$core$String$fromInt(position.row + position.height) + ';'))),
							'grid-column: ' + ($elm$core$String$fromInt(position.col) + (' / ' + ($elm$core$String$fromInt(position.col + position.width) + ';')))
						]));
				var _class = '.grid-pos-' + ($elm$core$String$fromInt(position.row) + ('-' + ($elm$core$String$fromInt(position.col) + ('-' + ($elm$core$String$fromInt(position.width) + ('-' + $elm$core$String$fromInt(position.height)))))));
				var modernGrid = _class + ('{' + (modernPosition + '}'));
				var supports = '@supports (display:grid) {' + (modernGrid + '}');
				var base = _class + ('{' + (msPosition + '}'));
				return _List_fromArray(
					[base, supports]);
			case 'PseudoSelector':
				var _class = rule.a;
				var styles = rule.b;
				var renderPseudoRule = function (style) {
					return A3(
						$mdgriffith$elm_ui$Internal$Model$renderStyleRule,
						options,
						style,
						$elm$core$Maybe$Just(_class));
				};
				return A2($elm$core$List$concatMap, renderPseudoRule, styles);
			default:
				var transform = rule.a;
				var val = $mdgriffith$elm_ui$Internal$Model$transformValue(transform);
				var _class = $mdgriffith$elm_ui$Internal$Model$transformClass(transform);
				var _v12 = _Utils_Tuple2(_class, val);
				if ((_v12.a.$ === 'Just') && (_v12.b.$ === 'Just')) {
					var cls = _v12.a.a;
					var v = _v12.b.a;
					return A4(
						$mdgriffith$elm_ui$Internal$Model$renderStyle,
						options,
						maybePseudo,
						'.' + cls,
						_List_fromArray(
							[
								A2($mdgriffith$elm_ui$Internal$Model$Property, 'transform', v)
							]));
				} else {
					return _List_Nil;
				}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$encodeStyles = F2(
	function (options, stylesheet) {
		return $elm$json$Json$Encode$object(
			A2(
				$elm$core$List$map,
				function (style) {
					var styled = A3($mdgriffith$elm_ui$Internal$Model$renderStyleRule, options, style, $elm$core$Maybe$Nothing);
					return _Utils_Tuple2(
						$mdgriffith$elm_ui$Internal$Model$getStyleName(style),
						A2($elm$json$Json$Encode$list, $elm$json$Json$Encode$string, styled));
				},
				stylesheet));
	});
var $mdgriffith$elm_ui$Internal$Model$bracket = F2(
	function (selector, rules) {
		var renderPair = function (_v0) {
			var name = _v0.a;
			var val = _v0.b;
			return name + (': ' + (val + ';'));
		};
		return selector + (' {' + (A2(
			$elm$core$String$join,
			'',
			A2($elm$core$List$map, renderPair, rules)) + '}'));
	});
var $mdgriffith$elm_ui$Internal$Model$fontRule = F3(
	function (name, modifier, _v0) {
		var parentAdj = _v0.a;
		var textAdjustment = _v0.b;
		return _List_fromArray(
			[
				A2($mdgriffith$elm_ui$Internal$Model$bracket, '.' + (name + ('.' + (modifier + (', ' + ('.' + (name + (' .' + modifier))))))), parentAdj),
				A2($mdgriffith$elm_ui$Internal$Model$bracket, '.' + (name + ('.' + (modifier + ('> .' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (', .' + (name + (' .' + (modifier + (' > .' + $mdgriffith$elm_ui$Internal$Style$classes.text)))))))))), textAdjustment)
			]);
	});
var $mdgriffith$elm_ui$Internal$Model$renderFontAdjustmentRule = F3(
	function (fontToAdjust, _v0, otherFontName) {
		var full = _v0.a;
		var capital = _v0.b;
		var name = _Utils_eq(fontToAdjust, otherFontName) ? fontToAdjust : (otherFontName + (' .' + fontToAdjust));
		return A2(
			$elm$core$String$join,
			' ',
			_Utils_ap(
				A3($mdgriffith$elm_ui$Internal$Model$fontRule, name, $mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital, capital),
				A3($mdgriffith$elm_ui$Internal$Model$fontRule, name, $mdgriffith$elm_ui$Internal$Style$classes.fullSize, full)));
	});
var $mdgriffith$elm_ui$Internal$Model$renderNullAdjustmentRule = F2(
	function (fontToAdjust, otherFontName) {
		var name = _Utils_eq(fontToAdjust, otherFontName) ? fontToAdjust : (otherFontName + (' .' + fontToAdjust));
		return A2(
			$elm$core$String$join,
			' ',
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Internal$Model$bracket,
					'.' + (name + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital + (', ' + ('.' + (name + (' .' + $mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital))))))),
					_List_fromArray(
						[
							_Utils_Tuple2('line-height', '1')
						])),
					A2(
					$mdgriffith$elm_ui$Internal$Model$bracket,
					'.' + (name + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital + ('> .' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (', .' + (name + (' .' + ($mdgriffith$elm_ui$Internal$Style$classes.sizeByCapital + (' > .' + $mdgriffith$elm_ui$Internal$Style$classes.text)))))))))),
					_List_fromArray(
						[
							_Utils_Tuple2('vertical-align', '0'),
							_Utils_Tuple2('line-height', '1')
						]))
				]));
	});
var $mdgriffith$elm_ui$Internal$Model$adjust = F3(
	function (size, height, vertical) {
		return {height: height / size, size: size, vertical: vertical};
	});
var $elm$core$List$maximum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$max, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $elm$core$List$minimum = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(
			A3($elm$core$List$foldl, $elm$core$Basics$min, x, xs));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$convertAdjustment = function (adjustment) {
	var lines = _List_fromArray(
		[adjustment.capital, adjustment.baseline, adjustment.descender, adjustment.lowercase]);
	var lineHeight = 1.5;
	var normalDescender = (lineHeight - 1) / 2;
	var oldMiddle = lineHeight / 2;
	var descender = A2(
		$elm$core$Maybe$withDefault,
		adjustment.descender,
		$elm$core$List$minimum(lines));
	var newBaseline = A2(
		$elm$core$Maybe$withDefault,
		adjustment.baseline,
		$elm$core$List$minimum(
			A2(
				$elm$core$List$filter,
				function (x) {
					return !_Utils_eq(x, descender);
				},
				lines)));
	var base = lineHeight;
	var ascender = A2(
		$elm$core$Maybe$withDefault,
		adjustment.capital,
		$elm$core$List$maximum(lines));
	var capitalSize = 1 / (ascender - newBaseline);
	var capitalVertical = 1 - ascender;
	var fullSize = 1 / (ascender - descender);
	var fullVertical = 1 - ascender;
	var newCapitalMiddle = ((ascender - newBaseline) / 2) + newBaseline;
	var newFullMiddle = ((ascender - descender) / 2) + descender;
	return {
		capital: A3($mdgriffith$elm_ui$Internal$Model$adjust, capitalSize, ascender - newBaseline, capitalVertical),
		full: A3($mdgriffith$elm_ui$Internal$Model$adjust, fullSize, ascender - descender, fullVertical)
	};
};
var $mdgriffith$elm_ui$Internal$Model$fontAdjustmentRules = function (converted) {
	return _Utils_Tuple2(
		_List_fromArray(
			[
				_Utils_Tuple2('display', 'block')
			]),
		_List_fromArray(
			[
				_Utils_Tuple2('display', 'inline-block'),
				_Utils_Tuple2(
				'line-height',
				$elm$core$String$fromFloat(converted.height)),
				_Utils_Tuple2(
				'vertical-align',
				$elm$core$String$fromFloat(converted.vertical) + 'em'),
				_Utils_Tuple2(
				'font-size',
				$elm$core$String$fromFloat(converted.size) + 'em')
			]));
};
var $mdgriffith$elm_ui$Internal$Model$typefaceAdjustment = function (typefaces) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (face, found) {
				if (found.$ === 'Nothing') {
					if (face.$ === 'FontWith') {
						var _with = face.a;
						var _v2 = _with.adjustment;
						if (_v2.$ === 'Nothing') {
							return found;
						} else {
							var adjustment = _v2.a;
							return $elm$core$Maybe$Just(
								_Utils_Tuple2(
									$mdgriffith$elm_ui$Internal$Model$fontAdjustmentRules(
										function ($) {
											return $.full;
										}(
											$mdgriffith$elm_ui$Internal$Model$convertAdjustment(adjustment))),
									$mdgriffith$elm_ui$Internal$Model$fontAdjustmentRules(
										function ($) {
											return $.capital;
										}(
											$mdgriffith$elm_ui$Internal$Model$convertAdjustment(adjustment)))));
						}
					} else {
						return found;
					}
				} else {
					return found;
				}
			}),
		$elm$core$Maybe$Nothing,
		typefaces);
};
var $mdgriffith$elm_ui$Internal$Model$renderTopLevelValues = function (rules) {
	var withImport = function (font) {
		if (font.$ === 'ImportFont') {
			var url = font.b;
			return $elm$core$Maybe$Just('@import url(\'' + (url + '\');'));
		} else {
			return $elm$core$Maybe$Nothing;
		}
	};
	var fontImports = function (_v2) {
		var name = _v2.a;
		var typefaces = _v2.b;
		var imports = A2(
			$elm$core$String$join,
			'\n',
			A2($elm$core$List$filterMap, withImport, typefaces));
		return imports;
	};
	var allNames = A2($elm$core$List$map, $elm$core$Tuple$first, rules);
	var fontAdjustments = function (_v1) {
		var name = _v1.a;
		var typefaces = _v1.b;
		var _v0 = $mdgriffith$elm_ui$Internal$Model$typefaceAdjustment(typefaces);
		if (_v0.$ === 'Nothing') {
			return A2(
				$elm$core$String$join,
				'',
				A2(
					$elm$core$List$map,
					$mdgriffith$elm_ui$Internal$Model$renderNullAdjustmentRule(name),
					allNames));
		} else {
			var adjustment = _v0.a;
			return A2(
				$elm$core$String$join,
				'',
				A2(
					$elm$core$List$map,
					A2($mdgriffith$elm_ui$Internal$Model$renderFontAdjustmentRule, name, adjustment),
					allNames));
		}
	};
	return _Utils_ap(
		A2(
			$elm$core$String$join,
			'\n',
			A2($elm$core$List$map, fontImports, rules)),
		A2(
			$elm$core$String$join,
			'\n',
			A2($elm$core$List$map, fontAdjustments, rules)));
};
var $mdgriffith$elm_ui$Internal$Model$topLevelValue = function (rule) {
	if (rule.$ === 'FontFamily') {
		var name = rule.a;
		var typefaces = rule.b;
		return $elm$core$Maybe$Just(
			_Utils_Tuple2(name, typefaces));
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$toStyleSheetString = F2(
	function (options, stylesheet) {
		var combine = F2(
			function (style, rendered) {
				return {
					rules: _Utils_ap(
						rendered.rules,
						A3($mdgriffith$elm_ui$Internal$Model$renderStyleRule, options, style, $elm$core$Maybe$Nothing)),
					topLevel: function () {
						var _v1 = $mdgriffith$elm_ui$Internal$Model$topLevelValue(style);
						if (_v1.$ === 'Nothing') {
							return rendered.topLevel;
						} else {
							var topLevel = _v1.a;
							return A2($elm$core$List$cons, topLevel, rendered.topLevel);
						}
					}()
				};
			});
		var _v0 = A3(
			$elm$core$List$foldl,
			combine,
			{rules: _List_Nil, topLevel: _List_Nil},
			stylesheet);
		var topLevel = _v0.topLevel;
		var rules = _v0.rules;
		return _Utils_ap(
			$mdgriffith$elm_ui$Internal$Model$renderTopLevelValues(topLevel),
			$elm$core$String$concat(rules));
	});
var $mdgriffith$elm_ui$Internal$Model$toStyleSheet = F2(
	function (options, styleSheet) {
		var _v0 = options.mode;
		switch (_v0.$) {
			case 'Layout':
				return A3(
					$elm$virtual_dom$VirtualDom$node,
					'div',
					_List_Nil,
					_List_fromArray(
						[
							A3(
							$elm$virtual_dom$VirtualDom$node,
							'style',
							_List_Nil,
							_List_fromArray(
								[
									$elm$virtual_dom$VirtualDom$text(
									A2($mdgriffith$elm_ui$Internal$Model$toStyleSheetString, options, styleSheet))
								]))
						]));
			case 'NoStaticStyleSheet':
				return A3(
					$elm$virtual_dom$VirtualDom$node,
					'div',
					_List_Nil,
					_List_fromArray(
						[
							A3(
							$elm$virtual_dom$VirtualDom$node,
							'style',
							_List_Nil,
							_List_fromArray(
								[
									$elm$virtual_dom$VirtualDom$text(
									A2($mdgriffith$elm_ui$Internal$Model$toStyleSheetString, options, styleSheet))
								]))
						]));
			default:
				return A3(
					$elm$virtual_dom$VirtualDom$node,
					'elm-ui-rules',
					_List_fromArray(
						[
							A2(
							$elm$virtual_dom$VirtualDom$property,
							'rules',
							A2($mdgriffith$elm_ui$Internal$Model$encodeStyles, options, styleSheet))
						]),
					_List_Nil);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$embedKeyed = F4(
	function (_static, opts, styles, children) {
		var dynamicStyleSheet = A2(
			$mdgriffith$elm_ui$Internal$Model$toStyleSheet,
			opts,
			A3(
				$elm$core$List$foldl,
				$mdgriffith$elm_ui$Internal$Model$reduceStyles,
				_Utils_Tuple2(
					$elm$core$Set$empty,
					$mdgriffith$elm_ui$Internal$Model$renderFocusStyle(opts.focus)),
				styles).b);
		return _static ? A2(
			$elm$core$List$cons,
			_Utils_Tuple2(
				'static-stylesheet',
				$mdgriffith$elm_ui$Internal$Model$staticRoot(opts)),
			A2(
				$elm$core$List$cons,
				_Utils_Tuple2('dynamic-stylesheet', dynamicStyleSheet),
				children)) : A2(
			$elm$core$List$cons,
			_Utils_Tuple2('dynamic-stylesheet', dynamicStyleSheet),
			children);
	});
var $mdgriffith$elm_ui$Internal$Model$embedWith = F4(
	function (_static, opts, styles, children) {
		var dynamicStyleSheet = A2(
			$mdgriffith$elm_ui$Internal$Model$toStyleSheet,
			opts,
			A3(
				$elm$core$List$foldl,
				$mdgriffith$elm_ui$Internal$Model$reduceStyles,
				_Utils_Tuple2(
					$elm$core$Set$empty,
					$mdgriffith$elm_ui$Internal$Model$renderFocusStyle(opts.focus)),
				styles).b);
		return _static ? A2(
			$elm$core$List$cons,
			$mdgriffith$elm_ui$Internal$Model$staticRoot(opts),
			A2($elm$core$List$cons, dynamicStyleSheet, children)) : A2($elm$core$List$cons, dynamicStyleSheet, children);
	});
var $mdgriffith$elm_ui$Internal$Flag$heightBetween = $mdgriffith$elm_ui$Internal$Flag$flag(45);
var $mdgriffith$elm_ui$Internal$Flag$heightFill = $mdgriffith$elm_ui$Internal$Flag$flag(37);
var $elm$virtual_dom$VirtualDom$keyedNode = function (tag) {
	return _VirtualDom_keyedNode(
		_VirtualDom_noScript(tag));
};
var $elm$html$Html$p = _VirtualDom_node('p');
var $elm$core$Bitwise$and = _Bitwise_and;
var $mdgriffith$elm_ui$Internal$Flag$present = F2(
	function (myFlag, _v0) {
		var fieldOne = _v0.a;
		var fieldTwo = _v0.b;
		if (myFlag.$ === 'Flag') {
			var first = myFlag.a;
			return _Utils_eq(first & fieldOne, first);
		} else {
			var second = myFlag.a;
			return _Utils_eq(second & fieldTwo, second);
		}
	});
var $elm$html$Html$s = _VirtualDom_node('s');
var $elm$html$Html$u = _VirtualDom_node('u');
var $mdgriffith$elm_ui$Internal$Flag$widthBetween = $mdgriffith$elm_ui$Internal$Flag$flag(44);
var $mdgriffith$elm_ui$Internal$Flag$widthFill = $mdgriffith$elm_ui$Internal$Flag$flag(39);
var $mdgriffith$elm_ui$Internal$Model$finalizeNode = F6(
	function (has, node, attributes, children, embedMode, parentContext) {
		var createNode = F2(
			function (nodeName, attrs) {
				if (children.$ === 'Keyed') {
					var keyed = children.a;
					return A3(
						$elm$virtual_dom$VirtualDom$keyedNode,
						nodeName,
						attrs,
						function () {
							switch (embedMode.$) {
								case 'NoStyleSheet':
									return keyed;
								case 'OnlyDynamic':
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedKeyed, false, opts, styles, keyed);
								default:
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedKeyed, true, opts, styles, keyed);
							}
						}());
				} else {
					var unkeyed = children.a;
					return A2(
						function () {
							switch (nodeName) {
								case 'div':
									return $elm$html$Html$div;
								case 'p':
									return $elm$html$Html$p;
								default:
									return $elm$virtual_dom$VirtualDom$node(nodeName);
							}
						}(),
						attrs,
						function () {
							switch (embedMode.$) {
								case 'NoStyleSheet':
									return unkeyed;
								case 'OnlyDynamic':
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedWith, false, opts, styles, unkeyed);
								default:
									var opts = embedMode.a;
									var styles = embedMode.b;
									return A4($mdgriffith$elm_ui$Internal$Model$embedWith, true, opts, styles, unkeyed);
							}
						}());
				}
			});
		var html = function () {
			switch (node.$) {
				case 'Generic':
					return A2(createNode, 'div', attributes);
				case 'NodeName':
					var nodeName = node.a;
					return A2(createNode, nodeName, attributes);
				default:
					var nodeName = node.a;
					var internal = node.b;
					return A3(
						$elm$virtual_dom$VirtualDom$node,
						nodeName,
						attributes,
						_List_fromArray(
							[
								A2(
								createNode,
								internal,
								_List_fromArray(
									[
										$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.single))
									]))
							]));
			}
		}();
		switch (parentContext.$) {
			case 'AsRow':
				return (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$widthFill, has) && (!A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$widthBetween, has))) ? html : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$alignRight, has) ? A2(
					$elm$html$Html$u,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.contentCenterY, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerRight])))
						]),
					_List_fromArray(
						[html])) : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$centerX, has) ? A2(
					$elm$html$Html$s,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.contentCenterY, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterX])))
						]),
					_List_fromArray(
						[html])) : html));
			case 'AsColumn':
				return (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$heightFill, has) && (!A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$heightBetween, has))) ? html : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$centerY, has) ? A2(
					$elm$html$Html$s,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerCenterY])))
						]),
					_List_fromArray(
						[html])) : (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$alignBottom, has) ? A2(
					$elm$html$Html$u,
					_List_fromArray(
						[
							$elm$html$Html$Attributes$class(
							A2(
								$elm$core$String$join,
								' ',
								_List_fromArray(
									[$mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.container, $mdgriffith$elm_ui$Internal$Style$classes.alignContainerBottom])))
						]),
					_List_fromArray(
						[html])) : html));
			default:
				return html;
		}
	});
var $elm$html$Html$text = $elm$virtual_dom$VirtualDom$text;
var $mdgriffith$elm_ui$Internal$Model$textElementClasses = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.widthContent + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.heightContent)))));
var $mdgriffith$elm_ui$Internal$Model$textElement = function (str) {
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Model$textElementClasses)
			]),
		_List_fromArray(
			[
				$elm$html$Html$text(str)
			]));
};
var $mdgriffith$elm_ui$Internal$Model$textElementFillClasses = $mdgriffith$elm_ui$Internal$Style$classes.any + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.text + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.widthFill + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.heightFill)))));
var $mdgriffith$elm_ui$Internal$Model$textElementFill = function (str) {
	return A2(
		$elm$html$Html$div,
		_List_fromArray(
			[
				$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Model$textElementFillClasses)
			]),
		_List_fromArray(
			[
				$elm$html$Html$text(str)
			]));
};
var $mdgriffith$elm_ui$Internal$Model$createElement = F3(
	function (context, children, rendered) {
		var gatherKeyed = F2(
			function (_v8, _v9) {
				var key = _v8.a;
				var child = _v8.b;
				var htmls = _v9.a;
				var existingStyles = _v9.b;
				switch (child.$) {
					case 'Unstyled':
						var html = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									html(context)),
								htmls),
							existingStyles) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									html(context)),
								htmls),
							existingStyles);
					case 'Styled':
						var styled = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context)),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles)) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context)),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles));
					case 'Text':
						var str = child.a;
						return _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_Tuple2(
									key,
									_Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asEl) ? $mdgriffith$elm_ui$Internal$Model$textElementFill(str) : $mdgriffith$elm_ui$Internal$Model$textElement(str)),
								htmls),
							existingStyles);
					default:
						return _Utils_Tuple2(htmls, existingStyles);
				}
			});
		var gather = F2(
			function (child, _v6) {
				var htmls = _v6.a;
				var existingStyles = _v6.b;
				switch (child.$) {
					case 'Unstyled':
						var html = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								html(context),
								htmls),
							existingStyles) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								html(context),
								htmls),
							existingStyles);
					case 'Styled':
						var styled = child.a;
						return _Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asParagraph) ? _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles)) : _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, context),
								htmls),
							$elm$core$List$isEmpty(existingStyles) ? styled.styles : _Utils_ap(styled.styles, existingStyles));
					case 'Text':
						var str = child.a;
						return _Utils_Tuple2(
							A2(
								$elm$core$List$cons,
								_Utils_eq(context, $mdgriffith$elm_ui$Internal$Model$asEl) ? $mdgriffith$elm_ui$Internal$Model$textElementFill(str) : $mdgriffith$elm_ui$Internal$Model$textElement(str),
								htmls),
							existingStyles);
					default:
						return _Utils_Tuple2(htmls, existingStyles);
				}
			});
		if (children.$ === 'Keyed') {
			var keyedChildren = children.a;
			var _v1 = A3(
				$elm$core$List$foldr,
				gatherKeyed,
				_Utils_Tuple2(_List_Nil, _List_Nil),
				keyedChildren);
			var keyed = _v1.a;
			var styles = _v1.b;
			var newStyles = $elm$core$List$isEmpty(styles) ? rendered.styles : _Utils_ap(rendered.styles, styles);
			if (!newStyles.b) {
				return $mdgriffith$elm_ui$Internal$Model$Unstyled(
					A5(
						$mdgriffith$elm_ui$Internal$Model$finalizeNode,
						rendered.has,
						rendered.node,
						rendered.attributes,
						$mdgriffith$elm_ui$Internal$Model$Keyed(
							A3($mdgriffith$elm_ui$Internal$Model$addKeyedChildren, 'nearby-element-pls', keyed, rendered.children)),
						$mdgriffith$elm_ui$Internal$Model$NoStyleSheet));
			} else {
				var allStyles = newStyles;
				return $mdgriffith$elm_ui$Internal$Model$Styled(
					{
						html: A4(
							$mdgriffith$elm_ui$Internal$Model$finalizeNode,
							rendered.has,
							rendered.node,
							rendered.attributes,
							$mdgriffith$elm_ui$Internal$Model$Keyed(
								A3($mdgriffith$elm_ui$Internal$Model$addKeyedChildren, 'nearby-element-pls', keyed, rendered.children))),
						styles: allStyles
					});
			}
		} else {
			var unkeyedChildren = children.a;
			var _v3 = A3(
				$elm$core$List$foldr,
				gather,
				_Utils_Tuple2(_List_Nil, _List_Nil),
				unkeyedChildren);
			var unkeyed = _v3.a;
			var styles = _v3.b;
			var newStyles = $elm$core$List$isEmpty(styles) ? rendered.styles : _Utils_ap(rendered.styles, styles);
			if (!newStyles.b) {
				return $mdgriffith$elm_ui$Internal$Model$Unstyled(
					A5(
						$mdgriffith$elm_ui$Internal$Model$finalizeNode,
						rendered.has,
						rendered.node,
						rendered.attributes,
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							A2($mdgriffith$elm_ui$Internal$Model$addChildren, unkeyed, rendered.children)),
						$mdgriffith$elm_ui$Internal$Model$NoStyleSheet));
			} else {
				var allStyles = newStyles;
				return $mdgriffith$elm_ui$Internal$Model$Styled(
					{
						html: A4(
							$mdgriffith$elm_ui$Internal$Model$finalizeNode,
							rendered.has,
							rendered.node,
							rendered.attributes,
							$mdgriffith$elm_ui$Internal$Model$Unkeyed(
								A2($mdgriffith$elm_ui$Internal$Model$addChildren, unkeyed, rendered.children))),
						styles: allStyles
					});
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$Single = F3(
	function (a, b, c) {
		return {$: 'Single', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Model$Transform = function (a) {
	return {$: 'Transform', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$Field = F2(
	function (a, b) {
		return {$: 'Field', a: a, b: b};
	});
var $elm$core$Bitwise$or = _Bitwise_or;
var $mdgriffith$elm_ui$Internal$Flag$add = F2(
	function (myFlag, _v0) {
		var one = _v0.a;
		var two = _v0.b;
		if (myFlag.$ === 'Flag') {
			var first = myFlag.a;
			return A2($mdgriffith$elm_ui$Internal$Flag$Field, first | one, two);
		} else {
			var second = myFlag.a;
			return A2($mdgriffith$elm_ui$Internal$Flag$Field, one, second | two);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$ChildrenBehind = function (a) {
	return {$: 'ChildrenBehind', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront = F2(
	function (a, b) {
		return {$: 'ChildrenBehindAndInFront', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$ChildrenInFront = function (a) {
	return {$: 'ChildrenInFront', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$nearbyElement = F2(
	function (location, elem) {
		return A2(
			$elm$html$Html$div,
			_List_fromArray(
				[
					$elm$html$Html$Attributes$class(
					function () {
						switch (location.$) {
							case 'Above':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.above]));
							case 'Below':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.below]));
							case 'OnRight':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.onRight]));
							case 'OnLeft':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.onLeft]));
							case 'InFront':
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.inFront]));
							default:
								return A2(
									$elm$core$String$join,
									' ',
									_List_fromArray(
										[$mdgriffith$elm_ui$Internal$Style$classes.nearby, $mdgriffith$elm_ui$Internal$Style$classes.single, $mdgriffith$elm_ui$Internal$Style$classes.behind]));
						}
					}())
				]),
			_List_fromArray(
				[
					function () {
					switch (elem.$) {
						case 'Empty':
							return $elm$virtual_dom$VirtualDom$text('');
						case 'Text':
							var str = elem.a;
							return $mdgriffith$elm_ui$Internal$Model$textElement(str);
						case 'Unstyled':
							var html = elem.a;
							return html($mdgriffith$elm_ui$Internal$Model$asEl);
						default:
							var styled = elem.a;
							return A2(styled.html, $mdgriffith$elm_ui$Internal$Model$NoStyleSheet, $mdgriffith$elm_ui$Internal$Model$asEl);
					}
				}()
				]));
	});
var $mdgriffith$elm_ui$Internal$Model$addNearbyElement = F3(
	function (location, elem, existing) {
		var nearby = A2($mdgriffith$elm_ui$Internal$Model$nearbyElement, location, elem);
		switch (existing.$) {
			case 'NoNearbyChildren':
				if (location.$ === 'Behind') {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenBehind(
						_List_fromArray(
							[nearby]));
				} else {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenInFront(
						_List_fromArray(
							[nearby]));
				}
			case 'ChildrenBehind':
				var existingBehind = existing.a;
				if (location.$ === 'Behind') {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenBehind(
						A2($elm$core$List$cons, nearby, existingBehind));
				} else {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						existingBehind,
						_List_fromArray(
							[nearby]));
				}
			case 'ChildrenInFront':
				var existingInFront = existing.a;
				if (location.$ === 'Behind') {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						_List_fromArray(
							[nearby]),
						existingInFront);
				} else {
					return $mdgriffith$elm_ui$Internal$Model$ChildrenInFront(
						A2($elm$core$List$cons, nearby, existingInFront));
				}
			default:
				var existingBehind = existing.a;
				var existingInFront = existing.b;
				if (location.$ === 'Behind') {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						A2($elm$core$List$cons, nearby, existingBehind),
						existingInFront);
				} else {
					return A2(
						$mdgriffith$elm_ui$Internal$Model$ChildrenBehindAndInFront,
						existingBehind,
						A2($elm$core$List$cons, nearby, existingInFront));
				}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$Embedded = F2(
	function (a, b) {
		return {$: 'Embedded', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$NodeName = function (a) {
	return {$: 'NodeName', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$addNodeName = F2(
	function (newNode, old) {
		switch (old.$) {
			case 'Generic':
				return $mdgriffith$elm_ui$Internal$Model$NodeName(newNode);
			case 'NodeName':
				var name = old.a;
				return A2($mdgriffith$elm_ui$Internal$Model$Embedded, name, newNode);
			default:
				var x = old.a;
				var y = old.b;
				return A2($mdgriffith$elm_ui$Internal$Model$Embedded, x, y);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$alignXName = function (align) {
	switch (align.$) {
		case 'Left':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedHorizontally + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignLeft);
		case 'Right':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedHorizontally + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignRight);
		default:
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedHorizontally + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignCenterX);
	}
};
var $mdgriffith$elm_ui$Internal$Model$alignYName = function (align) {
	switch (align.$) {
		case 'Top':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedVertically + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignTop);
		case 'Bottom':
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedVertically + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignBottom);
		default:
			return $mdgriffith$elm_ui$Internal$Style$classes.alignedVertically + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.alignCenterY);
	}
};
var $elm$virtual_dom$VirtualDom$attribute = F2(
	function (key, value) {
		return A2(
			_VirtualDom_attribute,
			_VirtualDom_noOnOrFormAction(key),
			_VirtualDom_noJavaScriptOrHtmlUri(value));
	});
var $mdgriffith$elm_ui$Internal$Model$FullTransform = F4(
	function (a, b, c, d) {
		return {$: 'FullTransform', a: a, b: b, c: c, d: d};
	});
var $mdgriffith$elm_ui$Internal$Model$Moved = function (a) {
	return {$: 'Moved', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$composeTransformation = F2(
	function (transform, component) {
		switch (transform.$) {
			case 'Untransformed':
				switch (component.$) {
					case 'MoveX':
						var x = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(x, 0, 0));
					case 'MoveY':
						var y = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(0, y, 0));
					case 'MoveZ':
						var z = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(0, 0, z));
					case 'MoveXYZ':
						var xyz = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(xyz);
					case 'Rotate':
						var xyz = component.a;
						var angle = component.b;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(0, 0, 0),
							_Utils_Tuple3(1, 1, 1),
							xyz,
							angle);
					default:
						var xyz = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(0, 0, 0),
							xyz,
							_Utils_Tuple3(0, 0, 1),
							0);
				}
			case 'Moved':
				var moved = transform.a;
				var x = moved.a;
				var y = moved.b;
				var z = moved.c;
				switch (component.$) {
					case 'MoveX':
						var newX = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(newX, y, z));
					case 'MoveY':
						var newY = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(x, newY, z));
					case 'MoveZ':
						var newZ = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(
							_Utils_Tuple3(x, y, newZ));
					case 'MoveXYZ':
						var xyz = component.a;
						return $mdgriffith$elm_ui$Internal$Model$Moved(xyz);
					case 'Rotate':
						var xyz = component.a;
						var angle = component.b;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							moved,
							_Utils_Tuple3(1, 1, 1),
							xyz,
							angle);
					default:
						var scale = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							moved,
							scale,
							_Utils_Tuple3(0, 0, 1),
							0);
				}
			default:
				var moved = transform.a;
				var x = moved.a;
				var y = moved.b;
				var z = moved.c;
				var scaled = transform.b;
				var origin = transform.c;
				var angle = transform.d;
				switch (component.$) {
					case 'MoveX':
						var newX = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(newX, y, z),
							scaled,
							origin,
							angle);
					case 'MoveY':
						var newY = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(x, newY, z),
							scaled,
							origin,
							angle);
					case 'MoveZ':
						var newZ = component.a;
						return A4(
							$mdgriffith$elm_ui$Internal$Model$FullTransform,
							_Utils_Tuple3(x, y, newZ),
							scaled,
							origin,
							angle);
					case 'MoveXYZ':
						var newMove = component.a;
						return A4($mdgriffith$elm_ui$Internal$Model$FullTransform, newMove, scaled, origin, angle);
					case 'Rotate':
						var newOrigin = component.a;
						var newAngle = component.b;
						return A4($mdgriffith$elm_ui$Internal$Model$FullTransform, moved, scaled, newOrigin, newAngle);
					default:
						var newScale = component.a;
						return A4($mdgriffith$elm_ui$Internal$Model$FullTransform, moved, newScale, origin, angle);
				}
		}
	});
var $mdgriffith$elm_ui$Internal$Flag$height = $mdgriffith$elm_ui$Internal$Flag$flag(7);
var $mdgriffith$elm_ui$Internal$Flag$heightContent = $mdgriffith$elm_ui$Internal$Flag$flag(36);
var $mdgriffith$elm_ui$Internal$Flag$merge = F2(
	function (_v0, _v1) {
		var one = _v0.a;
		var two = _v0.b;
		var three = _v1.a;
		var four = _v1.b;
		return A2($mdgriffith$elm_ui$Internal$Flag$Field, one | three, two | four);
	});
var $mdgriffith$elm_ui$Internal$Flag$none = A2($mdgriffith$elm_ui$Internal$Flag$Field, 0, 0);
var $mdgriffith$elm_ui$Internal$Model$renderHeight = function (h) {
	switch (h.$) {
		case 'Px':
			var px = h.a;
			var val = $elm$core$String$fromInt(px);
			var name = 'height-px-' + val;
			return _Utils_Tuple3(
				$mdgriffith$elm_ui$Internal$Flag$none,
				$mdgriffith$elm_ui$Internal$Style$classes.heightExact + (' ' + name),
				_List_fromArray(
					[
						A3($mdgriffith$elm_ui$Internal$Model$Single, name, 'height', val + 'px')
					]));
		case 'Content':
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightContent, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.heightContent,
				_List_Nil);
		case 'Fill':
			var portion = h.a;
			return (portion === 1) ? _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.heightFill,
				_List_Nil) : _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.heightFillPortion + (' height-fill-' + $elm$core$String$fromInt(portion)),
				_List_fromArray(
					[
						A3(
						$mdgriffith$elm_ui$Internal$Model$Single,
						$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.column + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
							'height-fill-' + $elm$core$String$fromInt(portion))))),
						'flex-grow',
						$elm$core$String$fromInt(portion * 100000))
					]));
		case 'Min':
			var minSize = h.a;
			var len = h.b;
			var cls = 'min-height-' + $elm$core$String$fromInt(minSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'min-height',
				$elm$core$String$fromInt(minSize) + 'px !important');
			var _v1 = $mdgriffith$elm_ui$Internal$Model$renderHeight(len);
			var newFlag = _v1.a;
			var newAttrs = _v1.b;
			var newStyle = _v1.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
		default:
			var maxSize = h.a;
			var len = h.b;
			var cls = 'max-height-' + $elm$core$String$fromInt(maxSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'max-height',
				$elm$core$String$fromInt(maxSize) + 'px');
			var _v2 = $mdgriffith$elm_ui$Internal$Model$renderHeight(len);
			var newFlag = _v2.a;
			var newAttrs = _v2.b;
			var newStyle = _v2.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$heightBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
	}
};
var $mdgriffith$elm_ui$Internal$Flag$widthContent = $mdgriffith$elm_ui$Internal$Flag$flag(38);
var $mdgriffith$elm_ui$Internal$Model$renderWidth = function (w) {
	switch (w.$) {
		case 'Px':
			var px = w.a;
			return _Utils_Tuple3(
				$mdgriffith$elm_ui$Internal$Flag$none,
				$mdgriffith$elm_ui$Internal$Style$classes.widthExact + (' width-px-' + $elm$core$String$fromInt(px)),
				_List_fromArray(
					[
						A3(
						$mdgriffith$elm_ui$Internal$Model$Single,
						'width-px-' + $elm$core$String$fromInt(px),
						'width',
						$elm$core$String$fromInt(px) + 'px')
					]));
		case 'Content':
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthContent, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.widthContent,
				_List_Nil);
		case 'Fill':
			var portion = w.a;
			return (portion === 1) ? _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.widthFill,
				_List_Nil) : _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthFill, $mdgriffith$elm_ui$Internal$Flag$none),
				$mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion + (' width-fill-' + $elm$core$String$fromInt(portion)),
				_List_fromArray(
					[
						A3(
						$mdgriffith$elm_ui$Internal$Model$Single,
						$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.row + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
							'width-fill-' + $elm$core$String$fromInt(portion))))),
						'flex-grow',
						$elm$core$String$fromInt(portion * 100000))
					]));
		case 'Min':
			var minSize = w.a;
			var len = w.b;
			var cls = 'min-width-' + $elm$core$String$fromInt(minSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'min-width',
				$elm$core$String$fromInt(minSize) + 'px');
			var _v1 = $mdgriffith$elm_ui$Internal$Model$renderWidth(len);
			var newFlag = _v1.a;
			var newAttrs = _v1.b;
			var newStyle = _v1.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
		default:
			var maxSize = w.a;
			var len = w.b;
			var cls = 'max-width-' + $elm$core$String$fromInt(maxSize);
			var style = A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				cls,
				'max-width',
				$elm$core$String$fromInt(maxSize) + 'px');
			var _v2 = $mdgriffith$elm_ui$Internal$Model$renderWidth(len);
			var newFlag = _v2.a;
			var newAttrs = _v2.b;
			var newStyle = _v2.c;
			return _Utils_Tuple3(
				A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$widthBetween, newFlag),
				cls + (' ' + newAttrs),
				A2($elm$core$List$cons, style, newStyle));
	}
};
var $mdgriffith$elm_ui$Internal$Flag$borderWidth = $mdgriffith$elm_ui$Internal$Flag$flag(27);
var $mdgriffith$elm_ui$Internal$Model$skippable = F2(
	function (flag, style) {
		if (_Utils_eq(flag, $mdgriffith$elm_ui$Internal$Flag$borderWidth)) {
			if (style.$ === 'Single') {
				var val = style.c;
				switch (val) {
					case '0px':
						return true;
					case '1px':
						return true;
					case '2px':
						return true;
					case '3px':
						return true;
					case '4px':
						return true;
					case '5px':
						return true;
					case '6px':
						return true;
					default:
						return false;
				}
			} else {
				return false;
			}
		} else {
			switch (style.$) {
				case 'FontSize':
					var i = style.a;
					return (i >= 8) && (i <= 32);
				case 'PaddingStyle':
					var name = style.a;
					var t = style.b;
					var r = style.c;
					var b = style.d;
					var l = style.e;
					return _Utils_eq(t, b) && (_Utils_eq(t, r) && (_Utils_eq(t, l) && ((t >= 0) && (t <= 24))));
				default:
					return false;
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Flag$width = $mdgriffith$elm_ui$Internal$Flag$flag(6);
var $mdgriffith$elm_ui$Internal$Flag$xAlign = $mdgriffith$elm_ui$Internal$Flag$flag(30);
var $mdgriffith$elm_ui$Internal$Flag$yAlign = $mdgriffith$elm_ui$Internal$Flag$flag(29);
var $mdgriffith$elm_ui$Internal$Model$gatherAttrRecursive = F8(
	function (classes, node, has, transform, styles, attrs, children, elementAttrs) {
		gatherAttrRecursive:
		while (true) {
			if (!elementAttrs.b) {
				var _v1 = $mdgriffith$elm_ui$Internal$Model$transformClass(transform);
				if (_v1.$ === 'Nothing') {
					return {
						attributes: A2(
							$elm$core$List$cons,
							$elm$html$Html$Attributes$class(classes),
							attrs),
						children: children,
						has: has,
						node: node,
						styles: styles
					};
				} else {
					var _class = _v1.a;
					return {
						attributes: A2(
							$elm$core$List$cons,
							$elm$html$Html$Attributes$class(classes + (' ' + _class)),
							attrs),
						children: children,
						has: has,
						node: node,
						styles: A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$Transform(transform),
							styles)
					};
				}
			} else {
				var attribute = elementAttrs.a;
				var remaining = elementAttrs.b;
				switch (attribute.$) {
					case 'NoAttribute':
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = has,
							$temp$transform = transform,
							$temp$styles = styles,
							$temp$attrs = attrs,
							$temp$children = children,
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'Class':
						var flag = attribute.a;
						var exactClassName = attribute.b;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, flag, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							var $temp$classes = exactClassName + (' ' + classes),
								$temp$node = node,
								$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						}
					case 'Attr':
						var actualAttribute = attribute.a;
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = has,
							$temp$transform = transform,
							$temp$styles = styles,
							$temp$attrs = A2($elm$core$List$cons, actualAttribute, attrs),
							$temp$children = children,
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'StyleClass':
						var flag = attribute.a;
						var style = attribute.b;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, flag, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							if (A2($mdgriffith$elm_ui$Internal$Model$skippable, flag, style)) {
								var $temp$classes = $mdgriffith$elm_ui$Internal$Model$getStyleName(style) + (' ' + classes),
									$temp$node = node,
									$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							} else {
								var $temp$classes = $mdgriffith$elm_ui$Internal$Model$getStyleName(style) + (' ' + classes),
									$temp$node = node,
									$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
									$temp$transform = transform,
									$temp$styles = A2($elm$core$List$cons, style, styles),
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							}
						}
					case 'TransformComponent':
						var flag = attribute.a;
						var component = attribute.b;
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, flag, has),
							$temp$transform = A2($mdgriffith$elm_ui$Internal$Model$composeTransformation, transform, component),
							$temp$styles = styles,
							$temp$attrs = attrs,
							$temp$children = children,
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'Width':
						var width = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$width, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							switch (width.$) {
								case 'Px':
									var px = width.a;
									var $temp$classes = ($mdgriffith$elm_ui$Internal$Style$classes.widthExact + (' width-px-' + $elm$core$String$fromInt(px))) + (' ' + classes),
										$temp$node = node,
										$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has),
										$temp$transform = transform,
										$temp$styles = A2(
										$elm$core$List$cons,
										A3(
											$mdgriffith$elm_ui$Internal$Model$Single,
											'width-px-' + $elm$core$String$fromInt(px),
											'width',
											$elm$core$String$fromInt(px) + 'px'),
										styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Content':
									var $temp$classes = classes + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.widthContent),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$add,
										$mdgriffith$elm_ui$Internal$Flag$widthContent,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
										$temp$transform = transform,
										$temp$styles = styles,
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Fill':
									var portion = width.a;
									if (portion === 1) {
										var $temp$classes = classes + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.widthFill),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$widthFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									} else {
										var $temp$classes = classes + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.widthFillPortion + (' width-fill-' + $elm$core$String$fromInt(portion)))),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$widthFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
											$temp$transform = transform,
											$temp$styles = A2(
											$elm$core$List$cons,
											A3(
												$mdgriffith$elm_ui$Internal$Model$Single,
												$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.row + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
													'width-fill-' + $elm$core$String$fromInt(portion))))),
												'flex-grow',
												$elm$core$String$fromInt(portion * 100000)),
											styles),
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									}
								default:
									var _v4 = $mdgriffith$elm_ui$Internal$Model$renderWidth(width);
									var addToFlags = _v4.a;
									var newClass = _v4.b;
									var newStyles = _v4.c;
									var $temp$classes = classes + (' ' + newClass),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$merge,
										addToFlags,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$width, has)),
										$temp$transform = transform,
										$temp$styles = _Utils_ap(newStyles, styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
							}
						}
					case 'Height':
						var height = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$height, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							switch (height.$) {
								case 'Px':
									var px = height.a;
									var val = $elm$core$String$fromInt(px) + 'px';
									var name = 'height-px-' + val;
									var $temp$classes = $mdgriffith$elm_ui$Internal$Style$classes.heightExact + (' ' + (name + (' ' + classes))),
										$temp$node = node,
										$temp$has = A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has),
										$temp$transform = transform,
										$temp$styles = A2(
										$elm$core$List$cons,
										A3($mdgriffith$elm_ui$Internal$Model$Single, name, 'height ', val),
										styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Content':
									var $temp$classes = $mdgriffith$elm_ui$Internal$Style$classes.heightContent + (' ' + classes),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$add,
										$mdgriffith$elm_ui$Internal$Flag$heightContent,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
										$temp$transform = transform,
										$temp$styles = styles,
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								case 'Fill':
									var portion = height.a;
									if (portion === 1) {
										var $temp$classes = $mdgriffith$elm_ui$Internal$Style$classes.heightFill + (' ' + classes),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$heightFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									} else {
										var $temp$classes = classes + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.heightFillPortion + (' height-fill-' + $elm$core$String$fromInt(portion)))),
											$temp$node = node,
											$temp$has = A2(
											$mdgriffith$elm_ui$Internal$Flag$add,
											$mdgriffith$elm_ui$Internal$Flag$heightFill,
											A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
											$temp$transform = transform,
											$temp$styles = A2(
											$elm$core$List$cons,
											A3(
												$mdgriffith$elm_ui$Internal$Model$Single,
												$mdgriffith$elm_ui$Internal$Style$classes.any + ('.' + ($mdgriffith$elm_ui$Internal$Style$classes.column + (' > ' + $mdgriffith$elm_ui$Internal$Style$dot(
													'height-fill-' + $elm$core$String$fromInt(portion))))),
												'flex-grow',
												$elm$core$String$fromInt(portion * 100000)),
											styles),
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									}
								default:
									var _v6 = $mdgriffith$elm_ui$Internal$Model$renderHeight(height);
									var addToFlags = _v6.a;
									var newClass = _v6.b;
									var newStyles = _v6.c;
									var $temp$classes = classes + (' ' + newClass),
										$temp$node = node,
										$temp$has = A2(
										$mdgriffith$elm_ui$Internal$Flag$merge,
										addToFlags,
										A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$height, has)),
										$temp$transform = transform,
										$temp$styles = _Utils_ap(newStyles, styles),
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
							}
						}
					case 'Describe':
						var description = attribute.a;
						switch (description.$) {
							case 'Main':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'main', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Navigation':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'nav', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'ContentInfo':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'footer', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Complementary':
								var $temp$classes = classes,
									$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'aside', node),
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Heading':
								var i = description.a;
								if (i <= 1) {
									var $temp$classes = classes,
										$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'h1', node),
										$temp$has = has,
										$temp$transform = transform,
										$temp$styles = styles,
										$temp$attrs = attrs,
										$temp$children = children,
										$temp$elementAttrs = remaining;
									classes = $temp$classes;
									node = $temp$node;
									has = $temp$has;
									transform = $temp$transform;
									styles = $temp$styles;
									attrs = $temp$attrs;
									children = $temp$children;
									elementAttrs = $temp$elementAttrs;
									continue gatherAttrRecursive;
								} else {
									if (i < 7) {
										var $temp$classes = classes,
											$temp$node = A2(
											$mdgriffith$elm_ui$Internal$Model$addNodeName,
											'h' + $elm$core$String$fromInt(i),
											node),
											$temp$has = has,
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									} else {
										var $temp$classes = classes,
											$temp$node = A2($mdgriffith$elm_ui$Internal$Model$addNodeName, 'h6', node),
											$temp$has = has,
											$temp$transform = transform,
											$temp$styles = styles,
											$temp$attrs = attrs,
											$temp$children = children,
											$temp$elementAttrs = remaining;
										classes = $temp$classes;
										node = $temp$node;
										has = $temp$has;
										transform = $temp$transform;
										styles = $temp$styles;
										attrs = $temp$attrs;
										children = $temp$children;
										elementAttrs = $temp$elementAttrs;
										continue gatherAttrRecursive;
									}
								}
							case 'Paragraph':
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = attrs,
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Button':
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'role', 'button'),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'Label':
								var label = description.a;
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'aria-label', label),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							case 'LivePolite':
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'aria-live', 'polite'),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
							default:
								var $temp$classes = classes,
									$temp$node = node,
									$temp$has = has,
									$temp$transform = transform,
									$temp$styles = styles,
									$temp$attrs = A2(
									$elm$core$List$cons,
									A2($elm$virtual_dom$VirtualDom$attribute, 'aria-live', 'assertive'),
									attrs),
									$temp$children = children,
									$temp$elementAttrs = remaining;
								classes = $temp$classes;
								node = $temp$node;
								has = $temp$has;
								transform = $temp$transform;
								styles = $temp$styles;
								attrs = $temp$attrs;
								children = $temp$children;
								elementAttrs = $temp$elementAttrs;
								continue gatherAttrRecursive;
						}
					case 'Nearby':
						var location = attribute.a;
						var elem = attribute.b;
						var newStyles = function () {
							switch (elem.$) {
								case 'Empty':
									return styles;
								case 'Text':
									var str = elem.a;
									return styles;
								case 'Unstyled':
									var html = elem.a;
									return styles;
								default:
									var styled = elem.a;
									return _Utils_ap(styles, styled.styles);
							}
						}();
						var $temp$classes = classes,
							$temp$node = node,
							$temp$has = has,
							$temp$transform = transform,
							$temp$styles = newStyles,
							$temp$attrs = attrs,
							$temp$children = A3($mdgriffith$elm_ui$Internal$Model$addNearbyElement, location, elem, children),
							$temp$elementAttrs = remaining;
						classes = $temp$classes;
						node = $temp$node;
						has = $temp$has;
						transform = $temp$transform;
						styles = $temp$styles;
						attrs = $temp$attrs;
						children = $temp$children;
						elementAttrs = $temp$elementAttrs;
						continue gatherAttrRecursive;
					case 'AlignX':
						var x = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$xAlign, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							var $temp$classes = $mdgriffith$elm_ui$Internal$Model$alignXName(x) + (' ' + classes),
								$temp$node = node,
								$temp$has = function (flags) {
								switch (x.$) {
									case 'CenterX':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$centerX, flags);
									case 'Right':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$alignRight, flags);
									default:
										return flags;
								}
							}(
								A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$xAlign, has)),
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						}
					default:
						var y = attribute.a;
						if (A2($mdgriffith$elm_ui$Internal$Flag$present, $mdgriffith$elm_ui$Internal$Flag$yAlign, has)) {
							var $temp$classes = classes,
								$temp$node = node,
								$temp$has = has,
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						} else {
							var $temp$classes = $mdgriffith$elm_ui$Internal$Model$alignYName(y) + (' ' + classes),
								$temp$node = node,
								$temp$has = function (flags) {
								switch (y.$) {
									case 'CenterY':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$centerY, flags);
									case 'Bottom':
										return A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$alignBottom, flags);
									default:
										return flags;
								}
							}(
								A2($mdgriffith$elm_ui$Internal$Flag$add, $mdgriffith$elm_ui$Internal$Flag$yAlign, has)),
								$temp$transform = transform,
								$temp$styles = styles,
								$temp$attrs = attrs,
								$temp$children = children,
								$temp$elementAttrs = remaining;
							classes = $temp$classes;
							node = $temp$node;
							has = $temp$has;
							transform = $temp$transform;
							styles = $temp$styles;
							attrs = $temp$attrs;
							children = $temp$children;
							elementAttrs = $temp$elementAttrs;
							continue gatherAttrRecursive;
						}
				}
			}
		}
	});
var $mdgriffith$elm_ui$Internal$Model$Untransformed = {$: 'Untransformed'};
var $mdgriffith$elm_ui$Internal$Model$untransformed = $mdgriffith$elm_ui$Internal$Model$Untransformed;
var $mdgriffith$elm_ui$Internal$Model$element = F4(
	function (context, node, attributes, children) {
		return A3(
			$mdgriffith$elm_ui$Internal$Model$createElement,
			context,
			children,
			A8(
				$mdgriffith$elm_ui$Internal$Model$gatherAttrRecursive,
				$mdgriffith$elm_ui$Internal$Model$contextClasses(context),
				node,
				$mdgriffith$elm_ui$Internal$Flag$none,
				$mdgriffith$elm_ui$Internal$Model$untransformed,
				_List_Nil,
				_List_Nil,
				$mdgriffith$elm_ui$Internal$Model$NoNearbyChildren,
				$elm$core$List$reverse(attributes)));
	});
var $mdgriffith$elm_ui$Internal$Model$Height = function (a) {
	return {$: 'Height', a: a};
};
var $mdgriffith$elm_ui$Element$height = $mdgriffith$elm_ui$Internal$Model$Height;
var $mdgriffith$elm_ui$Internal$Model$Attr = function (a) {
	return {$: 'Attr', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$htmlClass = function (cls) {
	return $mdgriffith$elm_ui$Internal$Model$Attr(
		$elm$html$Html$Attributes$class(cls));
};
var $mdgriffith$elm_ui$Internal$Model$Content = {$: 'Content'};
var $mdgriffith$elm_ui$Element$shrink = $mdgriffith$elm_ui$Internal$Model$Content;
var $mdgriffith$elm_ui$Internal$Model$Width = function (a) {
	return {$: 'Width', a: a};
};
var $mdgriffith$elm_ui$Element$width = $mdgriffith$elm_ui$Internal$Model$Width;
var $mdgriffith$elm_ui$Element$column = F2(
	function (attrs, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asColumn,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentTop + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.contentLeft)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
						attrs))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
	});
var $mdgriffith$elm_ui$Internal$Model$Fill = function (a) {
	return {$: 'Fill', a: a};
};
var $mdgriffith$elm_ui$Element$fill = $mdgriffith$elm_ui$Internal$Model$Fill(1);
var $mdgriffith$elm_ui$Internal$Model$FocusStyleOption = function (a) {
	return {$: 'FocusStyleOption', a: a};
};
var $mdgriffith$elm_ui$Element$focusStyle = $mdgriffith$elm_ui$Internal$Model$FocusStyleOption;
var $mdgriffith$elm_ui$Internal$Flag$borderColor = $mdgriffith$elm_ui$Internal$Flag$flag(28);
var $mdgriffith$elm_ui$Element$Border$color = function (clr) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$borderColor,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Colored,
			'bc-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(clr),
			'border-color',
			clr));
};
var $mdgriffith$elm_ui$Element$htmlAttribute = $mdgriffith$elm_ui$Internal$Model$Attr;
var $author$project$R10$Color$Internal$Derived$Border = {$: 'Border'};
var $author$project$R10$Color$AttrsBorder$normal = function (theme) {
	return $mdgriffith$elm_ui$Element$Border$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Border)));
};
var $author$project$R10$Color$Internal$Derived$FontHighEmphasis = {$: 'FontHighEmphasis'};
var $mdgriffith$elm_ui$Internal$Flag$fontColor = $mdgriffith$elm_ui$Internal$Flag$flag(14);
var $mdgriffith$elm_ui$Element$Font$color = function (fontColor) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$fontColor,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Colored,
			'fc-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(fontColor),
			'color',
			fontColor));
};
var $author$project$R10$Color$AttrsFont$normal = function (theme) {
	return $mdgriffith$elm_ui$Element$Font$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$FontHighEmphasis)));
};
var $mdgriffith$elm_ui$Internal$Model$PaddingStyle = F5(
	function (a, b, c, d, e) {
		return {$: 'PaddingStyle', a: a, b: b, c: c, d: d, e: e};
	});
var $mdgriffith$elm_ui$Internal$Flag$padding = $mdgriffith$elm_ui$Internal$Flag$flag(2);
var $mdgriffith$elm_ui$Element$padding = function (x) {
	var f = x;
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$padding,
		A5(
			$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
			'p-' + $elm$core$String$fromInt(x),
			f,
			f,
			f,
			f));
};
var $mdgriffith$elm_ui$Internal$Flag$borderRound = $mdgriffith$elm_ui$Internal$Flag$flag(17);
var $mdgriffith$elm_ui$Element$Border$rounded = function (radius) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$borderRound,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Single,
			'br-' + $elm$core$String$fromInt(radius),
			'border-radius',
			$elm$core$String$fromInt(radius) + 'px'));
};
var $elm$virtual_dom$VirtualDom$style = _VirtualDom_style;
var $elm$html$Html$Attributes$style = $elm$virtual_dom$VirtualDom$style;
var $author$project$R10$Color$Internal$Derived$Surface = {$: 'Surface'};
var $author$project$R10$Color$AttrsBackground$surface = function (theme) {
	return $mdgriffith$elm_ui$Element$Background$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Surface)));
};
var $mdgriffith$elm_ui$Internal$Model$BorderWidth = F5(
	function (a, b, c, d, e) {
		return {$: 'BorderWidth', a: a, b: b, c: c, d: d, e: e};
	});
var $mdgriffith$elm_ui$Element$Border$width = function (v) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$borderWidth,
		A5(
			$mdgriffith$elm_ui$Internal$Model$BorderWidth,
			'b-' + $elm$core$String$fromInt(v),
			v,
			v,
			v,
			v));
};
var $author$project$R10$Card$base = function (theme) {
	return _List_fromArray(
		[
			$author$project$R10$Color$AttrsBackground$surface(theme),
			$author$project$R10$Color$AttrsBorder$normal(theme),
			$author$project$R10$Color$AttrsFont$normal(theme),
			$mdgriffith$elm_ui$Element$Border$rounded(10),
			$mdgriffith$elm_ui$Element$Border$width(1),
			$mdgriffith$elm_ui$Element$Border$color(
			function () {
				var _v0 = theme.mode;
				if (_v0.$ === 'Light') {
					return A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0.1);
				} else {
					return A4($mdgriffith$elm_ui$Element$rgba, 1, 1, 1, 0.08);
				}
			}()),
			$mdgriffith$elm_ui$Element$padding(30),
			$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
			$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
			$mdgriffith$elm_ui$Element$htmlAttribute(
			A2($elm$html$Html$Attributes$style, 'transition', 'background-color 0.8s'))
		]);
};
var $mdgriffith$elm_ui$Element$rgba255 = F4(
	function (red, green, blue, a) {
		return A4($mdgriffith$elm_ui$Internal$Model$Rgba, red / 255, green / 255, blue / 255, a);
	});
var $mdgriffith$elm_ui$Internal$Model$boxShadowClass = function (shadow) {
	return $elm$core$String$concat(
		_List_fromArray(
			[
				shadow.inset ? 'box-inset' : 'box-',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.offset.a) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.offset.b) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.blur) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.size) + 'px',
				$mdgriffith$elm_ui$Internal$Model$formatColorClass(shadow.color)
			]));
};
var $mdgriffith$elm_ui$Internal$Flag$shadows = $mdgriffith$elm_ui$Internal$Flag$flag(19);
var $mdgriffith$elm_ui$Element$Border$shadow = function (almostShade) {
	var shade = {blur: almostShade.blur, color: almostShade.color, inset: false, offset: almostShade.offset, size: almostShade.size};
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$shadows,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Single,
			$mdgriffith$elm_ui$Internal$Model$boxShadowClass(shade),
			'box-shadow',
			$mdgriffith$elm_ui$Internal$Model$formatBoxShadow(shade)));
};
var $author$project$R10$Card$shadow = function (level) {
	return $mdgriffith$elm_ui$Element$Border$shadow(
		{
			blur: level + 2,
			color: A4($mdgriffith$elm_ui$Element$rgba255, 0, 0, 0, 0.07),
			offset: _Utils_Tuple2(0, level),
			size: level - 2
		});
};
var $author$project$R10$Card$high = function (theme) {
	return _Utils_ap(
		$author$project$R10$Card$base(theme),
		_List_fromArray(
			[
				$author$project$R10$Card$shadow(8)
			]));
};
var $mdgriffith$elm_ui$Internal$Model$OnlyDynamic = F2(
	function (a, b) {
		return {$: 'OnlyDynamic', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$StaticRootAndDynamic = F2(
	function (a, b) {
		return {$: 'StaticRootAndDynamic', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$AllowHover = {$: 'AllowHover'};
var $mdgriffith$elm_ui$Internal$Model$Layout = {$: 'Layout'};
var $mdgriffith$elm_ui$Internal$Model$focusDefaultStyle = {
	backgroundColor: $elm$core$Maybe$Nothing,
	borderColor: $elm$core$Maybe$Nothing,
	shadow: $elm$core$Maybe$Just(
		{
			blur: 0,
			color: A4($mdgriffith$elm_ui$Internal$Model$Rgba, 155 / 255, 203 / 255, 1, 1),
			offset: _Utils_Tuple2(0, 0),
			size: 3
		})
};
var $mdgriffith$elm_ui$Internal$Model$optionsToRecord = function (options) {
	var combine = F2(
		function (opt, record) {
			switch (opt.$) {
				case 'HoverOption':
					var hoverable = opt.a;
					var _v4 = record.hover;
					if (_v4.$ === 'Nothing') {
						return _Utils_update(
							record,
							{
								hover: $elm$core$Maybe$Just(hoverable)
							});
					} else {
						return record;
					}
				case 'FocusStyleOption':
					var focusStyle = opt.a;
					var _v5 = record.focus;
					if (_v5.$ === 'Nothing') {
						return _Utils_update(
							record,
							{
								focus: $elm$core$Maybe$Just(focusStyle)
							});
					} else {
						return record;
					}
				default:
					var renderMode = opt.a;
					var _v6 = record.mode;
					if (_v6.$ === 'Nothing') {
						return _Utils_update(
							record,
							{
								mode: $elm$core$Maybe$Just(renderMode)
							});
					} else {
						return record;
					}
			}
		});
	var andFinally = function (record) {
		return {
			focus: function () {
				var _v0 = record.focus;
				if (_v0.$ === 'Nothing') {
					return $mdgriffith$elm_ui$Internal$Model$focusDefaultStyle;
				} else {
					var focusable = _v0.a;
					return focusable;
				}
			}(),
			hover: function () {
				var _v1 = record.hover;
				if (_v1.$ === 'Nothing') {
					return $mdgriffith$elm_ui$Internal$Model$AllowHover;
				} else {
					var hoverable = _v1.a;
					return hoverable;
				}
			}(),
			mode: function () {
				var _v2 = record.mode;
				if (_v2.$ === 'Nothing') {
					return $mdgriffith$elm_ui$Internal$Model$Layout;
				} else {
					var actualMode = _v2.a;
					return actualMode;
				}
			}()
		};
	};
	return andFinally(
		A3(
			$elm$core$List$foldr,
			combine,
			{focus: $elm$core$Maybe$Nothing, hover: $elm$core$Maybe$Nothing, mode: $elm$core$Maybe$Nothing},
			options));
};
var $mdgriffith$elm_ui$Internal$Model$toHtml = F2(
	function (mode, el) {
		switch (el.$) {
			case 'Unstyled':
				var html = el.a;
				return html($mdgriffith$elm_ui$Internal$Model$asEl);
			case 'Styled':
				var styles = el.a.styles;
				var html = el.a.html;
				return A2(
					html,
					mode(styles),
					$mdgriffith$elm_ui$Internal$Model$asEl);
			case 'Text':
				var text = el.a;
				return $mdgriffith$elm_ui$Internal$Model$textElement(text);
			default:
				return $mdgriffith$elm_ui$Internal$Model$textElement('');
		}
	});
var $mdgriffith$elm_ui$Internal$Model$renderRoot = F3(
	function (optionList, attributes, child) {
		var options = $mdgriffith$elm_ui$Internal$Model$optionsToRecord(optionList);
		var embedStyle = function () {
			var _v0 = options.mode;
			if (_v0.$ === 'NoStaticStyleSheet') {
				return $mdgriffith$elm_ui$Internal$Model$OnlyDynamic(options);
			} else {
				return $mdgriffith$elm_ui$Internal$Model$StaticRootAndDynamic(options);
			}
		}();
		return A2(
			$mdgriffith$elm_ui$Internal$Model$toHtml,
			embedStyle,
			A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asEl,
				$mdgriffith$elm_ui$Internal$Model$div,
				attributes,
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(
					_List_fromArray(
						[child]))));
	});
var $mdgriffith$elm_ui$Internal$Model$FontFamily = F2(
	function (a, b) {
		return {$: 'FontFamily', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$FontSize = function (a) {
	return {$: 'FontSize', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$SansSerif = {$: 'SansSerif'};
var $mdgriffith$elm_ui$Internal$Model$Typeface = function (a) {
	return {$: 'Typeface', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$fontFamily = $mdgriffith$elm_ui$Internal$Flag$flag(5);
var $mdgriffith$elm_ui$Internal$Flag$fontSize = $mdgriffith$elm_ui$Internal$Flag$flag(4);
var $elm$core$String$words = _String_words;
var $mdgriffith$elm_ui$Internal$Model$renderFontClassName = F2(
	function (font, current) {
		return _Utils_ap(
			current,
			function () {
				switch (font.$) {
					case 'Serif':
						return 'serif';
					case 'SansSerif':
						return 'sans-serif';
					case 'Monospace':
						return 'monospace';
					case 'Typeface':
						var name = font.a;
						return A2(
							$elm$core$String$join,
							'-',
							$elm$core$String$words(
								$elm$core$String$toLower(name)));
					case 'ImportFont':
						var name = font.a;
						var url = font.b;
						return A2(
							$elm$core$String$join,
							'-',
							$elm$core$String$words(
								$elm$core$String$toLower(name)));
					default:
						var name = font.a.name;
						return A2(
							$elm$core$String$join,
							'-',
							$elm$core$String$words(
								$elm$core$String$toLower(name)));
				}
			}());
	});
var $mdgriffith$elm_ui$Internal$Model$rootStyle = function () {
	var families = _List_fromArray(
		[
			$mdgriffith$elm_ui$Internal$Model$Typeface('Open Sans'),
			$mdgriffith$elm_ui$Internal$Model$Typeface('Helvetica'),
			$mdgriffith$elm_ui$Internal$Model$Typeface('Verdana'),
			$mdgriffith$elm_ui$Internal$Model$SansSerif
		]);
	return _List_fromArray(
		[
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$bgColor,
			A3(
				$mdgriffith$elm_ui$Internal$Model$Colored,
				'bg-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(
					A4($mdgriffith$elm_ui$Internal$Model$Rgba, 1, 1, 1, 0)),
				'background-color',
				A4($mdgriffith$elm_ui$Internal$Model$Rgba, 1, 1, 1, 0))),
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$fontColor,
			A3(
				$mdgriffith$elm_ui$Internal$Model$Colored,
				'fc-' + $mdgriffith$elm_ui$Internal$Model$formatColorClass(
					A4($mdgriffith$elm_ui$Internal$Model$Rgba, 0, 0, 0, 1)),
				'color',
				A4($mdgriffith$elm_ui$Internal$Model$Rgba, 0, 0, 0, 1))),
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$fontSize,
			$mdgriffith$elm_ui$Internal$Model$FontSize(20)),
			A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$fontFamily,
			A2(
				$mdgriffith$elm_ui$Internal$Model$FontFamily,
				A3($elm$core$List$foldl, $mdgriffith$elm_ui$Internal$Model$renderFontClassName, 'font-', families),
				families))
		]);
}();
var $mdgriffith$elm_ui$Element$layoutWith = F3(
	function (_v0, attrs, child) {
		var options = _v0.options;
		return A3(
			$mdgriffith$elm_ui$Internal$Model$renderRoot,
			options,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass(
					A2(
						$elm$core$String$join,
						' ',
						_List_fromArray(
							[$mdgriffith$elm_ui$Internal$Style$classes.root, $mdgriffith$elm_ui$Internal$Style$classes.any, $mdgriffith$elm_ui$Internal$Style$classes.single]))),
				_Utils_ap($mdgriffith$elm_ui$Internal$Model$rootStyle, attrs)),
			child);
	});
var $author$project$R10$Color$Internal$Derived$Logo = {$: 'Logo'};
var $author$project$R10$Color$Svg$logo = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Logo);
};
var $mdgriffith$elm_ui$Internal$Model$Empty = {$: 'Empty'};
var $mdgriffith$elm_ui$Internal$Model$Text = function (a) {
	return {$: 'Text', a: a};
};
var $elm$virtual_dom$VirtualDom$map = _VirtualDom_map;
var $mdgriffith$elm_ui$Internal$Model$map = F2(
	function (fn, el) {
		switch (el.$) {
			case 'Styled':
				var styled = el.a;
				return $mdgriffith$elm_ui$Internal$Model$Styled(
					{
						html: F2(
							function (add, context) {
								return A2(
									$elm$virtual_dom$VirtualDom$map,
									fn,
									A2(styled.html, add, context));
							}),
						styles: styled.styles
					});
			case 'Unstyled':
				var html = el.a;
				return $mdgriffith$elm_ui$Internal$Model$Unstyled(
					A2(
						$elm$core$Basics$composeL,
						$elm$virtual_dom$VirtualDom$map(fn),
						html));
			case 'Text':
				var str = el.a;
				return $mdgriffith$elm_ui$Internal$Model$Text(str);
			default:
				return $mdgriffith$elm_ui$Internal$Model$Empty;
		}
	});
var $mdgriffith$elm_ui$Element$map = $mdgriffith$elm_ui$Internal$Model$map;
var $mdgriffith$elm_ui$Internal$Model$Max = F2(
	function (a, b) {
		return {$: 'Max', a: a, b: b};
	});
var $mdgriffith$elm_ui$Element$maximum = F2(
	function (i, l) {
		return A2($mdgriffith$elm_ui$Internal$Model$Max, i, l);
	});
var $author$project$R10$Form$Msg$Submit = function (a) {
	return {$: 'Submit', a: a};
};
var $author$project$R10$Form$msg = {submit: $author$project$R10$Form$Msg$Submit};
var $mdgriffith$elm_ui$Element$Font$size = function (i) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$fontSize,
		$mdgriffith$elm_ui$Internal$Model$FontSize(i));
};
var $author$project$R10$FontSize$normal = $mdgriffith$elm_ui$Element$Font$size(16);
var $mdgriffith$elm_ui$Internal$Model$Class = F2(
	function (a, b) {
		return {$: 'Class', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$fontAlignment = $mdgriffith$elm_ui$Internal$Flag$flag(12);
var $mdgriffith$elm_ui$Element$Font$center = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$fontAlignment, $mdgriffith$elm_ui$Internal$Style$classes.textCenter);
var $author$project$R10$Button$numberPadding = 18;
var $author$project$R10$Button$transition = $mdgriffith$elm_ui$Element$htmlAttribute(
	A2($elm$html$Html$Attributes$style, 'transition', 'color .2s ease-out, background-color .2s ease-out'));
var $author$project$R10$Button$attrsInCommon = _List_fromArray(
	[
		$mdgriffith$elm_ui$Element$padding($author$project$R10$Button$numberPadding),
		$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
		$author$project$R10$Button$transition,
		$mdgriffith$elm_ui$Element$Border$rounded(5),
		$mdgriffith$elm_ui$Element$Font$center,
		$author$project$R10$FontSize$normal
	]);
var $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimary = {$: 'BackgroundButtonPrimary'};
var $author$project$R10$Color$AttrsBackground$buttonPrimary = function (theme) {
	return $mdgriffith$elm_ui$Element$Background$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimary)));
};
var $author$project$R10$Color$Internal$Derived$FontHighEmphasisWithMaximumContrast = {$: 'FontHighEmphasisWithMaximumContrast'};
var $author$project$R10$Color$AttrsFont$buttonPrimary = function (theme) {
	return $mdgriffith$elm_ui$Element$Font$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$FontHighEmphasisWithMaximumContrast)));
};
var $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimaryOver = {$: 'BackgroundButtonPrimaryOver'};
var $author$project$R10$Color$AttrsBackground$buttonPrimaryOver = function (theme) {
	return $mdgriffith$elm_ui$Element$Background$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimaryOver)));
};
var $mdgriffith$elm_ui$Internal$Model$Focus = {$: 'Focus'};
var $mdgriffith$elm_ui$Internal$Model$PseudoSelector = F2(
	function (a, b) {
		return {$: 'PseudoSelector', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$focus = $mdgriffith$elm_ui$Internal$Flag$flag(31);
var $mdgriffith$elm_ui$Internal$Model$Describe = function (a) {
	return {$: 'Describe', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$Nearby = F2(
	function (a, b) {
		return {$: 'Nearby', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Model$NoAttribute = {$: 'NoAttribute'};
var $mdgriffith$elm_ui$Internal$Model$TransformComponent = F2(
	function (a, b) {
		return {$: 'TransformComponent', a: a, b: b};
	});
var $elm$virtual_dom$VirtualDom$mapAttribute = _VirtualDom_mapAttribute;
var $mdgriffith$elm_ui$Internal$Model$mapAttrFromStyle = F2(
	function (fn, attr) {
		switch (attr.$) {
			case 'NoAttribute':
				return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
			case 'Describe':
				var description = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Describe(description);
			case 'AlignX':
				var x = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$AlignX(x);
			case 'AlignY':
				var y = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$AlignY(y);
			case 'Width':
				var x = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Width(x);
			case 'Height':
				var x = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Height(x);
			case 'Class':
				var x = attr.a;
				var y = attr.b;
				return A2($mdgriffith$elm_ui$Internal$Model$Class, x, y);
			case 'StyleClass':
				var flag = attr.a;
				var style = attr.b;
				return A2($mdgriffith$elm_ui$Internal$Model$StyleClass, flag, style);
			case 'Nearby':
				var location = attr.a;
				var elem = attr.b;
				return A2(
					$mdgriffith$elm_ui$Internal$Model$Nearby,
					location,
					A2($mdgriffith$elm_ui$Internal$Model$map, fn, elem));
			case 'Attr':
				var htmlAttr = attr.a;
				return $mdgriffith$elm_ui$Internal$Model$Attr(
					A2($elm$virtual_dom$VirtualDom$mapAttribute, fn, htmlAttr));
			default:
				var fl = attr.a;
				var trans = attr.b;
				return A2($mdgriffith$elm_ui$Internal$Model$TransformComponent, fl, trans);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$removeNever = function (style) {
	return A2($mdgriffith$elm_ui$Internal$Model$mapAttrFromStyle, $elm$core$Basics$never, style);
};
var $mdgriffith$elm_ui$Internal$Model$unwrapDecsHelper = F2(
	function (attr, _v0) {
		var styles = _v0.a;
		var trans = _v0.b;
		var _v1 = $mdgriffith$elm_ui$Internal$Model$removeNever(attr);
		switch (_v1.$) {
			case 'StyleClass':
				var style = _v1.b;
				return _Utils_Tuple2(
					A2($elm$core$List$cons, style, styles),
					trans);
			case 'TransformComponent':
				var flag = _v1.a;
				var component = _v1.b;
				return _Utils_Tuple2(
					styles,
					A2($mdgriffith$elm_ui$Internal$Model$composeTransformation, trans, component));
			default:
				return _Utils_Tuple2(styles, trans);
		}
	});
var $mdgriffith$elm_ui$Internal$Model$unwrapDecorations = function (attrs) {
	var _v0 = A3(
		$elm$core$List$foldl,
		$mdgriffith$elm_ui$Internal$Model$unwrapDecsHelper,
		_Utils_Tuple2(_List_Nil, $mdgriffith$elm_ui$Internal$Model$Untransformed),
		attrs);
	var styles = _v0.a;
	var transform = _v0.b;
	return A2(
		$elm$core$List$cons,
		$mdgriffith$elm_ui$Internal$Model$Transform(transform),
		styles);
};
var $mdgriffith$elm_ui$Element$focused = function (decs) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$focus,
		A2(
			$mdgriffith$elm_ui$Internal$Model$PseudoSelector,
			$mdgriffith$elm_ui$Internal$Model$Focus,
			$mdgriffith$elm_ui$Internal$Model$unwrapDecorations(decs)));
};
var $mdgriffith$elm_ui$Internal$Model$Hover = {$: 'Hover'};
var $mdgriffith$elm_ui$Internal$Flag$hover = $mdgriffith$elm_ui$Internal$Flag$flag(33);
var $mdgriffith$elm_ui$Element$mouseOver = function (decs) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$hover,
		A2(
			$mdgriffith$elm_ui$Internal$Model$PseudoSelector,
			$mdgriffith$elm_ui$Internal$Model$Hover,
			$mdgriffith$elm_ui$Internal$Model$unwrapDecorations(decs)));
};
var $author$project$R10$Button$attrsPrimary = function (theme) {
	return _Utils_ap(
		$author$project$R10$Button$attrsInCommon,
		_List_fromArray(
			[
				$author$project$R10$Color$AttrsBackground$buttonPrimary(theme),
				$author$project$R10$Color$AttrsFont$buttonPrimary(theme),
				$mdgriffith$elm_ui$Element$mouseOver(
				_List_fromArray(
					[
						$author$project$R10$Color$AttrsBackground$buttonPrimaryOver(theme)
					])),
				$mdgriffith$elm_ui$Element$focused(
				_List_fromArray(
					[
						$author$project$R10$Color$AttrsBackground$buttonPrimaryOver(theme)
					]))
			]));
};
var $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimaryDisabled = {$: 'BackgroundButtonPrimaryDisabled'};
var $author$project$R10$Color$AttrsBackground$buttonPrimaryDisabled = function (theme) {
	return $mdgriffith$elm_ui$Element$Background$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimaryDisabled)));
};
var $author$project$R10$Color$Internal$Derived$FontMediumEmphasisWithMaximumContrast = {$: 'FontMediumEmphasisWithMaximumContrast'};
var $author$project$R10$Color$AttrsFont$buttonPrimaryDisabled = function (theme) {
	return $mdgriffith$elm_ui$Element$Font$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$FontMediumEmphasisWithMaximumContrast)));
};
var $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimaryDisabledOver = {$: 'BackgroundButtonPrimaryDisabledOver'};
var $author$project$R10$Color$AttrsBackground$buttonPrimaryDisabledOver = function (theme) {
	return $mdgriffith$elm_ui$Element$Background$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$BackgroundButtonPrimaryDisabledOver)));
};
var $author$project$R10$Color$AttrsFont$buttonPrimaryDisabledOver = function (theme) {
	return $mdgriffith$elm_ui$Element$Font$color(
		$author$project$R10$Color$Utils$colorToElementColor(
			A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$FontMediumEmphasisWithMaximumContrast)));
};
var $author$project$R10$Button$attrsPrimaryDisabled = function (theme) {
	return _Utils_ap(
		$author$project$R10$Button$attrsInCommon,
		_List_fromArray(
			[
				$author$project$R10$Color$AttrsBackground$buttonPrimaryDisabled(theme),
				$author$project$R10$Color$AttrsFont$buttonPrimaryDisabled(theme),
				$mdgriffith$elm_ui$Element$mouseOver(
				_List_fromArray(
					[
						$author$project$R10$Color$AttrsBackground$buttonPrimaryDisabledOver(theme),
						$author$project$R10$Color$AttrsFont$buttonPrimaryDisabledOver(theme)
					])),
				$mdgriffith$elm_ui$Element$focused(
				_List_fromArray(
					[
						$author$project$R10$Color$AttrsBackground$buttonPrimaryDisabledOver(theme),
						$author$project$R10$Color$AttrsFont$buttonPrimaryDisabledOver(theme)
					])),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'cursor', 'not-allowed'))
			]));
};
var $mdgriffith$elm_ui$Internal$Model$Button = {$: 'Button'};
var $elm$json$Json$Encode$bool = _Json_wrap;
var $elm$html$Html$Attributes$boolProperty = F2(
	function (key, bool) {
		return A2(
			_VirtualDom_property,
			key,
			$elm$json$Json$Encode$bool(bool));
	});
var $elm$html$Html$Attributes$disabled = $elm$html$Html$Attributes$boolProperty('disabled');
var $mdgriffith$elm_ui$Element$Input$enter = 'Enter';
var $mdgriffith$elm_ui$Element$Input$hasFocusStyle = function (attr) {
	if (((attr.$ === 'StyleClass') && (attr.b.$ === 'PseudoSelector')) && (attr.b.a.$ === 'Focus')) {
		var _v1 = attr.b;
		var _v2 = _v1.a;
		return true;
	} else {
		return false;
	}
};
var $mdgriffith$elm_ui$Element$Input$focusDefault = function (attrs) {
	return A2($elm$core$List$any, $mdgriffith$elm_ui$Element$Input$hasFocusStyle, attrs) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Internal$Model$htmlClass('focusable');
};
var $elm$virtual_dom$VirtualDom$Normal = function (a) {
	return {$: 'Normal', a: a};
};
var $elm$virtual_dom$VirtualDom$on = _VirtualDom_on;
var $elm$html$Html$Events$on = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$Normal(decoder));
	});
var $elm$html$Html$Events$onClick = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'click',
		$elm$json$Json$Decode$succeed(msg));
};
var $mdgriffith$elm_ui$Element$Events$onClick = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Events$onClick);
var $elm$json$Json$Decode$andThen = _Json_andThen;
var $elm$json$Json$Decode$fail = _Json_fail;
var $elm$json$Json$Decode$field = _Json_decodeField;
var $elm$virtual_dom$VirtualDom$MayPreventDefault = function (a) {
	return {$: 'MayPreventDefault', a: a};
};
var $elm$html$Html$Events$preventDefaultOn = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$MayPreventDefault(decoder));
	});
var $elm$json$Json$Decode$string = _Json_decodeString;
var $mdgriffith$elm_ui$Element$Input$onKeyLookup = function (lookup) {
	var decode = function (code) {
		var _v0 = lookup(code);
		if (_v0.$ === 'Nothing') {
			return $elm$json$Json$Decode$fail('No key matched');
		} else {
			var msg = _v0.a;
			return $elm$json$Json$Decode$succeed(msg);
		}
	};
	var isKey = A2(
		$elm$json$Json$Decode$andThen,
		decode,
		A2($elm$json$Json$Decode$field, 'key', $elm$json$Json$Decode$string));
	return $mdgriffith$elm_ui$Internal$Model$Attr(
		A2(
			$elm$html$Html$Events$preventDefaultOn,
			'keydown',
			A2(
				$elm$json$Json$Decode$map,
				function (fired) {
					return _Utils_Tuple2(fired, true);
				},
				isKey)));
};
var $mdgriffith$elm_ui$Internal$Flag$cursor = $mdgriffith$elm_ui$Internal$Flag$flag(21);
var $mdgriffith$elm_ui$Element$pointer = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$cursor, $mdgriffith$elm_ui$Internal$Style$classes.cursorPointer);
var $mdgriffith$elm_ui$Element$Input$space = ' ';
var $elm$html$Html$Attributes$tabindex = function (n) {
	return A2(
		_VirtualDom_attribute,
		'tabIndex',
		$elm$core$String$fromInt(n));
};
var $mdgriffith$elm_ui$Element$Input$button = F2(
	function (attrs, _v0) {
		var onPress = _v0.onPress;
		var label = _v0.label;
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentCenterX + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.seButton + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.noTextSelection)))))),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$pointer,
							A2(
								$elm$core$List$cons,
								$mdgriffith$elm_ui$Element$Input$focusDefault(attrs),
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Internal$Model$Describe($mdgriffith$elm_ui$Internal$Model$Button),
									A2(
										$elm$core$List$cons,
										$mdgriffith$elm_ui$Internal$Model$Attr(
											$elm$html$Html$Attributes$tabindex(0)),
										function () {
											if (onPress.$ === 'Nothing') {
												return A2(
													$elm$core$List$cons,
													$mdgriffith$elm_ui$Internal$Model$Attr(
														$elm$html$Html$Attributes$disabled(true)),
													attrs);
											} else {
												var msg = onPress.a;
												return A2(
													$elm$core$List$cons,
													$mdgriffith$elm_ui$Element$Events$onClick(msg),
													A2(
														$elm$core$List$cons,
														$mdgriffith$elm_ui$Element$Input$onKeyLookup(
															function (code) {
																return _Utils_eq(code, $mdgriffith$elm_ui$Element$Input$enter) ? $elm$core$Maybe$Just(msg) : (_Utils_eq(code, $mdgriffith$elm_ui$Element$Input$space) ? $elm$core$Maybe$Just(msg) : $elm$core$Maybe$Nothing);
															}),
														attrs));
											}
										}()))))))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[label])));
	});
var $elm$html$Html$Attributes$href = function (url) {
	return A2(
		$elm$html$Html$Attributes$stringProperty,
		'href',
		_VirtualDom_noJavaScriptUri(url));
};
var $elm$html$Html$Attributes$rel = _VirtualDom_attribute('rel');
var $mdgriffith$elm_ui$Element$link = F2(
	function (attrs, _v0) {
		var url = _v0.url;
		var label = _v0.label;
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$NodeName('a'),
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$Attr(
					$elm$html$Html$Attributes$href(url)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Internal$Model$Attr(
						$elm$html$Html$Attributes$rel('noopener noreferrer')),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
							A2(
								$elm$core$List$cons,
								$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentCenterX + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.link)))),
								attrs))))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[label])));
	});
var $elm$html$Html$Attributes$target = $elm$html$Html$Attributes$stringProperty('target');
var $mdgriffith$elm_ui$Element$newTabLink = F2(
	function (attrs, _v0) {
		var url = _v0.url;
		var label = _v0.label;
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$NodeName('a'),
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$Attr(
					$elm$html$Html$Attributes$href(url)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Internal$Model$Attr(
						$elm$html$Html$Attributes$rel('noopener noreferrer')),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Internal$Model$Attr(
							$elm$html$Html$Attributes$target('_blank')),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
							A2(
								$elm$core$List$cons,
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentCenterX + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.link)))),
									attrs)))))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[label])));
	});
var $author$project$R10$Libu$view = F2(
	function (attrs, args) {
		var _v0 = args.type_;
		switch (_v0.$) {
			case 'Li':
				var url = _v0.a;
				return A2(
					$mdgriffith$elm_ui$Element$link,
					attrs,
					{label: args.label, url: url});
			case 'LiNewTab':
				var url = _v0.a;
				return A2(
					$mdgriffith$elm_ui$Element$newTabLink,
					attrs,
					{label: args.label, url: url});
			case 'LiInternal':
				var url = _v0.a;
				var onClick = _v0.b;
				var preventDefault = function (msg) {
					return A2(
						$elm$html$Html$Events$preventDefaultOn,
						'click',
						$elm$json$Json$Decode$succeed(
							_Utils_Tuple2(msg, true)));
				};
				return A2(
					$mdgriffith$elm_ui$Element$link,
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$htmlAttribute(
							preventDefault(
								onClick(url))),
						attrs),
					{label: args.label, url: url});
			default:
				var onPress = _v0.a;
				return A2(
					$mdgriffith$elm_ui$Element$Input$button,
					attrs,
					{label: args.label, onPress: onPress});
		}
	});
var $author$project$R10$Button$primary = F2(
	function (attrsExtra, data) {
		var attrs = _Utils_eq(
			data.libu,
			$author$project$R10$Libu$Bu($elm$core$Maybe$Nothing)) ? $author$project$R10$Button$attrsPrimaryDisabled : $author$project$R10$Button$attrsPrimary;
		return A2(
			$author$project$R10$Libu$view,
			_Utils_ap(
				attrs(data.theme),
				attrsExtra),
			{label: data.label, type_: data.libu});
	});
var $elm$svg$Svg$Attributes$d = _VirtualDom_attribute('d');
var $elm$svg$Svg$Attributes$fill = _VirtualDom_attribute('fill');
var $elm$svg$Svg$trustedNode = _VirtualDom_nodeNS('http://www.w3.org/2000/svg');
var $elm$svg$Svg$path = $elm$svg$Svg$trustedNode('path');
var $noahzgordon$elm_color_extra$Color$Convert$cssColorString = F2(
	function (kind, values) {
		return kind + ('(' + (A2($elm$core$String$join, ', ', values) + ')'));
	});
var $noahzgordon$elm_color_extra$Color$Convert$colorToCssRgba = function (cl) {
	var _v0 = $avh4$elm_color$Color$toRgba(cl);
	var red = _v0.red;
	var green = _v0.green;
	var blue = _v0.blue;
	var alpha = _v0.alpha;
	return A2(
		$noahzgordon$elm_color_extra$Color$Convert$cssColorString,
		'rgba',
		_List_fromArray(
			[
				$elm$core$String$fromFloat(red * 255),
				$elm$core$String$fromFloat(green * 255),
				$elm$core$String$fromFloat(blue * 255),
				$elm$core$String$fromFloat(alpha)
			]));
};
var $author$project$R10$Color$Utils$toHex = $noahzgordon$elm_color_extra$Color$Convert$colorToCssRgba;
var $mdgriffith$elm_ui$Element$el = F2(
	function (attrs, child) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
					attrs)),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[child])));
	});
var $mdgriffith$elm_ui$Internal$Model$unstyled = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Unstyled, $elm$core$Basics$always);
var $mdgriffith$elm_ui$Element$html = $mdgriffith$elm_ui$Internal$Model$unstyled;
var $elm$html$Html$Attributes$attribute = $elm$virtual_dom$VirtualDom$attribute;
var $elm$svg$Svg$Attributes$preserveAspectRatio = _VirtualDom_attribute('preserveAspectRatio');
var $elm$svg$Svg$svg = $elm$svg$Svg$trustedNode('svg');
var $elm$svg$Svg$Attributes$height = _VirtualDom_attribute('height');
var $elm$core$Maybe$map4 = F5(
	function (func, ma, mb, mc, md) {
		if (ma.$ === 'Nothing') {
			return $elm$core$Maybe$Nothing;
		} else {
			var a = ma.a;
			if (mb.$ === 'Nothing') {
				return $elm$core$Maybe$Nothing;
			} else {
				var b = mb.a;
				if (mc.$ === 'Nothing') {
					return $elm$core$Maybe$Nothing;
				} else {
					var c = mc.a;
					if (md.$ === 'Nothing') {
						return $elm$core$Maybe$Nothing;
					} else {
						var d = md.a;
						return $elm$core$Maybe$Just(
							A4(func, a, b, c, d));
					}
				}
			}
		}
	});
var $elm$core$String$toFloat = _String_toFloat;
var $elm$svg$Svg$Attributes$width = _VirtualDom_attribute('width');
var $author$project$R10$Svg$Utils$svgSize_ = F2(
	function (viewbox, ySize) {
		var _v0 = A2($elm$core$String$split, ' ', viewbox);
		if ((((_v0.b && _v0.b.b) && _v0.b.b.b) && _v0.b.b.b.b) && (!_v0.b.b.b.b.b)) {
			var x = _v0.a;
			var _v1 = _v0.b;
			var y = _v1.a;
			var _v2 = _v1.b;
			var dx = _v2.a;
			var _v3 = _v2.b;
			var dy = _v3.a;
			return A2(
				$elm$core$Maybe$withDefault,
				_List_fromArray(
					[
						$elm$svg$Svg$Attributes$height(
						$elm$core$String$fromInt(ySize))
					]),
				A5(
					$elm$core$Maybe$map4,
					F4(
						function (_v4, _v5, dx_, dy_) {
							var xSize = (dx_ * ySize) / dy_;
							return _List_fromArray(
								[
									$elm$svg$Svg$Attributes$height(
									$elm$core$String$fromInt(ySize)),
									$elm$svg$Svg$Attributes$width(
									$elm$core$String$fromFloat(xSize))
								]);
						}),
					$elm$core$String$toFloat(x),
					$elm$core$String$toFloat(y),
					$elm$core$String$toFloat(dx),
					$elm$core$String$toFloat(dy)));
		} else {
			return _List_fromArray(
				[
					$elm$svg$Svg$Attributes$height(
					$elm$core$String$fromInt(ySize))
				]);
		}
	});
var $elm$svg$Svg$Attributes$version = _VirtualDom_attribute('version');
var $elm$svg$Svg$Attributes$viewBox = _VirtualDom_attribute('viewBox');
var $author$project$R10$Svg$Utils$wrapperWithViewbox_ = F3(
	function (viewbox, ySize, listSvg) {
		return A2(
			$elm$svg$Svg$svg,
			_Utils_ap(
				_List_fromArray(
					[
						A2($elm$html$Html$Attributes$attribute, 'xmlns', 'http://www.w3.org/2000/svg'),
						A2($elm$html$Html$Attributes$attribute, 'xmlns:xlink', 'http://www.w3.org/1999/xlink'),
						$elm$svg$Svg$Attributes$version('1.1'),
						$elm$svg$Svg$Attributes$preserveAspectRatio('xMinYMin slice'),
						$elm$svg$Svg$Attributes$viewBox(viewbox),
						A2($elm$html$Html$Attributes$attribute, 'focusable', 'false')
					]),
				A2($author$project$R10$Svg$Utils$svgSize_, viewbox, ySize)),
			listSvg);
	});
var $author$project$R10$Svg$Utils$wrapperWithViewbox = F4(
	function (attrs, viewbox, size, listSvg) {
		return A2(
			$mdgriffith$elm_ui$Element$el,
			attrs,
			$mdgriffith$elm_ui$Element$html(
				A3($author$project$R10$Svg$Utils$wrapperWithViewbox_, viewbox, size, listSvg)));
	});
var $author$project$R10$Svg$Logos$rakuten = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 166 50',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M41.2 49.4l92.3-8H33.2l8 8zm1.3-14.3v1.2h6.2V9.1h-6.2v1.2a10 10 0 0 0-5.8-1.9c-7 0-12.4 6.4-12.4 14.3S29.6 37 36.7 37c2.3 0 4-.7 5.8-1.9zM30.7 22.7c0-4.3 2.5-7.7 6-7.7s5.9 3.4 5.9 7.7c0 4.3-2.5 7.7-5.9 7.7-3.5 0-6-3.4-6-7.7zm56 14.3c3 0 5.3-1.7 5.3-1.7v1h6.2V9.1H92v16c0 3-2.1 5.5-5.1 5.5s-5.1-2.5-5.1-5.5v-16h-6.2v16c0 6.6 4.5 11.9 11.1 11.9zm68.2-28.6c-3 0-5.3 1.7-5.3 1.7v-1h-6.2v27.2h6.2v-16c0-3 2.1-5.5 5.1-5.5s5.1 2.5 5.1 5.5v16h6.2v-16c0-6.6-4.5-11.9-11.1-11.9zM22.4 14c0-6.5-5.3-11.7-11.7-11.7H0v34h6.5V25.8h4.6L19 36.3h8.1l-9.6-12.7c3-2.1 4.9-5.6 4.9-9.6zm-11.7 5.3H6.5V8.7h4.2c2.9 0 5.3 2.4 5.3 5.3s-2.4 5.3-5.3 5.3zm92.9 8c0 6.1 4.6 9.7 9.2 9.7a13 13 0 0 0 6-1.7l-4-5.4c-.6.4-1.3.7-2.1.7-1 0-2.9-.8-2.9-3.3V15.6h5.3V9.1h-5.3V2.3h-6.2v6.8h-3.3v6.5h3.3v11.7zm-45.1-2.2l9.2 11.2h8.6L64 21.8 74.6 9.1H66l-7.5 9.5V0h-6.3v36.3h6.3V25.1zm70.6-16.7c-7.2 0-12.3 6.3-12.3 14.3 0 8.4 6.4 14.3 12.9 14.3 3.3 0 7.4-1.1 10.9-6.1l-5.5-3.2c-4.2 6.2-11.3 3.1-12.1-3.2h17.8c1.7-9.7-4.7-16.1-11.7-16.1zm-5.7 10.8c1.3-6.4 9.9-6.8 11.1 0h-11.1z')
						]),
					_List_Nil)
				]));
	});
var $mdgriffith$elm_ui$Internal$Model$SpacingStyle = F3(
	function (a, b, c) {
		return {$: 'SpacingStyle', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Flag$spacing = $mdgriffith$elm_ui$Internal$Flag$flag(3);
var $mdgriffith$elm_ui$Internal$Model$spacingName = F2(
	function (x, y) {
		return 'spacing-' + ($elm$core$String$fromInt(x) + ('-' + $elm$core$String$fromInt(y)));
	});
var $mdgriffith$elm_ui$Element$spacing = function (x) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$spacing,
		A3(
			$mdgriffith$elm_ui$Internal$Model$SpacingStyle,
			A2($mdgriffith$elm_ui$Internal$Model$spacingName, x, x),
			x,
			x));
};
var $author$project$R10$FormComponents$Style$Filled = {$: 'Filled'};
var $author$project$R10$FormComponents$Style$Outlined = {$: 'Outlined'};
var $author$project$R10$Form$style = {filled: $author$project$R10$FormComponents$Style$Filled, outlined: $author$project$R10$FormComponents$Style$Outlined};
var $mdgriffith$elm_ui$Element$text = function (content) {
	return $mdgriffith$elm_ui$Internal$Model$Text(content);
};
var $author$project$R10$Mode$Light = {$: 'Light'};
var $author$project$R10$Color$Internal$Primary$Blue = {$: 'Blue'};
var $author$project$R10$Color$Internal$Primary$BlueSky = {$: 'BlueSky'};
var $author$project$R10$Color$Internal$Primary$CrimsonRed = {$: 'CrimsonRed'};
var $author$project$R10$Color$Internal$Primary$Green = {$: 'Green'};
var $author$project$R10$Color$Internal$Primary$Orange = {$: 'Orange'};
var $author$project$R10$Color$Internal$Primary$Pink = {$: 'Pink'};
var $author$project$R10$Color$Internal$Primary$Purple = {$: 'Purple'};
var $author$project$R10$Color$Internal$Primary$Yellow = {$: 'Yellow'};
var $author$project$R10$Color$primary = {blue: $author$project$R10$Color$Internal$Primary$Blue, blueSky: $author$project$R10$Color$Internal$Primary$BlueSky, crimsonRed: $author$project$R10$Color$Internal$Primary$CrimsonRed, green: $author$project$R10$Color$Internal$Primary$Green, lightBlue: $author$project$R10$Color$Internal$Primary$LightBlue, orange: $author$project$R10$Color$Internal$Primary$Orange, pink: $author$project$R10$Color$Internal$Primary$Pink, purple: $author$project$R10$Color$Internal$Primary$Purple, red: $author$project$R10$Color$Internal$Primary$CrimsonRed, yellow: $author$project$R10$Color$Internal$Primary$Yellow};
var $author$project$Main$theme = {mode: $author$project$R10$Mode$Light, primaryColor: $author$project$R10$Color$primary.pink};
var $author$project$R10$Color$Svg$background = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Background);
};
var $author$project$R10$Color$Internal$Derived$Error = {$: 'Error'};
var $author$project$R10$Color$Svg$error = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Error);
};
var $author$project$R10$Color$Svg$fontButtonPrimary = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$FontHighEmphasisWithMaximumContrast);
};
var $author$project$R10$Color$Svg$fontNormal = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$FontHighEmphasis);
};
var $author$project$R10$Color$Internal$Derived$Primary = {$: 'Primary'};
var $author$project$R10$Color$Svg$primary = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Primary);
};
var $author$project$R10$Color$Internal$Derived$PrimaryVariant = {$: 'PrimaryVariant'};
var $author$project$R10$Color$Svg$primaryVariant = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$PrimaryVariant);
};
var $author$project$R10$Color$Internal$Derived$Success = {$: 'Success'};
var $author$project$R10$Color$Svg$success = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Success);
};
var $author$project$R10$Color$Svg$surface = function (theme) {
	return A2($author$project$R10$Color$Internal$Derived$toColor, theme, $author$project$R10$Color$Internal$Derived$Surface);
};
var $author$project$R10$FormComponents$UI$Palette$fromTheme = function (theme) {
	return {
		background: $author$project$R10$Color$Svg$background(theme),
		error: $author$project$R10$Color$Svg$error(theme),
		onPrimary: $author$project$R10$Color$Svg$fontButtonPrimary(theme),
		onSurface: $author$project$R10$Color$Svg$fontNormal(theme),
		primary: $author$project$R10$Color$Svg$primary(theme),
		primaryVariant: $author$project$R10$Color$Svg$primaryVariant(theme),
		success: $author$project$R10$Color$Svg$success(theme),
		surface: $author$project$R10$Color$Svg$surface(theme)
	};
};
var $author$project$R10$Form$themeToPalette = $author$project$R10$FormComponents$UI$Palette$fromTheme;
var $mdgriffith$elm_ui$Internal$Model$Bottom = {$: 'Bottom'};
var $mdgriffith$elm_ui$Element$alignBottom = $mdgriffith$elm_ui$Internal$Model$AlignY($mdgriffith$elm_ui$Internal$Model$Bottom);
var $mdgriffith$elm_ui$Internal$Model$Right = {$: 'Right'};
var $mdgriffith$elm_ui$Element$alignRight = $mdgriffith$elm_ui$Internal$Model$AlignX($mdgriffith$elm_ui$Internal$Model$Right);
var $mdgriffith$elm_ui$Internal$Model$Top = {$: 'Top'};
var $mdgriffith$elm_ui$Element$alignTop = $mdgriffith$elm_ui$Internal$Model$AlignY($mdgriffith$elm_ui$Internal$Model$Top);
var $author$project$Main$backgroundImage = 'data:image/jpeg;base64,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';
var $mdgriffith$elm_ui$Internal$Flag$overflow = $mdgriffith$elm_ui$Internal$Flag$flag(20);
var $mdgriffith$elm_ui$Element$clip = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.clip);
var $author$project$R10$Form$Internal$Helpers$getField = F2(
	function (key, formState) {
		return A2($elm$core$Dict$get, key, formState.fieldsState);
	});
var $author$project$R10$Form$Internal$Helpers$getFieldValue = F2(
	function (key, formState) {
		return A2(
			$elm$core$Maybe$map,
			function ($) {
				return $.value;
			},
			A2($author$project$R10$Form$Internal$Helpers$getField, key, formState));
	});
var $author$project$R10$Form$getFieldValue = $author$project$R10$Form$Internal$Helpers$getFieldValue;
var $mdgriffith$elm_ui$Element$Font$family = function (families) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$fontFamily,
		A2(
			$mdgriffith$elm_ui$Internal$Model$FontFamily,
			A3($elm$core$List$foldl, $mdgriffith$elm_ui$Internal$Model$renderFontClassName, 'ff-', families),
			families));
};
var $mdgriffith$elm_ui$Element$Font$sansSerif = $mdgriffith$elm_ui$Internal$Model$SansSerif;
var $mdgriffith$elm_ui$Element$Font$typeface = $mdgriffith$elm_ui$Internal$Model$Typeface;
var $author$project$Main$textEmbossedCreditCard = F2(
	function (attrs, string) {
		var shadow = F3(
			function (x, y, color) {
				return A2(
					$elm$core$String$join,
					'',
					_List_fromArray(
						[
							$elm$core$String$fromInt(x),
							'px ',
							$elm$core$String$fromInt(y),
							'px ',
							'1px ',
							color
						]));
			});
		var colorRight = 'rgba(255, 127, 50, 1)';
		var colorLeft = 'rgba(255, 0, 0, 1)';
		var colorBelow = 'rgba(255, 255, 220, 1)';
		var colorAbove = 'rgba(0, 0, 255, 0.7)';
		var shodowCSS = A2(
			$elm$core$String$join,
			', ',
			_List_fromArray(
				[
					A3(shadow, 0, 1, colorBelow),
					A3(shadow, 1, 0, colorRight),
					A3(shadow, 0, -1, colorAbove),
					A3(shadow, -1, 0, colorLeft)
				]));
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'letter-spacing', '0px')),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'text-shadow', shodowCSS)),
						$mdgriffith$elm_ui$Element$Font$family(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$typeface('OCRA'),
								$mdgriffith$elm_ui$Element$Font$sansSerif
							])),
						$mdgriffith$elm_ui$Element$Font$size(18),
						$mdgriffith$elm_ui$Element$Font$color(
						A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0))
					]),
				attrs),
			$mdgriffith$elm_ui$Element$text(string));
	});
var $elm$core$String$toUpper = _String_toUpper;
var $author$project$Main$embossedValue = F4(
	function (formState, attrs, id, _default) {
		var defaultIfEmpty = function (string) {
			return $elm$core$String$isEmpty(string) ? _default : string;
		};
		return A2(
			$author$project$Main$textEmbossedCreditCard,
			attrs,
			$elm$core$String$toUpper(
				defaultIfEmpty(
					A2(
						$elm$core$Maybe$withDefault,
						_default,
						A2($author$project$R10$Form$getFieldValue, id, formState)))));
	});
var $elm$html$Html$Attributes$alt = $elm$html$Html$Attributes$stringProperty('alt');
var $elm$html$Html$Attributes$src = function (url) {
	return A2(
		$elm$html$Html$Attributes$stringProperty,
		'src',
		_VirtualDom_noJavaScriptOrHtmlUri(url));
};
var $mdgriffith$elm_ui$Element$image = F2(
	function (attrs, _v0) {
		var src = _v0.src;
		var description = _v0.description;
		var imageAttributes = A2(
			$elm$core$List$filter,
			function (a) {
				switch (a.$) {
					case 'Width':
						return true;
					case 'Height':
						return true;
					default:
						return false;
				}
			},
			attrs);
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.imageContainer),
				attrs),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(
				_List_fromArray(
					[
						A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asEl,
						$mdgriffith$elm_ui$Internal$Model$NodeName('img'),
						_Utils_ap(
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Internal$Model$Attr(
									$elm$html$Html$Attributes$src(src)),
									$mdgriffith$elm_ui$Internal$Model$Attr(
									$elm$html$Html$Attributes$alt(description))
								]),
							imageAttributes),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(_List_Nil))
					])));
	});
var $mdgriffith$elm_ui$Element$Background$image = function (src) {
	return $mdgriffith$elm_ui$Internal$Model$Attr(
		A2($elm$virtual_dom$VirtualDom$style, 'background', 'url(\"' + (src + '\") center / cover no-repeat')));
};
var $author$project$Main$logoAmericanExpress = function () {
	var color = 'fff';
	return 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' style=\'filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))\' viewBox=\'0 0 460 174\'%3E%3Cpath fill=\'none\' d=\'M-1-1h442v156H-1z\'/%3E%3Cg%3E%3Cg fill=\'%23' + (color + '\'%3E%3Cpath d=\'M38.7 38.3H54l-7.7-19.5zM120 103.7v9h25.8v9.7H120v10.5h28.5l13.3-14.6-12.6-14.6zM321 18.8l-8.4 19.5h16zM194.4 138.4V98.8l-18 19.5zM228.5 110c-.7-4.2-3.5-6.3-7.6-6.3h-14.6v12.5h15.3c4.1 0 7-2.1 7-6.3zM277.2 114.8c1.4-.7 2-2.8 2-4.9.8-2.7-.6-4.1-2-4.8-1.4-.7-3.5-.7-5.6-.7h-13.9v11.1h14c2 0 4 0 5.5-.7z\'/%3E%3Cpath d=\'M377.3.8V9L373.1.8h-32.6V9L336.3.8h-44.5c-7.7 0-14 1.4-19.5 4.1V.8H241v4.1A20 20 0 00227.8.8h-112L108.3 18 100.6.8H65V9L61.6.8H31L17.1 33.4 1.1 69l-.3.7H37l.3-.7 4.2-10.4h9l4.2 11.1H95V61.3l3.5 8.3h20.1l3.5-8.3V69.6h96.7v-18h1.4c1.4 0 1.4 0 1.4 2V69h50v-4.2c4.2 2.1 10.4 4.2 18.8 4.2h20.9l4.1-11.1h9.8l4.1 11.1h40.4V58.5l6.2 10.4h32.7V.8h-31.3zM141.6 59.2h-11.1V21l-.7 1.5-16.2 36.7h-10.2L86.6 20.9v38.3H63l-4.9-10.5H34.5l-4.9 10.5H17.4L38 10.5h17.4l19.4 46.6V10.5h18.5l.3.7 8.8 19 6.3 14.4.2-.7 14-33.4h18.7v48.7zm48-38.3h-27.2v9H189v9.8h-26.5v9.7h27.2V60h-39V10.5h39v10.4zm49.6 18l.7.8c1.3 1.8 2.4 4.4 2.5 8.2v11.3H232v-5.6c0-2.8 0-7-2.1-9.7-.7-.7-1.3-1.1-2-1.4-1-.7-3-.7-6.3-.7H209v17.4h-11.8V10.5h26.4c6.3 0 10.5 0 14 2 3.4 2.1 5.4 5.5 5.5 10.9-.2 7.4-5 11.5-8.3 12.8 0 0 2.3.5 4.4 2.7zm23.4 20.3h-11.8V10.5h11.8v48.7zm135.6 0h-15.3l-22.3-36.9v36.9H337l-4.2-10.5h-24.3L304.3 60H291c-5.6 0-12.5-1.4-16.7-5.6-4.2-4.2-6.3-9.7-6.3-18.8 0-7 1.4-13.9 6.3-19.4 3.5-4.2 9.7-5.6 17.4-5.6h11.1v10.4h-11.1c-4.2 0-6.3.7-9 2.8-2.1 2.1-3.5 6.3-3.5 11.1 0 5.6.7 9 3.4 11.9 2.1 2 5 2.7 8.4 2.7h4.9l16-38.2h17.3l19.5 46.6V11.2h17.4l20.1 34v-34h11.9v48z\'/%3E%3Cpath d=\'M229.2 30.8c.3-.2.4-.5.6-.8.6-1 1.3-2.8 1-5.2l-.2-.7V24c-.3-1.2-1.2-2-2-2.4-1.5-.7-3.6-.7-5.7-.7H209v11.2h14c2 0 4.1 0 5.5-.7l.6-.5.1-.1zM439.2 128.7c0-4.9-1.4-9.7-3.5-13.2V82.2h-33.5c-4.3 0-9.6 4-9.6 4v-4h-32c-4.8 0-11.1 1.3-13.9 4v-4h-57v4c-4.2-3.4-11.8-4-15.3-4h-37.6v4c-3.4-3.4-11.8-4-16-4h-41.7l-9.7 10.3-9-10.4H97.7v70.2H159l10-10 8.7 10H216.7v-15.9h3.5c4.8 0 11 0 16-2.1V153h31.2v-18h1.4c2.1 0 2.1 0 2.1 2v16h94.6c6.2 0 12.5-1.3 16-4.1v4.1h29.9c6.2 0 12.5-.7 16.7-3.4a23.4 23.4 0 0011-18.8v-.7-1.4zm-219-4.2h-14v18.1h-22.8l-13.3-15.3-.7-.7-15.3 16h-44.5V94h45.2l12.3 13.6 2.6 2.8.4-.4 14.6-16h36.9c7.1 0 15.1 1.8 18.1 9 .4 1.5.6 3.1.6 5 0 13.9-9.7 16.6-20.1 16.6zm69.5-.7c1.4 2.1 2 5 2 9v9.8H280v-6.2c0-2.8 0-7.7-2.1-9.8-1.4-2-4.2-2-8.4-2H257v18h-11.8V93.2h26.4c5.6 0 10.4 0 14 2.1 3.4 2.1 6.2 5.6 6.2 11.2 0 7.6-4.9 11.8-8.4 13.2 3.5 1.4 5.6 2.7 6.3 4.1zm48-20.1h-27.1v9H337v9.7h-26.4v9.8h27v10.4h-38.9V93.2h39v10.5zm29.2 39h-22.3v-10.5H367c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-7 4.2-14.6 16.7-14.6h23v11.8h-21.6c-2 0-3.5 0-4.9.7-1.3.7-1.3 2-1.3 3.4 0 2.1 1.3 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c6.2 0 10.4 1.4 13.2 4.2 2 2 3.5 5.6 3.5 10.4 0 10.4-6.3 15.3-18.1 15.3zm59.8-5c-2.8 2.8-7.7 5-14.6 5h-22.3v-10.5h22.3c2 0 3.5 0 4.8-1.4.7-.7 1.4-2 1.4-3.5 0-1.4-.7-2.8-1.4-3.5-.7-.7-2-1.3-4.1-1.3-11.2-.7-24.4 0-24.4-15.3 0-6.7 3.8-12.6 13.1-14.4a26 26 0 013.6-.2h23v11.8H406.5c-2 0-3.5 0-4.9.7-.7.7-1.3 2-1.3 3.4 0 2.1.6 2.8 2.7 3.5 1.4.7 2.8.7 4.2.7h6.3c3 0 5.3.4 7.4 1.1a15 15 0 019.7 11c.2.8.2 1.6.2 2.5 0 4.2-1.3 7.7-4.1 10.4z\'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E');
}();
var $author$project$Main$logoMasterCard = function () {
	var color = 'fff';
	return 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' style=\'filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))\' viewBox=\'0 0 1050 826\'%3E%3Cpath fill=\'%23' + (color + '\' d=\'M182 774v-51c0-20-12-33-33-33-10 0-21 4-29 15-6-10-14-15-27-15-9 0-17 3-24 12v-10H51v82h18v-45c0-15 7-22 19-22s18 8 18 22v45h18v-45c0-15 9-22 20-22 12 0 18 8 18 22v45h20zm267-82h-29v-25h-18v25h-17v16h17v38c0 19 7 30 28 30 8 0 16-3 22-6l-5-15c-5 3-11 4-15 4-9 0-12-5-12-14v-37h29v-16zm153-2c-11 0-17 5-22 12v-10h-18v82h18v-46c0-14 6-22 17-22l12 2 5-17-12-1zm-231 9c-9-6-21-9-34-9-20 0-34 10-34 27 0 13 10 21 28 24l9 1c9 1 15 4 15 8 0 6-7 11-19 11s-22-5-28-9l-8 14c9 7 22 10 35 10 24 0 38-11 38-27 0-14-12-22-29-25h-8c-8-1-14-3-14-8 0-6 6-10 15-10 11 0 21 5 26 7l8-14zm479-9c-11 0-17 5-22 12v-10h-18v82h18v-46c0-14 6-22 18-22l11 2 5-17-12-1zm-230 43c0 25 17 43 44 43 12 0 20-3 29-9l-9-15c-7 5-14 8-21 8-15 0-25-11-25-27 0-15 10-26 25-27 7 0 14 3 21 8l9-14c-9-7-17-10-29-10-27 0-44 18-44 43zm166 0v-41h-18v10c-6-8-14-12-26-12-23 0-41 18-41 43s18 43 41 43c13 0 21-4 26-12v10h18v-41zm-66 0c0-15 10-27 25-27s25 12 25 27-10 27-25 27c-15-1-25-12-25-27zm-215-43c-24 0-41 17-41 43s17 43 42 43c12 0 24-3 33-11l-9-13c-6 5-15 9-24 9-11 0-22-6-24-20h60v-7c1-27-14-44-37-44zm0 16c11 0 19 6 20 19h-43c2-11 10-19 23-19zm447 27v-74h-18v43c-6-8-15-12-26-12-23 0-41 18-41 43s18 43 41 43c12 0 21-4 26-12v10h18v-41zm-66 0c0-15 9-27 25-27 14 0 25 12 25 27s-11 27-25 27c-16-1-25-12-25-27zm-603 0v-41h-18v10c-6-8-14-12-26-12-23 0-41 18-41 43s18 43 41 43c13 0 21-4 26-12v10h18v-41zm-67 0c0-15 10-27 25-27s25 12 25 27-10 27-25 27c-15-1-25-12-25-27z\'/%3E%3Cpath fill=\'%23ff5f00\' d=\'M363 70h270v485H363z\' class=\'st1\'/%3E%3Cpath fill=\'%23eb001b\' d=\'M382 309c0-99 46-186 118-243a309 309 0 100 486 309 309 0 01-118-243z\' class=\'st2\'/%3E%3Cpath fill=\'%23f79e1b\' d=\'M1000 309a309 309 0 01-500 243 310 310 0 000-486 309 309 0 01500 243z\' class=\'st3\'/%3E%3C/svg%3E');
}();
var $author$project$Main$logoVisa = function () {
	var color2 = 'fff';
	var color1 = 'fff';
	return 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' style=\'filter: drop-shadow( 3px 3px 2px rgba(0, 0, 0, .5))\' viewBox=\'0 0 1050 374\'%3E%3Cpath fill=\'%23' + (color1 + ('\' d=\'M433 320h-80L402 6h84zM727 13c-16-6-41-13-73-13-80 0-136 43-136 104-1 45 40 70 71 85s42 25 42 39c-1 21-26 30-49 30-32 0-50-5-76-16l-11-5-11 70c19 9 54 16 90 17 85 0 141-42 141-107 1-36-21-63-68-86-28-14-45-24-45-38s14-27 46-27c27-1 46 5 61 12l7 3 11-68zM835 208l32-88 11-30 5 27 19 91h-67zM935 6h-63c-19 0-34 5-42 26L709 319h85l17-47h104l10 47h75L935 6zM285 6l-80 213-8-43C182 126 136 72 85 45l72 274h86L370 6h-85z\'/%3E%3Cpath fill=\'%23' + (color2 + '\' d=\'M132 6H1l-1 6c102 26 169 89 197 164L168 32c-4-20-19-26-36-26z\'/%3E%3C/svg%3E')));
}();
var $elm$core$Basics$modBy = _Basics_modBy;
var $author$project$Main$logoCreaditCard = function (formState) {
	var counter = A2(
		$elm$core$Basics$modBy,
		3,
		$elm$core$String$length(
			A2(
				$elm$core$Maybe$withDefault,
				'',
				A2($author$project$R10$Form$getFieldValue, 'cardNumber', formState))));
	switch (counter) {
		case 0:
			return {height: 40, src: $author$project$Main$logoVisa};
		case 1:
			return {height: 80, src: $author$project$Main$logoMasterCard};
		default:
			return {height: 60, src: $author$project$Main$logoAmericanExpress};
	}
};
var $mdgriffith$elm_ui$Internal$Model$Px = function (a) {
	return {$: 'Px', a: a};
};
var $mdgriffith$elm_ui$Element$px = $mdgriffith$elm_ui$Internal$Model$Px;
var $mdgriffith$elm_ui$Internal$Model$AsRow = {$: 'AsRow'};
var $mdgriffith$elm_ui$Internal$Model$asRow = $mdgriffith$elm_ui$Internal$Model$AsRow;
var $mdgriffith$elm_ui$Element$row = F2(
	function (attrs, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asRow,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.contentCenterY)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
						attrs))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
	});
var $author$project$Main$simContacts = 'data:image/svg+xml,%3Csvg xmlns=\'http://www.w3.org/2000/svg\' viewBox=\'0 0 364 296\'%3E%3Cpath fill=\'none\' d=\'M-1-1h366v298H-1z\'/%3E%3Cg%3E%3Cpath fill=\'%23ffcc3b\' d=\'M362 46v203c0 25-20 45-45 45H47c-25 0-46-20-46-45V46C1 21 22 1 47 1h270c25 0 45 20 45 45zm0 0\'/%3E%3Cpath fill=\'%23ffcc3b\' d=\'M362 46v203c0 25-20 45-45 45H47c-25 0-46-20-46-45V46C1 21 22 1 47 1h270c25 0 45 20 45 45zm0 0\'/%3E%3Cpath fill=\'%23ffd876\' d=\'M124 173v-51c0-12-10-21-21-21H1v93h102c11 0 21-9 21-21zm0 0M240 122v51c0 12 9 21 21 21h101v-93H261c-12 0-21 9-21 21zm0 0\'/%3E%3Cpath fill=\'%23efb525\' d=\'M147 1v19l-2 3a74 74 0 00-43 67v3H1v16h102c7 0 13 6 13 13v51c0 8-6 13-13 13H1v16h101v3c0 29 17 56 43 67l2 3v19h16v-19c0-7-5-14-11-17-21-9-35-30-35-53v-7c9-5 14-14 14-25v-51c0-11-5-20-14-25v-7c0-23 14-44 35-53 6-3 11-10 11-17V1h-16zm0 0M201 1v19c0 7 4 14 11 17 21 9 35 30 35 53v7c-9 5-15 14-15 25v51c0 11 6 20 15 25v7c0 23-14 44-35 53-7 3-11 10-11 17v19h16v-19c0-1 0-2 2-3 26-11 43-38 43-67v-3h100v-16H261c-7 0-13-5-13-13v-51c0-7 6-13 13-13h101V93H262v-3c0-29-17-56-43-67-2-1-2-2-2-3V1h-16zm0 0\'/%3E%3C/g%3E%3C/svg%3E';
var $mdgriffith$elm_ui$Internal$Model$formatTextShadow = function (shadow) {
	return A2(
		$elm$core$String$join,
		' ',
		_List_fromArray(
			[
				$elm$core$String$fromFloat(shadow.offset.a) + 'px',
				$elm$core$String$fromFloat(shadow.offset.b) + 'px',
				$elm$core$String$fromFloat(shadow.blur) + 'px',
				$mdgriffith$elm_ui$Internal$Model$formatColor(shadow.color)
			]));
};
var $mdgriffith$elm_ui$Internal$Model$textShadowClass = function (shadow) {
	return $elm$core$String$concat(
		_List_fromArray(
			[
				'txt',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.offset.a) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.offset.b) + 'px',
				$mdgriffith$elm_ui$Internal$Model$floatClass(shadow.blur) + 'px',
				$mdgriffith$elm_ui$Internal$Model$formatColorClass(shadow.color)
			]));
};
var $mdgriffith$elm_ui$Internal$Flag$txtShadows = $mdgriffith$elm_ui$Internal$Flag$flag(18);
var $mdgriffith$elm_ui$Element$Font$glow = F2(
	function (clr, i) {
		var shade = {
			blur: i * 2,
			color: clr,
			offset: _Utils_Tuple2(0, 0)
		};
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$txtShadows,
			A3(
				$mdgriffith$elm_ui$Internal$Model$Single,
				$mdgriffith$elm_ui$Internal$Model$textShadowClass(shade),
				'text-shadow',
				$mdgriffith$elm_ui$Internal$Model$formatTextShadow(shade)));
	});
var $author$project$Main$textCreditCard = F2(
	function (attrs, string) {
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Font$size(13),
						A2(
						$mdgriffith$elm_ui$Element$Font$glow,
						A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0.7),
						6),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'letter-spacing', '2px')),
						$mdgriffith$elm_ui$Element$Font$color(
						A4($mdgriffith$elm_ui$Element$rgba, 1, 1, 1, 0.8))
					]),
				attrs),
			$mdgriffith$elm_ui$Element$text(string));
	});
var $author$project$Main$viewCreditCard = function (formState) {
	var logo = $author$project$Main$logoCreaditCard(formState);
	return A2(
		$mdgriffith$elm_ui$Element$column,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height(
				$mdgriffith$elm_ui$Element$px(250)),
				$mdgriffith$elm_ui$Element$padding(20),
				$mdgriffith$elm_ui$Element$spacing(30),
				$mdgriffith$elm_ui$Element$Border$rounded(20),
				$mdgriffith$elm_ui$Element$Border$shadow(
				{
					blur: 40,
					color: A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0.2),
					offset: _Utils_Tuple2(0, 20),
					size: 0
				}),
				$mdgriffith$elm_ui$Element$Border$width(1),
				$mdgriffith$elm_ui$Element$Border$color(
				A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0.3)),
				$mdgriffith$elm_ui$Element$Background$image($author$project$Main$backgroundImage),
				$mdgriffith$elm_ui$Element$clip
			]),
		_List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$image,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height(
								$mdgriffith$elm_ui$Element$px(50)),
								$mdgriffith$elm_ui$Element$alignTop
							]),
						{description: 'Sim Contacts', src: $author$project$Main$simContacts}),
						A2(
						$mdgriffith$elm_ui$Element$image,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$height(
								$mdgriffith$elm_ui$Element$px(logo.height)),
								$mdgriffith$elm_ui$Element$alignRight,
								$mdgriffith$elm_ui$Element$alignTop
							]),
						{description: 'Visa Logo', src: logo.src})
					])),
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(5),
						$mdgriffith$elm_ui$Element$alignBottom
					]),
				_List_fromArray(
					[
						A4(
						$author$project$Main$embossedValue,
						formState,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$size(22)
							]),
						'cardNumber',
						'1234 5678 9012 3456')
					])),
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$spacing(5)
							]),
						_List_fromArray(
							[
								A2($author$project$Main$textCreditCard, _List_Nil, 'CARD HOLDER'),
								A4($author$project$Main$embossedValue, formState, _List_Nil, 'cardHolder', 'FULL NAME')
							])),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$spacing(5),
								$mdgriffith$elm_ui$Element$alignRight
							]),
						_List_fromArray(
							[
								A2($author$project$Main$textCreditCard, _List_Nil, 'EXPIRES'),
								A4(
								$author$project$Main$embossedValue,
								formState,
								_List_fromArray(
									[$mdgriffith$elm_ui$Element$alignRight]),
								'expires',
								'YY/MM')
							]))
					]))
			]));
};
var $elm$core$Dict$fromList = function (assocs) {
	return A3(
		$elm$core$List$foldl,
		F2(
			function (_v0, dict) {
				var key = _v0.a;
				var value = _v0.b;
				return A3($elm$core$Dict$insert, key, value, dict);
			}),
		$elm$core$Dict$empty,
		assocs);
};
var $author$project$R10$Form$Internal$ValidationCode$translator = function (validationCode) {
	return A2(
		$elm$core$Maybe$withDefault,
		validationCode,
		A2(
			$elm$core$Dict$get,
			validationCode,
			$elm$core$Dict$fromList(
				_List_fromArray(
					[
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.emailFormatInvalid, 'Invalid email format'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.emailFormatValid, 'Valid email format'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.formatInvalid, 'Invalid format'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.formatValid, 'Valid format'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.formatInvalidCharactersInvalid, 'Cannot contain spaces or special language characters'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.formatNoNumberInvalid, 'Must contain a digit (ex: 1, 2, etc.)'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.formatNoSpecialCharactersInvalid, 'Must contain a special character (ex: !, @, #, etc.)'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.formatNoUppercaseInvalid, 'Must contain a capital letter (ex: A, B, etc.)'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.hexColorFormatInvalid, 'Invalid hex color'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.jsonFormatInvalid, 'Invalid json format'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.lengthTooLargeInvalid, 'Maximum allowed length is {0} characters'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.lengthTooSmallInvalid, 'Minimum allowed length is {0} characters'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.required, 'Required'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.empty, 'Empty'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.requiredField, '(Required)'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.somethingWrong, 'Something wrong'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.equalInvalid, 'Value should be equal'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.valueInvalid, 'This is not a valid selection'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.allOf, 'One of the validations have failed'),
						_Utils_Tuple2($author$project$R10$Form$Internal$ValidationCode$validationCodes.oneOf, 'All the validations have failed')
					]))));
};
var $author$project$R10$Form$defaultTranslator = $author$project$R10$Form$Internal$ValidationCode$translator;
var $avh4$elm_color$Color$scaleFrom255 = function (c) {
	return c / 255;
};
var $avh4$elm_color$Color$rgb255 = F3(
	function (r, g, b) {
		return A4(
			$avh4$elm_color$Color$RgbaSpace,
			$avh4$elm_color$Color$scaleFrom255(r),
			$avh4$elm_color$Color$scaleFrom255(g),
			$avh4$elm_color$Color$scaleFrom255(b),
			1.0);
	});
var $author$project$R10$FormComponents$UI$Palette$black = A3($avh4$elm_color$Color$rgb255, 0, 0, 0);
var $author$project$R10$FormComponents$UI$Palette$grayLightest = A3($avh4$elm_color$Color$rgb255, 247, 247, 247);
var $author$project$R10$FormComponents$UI$Palette$pink = A3($avh4$elm_color$Color$rgb255, 255, 51, 102);
var $author$project$R10$FormComponents$UI$Palette$pinkVariant = A3($avh4$elm_color$Color$rgb255, 255, 111, 147);
var $author$project$R10$FormComponents$UI$Palette$success = A3($avh4$elm_color$Color$rgb255, 6, 153, 7);
var $author$project$R10$FormComponents$UI$Palette$warning = A3($avh4$elm_color$Color$rgb255, 255, 145, 0);
var $author$project$R10$FormComponents$UI$Palette$white = A3($avh4$elm_color$Color$rgb255, 255, 255, 255);
var $author$project$R10$FormComponents$UI$Palette$light = {background: $author$project$R10$FormComponents$UI$Palette$grayLightest, error: $author$project$R10$FormComponents$UI$Palette$warning, onPrimary: $author$project$R10$FormComponents$UI$Palette$white, onSurface: $author$project$R10$FormComponents$UI$Palette$black, primary: $author$project$R10$FormComponents$UI$Palette$pink, primaryVariant: $author$project$R10$FormComponents$UI$Palette$pinkVariant, success: $author$project$R10$FormComponents$UI$Palette$success, surface: $author$project$R10$FormComponents$UI$Palette$white};
var $author$project$R10$Form$Msg$AddEntity = function (a) {
	return {$: 'AddEntity', a: a};
};
var $author$project$R10$Form$Msg$RemoveEntity = function (a) {
	return {$: 'RemoveEntity', a: a};
};
var $mdgriffith$elm_ui$Internal$Model$Transparency = F2(
	function (a, b) {
		return {$: 'Transparency', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$transparency = $mdgriffith$elm_ui$Internal$Flag$flag(0);
var $mdgriffith$elm_ui$Element$alpha = function (o) {
	var transparency = function (x) {
		return 1 - x;
	}(
		A2(
			$elm$core$Basics$min,
			1.0,
			A2($elm$core$Basics$max, 0.0, o)));
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$transparency,
		A2(
			$mdgriffith$elm_ui$Internal$Model$Transparency,
			'transparency-' + $mdgriffith$elm_ui$Internal$Model$floatClass(transparency),
			transparency));
};
var $mdgriffith$elm_ui$Internal$Model$Behind = {$: 'Behind'};
var $mdgriffith$elm_ui$Element$createNearby = F2(
	function (loc, element) {
		if (element.$ === 'Empty') {
			return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
		} else {
			return A2($mdgriffith$elm_ui$Internal$Model$Nearby, loc, element);
		}
	});
var $mdgriffith$elm_ui$Element$behindContent = function (element) {
	return A2($mdgriffith$elm_ui$Element$createNearby, $mdgriffith$elm_ui$Internal$Model$Behind, element);
};
var $mdgriffith$elm_ui$Element$fromRgb = function (clr) {
	return A4($mdgriffith$elm_ui$Internal$Model$Rgba, clr.red, clr.green, clr.blue, clr.alpha);
};
var $author$project$R10$FormComponents$UI$Color$fromPaletteColor = A2($elm$core$Basics$composeR, $avh4$elm_color$Color$toRgba, $mdgriffith$elm_ui$Element$fromRgb);
var $author$project$R10$FormComponents$UI$Palette$withOpacity = function (opacity) {
	return A2(
		$elm$core$Basics$composeR,
		$avh4$elm_color$Color$toRgba,
		A2(
			$elm$core$Basics$composeR,
			function (rgba) {
				return _Utils_update(
					rgba,
					{alpha: opacity});
			},
			$avh4$elm_color$Color$fromRgba));
};
var $author$project$R10$FormComponents$UI$Color$onSurfaceA = F2(
	function (alpha, palette) {
		return $author$project$R10$FormComponents$UI$Color$fromPaletteColor(
			A2($author$project$R10$FormComponents$UI$Palette$withOpacity, alpha, palette.onSurface));
	});
var $author$project$R10$FormComponents$UI$Color$container = $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.54);
var $author$project$R10$FormComponents$UI$borderEntityWithBorder = function (palette) {
	return _List_fromArray(
		[
			$mdgriffith$elm_ui$Element$Border$width(1),
			$mdgriffith$elm_ui$Element$Border$color(
			$author$project$R10$FormComponents$UI$Color$container(palette)),
			$mdgriffith$elm_ui$Element$Border$rounded(5)
		]);
};
var $author$project$R10$FormComponents$UI$Color$containerA = function (alpha) {
	return $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.54 * alpha);
};
var $elm$core$Basics$pi = _Basics_pi;
var $elm$core$Basics$degrees = function (angleInDegrees) {
	return (angleInDegrees * $elm$core$Basics$pi) / 180;
};
var $author$project$R10$Form$Internal$Conf$getId = function (entity) {
	switch (entity.$) {
		case 'EntityNormal':
			var entityId = entity.a;
			return entityId;
		case 'EntityWrappable':
			var entityId = entity.a;
			return entityId;
		case 'EntityWithBorder':
			var entityId = entity.a;
			return entityId;
		case 'EntityWithTabs':
			var entityId = entity.a;
			return entityId;
		case 'EntityMulti':
			var entityId = entity.a;
			return entityId;
		case 'EntityField':
			var fieldConf = entity.a;
			return fieldConf.id;
		case 'EntityTitle':
			var titleConf = entity.b;
			return titleConf.title;
		default:
			var titleConf = entity.b;
			return titleConf.title;
	}
};
var $author$project$R10$Form$Internal$Key$composeMultiKeys = F2(
	function (key, quantity) {
		return A2(
			$elm$core$List$indexedMap,
			F2(
				function (index, _v0) {
					return A2(
						$author$project$R10$Form$Internal$Key$composeKey,
						key,
						$elm$core$String$fromInt(index));
				}),
			A2($elm$core$List$repeat, quantity, _Utils_Tuple0));
	});
var $author$project$R10$Form$Internal$Helpers$getMultiActiveKeys = F2(
	function (key, formState) {
		var quantity = A2(
			$elm$core$Maybe$withDefault,
			1,
			A2($author$project$R10$Form$Internal$Dict$get, key, formState.multiplicableQuantities));
		var notRemoved = function (newKey) {
			return !A2(
				$elm$core$Set$member,
				$author$project$R10$Form$Internal$Key$toString(newKey),
				formState.removed);
		};
		return A2(
			$elm$core$List$filter,
			notRemoved,
			A2($author$project$R10$Form$Internal$Key$composeMultiKeys, key, quantity));
	});
var $mdgriffith$elm_ui$Internal$Model$InFront = {$: 'InFront'};
var $mdgriffith$elm_ui$Element$inFront = function (element) {
	return A2($mdgriffith$elm_ui$Element$createNearby, $mdgriffith$elm_ui$Internal$Model$InFront, element);
};
var $author$project$R10$FormComponents$UI$Color$label = $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.6);
var $author$project$R10$FormComponents$UI$Color$labelA = function (alpha) {
	return $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.6 * alpha);
};
var $mdgriffith$elm_ui$Internal$Model$MoveX = function (a) {
	return {$: 'MoveX', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$moveX = $mdgriffith$elm_ui$Internal$Flag$flag(25);
var $mdgriffith$elm_ui$Element$moveLeft = function (x) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$TransformComponent,
		$mdgriffith$elm_ui$Internal$Flag$moveX,
		$mdgriffith$elm_ui$Internal$Model$MoveX(-x));
};
var $mdgriffith$elm_ui$Element$none = $mdgriffith$elm_ui$Internal$Model$Empty;
var $mdgriffith$elm_ui$Element$paddingXY = F2(
	function (x, y) {
		if (_Utils_eq(x, y)) {
			var f = x;
			return A2(
				$mdgriffith$elm_ui$Internal$Model$StyleClass,
				$mdgriffith$elm_ui$Internal$Flag$padding,
				A5(
					$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
					'p-' + $elm$core$String$fromInt(x),
					f,
					f,
					f,
					f));
		} else {
			var yFloat = y;
			var xFloat = x;
			return A2(
				$mdgriffith$elm_ui$Internal$Model$StyleClass,
				$mdgriffith$elm_ui$Internal$Flag$padding,
				A5(
					$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
					'p-' + ($elm$core$String$fromInt(x) + ('-' + $elm$core$String$fromInt(y))),
					yFloat,
					xFloat,
					yFloat,
					xFloat));
		}
	});
var $author$project$R10$Form$Internal$MakerForView$paddingGeneric = A2($mdgriffith$elm_ui$Element$paddingXY, 20, 25);
var $mdgriffith$elm_ui$Element$rgb = F3(
	function (r, g, b) {
		return A4($mdgriffith$elm_ui$Internal$Model$Rgba, r, g, b, 1);
	});
var $mdgriffith$elm_ui$Internal$Model$Rotate = F2(
	function (a, b) {
		return {$: 'Rotate', a: a, b: b};
	});
var $mdgriffith$elm_ui$Internal$Flag$rotate = $mdgriffith$elm_ui$Internal$Flag$flag(24);
var $mdgriffith$elm_ui$Element$rotate = function (angle) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$TransformComponent,
		$mdgriffith$elm_ui$Internal$Flag$rotate,
		A2(
			$mdgriffith$elm_ui$Internal$Model$Rotate,
			_Utils_Tuple3(0, 0, 1),
			angle));
};
var $mdgriffith$elm_ui$Element$scrollbars = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.scrollbars);
var $elm$core$List$singleton = function (value) {
	return _List_fromArray(
		[value]);
};
var $mdgriffith$elm_ui$Element$spacingXY = F2(
	function (x, y) {
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$spacing,
			A3(
				$mdgriffith$elm_ui$Internal$Model$SpacingStyle,
				A2($mdgriffith$elm_ui$Internal$Model$spacingName, x, y),
				x,
				y));
	});
var $author$project$R10$Form$Internal$MakerForView$spacingGeneric = A2($mdgriffith$elm_ui$Element$spacingXY, 15, 25);
var $author$project$R10$Form$Internal$MakerForView$isActive = F2(
	function (key, active) {
		if (active.$ === 'Just') {
			var active_x = active.a;
			return _Utils_eq(
				active_x,
				$author$project$R10$Form$Internal$Key$toString(key));
		} else {
			return false;
		}
	});
var $author$project$R10$Form$Internal$MakerForView$isFocused = F2(
	function (key, focused) {
		if (focused.$ === 'Just') {
			var focused_x = focused.a;
			return _Utils_eq(
				focused_x,
				$author$project$R10$Form$Internal$Key$toString(key));
		} else {
			return false;
		}
	});
var $author$project$R10$Form$Msg$ChangeValue = F4(
	function (a, b, c, d) {
		return {$: 'ChangeValue', a: a, b: b, c: c, d: d};
	});
var $author$project$R10$Form$Msg$GetFocus = function (a) {
	return {$: 'GetFocus', a: a};
};
var $author$project$R10$Form$Msg$LoseFocus = F2(
	function (a, b) {
		return {$: 'LoseFocus', a: a, b: b};
	});
var $author$project$R10$FormComponents$Binary$BinaryCheckbox = {$: 'BinaryCheckbox'};
var $author$project$R10$FormComponents$Binary$BinarySwitch = {$: 'BinarySwitch'};
var $author$project$R10$Form$Internal$Converter$binaryTypeFromFieldConfToComponent = function (typeText) {
	if (typeText.$ === 'BinaryCheckbox') {
		return $author$project$R10$FormComponents$Binary$BinaryCheckbox;
	} else {
		return $author$project$R10$FormComponents$Binary$BinarySwitch;
	}
};
var $author$project$R10$Form$Internal$Helpers$boolToString = function (bool) {
	return bool ? 'True' : 'False';
};
var $author$project$R10$FormComponents$Validations$NotYetValidated = {$: 'NotYetValidated'};
var $author$project$R10$FormComponents$Validations$Validated = function (a) {
	return {$: 'Validated', a: a};
};
var $author$project$R10$FormComponents$Validations$MessageErr = function (a) {
	return {$: 'MessageErr', a: a};
};
var $author$project$R10$FormComponents$Validations$MessageOk = function (a) {
	return {$: 'MessageOk', a: a};
};
var $elm$core$Tuple$pair = F2(
	function (a, b) {
		return _Utils_Tuple2(a, b);
	});
var $elm$regex$Regex$never = _Regex_never;
var $author$project$R10$Form$Internal$ValidationCode$regexBracket = function (index) {
	return A2(
		$elm$core$Maybe$withDefault,
		$elm$regex$Regex$never,
		A2(
			$elm$regex$Regex$fromStringWith,
			{caseInsensitive: true, multiline: true},
			'\\{' + ($elm$core$String$fromInt(index) + '\\}')));
};
var $elm$regex$Regex$replace = _Regex_replaceAtMost(_Regex_infinity);
var $author$project$R10$Form$Internal$ValidationCode$replacer = F2(
	function (_v0, acc) {
		var index = _v0.a;
		var value = _v0.b;
		return A3(
			$elm$regex$Regex$replace,
			$author$project$R10$Form$Internal$ValidationCode$regexBracket(index),
			function (_v1) {
				return value;
			},
			acc);
	});
var $author$project$R10$Form$Internal$ValidationCode$replaceBrackets = F2(
	function (values, target) {
		return A3(
			$elm$core$List$foldl,
			$author$project$R10$Form$Internal$ValidationCode$replacer,
			target,
			A2($elm$core$List$indexedMap, $elm$core$Tuple$pair, values));
	});
var $author$project$R10$Form$Internal$ValidationCode$fromValidationCodeToMessageWithReplacedValues = F3(
	function (validationCode, bracketsArgs, translator_) {
		var translated = translator_(validationCode);
		return $elm$core$List$isEmpty(bracketsArgs) ? translated : A2($author$project$R10$Form$Internal$ValidationCode$replaceBrackets, bracketsArgs, translated);
	});
var $author$project$R10$Form$Internal$Converter$fromValidationOutcomeToValidationMessage = F2(
	function (validationOutcome, translator) {
		if (validationOutcome.$ === 'MessageOk') {
			var validationCode = validationOutcome.a;
			var validationPayload = validationOutcome.b;
			return $author$project$R10$FormComponents$Validations$MessageOk(
				A3($author$project$R10$Form$Internal$ValidationCode$fromValidationCodeToMessageWithReplacedValues, validationCode, validationPayload, translator));
		} else {
			var validationCode = validationOutcome.a;
			var validationPayload = validationOutcome.b;
			return $author$project$R10$FormComponents$Validations$MessageErr(
				A3($author$project$R10$Form$Internal$ValidationCode$fromValidationCodeToMessageWithReplacedValues, validationCode, validationPayload, translator));
		}
	});
var $author$project$R10$Form$Internal$Converter$fromFieldStateValidationToComponentValidation = F3(
	function (maybeValidationSpecs, validation, translator) {
		if (validation.$ === 'NotYetValidated') {
			return $author$project$R10$FormComponents$Validations$NotYetValidated;
		} else {
			var listValidationOutcome = validation.a;
			var showPassedValidationMessages = A2(
				$elm$core$Maybe$withDefault,
				false,
				A2(
					$elm$core$Maybe$map,
					function ($) {
						return $.showPassedValidationMessages;
					},
					maybeValidationSpecs));
			var listErrValidationOutcome = A2(
				$elm$core$List$filter,
				function (validationOutcome) {
					if (validationOutcome.$ === 'MessageOk') {
						return false;
					} else {
						return true;
					}
				},
				listValidationOutcome);
			var hidePassedValidationStyle = A2(
				$elm$core$Maybe$withDefault,
				false,
				A2(
					$elm$core$Maybe$map,
					function ($) {
						return $.hidePassedValidationStyle;
					},
					maybeValidationSpecs));
			return showPassedValidationMessages ? $author$project$R10$FormComponents$Validations$Validated(
				A2(
					$elm$core$List$map,
					function (a) {
						return A2($author$project$R10$Form$Internal$Converter$fromValidationOutcomeToValidationMessage, a, translator);
					},
					listValidationOutcome)) : ((hidePassedValidationStyle && (!$elm$core$List$length(listErrValidationOutcome))) ? $author$project$R10$FormComponents$Validations$NotYetValidated : $author$project$R10$FormComponents$Validations$Validated(
				A2(
					$elm$core$List$map,
					function (err) {
						return A2($author$project$R10$Form$Internal$Converter$fromValidationOutcomeToValidationMessage, err, translator);
					},
					listErrValidationOutcome)));
		}
	});
var $mdgriffith$elm_ui$Internal$Model$Min = F2(
	function (a, b) {
		return {$: 'Min', a: a, b: b};
	});
var $mdgriffith$elm_ui$Element$minimum = F2(
	function (i, l) {
		return A2($mdgriffith$elm_ui$Internal$Model$Min, i, l);
	});
var $author$project$R10$Form$Internal$Helpers$stringToBool = function (string) {
	return $elm$core$String$toLower(string) === 'true';
};
var $author$project$R10$FormComponents$UI$genericSpacing = 8;
var $mdgriffith$elm_ui$Internal$Model$paddingName = F4(
	function (top, right, bottom, left) {
		return 'pad-' + ($elm$core$String$fromInt(top) + ('-' + ($elm$core$String$fromInt(right) + ('-' + ($elm$core$String$fromInt(bottom) + ('-' + $elm$core$String$fromInt(left)))))));
	});
var $mdgriffith$elm_ui$Element$paddingEach = function (_v0) {
	var top = _v0.top;
	var right = _v0.right;
	var bottom = _v0.bottom;
	var left = _v0.left;
	if (_Utils_eq(top, right) && (_Utils_eq(top, bottom) && _Utils_eq(top, left))) {
		var topFloat = top;
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$padding,
			A5(
				$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
				'p-' + $elm$core$String$fromInt(top),
				topFloat,
				topFloat,
				topFloat,
				topFloat));
	} else {
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$padding,
			A5(
				$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
				A4($mdgriffith$elm_ui$Internal$Model$paddingName, top, right, bottom, left),
				top,
				right,
				bottom,
				left));
	}
};
var $mdgriffith$elm_ui$Element$Font$alignLeft = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$fontAlignment, $mdgriffith$elm_ui$Internal$Style$classes.textLeft);
var $mdgriffith$elm_ui$Element$toRgb = function (_v0) {
	var r = _v0.a;
	var g = _v0.b;
	var b = _v0.c;
	var a = _v0.d;
	return {alpha: a, blue: b, green: g, red: r};
};
var $author$project$R10$Color$Utils$elementColorToColor = function (elementColor) {
	var _v0 = $mdgriffith$elm_ui$Element$toRgb(elementColor);
	var red = _v0.red;
	var green = _v0.green;
	var blue = _v0.blue;
	var alpha = _v0.alpha;
	return $avh4$elm_color$Color$fromRgba(
		{alpha: alpha, blue: blue, green: green, red: red});
};
var $author$project$R10$Svg$IconsExtra$checkBold = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 24 24',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M9 16.17L5.53 12.7c-.39-.39-1.02-.39-1.41 0-.39.39-.39 1.02 0 1.41l4.18 4.18c.39.39 1.02.39 1.41 0L20.29 7.71c.39-.39.39-1.02 0-1.41-.39-.39-1.02-.39-1.41 0L9 16.17z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$IconsExtra$email = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 512 512',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M486.4 59.7H25.6A25.6 25.6 0 000 85.3v341.4a25.6 25.6 0 0025.6 25.6h460.8a25.6 25.6 0 0025.6-25.6V85.3a25.6 25.6 0 00-25.6-25.6zm8.5 367c0 4.7-3.8 8.5-8.5 8.5H25.6a8.5 8.5 0 01-8.5-8.5V85.3c0-4.7 3.8-8.5 8.5-8.5h460.8c4.7 0 8.5 3.8 8.5 8.5v341.4z')
						]),
					_List_Nil),
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M470 93.9c-2.2-.2-4.4.5-6.2 2L267 261.2a17 17 0 01-22 0L48.2 96a8.5 8.5 0 00-11 13L234 274.3a34 34 0 0044 0l196.8-165.4a8.5 8.5 0 00-4.7-15zM164.1 273.1c-3-.6-6.1.4-8.2 2.7l-119.5 128A8.5 8.5 0 1049 415.4l119.5-128a8.5 8.5 0 00-4.3-14.3zM356.1 275.8a8.5 8.5 0 10-12.5 11.6l119.5 128a8.5 8.5 0 0012.5-11.6L356 275.8z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$Utils$wrapper32 = F3(
	function (attrs, size, listSvg) {
		return A4($author$project$R10$Svg$Utils$wrapperWithViewbox, attrs, '0 0 32 32', size, listSvg);
	});
var $author$project$R10$Svg$Icons$eye_ban_l = F3(
	function (attrs, cl, size) {
		return A3(
			$author$project$R10$Svg$Utils$wrapper32,
			attrs,
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill('none'),
							$elm$svg$Svg$Attributes$d('M0 0h32v32H0z')
						]),
					_List_Nil),
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$d('M24.5 23.09A18.85 18.85 0 0 0 30 16S26 6 16 6a13.55 13.55 0 0 0-6.8 1.78L3.2 1.8 1.8 3.2l5.7 5.7A18.85 18.85 0 0 0 2 16s4 10 14 10a13.55 13.55 0 0 0 6.8-1.78l5.99 5.98 1.41-1.41zM16 24c-7.1 0-10.72-5.88-11.8-8a16.43 16.43 0 0 1 4.72-5.66l2.91 2.9a5 5 0 0 0 6.92 6.93l2.57 2.57A11.65 11.65 0 0 1 16 24zm1.28-5.3A2.97 2.97 0 0 1 16 19a3 3 0 0 1-3-3 2.97 2.97 0 0 1 .3-1.28zm-2.57-5.4A2.97 2.97 0 0 1 16 13a3 3 0 0 1 3 3 2.97 2.97 0 0 1-.3 1.28l-2-1.99zm5.46 5.45a5 5 0 0 0-6.92-6.92l-2.57-2.57A11.65 11.65 0 0 1 16 8c7.1 0 10.72 5.88 11.8 8a16.43 16.43 0 0 1-4.72 5.66z'),
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl))
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$IconsExtra$grid = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 24 24',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M6,8c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM12,20c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM6,20c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM6,14c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM12,14c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM16,6c0,1.1 0.9,2 2,2s2,-0.9 2,-2 -0.9,-2 -2,-2 -2,0.9 -2,2zM12,8c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM18,14c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2zM18,20c1.1,0 2,-0.9 2,-2s-0.9,-2 -2,-2 -2,0.9 -2,2 0.9,2 2,2z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$IconsExtra$keyboardArrowDown = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 24 24',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M8.12 9.29L12 13.17l3.88-3.88c.39-.39 1.02-.39 1.41 0 .39.39.39 1.02 0 1.41l-4.59 4.59c-.39.39-1.02.39-1.41 0L6.7 10.7c-.39-.39-.39-1.02 0-1.41.39-.38 1.03-.39 1.42 0z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$Icons$notice_generic_l = F3(
	function (attrs, cl, size) {
		return A3(
			$author$project$R10$Svg$Utils$wrapper32,
			attrs,
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill('none'),
							$elm$svg$Svg$Attributes$d('M0 0h32v32H0z')
						]),
					_List_Nil),
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$d('M16 28a2 2 0 0 1-2-2h-2a4 4 0 0 0 8 0h-2a2 2 0 0 1-2 2zm10-8v-8a10 10 0 0 0-20 0v8a2 2 0 0 1-2 2v2h24v-2a2 2 0 0 1-2-2zM7.46 22A3.98 3.98 0 0 0 8 20v-8a8 8 0 0 1 16 0v8a3.98 3.98 0 0 0 .54 2z'),
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl))
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$IconsExtra$search = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 24 24',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M15.5 14h-.79l-.28-.27c1.2-1.4 1.82-3.31 1.48-5.34-.47-2.78-2.79-5-5.59-5.34-4.23-.52-7.79 3.04-7.27 7.27.34 2.8 2.56 5.12 5.34 5.59 2.03.34 3.94-.28 5.34-1.48l.27.28v.79l4.25 4.25c.41.41 1.08.41 1.49 0 .41-.41.41-1.08 0-1.49L15.5 14zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$Icons$sign_warning_f = F3(
	function (attrs, cl, size) {
		return A3(
			$author$project$R10$Svg$Utils$wrapper32,
			attrs,
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill('none'),
							$elm$svg$Svg$Attributes$d('M0 0h32v32H0z')
						]),
					_List_Nil),
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$d('M29.82 25.94L17.25 3.72a1.45 1.45 0 0 0-2.5 0L2.18 25.94A1.4 1.4 0 0 0 3.43 28h25.14a1.4 1.4 0 0 0 1.25-2.06zM15 10h2v9h-2zm1 14a1.5 1.5 0 1 1 1.5-1.5A1.5 1.5 0 0 1 16 24z'),
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl))
						]),
					_List_Nil)
				]));
	});
var $elm$svg$Svg$circle = $elm$svg$Svg$trustedNode('circle');
var $elm$svg$Svg$Attributes$cx = _VirtualDom_attribute('cx');
var $elm$svg$Svg$Attributes$cy = _VirtualDom_attribute('cy');
var $elm$svg$Svg$g = $elm$svg$Svg$trustedNode('g');
var $elm$svg$Svg$Attributes$r = _VirtualDom_attribute('r');
var $author$project$R10$Svg$Icons$sign_warning_l = F3(
	function (attrs, cl, size) {
		return A3(
			$author$project$R10$Svg$Utils$wrapper32,
			attrs,
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill('none'),
							$elm$svg$Svg$Attributes$d('M0 0h32v32H0z')
						]),
					_List_Nil),
					A2(
					$elm$svg$Svg$g,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl))
						]),
					_List_fromArray(
						[
							A2(
							$elm$svg$Svg$path,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$d('M29.82 25.94L17.25 3.72a1.45 1.45 0 0 0-2.5 0L2.18 25.94A1.4 1.4 0 0 0 3.43 28h25.14a1.4 1.4 0 0 0 1.25-2.06zM4.44 26L16 5.57 27.56 26z')
								]),
							_List_Nil),
							A2(
							$elm$svg$Svg$path,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$d('M15 10h2v9h-2z')
								]),
							_List_Nil),
							A2(
							$elm$svg$Svg$circle,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$cx('16'),
									$elm$svg$Svg$Attributes$cy('22.5'),
									$elm$svg$Svg$Attributes$r('1.5')
								]),
							_List_Nil)
						]))
				]));
	});
var $author$project$R10$Svg$IconsExtra$validation_check = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 24 24',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M9 16.2l-3.5-3.5c-.39-.39-1.01-.39-1.4 0-.39.39-.39 1.01 0 1.4l4.19 4.19c.39.39 1.02.39 1.41 0L20.3 7.7c.39-.39.39-1.01 0-1.4-.39-.39-1.01-.39-1.4 0L9 16.2z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$IconsExtra$validation_clear = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'2 2 20 20',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M18.3 5.71c-.39-.39-1.02-.39-1.41 0L12 10.59 7.11 5.7c-.39-.39-1.02-.39-1.41 0-.39.39-.39 1.02 0 1.41L10.59 12 5.7 16.89c-.39.39-.39 1.02 0 1.41.39.39 1.02.39 1.41 0L12 13.41l4.89 4.89c.39.39 1.02.39 1.41 0 .39-.39.39-1.02 0-1.41L13.41 12l4.89-4.89c.38-.38.38-1.02 0-1.4z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$Svg$IconsExtra$validation_error = F3(
	function (attrs, cl, size) {
		return A4(
			$author$project$R10$Svg$Utils$wrapperWithViewbox,
			attrs,
			'0 0 24 24',
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl)),
							$elm$svg$Svg$Attributes$d('M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z')
						]),
					_List_Nil)
				]));
	});
var $author$project$R10$FormComponents$UI$icons = {checkBold: $author$project$R10$Svg$IconsExtra$checkBold, combobox_arrow: $author$project$R10$Svg$IconsExtra$keyboardArrowDown, eye_ban_l: $author$project$R10$Svg$Icons$eye_ban_l, eye_l: $author$project$R10$Svg$IconsExtra$email, grid: $author$project$R10$Svg$IconsExtra$grid, notice_generic_l: $author$project$R10$Svg$Icons$notice_generic_l, search: $author$project$R10$Svg$IconsExtra$search, sign_warning_f: $author$project$R10$Svg$Icons$sign_warning_f, sign_warning_l: $author$project$R10$Svg$Icons$sign_warning_l, validation_check: $author$project$R10$Svg$IconsExtra$validation_check, validation_clear: $author$project$R10$Svg$IconsExtra$validation_clear, validation_error: $author$project$R10$Svg$IconsExtra$validation_error};
var $mdgriffith$elm_ui$Element$Border$innerShadow = function (almostShade) {
	var shade = {blur: almostShade.blur, color: almostShade.color, inset: true, offset: almostShade.offset, size: almostShade.size};
	return A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$shadows,
		A3(
			$mdgriffith$elm_ui$Internal$Model$Single,
			$mdgriffith$elm_ui$Internal$Model$boxShadowClass(shade),
			'box-shadow',
			$mdgriffith$elm_ui$Internal$Model$formatBoxShadow(shade)));
};
var $author$project$R10$FormComponents$UI$Color$onPrimary = A2(
	$elm$core$Basics$composeR,
	function ($) {
		return $.onPrimary;
	},
	$author$project$R10$FormComponents$UI$Color$fromPaletteColor);
var $author$project$R10$FormComponents$UI$Color$primary = A2(
	$elm$core$Basics$composeR,
	function ($) {
		return $.primary;
	},
	$author$project$R10$FormComponents$UI$Color$fromPaletteColor);
var $author$project$R10$FormComponents$UI$Color$transparent = $author$project$R10$FormComponents$UI$Color$fromPaletteColor(
	A2($author$project$R10$FormComponents$UI$Palette$withOpacity, 0, $author$project$R10$FormComponents$UI$Palette$black));
var $author$project$R10$FormComponents$UI$Color$primaryA = F2(
	function (alpha, palette) {
		return $author$project$R10$FormComponents$UI$Color$fromPaletteColor(
			A2($author$project$R10$FormComponents$UI$Palette$withOpacity, alpha, palette.primary));
	});
var $author$project$R10$FormComponents$UI$getSelectShadowColor = F3(
	function (palette, focused, mouseOver) {
		var alpha = function () {
			var _v0 = _Utils_Tuple2(focused, mouseOver);
			if (_v0.a) {
				if (_v0.b) {
					return 0.21;
				} else {
					return 0.14;
				}
			} else {
				if (_v0.b) {
					return 0.07;
				} else {
					return 0;
				}
			}
		}();
		return A2($author$project$R10$FormComponents$UI$Color$primaryA, alpha, palette);
	});
var $author$project$R10$FormComponents$UI$viewSelectShadow = F2(
	function (_v0, element) {
		var palette = _v0.palette;
		var focused = _v0.focused;
		var disabled = _v0.disabled;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$px(40)),
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(40)),
						$mdgriffith$elm_ui$Element$Border$rounded(20),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'transition', 'all 0.15s'))
					]),
				disabled ? _List_Nil : _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						$elm$html$Html$Attributes$class('ripple-primary')),
						$mdgriffith$elm_ui$Element$Background$color(
						A3($author$project$R10$FormComponents$UI$getSelectShadowColor, palette, focused, false)),
						$mdgriffith$elm_ui$Element$mouseOver(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Background$color(
								A3($author$project$R10$FormComponents$UI$getSelectShadowColor, palette, focused, true))
							]))
					])),
			element);
	});
var $author$project$R10$FormComponents$Binary$checkboxIcon = F2(
	function (args, value) {
		var checkMark = value ? A3(
			$author$project$R10$FormComponents$UI$icons.checkBold,
			_List_fromArray(
				[$mdgriffith$elm_ui$Element$centerX, $mdgriffith$elm_ui$Element$centerY]),
			$author$project$R10$Color$Utils$elementColorToColor(
				$author$project$R10$FormComponents$UI$Color$onPrimary(args.palette)),
			18) : $mdgriffith$elm_ui$Element$none;
		var boxBorderAndFill = A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'transition', 'all 0.2s ')),
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$px(18)),
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(18)),
						$mdgriffith$elm_ui$Element$Border$rounded(3),
						$mdgriffith$elm_ui$Element$centerY,
						$mdgriffith$elm_ui$Element$centerX
					]),
				value ? _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Background$color(
						$author$project$R10$FormComponents$UI$Color$primary(args.palette)),
						$mdgriffith$elm_ui$Element$Border$innerShadow(
						{
							blur: 0,
							color: A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.54, args.palette),
							offset: _Utils_Tuple2(0, 0),
							size: 0
						})
					]) : _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Background$color($author$project$R10$FormComponents$UI$Color$transparent),
						$mdgriffith$elm_ui$Element$Border$innerShadow(
						{
							blur: 0,
							color: A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.54, args.palette),
							offset: _Utils_Tuple2(0, 0),
							size: 2
						})
					])),
			checkMark);
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(18)),
					$mdgriffith$elm_ui$Element$moveLeft(11)
				]),
			A2($author$project$R10$FormComponents$UI$viewSelectShadow, args, boxBorderAndFill));
	});
var $elm$html$Html$Attributes$id = $elm$html$Html$Attributes$stringProperty('id');
var $elm$html$Html$Events$onFocus = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'focus',
		$elm$json$Json$Decode$succeed(msg));
};
var $mdgriffith$elm_ui$Element$Events$onFocus = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Events$onFocus);
var $elm$html$Html$Events$onBlur = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'blur',
		$elm$json$Json$Decode$succeed(msg));
};
var $mdgriffith$elm_ui$Element$Events$onLoseFocus = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Events$onBlur);
var $author$project$R10$FormComponents$UI$keyCode = {down: 40, enter: 13, esc: 27, space: 32, up: 38};
var $elm$json$Json$Decode$int = _Json_decodeInt;
var $elm$html$Html$Events$keyCode = A2($elm$json$Json$Decode$field, 'keyCode', $elm$json$Json$Decode$int);
var $author$project$R10$FormComponents$UI$onKeyPressBatch = function (codesMsg) {
	var codesMsgDict = $elm$core$Dict$fromList(codesMsg);
	return A2(
		$elm$html$Html$Events$preventDefaultOn,
		'keydown',
		A2(
			$elm$json$Json$Decode$andThen,
			function (key) {
				var _v0 = A2($elm$core$Dict$get, key, codesMsgDict);
				if (_v0.$ === 'Just') {
					var msg = _v0.a;
					return $elm$json$Json$Decode$succeed(
						_Utils_Tuple2(msg, true));
				} else {
					return $elm$json$Json$Decode$fail('Not code');
				}
			},
			$elm$html$Html$Events$keyCode));
};
var $author$project$R10$FormComponents$UI$onSelectKey = function (msg) {
	return $author$project$R10$FormComponents$UI$onKeyPressBatch(
		_List_fromArray(
			[
				_Utils_Tuple2($author$project$R10$FormComponents$UI$keyCode.enter, msg),
				_Utils_Tuple2($author$project$R10$FormComponents$UI$keyCode.space, msg)
			]));
};
var $mdgriffith$elm_ui$Internal$Model$Paragraph = {$: 'Paragraph'};
var $mdgriffith$elm_ui$Element$paragraph = F2(
	function (attrs, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asParagraph,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$Describe($mdgriffith$elm_ui$Internal$Model$Paragraph),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$spacing(5),
						attrs))),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
	});
var $author$project$R10$FormComponents$Binary$viewBinaryCheckbox = F2(
	function (attrs, args) {
		return A2(
			$mdgriffith$elm_ui$Element$row,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(20)),
						$mdgriffith$elm_ui$Element$spacing(15)
					]),
				_Utils_ap(
					args.disabled ? _List_fromArray(
						[
							$mdgriffith$elm_ui$Element$alpha(0.38)
						]) : _List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Events$onClick(args.msgOnClick),
							$mdgriffith$elm_ui$Element$pointer,
							$mdgriffith$elm_ui$Element$htmlAttribute(
							$elm$html$Html$Attributes$tabindex(0)),
							$mdgriffith$elm_ui$Element$htmlAttribute(
							$author$project$R10$FormComponents$UI$onSelectKey(args.msgOnClick)),
							$mdgriffith$elm_ui$Element$Events$onFocus(args.msgOnFocus),
							$mdgriffith$elm_ui$Element$Events$onLoseFocus(args.msgOnLoseFocus)
						]),
					attrs)),
			_List_fromArray(
				[
					A2($author$project$R10$FormComponents$Binary$checkboxIcon, args, args.value),
					A2(
					$mdgriffith$elm_ui$Element$paragraph,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$Font$alignLeft,
							$mdgriffith$elm_ui$Element$htmlAttribute(
							$elm$html$Html$Attributes$id('ie-flex-fix'))
						]),
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$text(args.label)
						]))
				]));
	});
var $mdgriffith$elm_ui$Element$moveRight = function (x) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$TransformComponent,
		$mdgriffith$elm_ui$Internal$Flag$moveX,
		$mdgriffith$elm_ui$Internal$Model$MoveX(x));
};
var $author$project$R10$FormComponents$UI$Color$primaryVariant = A2(
	$elm$core$Basics$composeR,
	function ($) {
		return $.primaryVariant;
	},
	$author$project$R10$FormComponents$UI$Color$fromPaletteColor);
var $author$project$R10$FormComponents$UI$Color$surface = A2(
	$elm$core$Basics$composeR,
	function ($) {
		return $.surface;
	},
	$author$project$R10$FormComponents$UI$Color$fromPaletteColor);
var $author$project$R10$FormComponents$Binary$viewBinarySwitch = F2(
	function (attrs, args) {
		var _v0 = args.value ? {thumbColor: $author$project$R10$FormComponents$UI$Color$primary, trackColor: $author$project$R10$FormComponents$UI$Color$primaryVariant} : {
			thumbColor: $author$project$R10$FormComponents$UI$Color$surface,
			trackColor: $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.37)
		};
		var trackColor = _v0.trackColor;
		var thumbColor = _v0.thumbColor;
		var thumb = A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(20)),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(20)),
					$mdgriffith$elm_ui$Element$Border$rounded(24),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'transition', 'all 0.14s ')),
					$mdgriffith$elm_ui$Element$centerY,
					$mdgriffith$elm_ui$Element$centerX,
					$mdgriffith$elm_ui$Element$Background$color(
					thumbColor(args.palette)),
					$mdgriffith$elm_ui$Element$Border$shadow(
					{
						blur: 2,
						color: trackColor(args.palette),
						offset: _Utils_Tuple2(0, 1),
						size: 1
					})
				]),
			$mdgriffith$elm_ui$Element$none);
		var track = A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$centerX,
					$mdgriffith$elm_ui$Element$centerY,
					$mdgriffith$elm_ui$Element$Border$rounded(36),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(36)),
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(14)),
					$mdgriffith$elm_ui$Element$Background$color(
					trackColor(args.palette))
				]),
			$mdgriffith$elm_ui$Element$none);
		var _switch = A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(56)),
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(40)),
					$mdgriffith$elm_ui$Element$inFront(
					A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$htmlAttribute(
								A2($elm$html$Html$Attributes$style, 'transition', 'all 0.13s')),
								args.value ? $mdgriffith$elm_ui$Element$moveRight(16) : $mdgriffith$elm_ui$Element$moveRight(0)
							]),
						A2($author$project$R10$FormComponents$UI$viewSelectShadow, args, thumb))),
					$mdgriffith$elm_ui$Element$behindContent(track)
				]),
			$mdgriffith$elm_ui$Element$none);
		return A2(
			$mdgriffith$elm_ui$Element$row,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(15),
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(20))
					]),
				_Utils_ap(
					args.disabled ? _List_fromArray(
						[
							$mdgriffith$elm_ui$Element$alpha(0.38)
						]) : _List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Events$onClick(args.msgOnClick),
							$mdgriffith$elm_ui$Element$pointer,
							$mdgriffith$elm_ui$Element$htmlAttribute(
							$elm$html$Html$Attributes$tabindex(0)),
							$mdgriffith$elm_ui$Element$htmlAttribute(
							$author$project$R10$FormComponents$UI$onSelectKey(args.msgOnClick)),
							$mdgriffith$elm_ui$Element$Events$onFocus(args.msgOnFocus),
							$mdgriffith$elm_ui$Element$Events$onLoseFocus(args.msgOnLoseFocus)
						]),
					attrs)),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$paragraph,
					_List_Nil,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$text(args.label)
						])),
					_switch
				]));
	});
var $mdgriffith$elm_ui$Internal$Flag$fontWeight = $mdgriffith$elm_ui$Internal$Flag$flag(13);
var $mdgriffith$elm_ui$Element$Font$bold = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$fontWeight, $mdgriffith$elm_ui$Internal$Style$classes.bold);
var $author$project$R10$SimpleMarkdown$elementBoldGenerator = function (string) {
	return A2(
		$mdgriffith$elm_ui$Element$el,
		_List_fromArray(
			[$mdgriffith$elm_ui$Element$Font$bold]),
		$mdgriffith$elm_ui$Element$text(string));
};
var $author$project$R10$SimpleMarkdown$elementLabelGenerator = function (string) {
	return $mdgriffith$elm_ui$Element$text(string);
};
var $author$project$R10$SimpleMarkdown$elementLinkGeneratorAdvanced = F3(
	function (attrs, linkLabel, url) {
		return A2(
			$mdgriffith$elm_ui$Element$newTabLink,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Border$rounded(4),
						$mdgriffith$elm_ui$Element$focused(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Border$innerShadow(
								{
									blur: 1,
									color: A3($mdgriffith$elm_ui$Element$rgb, 0.7, 0.7, 0.7),
									offset: _Utils_Tuple2(0, 0),
									size: 1
								})
							])),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						$elm$html$Html$Attributes$tabindex(0))
					]),
				attrs.link),
			{
				label: $author$project$R10$SimpleMarkdown$elementLabelGenerator(linkLabel),
				url: url
			});
	});
var $author$project$R10$SimpleMarkdown$elementTextGenerator = function (string) {
	return $mdgriffith$elm_ui$Element$text(string);
};
var $author$project$R10$SimpleMarkdown$MarkDownText = function (a) {
	return {$: 'MarkDownText', a: a};
};
var $elm$regex$Regex$find = _Regex_findAtMost(_Regex_infinity);
var $elm$core$Array$fromListHelp = F3(
	function (list, nodeList, nodeListSize) {
		fromListHelp:
		while (true) {
			var _v0 = A2($elm$core$Elm$JsArray$initializeFromList, $elm$core$Array$branchFactor, list);
			var jsArray = _v0.a;
			var remainingItems = _v0.b;
			if (_Utils_cmp(
				$elm$core$Elm$JsArray$length(jsArray),
				$elm$core$Array$branchFactor) < 0) {
				return A2(
					$elm$core$Array$builderToArray,
					true,
					{nodeList: nodeList, nodeListSize: nodeListSize, tail: jsArray});
			} else {
				var $temp$list = remainingItems,
					$temp$nodeList = A2(
					$elm$core$List$cons,
					$elm$core$Array$Leaf(jsArray),
					nodeList),
					$temp$nodeListSize = nodeListSize + 1;
				list = $temp$list;
				nodeList = $temp$nodeList;
				nodeListSize = $temp$nodeListSize;
				continue fromListHelp;
			}
		}
	});
var $elm$core$Array$fromList = function (list) {
	if (!list.b) {
		return $elm$core$Array$empty;
	} else {
		return A3($elm$core$Array$fromListHelp, list, _List_Nil, 0);
	}
};
var $elm$core$Bitwise$shiftRightZfBy = _Bitwise_shiftRightZfBy;
var $elm$core$Array$bitMask = 4294967295 >>> (32 - $elm$core$Array$shiftStep);
var $elm$core$Elm$JsArray$unsafeGet = _JsArray_unsafeGet;
var $elm$core$Array$getHelp = F3(
	function (shift, index, tree) {
		getHelp:
		while (true) {
			var pos = $elm$core$Array$bitMask & (index >>> shift);
			var _v0 = A2($elm$core$Elm$JsArray$unsafeGet, pos, tree);
			if (_v0.$ === 'SubTree') {
				var subTree = _v0.a;
				var $temp$shift = shift - $elm$core$Array$shiftStep,
					$temp$index = index,
					$temp$tree = subTree;
				shift = $temp$shift;
				index = $temp$index;
				tree = $temp$tree;
				continue getHelp;
			} else {
				var values = _v0.a;
				return A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, values);
			}
		}
	});
var $elm$core$Array$tailIndex = function (len) {
	return (len >>> 5) << 5;
};
var $elm$core$Array$get = F2(
	function (index, _v0) {
		var len = _v0.a;
		var startShift = _v0.b;
		var tree = _v0.c;
		var tail = _v0.d;
		return ((index < 0) || (_Utils_cmp(index, len) > -1)) ? $elm$core$Maybe$Nothing : ((_Utils_cmp(
			index,
			$elm$core$Array$tailIndex(len)) > -1) ? $elm$core$Maybe$Just(
			A2($elm$core$Elm$JsArray$unsafeGet, $elm$core$Array$bitMask & index, tail)) : $elm$core$Maybe$Just(
			A3($elm$core$Array$getHelp, startShift, index, tree)));
	});
var $author$project$R10$SimpleMarkdown$MarkDownBold = function (a) {
	return {$: 'MarkDownBold', a: a};
};
var $author$project$R10$SimpleMarkdown$markDownParseBoldData = function (data) {
	var text1 = A2(
		$elm$core$Maybe$withDefault,
		'',
		$elm$core$List$head(data));
	return $author$project$R10$SimpleMarkdown$MarkDownBold(text1);
};
var $author$project$R10$SimpleMarkdown$regexForBold = $elm$regex$Regex$fromString('\\*\\*([^*]*)\\*\\*');
var $elm$regex$Regex$split = _Regex_splitAtMost(_Regex_infinity);
var $author$project$R10$SimpleMarkdown$parseTextForBold = function (text) {
	var _v0 = function () {
		var _v1 = $author$project$R10$SimpleMarkdown$regexForBold;
		if (_v1.$ === 'Just') {
			var regex = _v1.a;
			return _Utils_Tuple2(
				A2($elm$regex$Regex$find, regex, text),
				A2($elm$regex$Regex$split, regex, text));
		} else {
			return _Utils_Tuple2(_List_Nil, _List_Nil);
		}
	}();
	var find = _v0.a;
	var split = _v0.b;
	return $elm$core$List$concat(
		A2(
			$elm$core$List$indexedMap,
			F2(
				function (index, splitted) {
					var maybeGetFinding = function () {
						var _v3 = A2(
							$elm$core$Array$get,
							index,
							$elm$core$Array$fromList(find));
						if (_v3.$ === 'Just') {
							var match = _v3.a;
							return $elm$core$Maybe$Just(
								A2(
									$elm$core$List$map,
									function (item_) {
										if (item_.$ === 'Just') {
											var i = item_.a;
											return i;
										} else {
											return '';
										}
									},
									match.submatches));
						} else {
							return $elm$core$Maybe$Nothing;
						}
					}();
					if (maybeGetFinding.$ === 'Just') {
						var getFinding = maybeGetFinding.a;
						return _List_fromArray(
							[
								$author$project$R10$SimpleMarkdown$MarkDownText(splitted),
								$author$project$R10$SimpleMarkdown$markDownParseBoldData(getFinding)
							]);
					} else {
						return _List_fromArray(
							[
								$author$project$R10$SimpleMarkdown$MarkDownText(splitted)
							]);
					}
				}),
			split));
};
var $author$project$R10$SimpleMarkdown$MarkDownLink = F2(
	function (a, b) {
		return {$: 'MarkDownLink', a: a, b: b};
	});
var $elm$core$List$tail = function (list) {
	if (list.b) {
		var x = list.a;
		var xs = list.b;
		return $elm$core$Maybe$Just(xs);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $author$project$R10$SimpleMarkdown$markDownParseLinkData = function (data) {
	var text2 = A2(
		$elm$core$Maybe$withDefault,
		'',
		$elm$core$List$head(
			A2(
				$elm$core$Maybe$withDefault,
				_List_Nil,
				$elm$core$List$tail(data))));
	var text1 = A2(
		$elm$core$Maybe$withDefault,
		'',
		$elm$core$List$head(data));
	return A2($author$project$R10$SimpleMarkdown$MarkDownLink, text1, text2);
};
var $author$project$R10$SimpleMarkdown$regexForLinks = $elm$regex$Regex$fromString('\\[([^\\[\\]]+)\\]\\(([^()]+)\\)');
var $author$project$R10$SimpleMarkdown$parseTextForLinks = function (text) {
	var _v0 = function () {
		var _v1 = $author$project$R10$SimpleMarkdown$regexForLinks;
		if (_v1.$ === 'Just') {
			var regex = _v1.a;
			return _Utils_Tuple2(
				A2($elm$regex$Regex$find, regex, text),
				A2($elm$regex$Regex$split, regex, text));
		} else {
			return _Utils_Tuple2(_List_Nil, _List_Nil);
		}
	}();
	var find = _v0.a;
	var split = _v0.b;
	return $elm$core$List$concat(
		A2(
			$elm$core$List$indexedMap,
			F2(
				function (index, splitted) {
					var maybeGetFinding = function () {
						var _v3 = A2(
							$elm$core$Array$get,
							index,
							$elm$core$Array$fromList(find));
						if (_v3.$ === 'Just') {
							var match = _v3.a;
							return $elm$core$Maybe$Just(
								A2(
									$elm$core$List$map,
									function (item_) {
										if (item_.$ === 'Just') {
											var i = item_.a;
											return i;
										} else {
											return '';
										}
									},
									match.submatches));
						} else {
							return $elm$core$Maybe$Nothing;
						}
					}();
					if (maybeGetFinding.$ === 'Just') {
						var getFinding = maybeGetFinding.a;
						return _List_fromArray(
							[
								$author$project$R10$SimpleMarkdown$MarkDownText(splitted),
								$author$project$R10$SimpleMarkdown$markDownParseLinkData(getFinding)
							]);
					} else {
						return _List_fromArray(
							[
								$author$project$R10$SimpleMarkdown$MarkDownText(splitted)
							]);
					}
				}),
			split));
};
var $author$project$R10$SimpleMarkdown$markdown = F4(
	function (boldGenerator, textGenerator, linkGenerator, string) {
		var step1 = $author$project$R10$SimpleMarkdown$parseTextForLinks(string);
		var step2 = $elm$core$List$concat(
			A2(
				$elm$core$List$map,
				function (item) {
					if (item.$ === 'MarkDownText') {
						var string_ = item.a;
						return $author$project$R10$SimpleMarkdown$parseTextForBold(string_);
					} else {
						return _List_fromArray(
							[item]);
					}
				},
				step1));
		return A2(
			$elm$core$List$map,
			function (item) {
				switch (item.$) {
					case 'MarkDownText':
						var text = item.a;
						return textGenerator(text);
					case 'MarkDownBold':
						var text = item.a;
						return boldGenerator(text);
					default:
						var linkLabel = item.a;
						var url = item.b;
						return A2(linkGenerator, linkLabel, url);
				}
			},
			step2);
	});
var $author$project$R10$SimpleMarkdown$elementMarkdownAdvanced = F2(
	function (attrs, string) {
		return A4(
			$author$project$R10$SimpleMarkdown$markdown,
			$author$project$R10$SimpleMarkdown$elementBoldGenerator,
			$author$project$R10$SimpleMarkdown$elementTextGenerator,
			$author$project$R10$SimpleMarkdown$elementLinkGeneratorAdvanced(attrs),
			string);
	});
var $author$project$R10$FormComponents$UI$viewHelperText = F3(
	function (palette, attrs, maybeHelperText) {
		if (maybeHelperText.$ === 'Just') {
			var helperText = maybeHelperText.a;
			return A2(
				$mdgriffith$elm_ui$Element$paragraph,
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Font$color(
							$author$project$R10$FormComponents$UI$Color$label(palette))
						]),
					attrs),
				A2(
					$author$project$R10$SimpleMarkdown$elementMarkdownAdvanced,
					{
						link: _List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								$author$project$R10$FormComponents$UI$Color$primary(palette))
							])
					},
					helperText));
		} else {
			return $mdgriffith$elm_ui$Element$none;
		}
	});
var $author$project$R10$FormComponents$Binary$view = F2(
	function (attrs, args) {
		return A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$centerY
				]),
			_List_fromArray(
				[
					function () {
					var _v0 = args.typeBinary;
					if (_v0.$ === 'BinarySwitch') {
						return A2($author$project$R10$FormComponents$Binary$viewBinarySwitch, attrs, args);
					} else {
						return A2($author$project$R10$FormComponents$Binary$viewBinaryCheckbox, attrs, args);
					}
				}(),
					A3(
					$author$project$R10$FormComponents$UI$viewHelperText,
					args.palette,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Font$size(14),
							$mdgriffith$elm_ui$Element$alpha(0.5),
							$mdgriffith$elm_ui$Element$paddingEach(
							{bottom: 0, left: 0, right: 0, top: $author$project$R10$FormComponents$UI$genericSpacing})
						]),
					args.helperText)
				]));
	});
var $author$project$R10$Form$Internal$MakerForView$viewBinary = F3(
	function (args, typeBinary, formConf) {
		var value = $author$project$R10$Form$Internal$Helpers$stringToBool(args.fieldState.value);
		var msgOnClick = A4(
			$author$project$R10$Form$Msg$ChangeValue,
			args.key,
			args.fieldConf,
			formConf,
			$author$project$R10$Form$Internal$Helpers$boolToString(!value));
		return A2(
			$author$project$R10$FormComponents$Binary$view,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width(
					A2(
						$mdgriffith$elm_ui$Element$maximum,
						900,
						A2($mdgriffith$elm_ui$Element$minimum, 300, $mdgriffith$elm_ui$Element$fill)))
				]),
			{
				disabled: args.fieldState.disabled,
				focused: args.focused,
				helperText: args.fieldConf.helperText,
				label: args.fieldConf.label,
				msgOnChange: function (_v0) {
					return msgOnClick;
				},
				msgOnClick: msgOnClick,
				msgOnFocus: $author$project$R10$Form$Msg$GetFocus(args.key),
				msgOnLoseFocus: A2($author$project$R10$Form$Msg$LoseFocus, args.key, args.fieldConf),
				palette: args.palette,
				typeBinary: $author$project$R10$Form$Internal$Converter$binaryTypeFromFieldConfToComponent(typeBinary),
				validation: A3($author$project$R10$Form$Internal$Converter$fromFieldStateValidationToComponentValidation, args.fieldConf.validationSpecs, args.fieldState.validation, args.translator),
				value: value
			});
	});
var $author$project$R10$FormComponents$Single$Common$SingleCombobox = {$: 'SingleCombobox'};
var $author$project$R10$FormComponents$Single$Common$SingleRadio = {$: 'SingleRadio'};
var $author$project$R10$Form$Internal$Converter$singleTypeFromFieldConfToComponent = function (typeText) {
	if (typeText.$ === 'SingleRadio') {
		return $author$project$R10$FormComponents$Single$Common$SingleRadio;
	} else {
		return $author$project$R10$FormComponents$Single$Common$SingleCombobox;
	}
};
var $author$project$R10$FormComponents$Single$Common$OnOptionSelect = function (a) {
	return {$: 'OnOptionSelect', a: a};
};
var $elm$core$String$trim = _String_trim;
var $author$project$R10$FormComponents$Single$normalizeString = A2($elm$core$Basics$composeR, $elm$core$String$toLower, $elm$core$String$trim);
var $author$project$R10$FormComponents$Single$defaultSearchFn = F2(
	function (search, opt) {
		return A2(
			$elm$core$String$contains,
			$author$project$R10$FormComponents$Single$normalizeString(search),
			$author$project$R10$FormComponents$Single$normalizeString(opt.label));
	});
var $author$project$R10$SimpleMarkdown$elementLinkGenerator = F2(
	function (linkLabel, url) {
		return A2(
			$mdgriffith$elm_ui$Element$newTabLink,
			_List_Nil,
			{
				label: $author$project$R10$SimpleMarkdown$elementLabelGenerator(linkLabel),
				url: url
			});
	});
var $author$project$R10$SimpleMarkdown$elementMarkdown = function (string) {
	return A4($author$project$R10$SimpleMarkdown$markdown, $author$project$R10$SimpleMarkdown$elementBoldGenerator, $author$project$R10$SimpleMarkdown$elementTextGenerator, $author$project$R10$SimpleMarkdown$elementLinkGenerator, string);
};
var $elm_community$string_extra$String$Extra$replaceSlice = F4(
	function (substitution, start, end, string) {
		return _Utils_ap(
			A3($elm$core$String$slice, 0, start, string),
			_Utils_ap(
				substitution,
				A3(
					$elm$core$String$slice,
					end,
					$elm$core$String$length(string),
					string)));
	});
var $elm_community$string_extra$String$Extra$insertAt = F3(
	function (insert, pos, string) {
		return A4($elm_community$string_extra$String$Extra$replaceSlice, insert, pos, pos, string);
	});
var $author$project$R10$FormComponents$Utils$stringInsertAtMulti = F3(
	function (insert, positions, string) {
		var insertLen = $elm$core$String$length(insert);
		var insertAtOffset = F2(
			function (pos, _v0) {
				var str = _v0.str;
				var offset = _v0.offset;
				return {
					offset: offset + insertLen,
					str: A3($elm_community$string_extra$String$Extra$insertAt, insert, pos + offset, str)
				};
			});
		return A3(
			$elm$core$List$foldl,
			insertAtOffset,
			{offset: 0, str: string},
			positions).str;
	});
var $elm_community$string_extra$String$Extra$surround = F2(
	function (wrapper, string) {
		return _Utils_ap(
			wrapper,
			_Utils_ap(string, wrapper));
	});
var $author$project$R10$FormComponents$Single$insertBold = F2(
	function (indexes, string) {
		return A2(
			$elm_community$string_extra$String$Extra$surround,
			'**',
			A3($author$project$R10$FormComponents$Utils$stringInsertAtMulti, '**', indexes, string));
	});
var $elm$virtual_dom$VirtualDom$MayStopPropagation = function (a) {
	return {$: 'MayStopPropagation', a: a};
};
var $elm$html$Html$Events$stopPropagationOn = F2(
	function (event, decoder) {
		return A2(
			$elm$virtual_dom$VirtualDom$on,
			event,
			$elm$virtual_dom$VirtualDom$MayStopPropagation(decoder));
	});
var $author$project$R10$FormComponents$UI$onClickWithStopPropagation = function (message) {
	return $mdgriffith$elm_ui$Element$htmlAttribute(
		A2(
			$elm$html$Html$Events$stopPropagationOn,
			'click',
			$elm$json$Json$Decode$succeed(
				_Utils_Tuple2(message, true))));
};
var $author$project$R10$FormComponents$Single$defaultToOptionEl = F2(
	function (_v0, _v1) {
		var search = _v0.search;
		var msgOnSelect = _v0.msgOnSelect;
		var label = _v1.label;
		var value = _v1.value;
		var insertPositions = A2(
			$elm$core$List$concatMap,
			function (idx) {
				return _List_fromArray(
					[
						idx,
						idx + $elm$core$String$length(search)
					]);
			},
			A2(
				$elm$core$String$indexes,
				$author$project$R10$FormComponents$Single$normalizeString(search),
				$author$project$R10$FormComponents$Single$normalizeString(label)));
		var withBold = $elm$core$List$isEmpty(insertPositions) ? label : A2($author$project$R10$FormComponents$Single$insertBold, insertPositions, label);
		return A2(
			$mdgriffith$elm_ui$Element$row,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
					$author$project$R10$FormComponents$UI$onClickWithStopPropagation(
					msgOnSelect(value)),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'z-index', '0')),
					$mdgriffith$elm_ui$Element$pointer,
					A2($mdgriffith$elm_ui$Element$paddingXY, 12, 0),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'mask-image', 'linear-gradient(right, rgba(255,255,0,0), rgba(255,255,0, 1) 16px)')),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, '-webkit-mask-image', '-webkit-linear-gradient(right, rgba(255,255,0,0) 10px, rgba(255,255,0, 1) 16px)'))
				]),
			$author$project$R10$SimpleMarkdown$elementMarkdown(withBold));
	});
var $author$project$R10$FormComponents$IconButton$view = F2(
	function (args, _v0) {
		var msgOnClick = _v0.msgOnClick;
		var icon = _v0.icon;
		var palette = _v0.palette;
		var size = _v0.size;
		var padding_ = 8;
		var iconHitboxSize = size + (padding_ * 2);
		var containerSize = 24;
		var moveUp_ = (iconHitboxSize - containerSize) / 2;
		var attrsCommon = _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$Background$color(
				A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0, palette)),
				$mdgriffith$elm_ui$Element$padding(padding_),
				$mdgriffith$elm_ui$Element$centerX,
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2(
					$elm$html$Html$Attributes$style,
					'margin-top',
					'-' + ($elm$core$String$fromFloat(moveUp_) + 'px')))
			]);
		var attrsClickable = function () {
			if (msgOnClick.$ === 'Just') {
				var msgOnClick_ = msgOnClick.a;
				return _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						$elm$html$Html$Attributes$tabindex(0)),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						$author$project$R10$FormComponents$UI$onSelectKey(msgOnClick_)),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2(
							$elm$html$Html$Events$preventDefaultOn,
							'mousedown',
							$elm$json$Json$Decode$succeed(
								_Utils_Tuple2(msgOnClick_, true)))),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						$elm$html$Html$Attributes$class('ripple')),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'transition', 'all 0.13s; margin-top 0s ')),
						$mdgriffith$elm_ui$Element$pointer,
						$mdgriffith$elm_ui$Element$Border$rounded(40),
						$mdgriffith$elm_ui$Element$mouseOver(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Border$innerShadow(
								{
									blur: 0,
									color: A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.07, palette),
									offset: _Utils_Tuple2(0, 0),
									size: 40
								})
							])),
						$mdgriffith$elm_ui$Element$focused(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Background$color(
								A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.14, palette))
							]))
					]);
			} else {
				return _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alpha(0.5)
					]);
			}
		}();
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$px(containerSize)),
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(containerSize))
					]),
				args),
			A2(
				$mdgriffith$elm_ui$Element$el,
				_Utils_ap(attrsCommon, attrsClickable),
				A2(
					$mdgriffith$elm_ui$Element$el,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$centerX,
							$mdgriffith$elm_ui$Element$centerY,
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$px(size)),
							$mdgriffith$elm_ui$Element$height(
							$mdgriffith$elm_ui$Element$px(size))
						]),
					icon)));
	});
var $author$project$R10$FormComponents$Single$defaultTrailingIcon = function (_v0) {
	var opened = _v0.opened;
	var palette = _v0.palette;
	return A2(
		$author$project$R10$FormComponents$IconButton$view,
		_List_Nil,
		{
			icon: A3(
				$author$project$R10$FormComponents$UI$icons.combobox_arrow,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$rotate(
						$elm$core$Basics$degrees(
							opened ? 180 : 0)),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'transition', 'all 0.13s'))
					]),
				$author$project$R10$Color$Utils$elementColorToColor(
					$author$project$R10$FormComponents$UI$Color$label(palette)),
				24),
			msgOnClick: $elm$core$Maybe$Nothing,
			palette: palette,
			size: 24
		});
};
var $author$project$R10$FormComponents$Single$Common$OnArrowDown = function (a) {
	return {$: 'OnArrowDown', a: a};
};
var $author$project$R10$FormComponents$Single$Common$OnArrowUp = function (a) {
	return {$: 'OnArrowUp', a: a};
};
var $author$project$R10$FormComponents$Single$Common$OnEsc = {$: 'OnEsc'};
var $author$project$R10$FormComponents$Single$Common$OnFocus = function (a) {
	return {$: 'OnFocus', a: a};
};
var $author$project$R10$FormComponents$Single$Common$OnLoseFocus = function (a) {
	return {$: 'OnLoseFocus', a: a};
};
var $author$project$R10$FormComponents$Single$Common$OnSearch = F2(
	function (a, b) {
		return {$: 'OnSearch', a: a, b: b};
	});
var $author$project$R10$FormComponents$Text$TextPlain = {$: 'TextPlain'};
var $author$project$R10$FormComponents$Single$Common$isAnyOptionLabelMatched = function (_v0) {
	var value = _v0.value;
	var fieldOptions = _v0.fieldOptions;
	return A2(
		$elm$core$List$any,
		function (option) {
			return _Utils_eq(option.label, value);
		},
		fieldOptions);
};
var $author$project$R10$FormComponents$Single$Combobox$filterBySearch = F2(
	function (search, _v0) {
		var searchFn = _v0.searchFn;
		var fieldOptions = _v0.fieldOptions;
		return ($elm$core$String$isEmpty(search) || $author$project$R10$FormComponents$Single$Common$isAnyOptionLabelMatched(
			{fieldOptions: fieldOptions, value: search})) ? fieldOptions : A2(
			$elm$core$List$filter,
			searchFn(search),
			fieldOptions);
	});
var $author$project$R10$FormComponents$UI$Color$fontA = function (alpha) {
	return $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.87 * alpha);
};
var $author$project$R10$FormComponents$Single$Common$OnInputClick = function (a) {
	return {$: 'OnInputClick', a: a};
};
var $author$project$R10$FormComponents$Single$Combobox$getMsgOnInputClick = F3(
	function (model, args, filteredOptions) {
		var selectedOptionIndex = A2(
			$elm$core$Maybe$withDefault,
			-1,
			A2($author$project$R10$FormComponents$Single$Update$getOptionIndex, filteredOptions, model.value));
		var selectedY = A4(
			$author$project$R10$FormComponents$Single$Update$getOptionY,
			model.scroll,
			args,
			selectedOptionIndex,
			$elm$core$List$length(filteredOptions));
		return $author$project$R10$FormComponents$Single$Common$OnInputClick(selectedY);
	});
var $author$project$R10$FormComponents$Single$Common$isAnyOptionValueMatched = function (_v0) {
	var value = _v0.value;
	var fieldOptions = _v0.fieldOptions;
	return A2(
		$elm$core$List$any,
		function (option) {
			return _Utils_eq(option.value, value);
		},
		fieldOptions);
};
var $author$project$R10$FormComponents$Single$Common$getSelectedOrFirst = F3(
	function (fieldOptions, value, select) {
		return (!$elm$core$String$isEmpty(select)) ? select : ($author$project$R10$FormComponents$Single$Common$isAnyOptionValueMatched(
			{fieldOptions: fieldOptions, value: value}) ? value : A2(
			$elm$core$Maybe$withDefault,
			'',
			A2(
				$elm$core$Maybe$map,
				function ($) {
					return $.value;
				},
				$elm$core$List$head(fieldOptions))));
	});
var $elm$json$Json$Decode$lazy = function (thunk) {
	return A2(
		$elm$json$Json$Decode$andThen,
		thunk,
		$elm$json$Json$Decode$succeed(_Utils_Tuple0));
};
var $elm$json$Json$Decode$oneOf = _Json_oneOf;
var $author$project$R10$FormComponents$Utils$FocusOut$isOutsideDropdown = function (dropdownId) {
	return $elm$json$Json$Decode$oneOf(
		_List_fromArray(
			[
				A2(
				$elm$json$Json$Decode$andThen,
				function (id) {
					return _Utils_eq(dropdownId, id) ? $elm$json$Json$Decode$succeed(false) : $elm$json$Json$Decode$fail('check parent node');
				},
				A2($elm$json$Json$Decode$field, 'id', $elm$json$Json$Decode$string)),
				$elm$json$Json$Decode$lazy(
				function (_v0) {
					return A2(
						$elm$json$Json$Decode$field,
						'parentNode',
						$author$project$R10$FormComponents$Utils$FocusOut$isOutsideDropdown(dropdownId));
				}),
				$elm$json$Json$Decode$succeed(true)
			]));
};
var $author$project$R10$FormComponents$Utils$FocusOut$outsideTarget = F3(
	function (targetName, dropdownId, closeMsg) {
		return A2(
			$elm$json$Json$Decode$andThen,
			function (isOutside) {
				return isOutside ? $elm$json$Json$Decode$succeed(closeMsg) : $elm$json$Json$Decode$fail('inside dropdown');
			},
			A2(
				$elm$json$Json$Decode$field,
				targetName,
				$author$project$R10$FormComponents$Utils$FocusOut$isOutsideDropdown(dropdownId)));
	});
var $author$project$R10$FormComponents$Utils$FocusOut$onFocusOut = F2(
	function (containerId, closeMsg) {
		return A3($author$project$R10$FormComponents$Utils$FocusOut$outsideTarget, 'relatedTarget', containerId, closeMsg);
	});
var $author$project$R10$FormComponents$Single$Combobox$optionsLabelOrSearchValue = F3(
	function (search, value, fieldOptions) {
		return $elm$core$String$isEmpty(search) ? A2(
			$elm$core$Maybe$withDefault,
			{displayValue: search, isActualValueDisplayed: false},
			A2(
				$elm$core$Maybe$map,
				function (label) {
					return {displayValue: label, isActualValueDisplayed: true};
				},
				A2(
					$elm$core$Maybe$map,
					function ($) {
						return $.label;
					},
					A2(
						$elm_community$list_extra$List$Extra$find,
						function (opt) {
							return _Utils_eq(opt.value, value);
						},
						fieldOptions)))) : {displayValue: search, isActualValueDisplayed: false};
	});
var $author$project$R10$FormComponents$Single$Common$selectId = function (key) {
	return 'dropdown-' + key;
};
var $author$project$R10$FormComponents$Text$TextMultiline = {$: 'TextMultiline'};
var $author$project$R10$FormComponents$UI$Color$errorA = F2(
	function (alpha, palette) {
		return $author$project$R10$FormComponents$UI$Color$fromPaletteColor(
			A2($author$project$R10$FormComponents$UI$Palette$withOpacity, alpha, palette.error));
	});
var $author$project$R10$FormComponents$UI$getBorderColor = function (_v0) {
	var disabled = _v0.disabled;
	var focused = _v0.focused;
	var style = _v0.style;
	var valid = _v0.valid;
	var displayValidation = _v0.displayValidation;
	var isMouseOver = _v0.isMouseOver;
	var palette = _v0.palette;
	var validationActive = displayValidation && _Utils_eq(
		valid,
		$elm$core$Maybe$Just(false));
	var alpha = ((!disabled) && (focused || (isMouseOver || validationActive))) ? 1 : 0.5;
	if (style.$ === 'Filled') {
		var _v2 = _Utils_Tuple3(displayValidation, valid, focused);
		if ((_v2.a && (_v2.b.$ === 'Just')) && (!_v2.b.a)) {
			return A2($author$project$R10$FormComponents$UI$Color$errorA, alpha, palette);
		} else {
			return A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.3 * alpha, palette);
		}
	} else {
		var _v3 = _Utils_Tuple3(displayValidation, valid, focused);
		_v3$0:
		while (true) {
			if (_v3.c) {
				if ((_v3.a && (_v3.b.$ === 'Just')) && (!_v3.b.a)) {
					break _v3$0;
				} else {
					return A2($author$project$R10$FormComponents$UI$Color$primaryA, alpha, palette);
				}
			} else {
				if ((_v3.a && (_v3.b.$ === 'Just')) && (!_v3.b.a)) {
					break _v3$0;
				} else {
					return A2($author$project$R10$FormComponents$UI$Color$containerA, alpha, palette);
				}
			}
		}
		return A2($author$project$R10$FormComponents$UI$Color$errorA, alpha, palette);
	}
};
var $author$project$R10$FormComponents$UI$getTextfieldBorderSizeOffset = function (_v0) {
	var focused = _v0.focused;
	var style = _v0.style;
	var valid = _v0.valid;
	var displayValidation = _v0.displayValidation;
	var validationActive = displayValidation && _Utils_eq(
		valid,
		$elm$core$Maybe$Just(false));
	var _v1 = _Utils_Tuple2(validationActive || focused, style);
	if (_v1.a) {
		if (_v1.b.$ === 'Filled') {
			var _v2 = _v1.b;
			return {
				offset: _Utils_Tuple2(0, -2),
				size: 0
			};
		} else {
			var _v3 = _v1.b;
			return {
				offset: _Utils_Tuple2(0, 0),
				size: 2
			};
		}
	} else {
		if (_v1.b.$ === 'Filled') {
			var _v4 = _v1.b;
			return {
				offset: _Utils_Tuple2(0, -1),
				size: 0
			};
		} else {
			var _v5 = _v1.b;
			return {
				offset: _Utils_Tuple2(0, 0),
				size: 1
			};
		}
	}
};
var $author$project$R10$FormComponents$Text$getBorder = function (args) {
	var _v0 = $author$project$R10$FormComponents$UI$getTextfieldBorderSizeOffset(args);
	var offset = _v0.offset;
	var size = _v0.size;
	return $mdgriffith$elm_ui$Element$Border$innerShadow(
		{
			blur: 0,
			color: $author$project$R10$FormComponents$UI$getBorderColor(args),
			offset: offset,
			size: size
		});
};
var $author$project$R10$FormComponents$UI$Const$inputTextHeight = 50;
var $author$project$R10$FormComponents$Validations$isValid = function (validation) {
	if (validation.$ === 'NotYetValidated') {
		return $elm$core$Maybe$Nothing;
	} else {
		var listValidationMessage = validation.a;
		return $elm$core$Maybe$Just(
			A3(
				$elm$core$List$foldl,
				F2(
					function (validationMessage, acc) {
						if (validationMessage.$ === 'MessageErr') {
							return false;
						} else {
							return acc;
						}
					}),
				true,
				listValidationMessage));
	}
};
var $author$project$R10$FormComponents$UI$iconWidth = function (icon) {
	if (icon.$ === 'Just') {
		return 40;
	} else {
		return 0;
	}
};
var $author$project$R10$FormComponents$UI$Const$inputTextFilledDown = 8;
var $author$project$R10$FormComponents$UI$Const$inputTextFontSize = 16;
var $author$project$R10$FormComponents$UI$getTextfieldPaddingEach = function (args) {
	var paddingCenterY = $elm$core$Basics$ceiling(($author$project$R10$FormComponents$UI$Const$inputTextHeight - $author$project$R10$FormComponents$UI$Const$inputTextFontSize) / 2);
	var _v0 = args.style;
	if (_v0.$ === 'Filled') {
		return {
			bottom: paddingCenterY - $author$project$R10$FormComponents$UI$Const$inputTextFilledDown,
			left: 0 + $author$project$R10$FormComponents$UI$iconWidth(args.leadingIcon),
			right: 0 + $author$project$R10$FormComponents$UI$iconWidth(args.trailingIcon),
			top: paddingCenterY + $author$project$R10$FormComponents$UI$Const$inputTextFilledDown
		};
	} else {
		return {
			bottom: paddingCenterY,
			left: A2(
				$elm$core$Basics$max,
				16,
				$author$project$R10$FormComponents$UI$iconWidth(args.leadingIcon)),
			right: A2(
				$elm$core$Basics$max,
				16,
				$author$project$R10$FormComponents$UI$iconWidth(args.trailingIcon)),
			top: paddingCenterY
		};
	}
};
var $mdgriffith$elm_ui$Internal$Model$MoveY = function (a) {
	return {$: 'MoveY', a: a};
};
var $mdgriffith$elm_ui$Internal$Flag$moveY = $mdgriffith$elm_ui$Internal$Flag$flag(26);
var $mdgriffith$elm_ui$Element$moveUp = function (y) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$TransformComponent,
		$mdgriffith$elm_ui$Internal$Flag$moveY,
		$mdgriffith$elm_ui$Internal$Model$MoveY(-y));
};
var $author$project$R10$FormComponents$UI$Color$error = A2(
	$elm$core$Basics$composeR,
	function ($) {
		return $.error;
	},
	$author$project$R10$FormComponents$UI$Color$fromPaletteColor);
var $author$project$R10$FormComponents$UI$textfieldLabelColor = function (_v0) {
	var focused = _v0.focused;
	var style = _v0.style;
	var valid = _v0.valid;
	var displayValidation = _v0.displayValidation;
	var palette = _v0.palette;
	if (style.$ === 'Filled') {
		var _v2 = _Utils_Tuple3(displayValidation, valid, focused);
		if (((_v2.a && (_v2.b.$ === 'Just')) && (!_v2.b.a)) && _v2.c) {
			return $author$project$R10$FormComponents$UI$Color$error(palette);
		} else {
			return $author$project$R10$FormComponents$UI$Color$label(palette);
		}
	} else {
		var _v3 = _Utils_Tuple3(displayValidation, valid, focused);
		if (_v3.c) {
			if ((_v3.a && (_v3.b.$ === 'Just')) && (!_v3.b.a)) {
				return $author$project$R10$FormComponents$UI$Color$error(palette);
			} else {
				return $author$project$R10$FormComponents$UI$Color$primary(palette);
			}
		} else {
			return $author$project$R10$FormComponents$UI$Color$label(palette);
		}
	}
};
var $author$project$R10$FormComponents$UI$labelBuilder = function (args) {
	var requiredEl = function () {
		var _v3 = args.requiredLabel;
		if (_v3.$ === 'Just') {
			var required = _v3.a;
			return A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alpha(0.7)
					]),
				$mdgriffith$elm_ui$Element$text(required));
		} else {
			return $mdgriffith$elm_ui$Element$none;
		}
	}();
	var notchClearance = function () {
		var _v2 = args.style;
		if (_v2.$ === 'Filled') {
			return 0;
		} else {
			return 3;
		}
	}();
	var labelIsAbove = args.focused || ($elm$core$String$length(args.value) > 0);
	var notch = function () {
		var _v1 = args.style;
		if (_v1.$ === 'Filled') {
			return $mdgriffith$elm_ui$Element$none;
		} else {
			return A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'transition', 'all 0.15s')),
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(2)),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$Background$color(
						$author$project$R10$FormComponents$UI$Color$surface(args.palette)),
						$mdgriffith$elm_ui$Element$alpha(
						labelIsAbove ? 1 : 0)
					]),
				$mdgriffith$elm_ui$Element$none);
		}
	}();
	var containerPaddingAttrs = $author$project$R10$FormComponents$UI$getTextfieldPaddingEach(
		_Utils_update(
			args,
			{leadingIcon: $elm$core$Maybe$Nothing}));
	var labelBelowLeftPadding = $author$project$R10$FormComponents$UI$getTextfieldPaddingEach(args).left - containerPaddingAttrs.left;
	var labelAboveAttrs = function () {
		if (labelIsAbove) {
			var _v0 = args.style;
			if (_v0.$ === 'Filled') {
				return _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$moveUp(28),
						$mdgriffith$elm_ui$Element$moveRight(0)
					]);
			} else {
				return _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$moveUp(21),
						$mdgriffith$elm_ui$Element$Font$size(12),
						$mdgriffith$elm_ui$Element$moveRight(0)
					]);
			}
		} else {
			return _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$moveUp(0),
					$mdgriffith$elm_ui$Element$moveRight(labelBelowLeftPadding),
					$mdgriffith$elm_ui$Element$Font$size($author$project$R10$FormComponents$UI$Const$inputTextFontSize)
				]);
		}
	}();
	var labelEl = A2(
		$mdgriffith$elm_ui$Element$el,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'transition', 'all 0.15s')),
				$mdgriffith$elm_ui$Element$paddingEach(
				{bottom: containerPaddingAttrs.bottom, left: notchClearance, right: notchClearance, top: containerPaddingAttrs.top}),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'pointer-events', 'none')),
				$mdgriffith$elm_ui$Element$behindContent(notch),
				$mdgriffith$elm_ui$Element$Border$width(0)
			]),
		A2(
			$mdgriffith$elm_ui$Element$row,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'transition', 'all 0.15s')),
						$mdgriffith$elm_ui$Element$spacing(6),
						$mdgriffith$elm_ui$Element$centerY
					]),
				labelAboveAttrs),
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$text(args.label),
					requiredEl
				])));
	return ($elm$core$String$isEmpty(args.label) && _Utils_eq(args.requiredLabel, $elm$core$Maybe$Nothing)) ? $mdgriffith$elm_ui$Element$none : A2(
		$mdgriffith$elm_ui$Element$el,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$height(
				$mdgriffith$elm_ui$Element$px(0)),
				$mdgriffith$elm_ui$Element$Font$color(
				$author$project$R10$FormComponents$UI$textfieldLabelColor(args)),
				$mdgriffith$elm_ui$Element$paddingEach(
				{bottom: 0, left: containerPaddingAttrs.left - notchClearance, right: containerPaddingAttrs.right, top: 0})
			]),
		labelEl);
};
var $author$project$R10$FormComponents$Text$TextPasswordCurrent = {$: 'TextPasswordCurrent'};
var $author$project$R10$FormComponents$Text$TextPasswordNew = {$: 'TextPasswordNew'};
var $author$project$R10$FormComponents$Text$needShowHideIcon = function (fieldType) {
	return _Utils_eq(fieldType, $author$project$R10$FormComponents$Text$TextPasswordCurrent) || _Utils_eq(fieldType, $author$project$R10$FormComponents$Text$TextPasswordNew);
};
var $author$project$R10$FormComponents$UI$showValidationIcon_ = function (_v0) {
	var maybeValid = _v0.maybeValid;
	var displayValidation = _v0.displayValidation;
	var palette = _v0.palette;
	var widthPx = (displayValidation && _Utils_eq(
		maybeValid,
		$elm$core$Maybe$Just(false))) ? 24 : 0;
	return A3(
		$author$project$R10$FormComponents$UI$icons.sign_warning_f,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'transition', 'width 0.4s')),
				$mdgriffith$elm_ui$Element$width(
				$mdgriffith$elm_ui$Element$px(widthPx)),
				$mdgriffith$elm_ui$Element$height(
				$mdgriffith$elm_ui$Element$px(24)),
				$mdgriffith$elm_ui$Element$clip
			]),
		$author$project$R10$Color$Utils$elementColorToColor(
			$author$project$R10$FormComponents$UI$Color$error(palette)),
		24);
};
var $mdgriffith$elm_ui$Internal$Model$Left = {$: 'Left'};
var $mdgriffith$elm_ui$Element$alignLeft = $mdgriffith$elm_ui$Internal$Model$AlignX($mdgriffith$elm_ui$Internal$Model$Left);
var $mdgriffith$elm_ui$Element$Input$TextInputNode = function (a) {
	return {$: 'TextInputNode', a: a};
};
var $mdgriffith$elm_ui$Element$Input$TextArea = {$: 'TextArea'};
var $mdgriffith$elm_ui$Internal$Model$LivePolite = {$: 'LivePolite'};
var $mdgriffith$elm_ui$Element$Region$announce = $mdgriffith$elm_ui$Internal$Model$Describe($mdgriffith$elm_ui$Internal$Model$LivePolite);
var $mdgriffith$elm_ui$Element$Input$applyLabel = F3(
	function (attrs, label, input) {
		if (label.$ === 'HiddenLabel') {
			var labelText = label.a;
			return A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asColumn,
				$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
				attrs,
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(
					_List_fromArray(
						[input])));
		} else {
			var position = label.a;
			var labelAttrs = label.b;
			var labelChild = label.c;
			var labelElement = A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asEl,
				$mdgriffith$elm_ui$Internal$Model$div,
				labelAttrs,
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(
					_List_fromArray(
						[labelChild])));
			switch (position.$) {
				case 'Above':
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asColumn,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[labelElement, input])));
				case 'Below':
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asColumn,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[input, labelElement])));
				case 'OnRight':
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asRow,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[input, labelElement])));
				default:
					return A4(
						$mdgriffith$elm_ui$Internal$Model$element,
						$mdgriffith$elm_ui$Internal$Model$asRow,
						$mdgriffith$elm_ui$Internal$Model$NodeName('label'),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputLabel),
							attrs),
						$mdgriffith$elm_ui$Internal$Model$Unkeyed(
							_List_fromArray(
								[labelElement, input])));
			}
		}
	});
var $mdgriffith$elm_ui$Element$Input$autofill = A2(
	$elm$core$Basics$composeL,
	$mdgriffith$elm_ui$Internal$Model$Attr,
	$elm$html$Html$Attributes$attribute('autocomplete'));
var $mdgriffith$elm_ui$Element$Input$calcMoveToCompensateForPadding = function (attrs) {
	var gatherSpacing = F2(
		function (attr, found) {
			if ((attr.$ === 'StyleClass') && (attr.b.$ === 'SpacingStyle')) {
				var _v2 = attr.b;
				var x = _v2.b;
				var y = _v2.c;
				if (found.$ === 'Nothing') {
					return $elm$core$Maybe$Just(y);
				} else {
					return found;
				}
			} else {
				return found;
			}
		});
	var _v0 = A3($elm$core$List$foldr, gatherSpacing, $elm$core$Maybe$Nothing, attrs);
	if (_v0.$ === 'Nothing') {
		return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
	} else {
		var vSpace = _v0.a;
		return $mdgriffith$elm_ui$Element$moveUp(
			$elm$core$Basics$floor(vSpace / 2));
	}
};
var $mdgriffith$elm_ui$Element$Input$darkGrey = A3($mdgriffith$elm_ui$Element$rgb, 186 / 255, 189 / 255, 182 / 255);
var $mdgriffith$elm_ui$Element$Input$defaultTextPadding = A2($mdgriffith$elm_ui$Element$paddingXY, 12, 12);
var $mdgriffith$elm_ui$Element$Input$white = A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1);
var $mdgriffith$elm_ui$Element$Input$defaultTextBoxStyle = _List_fromArray(
	[
		$mdgriffith$elm_ui$Element$Input$defaultTextPadding,
		$mdgriffith$elm_ui$Element$Border$rounded(3),
		$mdgriffith$elm_ui$Element$Border$color($mdgriffith$elm_ui$Element$Input$darkGrey),
		$mdgriffith$elm_ui$Element$Background$color($mdgriffith$elm_ui$Element$Input$white),
		$mdgriffith$elm_ui$Element$Border$width(1),
		$mdgriffith$elm_ui$Element$spacing(5),
		$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
		$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink)
	]);
var $mdgriffith$elm_ui$Element$Input$getHeight = function (attr) {
	if (attr.$ === 'Height') {
		var h = attr.a;
		return $elm$core$Maybe$Just(h);
	} else {
		return $elm$core$Maybe$Nothing;
	}
};
var $mdgriffith$elm_ui$Internal$Model$Label = function (a) {
	return {$: 'Label', a: a};
};
var $mdgriffith$elm_ui$Element$Input$hiddenLabelAttribute = function (label) {
	if (label.$ === 'HiddenLabel') {
		var textLabel = label.a;
		return $mdgriffith$elm_ui$Internal$Model$Describe(
			$mdgriffith$elm_ui$Internal$Model$Label(textLabel));
	} else {
		return $mdgriffith$elm_ui$Internal$Model$NoAttribute;
	}
};
var $mdgriffith$elm_ui$Element$Input$isConstrained = function (len) {
	isConstrained:
	while (true) {
		switch (len.$) {
			case 'Content':
				return false;
			case 'Px':
				return true;
			case 'Fill':
				return true;
			case 'Min':
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isConstrained;
			default:
				var l = len.b;
				return true;
		}
	}
};
var $mdgriffith$elm_ui$Element$Input$isHiddenLabel = function (label) {
	if (label.$ === 'HiddenLabel') {
		return true;
	} else {
		return false;
	}
};
var $mdgriffith$elm_ui$Element$Input$isStacked = function (label) {
	if (label.$ === 'Label') {
		var loc = label.a;
		switch (loc.$) {
			case 'OnRight':
				return false;
			case 'OnLeft':
				return false;
			case 'Above':
				return true;
			default:
				return true;
		}
	} else {
		return true;
	}
};
var $mdgriffith$elm_ui$Element$Input$negateBox = function (box) {
	return {bottom: -box.bottom, left: -box.left, right: -box.right, top: -box.top};
};
var $elm$html$Html$Events$alwaysStop = function (x) {
	return _Utils_Tuple2(x, true);
};
var $elm$json$Json$Decode$at = F2(
	function (fields, decoder) {
		return A3($elm$core$List$foldr, $elm$json$Json$Decode$field, decoder, fields);
	});
var $elm$html$Html$Events$targetValue = A2(
	$elm$json$Json$Decode$at,
	_List_fromArray(
		['target', 'value']),
	$elm$json$Json$Decode$string);
var $elm$html$Html$Events$onInput = function (tagger) {
	return A2(
		$elm$html$Html$Events$stopPropagationOn,
		'input',
		A2(
			$elm$json$Json$Decode$map,
			$elm$html$Html$Events$alwaysStop,
			A2($elm$json$Json$Decode$map, tagger, $elm$html$Html$Events$targetValue)));
};
var $mdgriffith$elm_ui$Element$Input$isFill = function (len) {
	isFill:
	while (true) {
		switch (len.$) {
			case 'Fill':
				return true;
			case 'Content':
				return false;
			case 'Px':
				return false;
			case 'Min':
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isFill;
			default:
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isFill;
		}
	}
};
var $mdgriffith$elm_ui$Element$Input$isPixel = function (len) {
	isPixel:
	while (true) {
		switch (len.$) {
			case 'Content':
				return false;
			case 'Px':
				return true;
			case 'Fill':
				return false;
			case 'Min':
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isPixel;
			default:
				var l = len.b;
				var $temp$len = l;
				len = $temp$len;
				continue isPixel;
		}
	}
};
var $mdgriffith$elm_ui$Internal$Model$paddingNameFloat = F4(
	function (top, right, bottom, left) {
		return 'pad-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(top) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(right) + ('-' + ($mdgriffith$elm_ui$Internal$Model$floatClass(bottom) + ('-' + $mdgriffith$elm_ui$Internal$Model$floatClass(left)))))));
	});
var $mdgriffith$elm_ui$Element$Input$redistributeOver = F4(
	function (isMultiline, stacked, attr, els) {
		switch (attr.$) {
			case 'Nearby':
				return _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					});
			case 'Width':
				var width = attr.a;
				return $mdgriffith$elm_ui$Element$Input$isFill(width) ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent),
						input: A2($elm$core$List$cons, attr, els.input),
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : (stacked ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent)
					}) : _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					}));
			case 'Height':
				var height = attr.a;
				return (!stacked) ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent),
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : ($mdgriffith$elm_ui$Element$Input$isFill(height) ? _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent),
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : ($mdgriffith$elm_ui$Element$Input$isPixel(height) ? _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					}) : _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					})));
			case 'AlignX':
				return _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent)
					});
			case 'AlignY':
				return _Utils_update(
					els,
					{
						fullParent: A2($elm$core$List$cons, attr, els.fullParent)
					});
			case 'StyleClass':
				switch (attr.b.$) {
					case 'SpacingStyle':
						var _v1 = attr.b;
						return _Utils_update(
							els,
							{
								fullParent: A2($elm$core$List$cons, attr, els.fullParent),
								input: A2($elm$core$List$cons, attr, els.input),
								parent: A2($elm$core$List$cons, attr, els.parent),
								wrapper: A2($elm$core$List$cons, attr, els.wrapper)
							});
					case 'PaddingStyle':
						var cls = attr.a;
						var _v2 = attr.b;
						var pad = _v2.a;
						var t = _v2.b;
						var r = _v2.c;
						var b = _v2.d;
						var l = _v2.e;
						if (isMultiline) {
							return _Utils_update(
								els,
								{
									cover: A2($elm$core$List$cons, attr, els.cover),
									parent: A2($elm$core$List$cons, attr, els.parent)
								});
						} else {
							var newTop = t - A2($elm$core$Basics$min, t, b);
							var newLineHeight = $mdgriffith$elm_ui$Element$htmlAttribute(
								A2(
									$elm$html$Html$Attributes$style,
									'line-height',
									'calc(1.0em + ' + ($elm$core$String$fromFloat(
										2 * A2($elm$core$Basics$min, t, b)) + 'px)')));
							var newHeight = $mdgriffith$elm_ui$Element$htmlAttribute(
								A2(
									$elm$html$Html$Attributes$style,
									'height',
									'calc(1.0em + ' + ($elm$core$String$fromFloat(
										2 * A2($elm$core$Basics$min, t, b)) + 'px)')));
							var newBottom = b - A2($elm$core$Basics$min, t, b);
							var reducedVerticalPadding = A2(
								$mdgriffith$elm_ui$Internal$Model$StyleClass,
								$mdgriffith$elm_ui$Internal$Flag$padding,
								A5(
									$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
									A4($mdgriffith$elm_ui$Internal$Model$paddingNameFloat, newTop, r, newBottom, l),
									newTop,
									r,
									newBottom,
									l));
							return _Utils_update(
								els,
								{
									cover: A2($elm$core$List$cons, attr, els.cover),
									input: A2(
										$elm$core$List$cons,
										newHeight,
										A2($elm$core$List$cons, newLineHeight, els.input)),
									parent: A2($elm$core$List$cons, reducedVerticalPadding, els.parent)
								});
						}
					case 'BorderWidth':
						var _v3 = attr.b;
						return _Utils_update(
							els,
							{
								cover: A2($elm$core$List$cons, attr, els.cover),
								parent: A2($elm$core$List$cons, attr, els.parent)
							});
					case 'Transform':
						return _Utils_update(
							els,
							{
								cover: A2($elm$core$List$cons, attr, els.cover),
								parent: A2($elm$core$List$cons, attr, els.parent)
							});
					case 'FontSize':
						return _Utils_update(
							els,
							{
								fullParent: A2($elm$core$List$cons, attr, els.fullParent)
							});
					case 'FontFamily':
						var _v4 = attr.b;
						return _Utils_update(
							els,
							{
								fullParent: A2($elm$core$List$cons, attr, els.fullParent)
							});
					default:
						var flag = attr.a;
						var cls = attr.b;
						return _Utils_update(
							els,
							{
								parent: A2($elm$core$List$cons, attr, els.parent)
							});
				}
			case 'NoAttribute':
				return els;
			case 'Attr':
				var a = attr.a;
				return _Utils_update(
					els,
					{
						input: A2($elm$core$List$cons, attr, els.input)
					});
			case 'Describe':
				return _Utils_update(
					els,
					{
						input: A2($elm$core$List$cons, attr, els.input)
					});
			case 'Class':
				return _Utils_update(
					els,
					{
						parent: A2($elm$core$List$cons, attr, els.parent)
					});
			default:
				return _Utils_update(
					els,
					{
						input: A2($elm$core$List$cons, attr, els.input)
					});
		}
	});
var $mdgriffith$elm_ui$Element$Input$redistribute = F3(
	function (isMultiline, stacked, attrs) {
		return function (redist) {
			return {
				cover: $elm$core$List$reverse(redist.cover),
				fullParent: $elm$core$List$reverse(redist.fullParent),
				input: $elm$core$List$reverse(redist.input),
				parent: $elm$core$List$reverse(redist.parent),
				wrapper: $elm$core$List$reverse(redist.wrapper)
			};
		}(
			A3(
				$elm$core$List$foldl,
				A2($mdgriffith$elm_ui$Element$Input$redistributeOver, isMultiline, stacked),
				{cover: _List_Nil, fullParent: _List_Nil, input: _List_Nil, parent: _List_Nil, wrapper: _List_Nil},
				attrs));
	});
var $mdgriffith$elm_ui$Element$Input$renderBox = function (_v0) {
	var top = _v0.top;
	var right = _v0.right;
	var bottom = _v0.bottom;
	var left = _v0.left;
	return $elm$core$String$fromInt(top) + ('px ' + ($elm$core$String$fromInt(right) + ('px ' + ($elm$core$String$fromInt(bottom) + ('px ' + ($elm$core$String$fromInt(left) + 'px'))))));
};
var $mdgriffith$elm_ui$Element$Input$charcoal = A3($mdgriffith$elm_ui$Element$rgb, 136 / 255, 138 / 255, 133 / 255);
var $mdgriffith$elm_ui$Element$Input$renderPlaceholder = F3(
	function (_v0, forPlaceholder, on) {
		var placeholderAttrs = _v0.a;
		var placeholderEl = _v0.b;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				forPlaceholder,
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Font$color($mdgriffith$elm_ui$Element$Input$charcoal),
							$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.noTextSelection + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.passPointerEvents)),
							$mdgriffith$elm_ui$Element$clip,
							$mdgriffith$elm_ui$Element$Border$color(
							A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0)),
							$mdgriffith$elm_ui$Element$Background$color(
							A4($mdgriffith$elm_ui$Element$rgba, 0, 0, 0, 0)),
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$alpha(
							on ? 1 : 0)
						]),
					placeholderAttrs)),
			placeholderEl);
	});
var $mdgriffith$elm_ui$Element$scrollbarY = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.scrollbarsY);
var $elm$html$Html$span = _VirtualDom_node('span');
var $elm$html$Html$Attributes$spellcheck = $elm$html$Html$Attributes$boolProperty('spellcheck');
var $mdgriffith$elm_ui$Element$Input$spellcheck = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Attributes$spellcheck);
var $elm$html$Html$Attributes$type_ = $elm$html$Html$Attributes$stringProperty('type');
var $elm$html$Html$Attributes$value = $elm$html$Html$Attributes$stringProperty('value');
var $mdgriffith$elm_ui$Element$Input$value = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Attributes$value);
var $mdgriffith$elm_ui$Element$Input$textHelper = F3(
	function (textInput, attrs, textOptions) {
		var withDefaults = _Utils_ap($mdgriffith$elm_ui$Element$Input$defaultTextBoxStyle, attrs);
		var redistributed = A3(
			$mdgriffith$elm_ui$Element$Input$redistribute,
			_Utils_eq(textInput.type_, $mdgriffith$elm_ui$Element$Input$TextArea),
			$mdgriffith$elm_ui$Element$Input$isStacked(textOptions.label),
			withDefaults);
		var onlySpacing = function (attr) {
			if ((attr.$ === 'StyleClass') && (attr.b.$ === 'SpacingStyle')) {
				var _v9 = attr.b;
				return true;
			} else {
				return false;
			}
		};
		var heightConstrained = function () {
			var _v7 = textInput.type_;
			if (_v7.$ === 'TextInputNode') {
				var inputType = _v7.a;
				return false;
			} else {
				return A2(
					$elm$core$Maybe$withDefault,
					false,
					A2(
						$elm$core$Maybe$map,
						$mdgriffith$elm_ui$Element$Input$isConstrained,
						$elm$core$List$head(
							$elm$core$List$reverse(
								A2($elm$core$List$filterMap, $mdgriffith$elm_ui$Element$Input$getHeight, withDefaults)))));
			}
		}();
		var getPadding = function (attr) {
			if ((attr.$ === 'StyleClass') && (attr.b.$ === 'PaddingStyle')) {
				var cls = attr.a;
				var _v6 = attr.b;
				var pad = _v6.a;
				var t = _v6.b;
				var r = _v6.c;
				var b = _v6.d;
				var l = _v6.e;
				return $elm$core$Maybe$Just(
					{
						bottom: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(b - 3)),
						left: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(l - 3)),
						right: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(r - 3)),
						top: A2(
							$elm$core$Basics$max,
							0,
							$elm$core$Basics$floor(t - 3))
					});
			} else {
				return $elm$core$Maybe$Nothing;
			}
		};
		var parentPadding = A2(
			$elm$core$Maybe$withDefault,
			{bottom: 0, left: 0, right: 0, top: 0},
			$elm$core$List$head(
				$elm$core$List$reverse(
					A2($elm$core$List$filterMap, getPadding, withDefaults))));
		var inputElement = A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asEl,
			function () {
				var _v3 = textInput.type_;
				if (_v3.$ === 'TextInputNode') {
					var inputType = _v3.a;
					return $mdgriffith$elm_ui$Internal$Model$NodeName('input');
				} else {
					return $mdgriffith$elm_ui$Internal$Model$NodeName('textarea');
				}
			}(),
			_Utils_ap(
				function () {
					var _v4 = textInput.type_;
					if (_v4.$ === 'TextInputNode') {
						var inputType = _v4.a;
						return _List_fromArray(
							[
								$mdgriffith$elm_ui$Internal$Model$Attr(
								$elm$html$Html$Attributes$type_(inputType)),
								$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputText)
							]);
					} else {
						return _List_fromArray(
							[
								$mdgriffith$elm_ui$Element$clip,
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputMultiline),
								$mdgriffith$elm_ui$Element$Input$calcMoveToCompensateForPadding(withDefaults),
								$mdgriffith$elm_ui$Element$paddingEach(parentPadding),
								$mdgriffith$elm_ui$Internal$Model$Attr(
								A2(
									$elm$html$Html$Attributes$style,
									'margin',
									$mdgriffith$elm_ui$Element$Input$renderBox(
										$mdgriffith$elm_ui$Element$Input$negateBox(parentPadding)))),
								$mdgriffith$elm_ui$Internal$Model$Attr(
								A2($elm$html$Html$Attributes$style, 'box-sizing', 'content-box'))
							]);
					}
				}(),
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Input$value(textOptions.text),
							$mdgriffith$elm_ui$Internal$Model$Attr(
							$elm$html$Html$Events$onInput(textOptions.onChange)),
							$mdgriffith$elm_ui$Element$Input$hiddenLabelAttribute(textOptions.label),
							$mdgriffith$elm_ui$Element$Input$spellcheck(textInput.spellchecked),
							A2(
							$elm$core$Maybe$withDefault,
							$mdgriffith$elm_ui$Internal$Model$NoAttribute,
							A2($elm$core$Maybe$map, $mdgriffith$elm_ui$Element$Input$autofill, textInput.autofill))
						]),
					redistributed.input)),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(_List_Nil));
		var wrappedInput = function () {
			var _v0 = textInput.type_;
			if (_v0.$ === 'TextArea') {
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asEl,
					$mdgriffith$elm_ui$Internal$Model$div,
					_Utils_ap(
						(heightConstrained ? $elm$core$List$cons($mdgriffith$elm_ui$Element$scrollbarY) : $elm$core$Basics$identity)(
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
									A2($elm$core$List$any, $mdgriffith$elm_ui$Element$Input$hasFocusStyle, withDefaults) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.focusedWithin),
									$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineWrapper)
								])),
						redistributed.parent),
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(
						_List_fromArray(
							[
								A4(
								$mdgriffith$elm_ui$Internal$Model$element,
								$mdgriffith$elm_ui$Internal$Model$asParagraph,
								$mdgriffith$elm_ui$Internal$Model$div,
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
									A2(
										$elm$core$List$cons,
										$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
										A2(
											$elm$core$List$cons,
											$mdgriffith$elm_ui$Element$inFront(inputElement),
											A2(
												$elm$core$List$cons,
												$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineParent),
												redistributed.wrapper)))),
								$mdgriffith$elm_ui$Internal$Model$Unkeyed(
									function () {
										if (textOptions.text === '') {
											var _v1 = textOptions.placeholder;
											if (_v1.$ === 'Nothing') {
												return _List_fromArray(
													[
														$mdgriffith$elm_ui$Element$text('\u00A0')
													]);
											} else {
												var place = _v1.a;
												return _List_fromArray(
													[
														A3($mdgriffith$elm_ui$Element$Input$renderPlaceholder, place, _List_Nil, textOptions.text === '')
													]);
											}
										} else {
											return _List_fromArray(
												[
													$mdgriffith$elm_ui$Internal$Model$unstyled(
													A2(
														$elm$html$Html$span,
														_List_fromArray(
															[
																$elm$html$Html$Attributes$class($mdgriffith$elm_ui$Internal$Style$classes.inputMultilineFiller)
															]),
														_List_fromArray(
															[
																$elm$html$Html$text(textOptions.text + '\u00A0')
															])))
												]);
										}
									}()))
							])));
			} else {
				var inputType = _v0.a;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asEl,
					$mdgriffith$elm_ui$Internal$Model$div,
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						A2(
							$elm$core$List$cons,
							A2($elm$core$List$any, $mdgriffith$elm_ui$Element$Input$hasFocusStyle, withDefaults) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.focusedWithin),
							$elm$core$List$concat(
								_List_fromArray(
									[
										redistributed.parent,
										function () {
										var _v2 = textOptions.placeholder;
										if (_v2.$ === 'Nothing') {
											return _List_Nil;
										} else {
											var place = _v2.a;
											return _List_fromArray(
												[
													$mdgriffith$elm_ui$Element$behindContent(
													A3($mdgriffith$elm_ui$Element$Input$renderPlaceholder, place, redistributed.cover, textOptions.text === ''))
												]);
										}
									}()
									])))),
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(
						_List_fromArray(
							[inputElement])));
			}
		}();
		return A3(
			$mdgriffith$elm_ui$Element$Input$applyLabel,
			A2(
				$elm$core$List$cons,
				A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$cursor, $mdgriffith$elm_ui$Internal$Style$classes.cursorText),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$Input$isHiddenLabel(textOptions.label) ? $mdgriffith$elm_ui$Internal$Model$NoAttribute : $mdgriffith$elm_ui$Element$spacing(5),
					A2($elm$core$List$cons, $mdgriffith$elm_ui$Element$Region$announce, redistributed.fullParent))),
			textOptions.label,
			wrappedInput);
	});
var $mdgriffith$elm_ui$Element$Input$currentPassword = F2(
	function (attrs, pass) {
		return A3(
			$mdgriffith$elm_ui$Element$Input$textHelper,
			{
				autofill: $elm$core$Maybe$Just('current-password'),
				spellchecked: false,
				type_: $mdgriffith$elm_ui$Element$Input$TextInputNode(
					pass.show ? 'text' : 'password')
			},
			attrs,
			{label: pass.label, onChange: pass.onChange, placeholder: pass.placeholder, text: pass.text});
	});
var $mdgriffith$elm_ui$Element$Input$email = $mdgriffith$elm_ui$Element$Input$textHelper(
	{
		autofill: $elm$core$Maybe$Just('email'),
		spellchecked: false,
		type_: $mdgriffith$elm_ui$Element$Input$TextInputNode('email')
	});
var $author$project$R10$FormComponents$UI$Color$font = $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.87);
var $elm$core$String$cons = _String_cons;
var $elm$core$String$fromChar = function (_char) {
	return A2($elm$core$String$cons, _char, '');
};
var $author$project$R10$FormComponents$Text$append = F3(
	function (tokens, input, formatted) {
		append:
		while (true) {
			var maybeToken = $elm$core$List$head(tokens);
			var appendInput = A2(
				$elm$core$Maybe$withDefault,
				formatted,
				A2(
					$elm$core$Maybe$map,
					A2(
						$author$project$R10$FormComponents$Text$append,
						A2(
							$elm$core$Maybe$withDefault,
							_List_Nil,
							$elm$core$List$tail(tokens)),
						A2(
							$elm$core$Maybe$withDefault,
							_List_Nil,
							$elm$core$List$tail(input))),
					A2(
						$elm$core$Maybe$map,
						function (_char) {
							return _Utils_ap(
								formatted,
								$elm$core$String$fromChar(_char));
						},
						$elm$core$List$head(input))));
			if (maybeToken.$ === 'Nothing') {
				return formatted;
			} else {
				var token = maybeToken.a;
				if (token.$ === 'InputValue') {
					return appendInput;
				} else {
					var _char = token.a;
					var $temp$tokens = A2(
						$elm$core$Maybe$withDefault,
						_List_Nil,
						$elm$core$List$tail(tokens)),
						$temp$input = input,
						$temp$formatted = _Utils_ap(
						formatted,
						$elm$core$String$fromChar(_char));
					tokens = $temp$tokens;
					input = $temp$input;
					formatted = $temp$formatted;
					continue append;
				}
			}
		}
	});
var $author$project$R10$FormComponents$Text$format = F2(
	function (tokens, input) {
		return $elm$core$String$isEmpty(input) ? input : A3(
			$author$project$R10$FormComponents$Text$append,
			tokens,
			$elm$core$String$toList(input),
			'');
	});
var $author$project$R10$FormComponents$Text$InputValue = {$: 'InputValue'};
var $author$project$R10$FormComponents$Text$Other = function (a) {
	return {$: 'Other', a: a};
};
var $author$project$R10$FormComponents$Text$tokenize = F2(
	function (inputChar, pattern) {
		return (_Utils_eq(pattern, inputChar) || _Utils_eq(
			pattern,
			_Utils_chr('_'))) ? $author$project$R10$FormComponents$Text$InputValue : $author$project$R10$FormComponents$Text$Other(pattern);
	});
var $author$project$R10$FormComponents$Text$parse = F2(
	function (inputChar, pattern) {
		return A2(
			$elm$core$List$map,
			$author$project$R10$FormComponents$Text$tokenize(inputChar),
			$elm$core$String$toList(pattern));
	});
var $author$project$R10$FormComponents$Text$appendPattern = F2(
	function (template, string) {
		return A2(
			$author$project$R10$FormComponents$Text$format,
			A2(
				$author$project$R10$FormComponents$Text$parse,
				_Utils_chr('0'),
				template),
			string);
	});
var $author$project$R10$FormComponents$Text$regexNotDigit = A2(
	$elm$core$Maybe$withDefault,
	$elm$regex$Regex$never,
	$elm$regex$Regex$fromString('[^0-9]'));
var $author$project$R10$FormComponents$Text$onlyDigit = function (str) {
	return A3(
		$elm$regex$Regex$replace,
		$author$project$R10$FormComponents$Text$regexNotDigit,
		function (_v0) {
			return '';
		},
		str);
};
var $author$project$R10$FormComponents$Text$removeTrailingChar = function (str) {
	return A2(
		$elm$core$String$left,
		$elm$core$String$length(str) - 1,
		str);
};
var $author$project$R10$FormComponents$Text$regexNotDigitAtTheEnd = A2(
	$elm$core$Maybe$withDefault,
	$elm$regex$Regex$never,
	$elm$regex$Regex$fromString('[^0-9]*$'));
var $author$project$R10$FormComponents$Text$removeTrailingPattern = function (str) {
	return A3(
		$elm$regex$Regex$replace,
		$author$project$R10$FormComponents$Text$regexNotDigitAtTheEnd,
		function (_v0) {
			return '';
		},
		str);
};
var $author$project$R10$FormComponents$Text$handleWithPatternChange = F3(
	function (pattern, oldValue, newValue) {
		var value = A2(
			$author$project$R10$FormComponents$Text$appendPattern,
			pattern,
			$author$project$R10$FormComponents$Text$onlyDigit(newValue));
		var isDeleteAction = _Utils_eq(
			$author$project$R10$FormComponents$Text$removeTrailingChar(oldValue),
			newValue);
		return (_Utils_eq(value, oldValue) && isDeleteAction) ? $author$project$R10$FormComponents$Text$removeTrailingChar(
			$author$project$R10$FormComponents$Text$removeTrailingPattern(value)) : value;
	});
var $mdgriffith$elm_ui$Element$Input$HiddenLabel = function (a) {
	return {$: 'HiddenLabel', a: a};
};
var $mdgriffith$elm_ui$Element$Input$labelHidden = $mdgriffith$elm_ui$Element$Input$HiddenLabel;
var $mdgriffith$elm_ui$Element$moveDown = function (y) {
	return A2(
		$mdgriffith$elm_ui$Internal$Model$TransformComponent,
		$mdgriffith$elm_ui$Internal$Flag$moveY,
		$mdgriffith$elm_ui$Internal$Model$MoveY(y));
};
var $mdgriffith$elm_ui$Element$Input$multiline = F2(
	function (attrs, multi) {
		return A3(
			$mdgriffith$elm_ui$Element$Input$textHelper,
			{autofill: $elm$core$Maybe$Nothing, spellchecked: multi.spellcheck, type_: $mdgriffith$elm_ui$Element$Input$TextArea},
			attrs,
			{label: multi.label, onChange: multi.onChange, placeholder: multi.placeholder, text: multi.text});
	});
var $mdgriffith$elm_ui$Element$Input$newPassword = F2(
	function (attrs, pass) {
		return A3(
			$mdgriffith$elm_ui$Element$Input$textHelper,
			{
				autofill: $elm$core$Maybe$Just('new-password'),
				spellchecked: false,
				type_: $mdgriffith$elm_ui$Element$Input$TextInputNode(
					pass.show ? 'text' : 'password')
			},
			attrs,
			{label: pass.label, onChange: pass.onChange, placeholder: pass.placeholder, text: pass.text});
	});
var $author$project$R10$FormComponents$UI$onEnter = function (msg) {
	return $author$project$R10$FormComponents$UI$onKeyPressBatch(
		_List_fromArray(
			[
				_Utils_Tuple2($author$project$R10$FormComponents$UI$keyCode.enter, msg)
			]));
};
var $elm$core$String$right = F2(
	function (n, string) {
		return (n < 1) ? '' : A3(
			$elm$core$String$slice,
			-n,
			$elm$core$String$length(string),
			string);
	});
var $mdgriffith$elm_ui$Element$Input$text = $mdgriffith$elm_ui$Element$Input$textHelper(
	{
		autofill: $elm$core$Maybe$Nothing,
		spellchecked: false,
		type_: $mdgriffith$elm_ui$Element$Input$TextInputNode('text')
	});
var $mdgriffith$elm_ui$Element$Input$username = $mdgriffith$elm_ui$Element$Input$textHelper(
	{
		autofill: $elm$core$Maybe$Just('username'),
		spellchecked: false,
		type_: $mdgriffith$elm_ui$Element$Input$TextInputNode('text')
	});
var $author$project$R10$FormComponents$Text$viewBehindPattern = function (args) {
	var _v4 = args.textType;
	if (_v4.$ === 'TextWithPattern') {
		var pattern = _v4.a;
		var valueWithTrailingPattern = function () {
			if (args.focused) {
				var lengthDifference = $elm$core$String$length(pattern) - $elm$core$String$length(args.value);
				return _Utils_ap(
					args.value,
					A2($elm$core$String$right, lengthDifference, pattern));
			} else {
				return '';
			}
		}();
		return _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$behindContent(
				A2(
					$author$project$R10$FormComponents$Text$viewInput,
					_Utils_update(
						args,
						{textType: $author$project$R10$FormComponents$Text$TextPlain, value: valueWithTrailingPattern}),
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$alpha(0.6),
							$mdgriffith$elm_ui$Element$htmlAttribute(
							A2($elm$html$Html$Attributes$attribute, 'disabled', 'true'))
						])))
			]);
	} else {
		return _List_Nil;
	}
};
var $author$project$R10$FormComponents$Text$viewInput = F2(
	function (args, extraAttr) {
		var paddingValues = $author$project$R10$FormComponents$UI$getTextfieldPaddingEach(args);
		var paddingOffset = 12;
		var inputDisabledAttrs = _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$attribute, 'disabled', 'true'))
			]);
		var iconCommonAttrs = _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$moveDown(
				function () {
					var _v3 = args.style;
					if (_v3.$ === 'Filled') {
						return 8;
					} else {
						return 0;
					}
				}()),
				$mdgriffith$elm_ui$Element$centerY,
				A2($mdgriffith$elm_ui$Element$paddingXY, 8, 0)
			]);
		var inputAttrs = _Utils_ap(
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$attribute, 'spellcheck', 'false')),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$attribute, 'autocorrect', 'off')),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$attribute, 'autocapitalize', 'off')),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'transition', 'all 0.15s')),
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$Font$size($author$project$R10$FormComponents$UI$Const$inputTextFontSize),
					$mdgriffith$elm_ui$Element$Border$width(0),
					$mdgriffith$elm_ui$Element$Background$color($author$project$R10$FormComponents$UI$Color$transparent),
					$mdgriffith$elm_ui$Element$Font$color(
					$author$project$R10$FormComponents$UI$Color$font(args.palette)),
					$mdgriffith$elm_ui$Element$Events$onFocus(args.msgOnFocus),
					$mdgriffith$elm_ui$Element$paddingEach(
					_Utils_update(
						paddingValues,
						{top: paddingValues.top - paddingOffset})),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2(
						$elm$html$Html$Attributes$style,
						'margin-top',
						$elm$core$String$fromInt(paddingOffset) + 'px')),
					$mdgriffith$elm_ui$Element$behindContent(
					A2(
						$mdgriffith$elm_ui$Element$el,
						A2($elm$core$List$cons, $mdgriffith$elm_ui$Element$alignLeft, iconCommonAttrs),
						A2($elm$core$Maybe$withDefault, $mdgriffith$elm_ui$Element$none, args.leadingIcon))),
					$mdgriffith$elm_ui$Element$inFront(
					A2(
						$mdgriffith$elm_ui$Element$el,
						A2($elm$core$List$cons, $mdgriffith$elm_ui$Element$alignRight, iconCommonAttrs),
						A2($elm$core$Maybe$withDefault, $mdgriffith$elm_ui$Element$none, args.trailingIcon)))
				]),
			_Utils_ap(
				function () {
					var _v1 = args.msgOnEnter;
					if (_v1.$ === 'Just') {
						var msgOnEnter_ = _v1.a;
						return _List_fromArray(
							[
								$mdgriffith$elm_ui$Element$htmlAttribute(
								$author$project$R10$FormComponents$UI$onEnter(msgOnEnter_))
							]);
					} else {
						return _List_Nil;
					}
				}(),
				_Utils_ap(
					function () {
						var _v2 = args.msgOnLoseFocus;
						if (_v2.$ === 'Just') {
							var msgOnLoseFocus_ = _v2.a;
							return _List_fromArray(
								[
									$mdgriffith$elm_ui$Element$Events$onLoseFocus(msgOnLoseFocus_)
								]);
						} else {
							return _List_Nil;
						}
					}(),
					_Utils_ap(
						args.disabled ? inputDisabledAttrs : _List_Nil,
						_Utils_ap(
							$author$project$R10$FormComponents$Text$viewBehindPattern(args),
							extraAttr)))));
		var behavioursTextWithPattern = function (pattern) {
			return {
				label: $mdgriffith$elm_ui$Element$Input$labelHidden(args.label),
				onChange: A2(
					$elm$core$Basics$composeR,
					A2($author$project$R10$FormComponents$Text$handleWithPatternChange, pattern, args.value),
					args.msgOnChange),
				placeholder: $elm$core$Maybe$Nothing,
				text: args.value
			};
		};
		var behavioursText = {
			label: $mdgriffith$elm_ui$Element$Input$labelHidden(args.label),
			onChange: args.msgOnChange,
			placeholder: $elm$core$Maybe$Nothing,
			text: args.value
		};
		var behavioursPassword = function (show) {
			return {
				label: $mdgriffith$elm_ui$Element$Input$labelHidden(args.label),
				onChange: args.msgOnChange,
				placeholder: $elm$core$Maybe$Nothing,
				show: show,
				text: args.value
			};
		};
		var behavioursMultiline = {
			label: $mdgriffith$elm_ui$Element$Input$labelHidden(args.label),
			onChange: args.msgOnChange,
			placeholder: $elm$core$Maybe$Nothing,
			spellcheck: false,
			text: args.value
		};
		var _v0 = args.textType;
		switch (_v0.$) {
			case 'TextUsername':
				return A2($mdgriffith$elm_ui$Element$Input$username, inputAttrs, behavioursText);
			case 'TextEmail':
				return A2($mdgriffith$elm_ui$Element$Input$email, inputAttrs, behavioursText);
			case 'TextPasswordCurrent':
				return A2(
					$mdgriffith$elm_ui$Element$Input$currentPassword,
					inputAttrs,
					behavioursPassword(args.showPassword));
			case 'TextPasswordNew':
				return A2(
					$mdgriffith$elm_ui$Element$Input$newPassword,
					inputAttrs,
					behavioursPassword(args.showPassword));
			case 'TextPlain':
				return A2($mdgriffith$elm_ui$Element$Input$text, inputAttrs, behavioursText);
			case 'TextMultiline':
				return A2($mdgriffith$elm_ui$Element$Input$multiline, inputAttrs, behavioursMultiline);
			default:
				var pattern = _v0.a;
				return A2(
					$mdgriffith$elm_ui$Element$Input$text,
					inputAttrs,
					behavioursTextWithPattern(pattern));
		}
	});
var $author$project$R10$Svg$Icons$eye_l = F3(
	function (attrs, cl, size) {
		return A3(
			$author$project$R10$Svg$Utils$wrapper32,
			attrs,
			size,
			_List_fromArray(
				[
					A2(
					$elm$svg$Svg$path,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill('none'),
							$elm$svg$Svg$Attributes$d('M0 0h32v32H0z')
						]),
					_List_Nil),
					A2(
					$elm$svg$Svg$g,
					_List_fromArray(
						[
							$elm$svg$Svg$Attributes$fill(
							$author$project$R10$Color$Utils$toHex(cl))
						]),
					_List_fromArray(
						[
							A2(
							$elm$svg$Svg$path,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$d('M16 6C6 6 2 16 2 16s4 10 14 10 14-10 14-10S26 6 16 6zm0 18c-7.1 0-10.71-5.87-11.8-8C5.3 13.9 8.96 8 16 8c7.1 0 10.72 5.87 11.8 8-1.09 2.1-4.75 8-11.8 8z')
								]),
							_List_Nil),
							A2(
							$elm$svg$Svg$path,
							_List_fromArray(
								[
									$elm$svg$Svg$Attributes$d('M16 11a5 5 0 1 0 5 5 5 5 0 0 0-5-5zm0 8a3 3 0 1 1 3-3 3 3 0 0 1-3 3z')
								]),
							_List_Nil)
						]))
				]));
	});
var $author$project$R10$FormComponents$Text$viewShowHidePasswordButton = function (_v0) {
	var msgOnTogglePasswordShow = _v0.msgOnTogglePasswordShow;
	var showPassword = _v0.showPassword;
	var palette = _v0.palette;
	var icon = showPassword ? A3(
		$author$project$R10$Svg$Icons$eye_ban_l,
		_List_Nil,
		$author$project$R10$Color$Utils$elementColorToColor(
			$author$project$R10$FormComponents$UI$Color$label(palette)),
		24) : A3(
		$author$project$R10$Svg$Icons$eye_l,
		_List_Nil,
		$author$project$R10$Color$Utils$elementColorToColor(
			$author$project$R10$FormComponents$UI$Color$label(palette)),
		24);
	if (msgOnTogglePasswordShow.$ === 'Just') {
		var msgOnTogglePasswordShow_ = msgOnTogglePasswordShow.a;
		return A2(
			$author$project$R10$FormComponents$IconButton$view,
			_List_Nil,
			{
				icon: icon,
				msgOnClick: $elm$core$Maybe$Just(msgOnTogglePasswordShow_),
				palette: palette,
				size: 24
			});
	} else {
		return $mdgriffith$elm_ui$Element$none;
	}
};
var $author$project$R10$FormComponents$Text$view = F3(
	function (attrs, extraInputAttrs, args) {
		var valid = $author$project$R10$FormComponents$Validations$isValid(args.validation);
		var displayValidation = !_Utils_eq(valid, $elm$core$Maybe$Nothing);
		var newArgs = _Utils_update(
			args,
			{
				trailingIcon: $author$project$R10$FormComponents$Text$needShowHideIcon(args.textType) ? $elm$core$Maybe$Just(
					$author$project$R10$FormComponents$Text$viewShowHidePasswordButton(args)) : ((!_Utils_eq(args.trailingIcon, $elm$core$Maybe$Nothing)) ? args.trailingIcon : $elm$core$Maybe$Just(
					$author$project$R10$FormComponents$UI$showValidationIcon_(
						{displayValidation: displayValidation, maybeValid: valid, palette: args.palette})))
			});
		var styleArgs = {disabled: newArgs.disabled, displayValidation: displayValidation, focused: newArgs.focused, isMouseOver: false, label: newArgs.label, leadingIcon: newArgs.leadingIcon, palette: newArgs.palette, requiredLabel: newArgs.requiredLabel, style: newArgs.style, trailingIcon: newArgs.trailingIcon, valid: valid, value: newArgs.value};
		return A2(
			$mdgriffith$elm_ui$Element$column,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(0),
						$mdgriffith$elm_ui$Element$width(
						A2($mdgriffith$elm_ui$Element$minimum, 150, $mdgriffith$elm_ui$Element$fill)),
						$mdgriffith$elm_ui$Element$inFront(
						$author$project$R10$FormComponents$UI$labelBuilder(styleArgs))
					]),
				_Utils_ap(
					newArgs.disabled ? _List_fromArray(
						[
							$mdgriffith$elm_ui$Element$alpha(0.6)
						]) : _List_fromArray(
						[
							$mdgriffith$elm_ui$Element$alpha(1)
						]),
					_Utils_ap(
						attrs,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
							])))),
			_List_fromArray(
				[
					A2(
					$author$project$R10$FormComponents$Text$viewInput,
					newArgs,
					_Utils_ap(
						_List_fromArray(
							[
								$author$project$R10$FormComponents$Text$getBorder(styleArgs),
								$mdgriffith$elm_ui$Element$mouseOver(
								_List_fromArray(
									[
										$author$project$R10$FormComponents$Text$getBorder(
										_Utils_update(
											styleArgs,
											{isMouseOver: true}))
									])),
								function () {
								var _v0 = newArgs.style;
								if (_v0.$ === 'Filled') {
									return $mdgriffith$elm_ui$Element$Border$rounded(0);
								} else {
									return $mdgriffith$elm_ui$Element$Border$rounded(5);
								}
							}(),
								$mdgriffith$elm_ui$Element$height(
								$mdgriffith$elm_ui$Element$px(
									_Utils_eq(newArgs.textType, $author$project$R10$FormComponents$Text$TextMultiline) ? 200 : $author$project$R10$FormComponents$UI$Const$inputTextHeight))
							]),
						_Utils_ap(
							function () {
								var _v1 = args.idDom;
								if (_v1.$ === 'Just') {
									var id = _v1.a;
									return _List_fromArray(
										[
											$mdgriffith$elm_ui$Element$htmlAttribute(
											$elm$html$Html$Attributes$id(id))
										]);
								} else {
									return _List_Nil;
								}
							}(),
							extraInputAttrs))),
					A3(
					$author$project$R10$FormComponents$UI$viewHelperText,
					newArgs.palette,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$spacing(2),
							$mdgriffith$elm_ui$Element$alpha(0.5),
							$mdgriffith$elm_ui$Element$Font$size(14),
							$mdgriffith$elm_ui$Element$paddingEach(
							{bottom: 0, left: 0, right: 0, top: $author$project$R10$FormComponents$UI$genericSpacing})
						]),
					newArgs.helperText)
				]));
	});
var $author$project$R10$FormComponents$Single$Common$OnScroll = function (a) {
	return {$: 'OnScroll', a: a};
};
var $mdgriffith$elm_ui$Element$Keyed$column = F2(
	function (attrs, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asColumn,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentTop + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.contentLeft)),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
						attrs))),
			$mdgriffith$elm_ui$Internal$Model$Keyed(children));
	});
var $author$project$R10$FormComponents$Single$Combobox$comboboxOptionNoResults = function (_v0) {
	var palette = _v0.palette;
	var selectOptionHeight = _v0.selectOptionHeight;
	return A2(
		$mdgriffith$elm_ui$Element$el,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				$mdgriffith$elm_ui$Element$height(
				$mdgriffith$elm_ui$Element$px(selectOptionHeight)),
				$mdgriffith$elm_ui$Element$paddingEach(
				{bottom: 0, left: 12, right: 0, top: 0}),
				$mdgriffith$elm_ui$Element$Font$color(
				A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.5, palette))
			]),
		A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[$mdgriffith$elm_ui$Element$centerY]),
			$mdgriffith$elm_ui$Element$text('No results')));
};
var $author$project$R10$FormComponents$Utils$listSlice = F3(
	function (from, to, list) {
		return (_Utils_cmp(from, to) > -1) ? _List_Nil : A2(
			$elm$core$List$filterMap,
			$elm$core$Basics$identity,
			A2(
				$elm$core$List$indexedMap,
				F2(
					function (idx, opt) {
						return (_Utils_cmp(idx, to - from) < 0) ? $elm$core$Maybe$Just(opt) : $elm$core$Maybe$Nothing;
					}),
				A2($elm$core$List$drop, from, list)));
	});
var $elm$json$Json$Decode$float = _Json_decodeFloat;
var $author$project$R10$FormComponents$UI$onScroll = function (msg) {
	return A2(
		$elm$html$Html$Events$on,
		'scroll',
		A2(
			$elm$json$Json$Decode$map,
			msg,
			A2(
				$elm$json$Json$Decode$at,
				_List_fromArray(
					['target', 'scrollTop']),
				$elm$json$Json$Decode$float)));
};
var $mdgriffith$elm_ui$Element$scrollbarX = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.scrollbarsX);
var $author$project$R10$FormComponents$UI$Color$primaryVariantA = F2(
	function (alpha, palette) {
		return $author$project$R10$FormComponents$UI$Color$fromPaletteColor(
			A2($author$project$R10$FormComponents$UI$Palette$withOpacity, alpha, palette.primaryVariant));
	});
var $author$project$R10$FormComponents$Single$Combobox$viewComboboxOption = F4(
	function (value, select, args, opt) {
		var isSelected_ = _Utils_eq(select, opt.value);
		var isActiveValue = _Utils_eq(value, opt.value);
		var getShadowColor = isActiveValue ? A2($author$project$R10$FormComponents$UI$Color$primaryVariantA, 0.1, args.palette) : A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.05, args.palette);
		var getBackgroundColor = (isActiveValue && isSelected_) ? A2($author$project$R10$FormComponents$UI$Color$primaryVariantA, 0.13, args.palette) : (isActiveValue ? A2($author$project$R10$FormComponents$UI$Color$primaryVariantA, 0.07, args.palette) : (isSelected_ ? A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.07, args.palette) : A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0, args.palette)));
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(args.selectOptionHeight)),
					$mdgriffith$elm_ui$Element$Background$color(getBackgroundColor),
					$mdgriffith$elm_ui$Element$mouseOver(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Border$innerShadow(
							{
								blur: 0,
								color: getShadowColor,
								offset: _Utils_Tuple2(0, 0),
								size: 40
							})
						]))
				]),
			args.toOptionEl(opt));
	});
var $author$project$R10$FormComponents$Single$Combobox$viewComboboxDropdown = F3(
	function (model, args, filteredOptions) {
		var visibleCount = args.maxDisplayCount + 2;
		var optionsCount = $elm$core$List$length(filteredOptions);
		var elementsScrolledFromTop = ($elm$core$Basics$round(model.scroll) / args.selectOptionHeight) | 0;
		var visibleFrom = elementsScrolledFromTop - 1;
		var visibleMoveDown = $author$project$R10$FormComponents$Single$Update$dropdownHingeHeight + (A2($elm$core$Basics$max, 0, visibleFrom) * args.selectOptionHeight);
		var visibleTo = visibleFrom + visibleCount;
		var visibleOptions = ($elm$core$List$length(filteredOptions) > 0) ? A2(
			$elm$core$List$map,
			function (opt) {
				return _Utils_Tuple2(
					opt.value,
					A4($author$project$R10$FormComponents$Single$Combobox$viewComboboxOption, model.value, model.select, args, opt));
			},
			A3($author$project$R10$FormComponents$Utils$listSlice, visibleFrom, visibleTo, filteredOptions)) : _List_fromArray(
			[
				_Utils_Tuple2(
				'no_results',
				$author$project$R10$FormComponents$Single$Combobox$comboboxOptionNoResults(args))
			]);
		var contentHeight = args.selectOptionHeight * A2($elm$core$Basics$max, optionsCount, 1);
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(
						A2($author$project$R10$FormComponents$Single$Update$getDropdownHeight, args, optionsCount))),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'z-index', '1')),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					$elm$html$Html$Attributes$tabindex(0)),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'overscroll-behavior', 'contain')),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					$author$project$R10$FormComponents$UI$onScroll(
						A2($elm$core$Basics$composeL, args.toMsg, $author$project$R10$FormComponents$Single$Common$OnScroll))),
					$mdgriffith$elm_ui$Element$htmlAttribute(
					$elm$html$Html$Attributes$id(
						$author$project$R10$FormComponents$Single$Common$dropdownContentId(args.key))),
					$mdgriffith$elm_ui$Element$Font$color(
					$author$project$R10$FormComponents$UI$Color$font(args.palette)),
					$mdgriffith$elm_ui$Element$Background$color(
					$author$project$R10$FormComponents$UI$Color$surface(args.palette)),
					A2($mdgriffith$elm_ui$Element$paddingXY, 0, $author$project$R10$FormComponents$Single$Update$dropdownHingeHeight),
					$mdgriffith$elm_ui$Element$scrollbarX,
					$mdgriffith$elm_ui$Element$Border$rounded(
					function () {
						var _v0 = args.style;
						if (_v0.$ === 'Filled') {
							return 0;
						} else {
							return 8;
						}
					}()),
					$mdgriffith$elm_ui$Element$Border$shadow(
					{
						blur: 3,
						color: A2($author$project$R10$FormComponents$UI$Color$onSurfaceA, 0.1, args.palette),
						offset: _Utils_Tuple2(0, 0),
						size: 1
					}),
					$mdgriffith$elm_ui$Element$moveDown(52),
					$mdgriffith$elm_ui$Element$inFront(
					A2(
						$mdgriffith$elm_ui$Element$Keyed$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$moveDown(visibleMoveDown)
							]),
						visibleOptions))
				]),
			A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(contentHeight)),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				$mdgriffith$elm_ui$Element$none));
	});
var $author$project$R10$FormComponents$Single$Combobox$view = F3(
	function (attrs, model, args) {
		var filteredOptions = A2($author$project$R10$FormComponents$Single$Combobox$filterBySearch, model.search, args);
		var _v0 = A3($author$project$R10$FormComponents$Single$Combobox$optionsLabelOrSearchValue, model.search, model.value, args.fieldOptions);
		var displayValue = _v0.displayValue;
		var isActualValueDisplayed = _v0.isActualValueDisplayed;
		var textArgs = {
			disabled: args.disabled,
			focused: model.focused,
			helperText: args.helperText,
			idDom: $elm$core$Maybe$Just(
				$author$project$R10$FormComponents$Single$Common$selectId(args.key)),
			label: args.label,
			leadingIcon: args.leadingIcon,
			msgOnChange: A2(
				$elm$core$Basics$composeL,
				args.toMsg,
				$author$project$R10$FormComponents$Single$Common$OnSearch(args.fieldOptions)),
			msgOnEnter: $elm$core$Maybe$Nothing,
			msgOnFocus: args.toMsg(
				$author$project$R10$FormComponents$Single$Common$OnFocus(model.value)),
			msgOnLoseFocus: $elm$core$Maybe$Nothing,
			msgOnTogglePasswordShow: $elm$core$Maybe$Nothing,
			palette: args.palette,
			requiredLabel: args.requiredLabel,
			showPassword: false,
			style: args.style,
			textType: $author$project$R10$FormComponents$Text$TextPlain,
			trailingIcon: args.trailingIcon,
			validation: args.validation,
			value: displayValue
		};
		var inputAttrs = _Utils_ap(
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$Events$onClick(
					args.toMsg(
						A3($author$project$R10$FormComponents$Single$Combobox$getMsgOnInputClick, model, args, filteredOptions)))
				]),
			isActualValueDisplayed ? _List_Nil : _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$Font$color(
					A2($author$project$R10$FormComponents$UI$Color$fontA, 0.6, args.palette))
				]));
		return A3(
			$author$project$R10$FormComponents$Text$view,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2(
							$elm$html$Html$Events$on,
							'focusout',
							A2(
								$author$project$R10$FormComponents$Utils$FocusOut$onFocusOut,
								$author$project$R10$FormComponents$Single$Common$dropdownContentId(args.key),
								args.toMsg(
									$author$project$R10$FormComponents$Single$Common$OnLoseFocus(model.value))))),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						$author$project$R10$FormComponents$UI$onKeyPressBatch(
							_Utils_ap(
								_List_fromArray(
									[
										_Utils_Tuple2(
										$author$project$R10$FormComponents$UI$keyCode.down,
										args.toMsg(
											$author$project$R10$FormComponents$Single$Common$OnArrowDown(
												{fieldOptions: args.fieldOptions, maxDisplayCount: args.maxDisplayCount, selectOptionHeight: args.selectOptionHeight}))),
										_Utils_Tuple2(
										$author$project$R10$FormComponents$UI$keyCode.up,
										args.toMsg(
											$author$project$R10$FormComponents$Single$Common$OnArrowUp(
												{fieldOptions: args.fieldOptions, maxDisplayCount: args.maxDisplayCount, selectOptionHeight: args.selectOptionHeight})))
									]),
								model.opened ? _List_fromArray(
									[
										_Utils_Tuple2(
										$author$project$R10$FormComponents$UI$keyCode.esc,
										args.toMsg($author$project$R10$FormComponents$Single$Common$OnEsc)),
										_Utils_Tuple2(
										$author$project$R10$FormComponents$UI$keyCode.enter,
										args.toMsg(
											$author$project$R10$FormComponents$Single$Common$OnOptionSelect(
												A3($author$project$R10$FormComponents$Single$Common$getSelectedOrFirst, filteredOptions, model.value, model.select))))
									]) : _List_Nil)))
					]),
				model.opened ? _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$inFront(
						A3($author$project$R10$FormComponents$Single$Combobox$viewComboboxDropdown, model, args, filteredOptions))
					]) : _List_Nil),
			_Utils_ap(inputAttrs, attrs),
			textArgs);
	});
var $mdgriffith$elm_ui$Element$Input$Above = {$: 'Above'};
var $mdgriffith$elm_ui$Element$Input$Label = F3(
	function (a, b, c) {
		return {$: 'Label', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Element$Input$labelAbove = $mdgriffith$elm_ui$Element$Input$Label($mdgriffith$elm_ui$Element$Input$Above);
var $mdgriffith$elm_ui$Element$Input$Column = {$: 'Column'};
var $mdgriffith$elm_ui$Element$Input$AfterFound = {$: 'AfterFound'};
var $mdgriffith$elm_ui$Element$Input$BeforeFound = {$: 'BeforeFound'};
var $mdgriffith$elm_ui$Element$Input$Idle = {$: 'Idle'};
var $mdgriffith$elm_ui$Element$Input$NotFound = {$: 'NotFound'};
var $mdgriffith$elm_ui$Element$Input$Selected = {$: 'Selected'};
var $mdgriffith$elm_ui$Element$Input$column = F2(
	function (attributes, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asColumn,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					attributes)),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
	});
var $mdgriffith$elm_ui$Element$Input$downArrow = 'ArrowDown';
var $mdgriffith$elm_ui$Internal$Model$filter = function (attrs) {
	return A3(
		$elm$core$List$foldr,
		F2(
			function (x, _v0) {
				var found = _v0.a;
				var has = _v0.b;
				switch (x.$) {
					case 'NoAttribute':
						return _Utils_Tuple2(found, has);
					case 'Class':
						var key = x.a;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							has);
					case 'Attr':
						var attr = x.a;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							has);
					case 'StyleClass':
						var style = x.b;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							has);
					case 'Width':
						var width = x.a;
						return A2($elm$core$Set$member, 'width', has) ? _Utils_Tuple2(found, has) : _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							A2($elm$core$Set$insert, 'width', has));
					case 'Height':
						var height = x.a;
						return A2($elm$core$Set$member, 'height', has) ? _Utils_Tuple2(found, has) : _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							A2($elm$core$Set$insert, 'height', has));
					case 'Describe':
						var description = x.a;
						return A2($elm$core$Set$member, 'described', has) ? _Utils_Tuple2(found, has) : _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							A2($elm$core$Set$insert, 'described', has));
					case 'Nearby':
						var location = x.a;
						var elem = x.b;
						return _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							has);
					case 'AlignX':
						return A2($elm$core$Set$member, 'align-x', has) ? _Utils_Tuple2(found, has) : _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							A2($elm$core$Set$insert, 'align-x', has));
					case 'AlignY':
						return A2($elm$core$Set$member, 'align-y', has) ? _Utils_Tuple2(found, has) : _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							A2($elm$core$Set$insert, 'align-y', has));
					default:
						return A2($elm$core$Set$member, 'transform', has) ? _Utils_Tuple2(found, has) : _Utils_Tuple2(
							A2($elm$core$List$cons, x, found),
							A2($elm$core$Set$insert, 'transform', has));
				}
			}),
		_Utils_Tuple2(_List_Nil, $elm$core$Set$empty),
		attrs).a;
};
var $mdgriffith$elm_ui$Internal$Model$get = F2(
	function (attrs, isAttr) {
		return A3(
			$elm$core$List$foldr,
			F2(
				function (x, found) {
					return isAttr(x) ? A2($elm$core$List$cons, x, found) : found;
				}),
			_List_Nil,
			$mdgriffith$elm_ui$Internal$Model$filter(attrs));
	});
var $mdgriffith$elm_ui$Element$Input$leftArrow = 'ArrowLeft';
var $mdgriffith$elm_ui$Element$Input$rightArrow = 'ArrowRight';
var $mdgriffith$elm_ui$Element$Input$row = F2(
	function (attributes, children) {
		return A4(
			$mdgriffith$elm_ui$Internal$Model$element,
			$mdgriffith$elm_ui$Internal$Model$asRow,
			$mdgriffith$elm_ui$Internal$Model$div,
			A2(
				$elm$core$List$cons,
				$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
				attributes),
			$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
	});
var $mdgriffith$elm_ui$Element$Input$tabindex = A2($elm$core$Basics$composeL, $mdgriffith$elm_ui$Internal$Model$Attr, $elm$html$Html$Attributes$tabindex);
var $mdgriffith$elm_ui$Element$Input$upArrow = 'ArrowUp';
var $mdgriffith$elm_ui$Element$Input$radioHelper = F3(
	function (orientation, attrs, input) {
		var track = F2(
			function (opt, _v14) {
				var found = _v14.a;
				var prev = _v14.b;
				var nxt = _v14.c;
				var val = opt.a;
				switch (found.$) {
					case 'NotFound':
						return _Utils_eq(
							$elm$core$Maybe$Just(val),
							input.selected) ? _Utils_Tuple3($mdgriffith$elm_ui$Element$Input$BeforeFound, prev, nxt) : _Utils_Tuple3(found, val, nxt);
					case 'BeforeFound':
						return _Utils_Tuple3($mdgriffith$elm_ui$Element$Input$AfterFound, prev, val);
					default:
						return _Utils_Tuple3(found, prev, nxt);
				}
			});
		var renderOption = function (_v11) {
			var val = _v11.a;
			var view = _v11.b;
			var status = _Utils_eq(
				$elm$core$Maybe$Just(val),
				input.selected) ? $mdgriffith$elm_ui$Element$Input$Selected : $mdgriffith$elm_ui$Element$Input$Idle;
			return A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$pointer,
						function () {
						if (orientation.$ === 'Row') {
							return $mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink);
						} else {
							return $mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill);
						}
					}(),
						$mdgriffith$elm_ui$Element$Events$onClick(
						input.onChange(val)),
						function () {
						if (status.$ === 'Selected') {
							return $mdgriffith$elm_ui$Internal$Model$Attr(
								A2($elm$html$Html$Attributes$attribute, 'aria-checked', 'true'));
						} else {
							return $mdgriffith$elm_ui$Internal$Model$Attr(
								A2($elm$html$Html$Attributes$attribute, 'aria-checked', 'false'));
						}
					}(),
						$mdgriffith$elm_ui$Internal$Model$Attr(
						A2($elm$html$Html$Attributes$attribute, 'role', 'radio'))
					]),
				view(status));
		};
		var prevNext = function () {
			var _v5 = input.options;
			if (!_v5.b) {
				return $elm$core$Maybe$Nothing;
			} else {
				var _v6 = _v5.a;
				var val = _v6.a;
				return function (_v7) {
					var found = _v7.a;
					var b = _v7.b;
					var a = _v7.c;
					switch (found.$) {
						case 'NotFound':
							return $elm$core$Maybe$Just(
								_Utils_Tuple2(b, val));
						case 'BeforeFound':
							return $elm$core$Maybe$Just(
								_Utils_Tuple2(b, val));
						default:
							return $elm$core$Maybe$Just(
								_Utils_Tuple2(b, a));
					}
				}(
					A3(
						$elm$core$List$foldl,
						track,
						_Utils_Tuple3($mdgriffith$elm_ui$Element$Input$NotFound, val, val),
						input.options));
			}
		}();
		var optionArea = function () {
			if (orientation.$ === 'Row') {
				return A2(
					$mdgriffith$elm_ui$Element$Input$row,
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$Input$hiddenLabelAttribute(input.label),
						attrs),
					A2($elm$core$List$map, renderOption, input.options));
			} else {
				return A2(
					$mdgriffith$elm_ui$Element$Input$column,
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$Input$hiddenLabelAttribute(input.label),
						attrs),
					A2($elm$core$List$map, renderOption, input.options));
			}
		}();
		var events = A2(
			$mdgriffith$elm_ui$Internal$Model$get,
			attrs,
			function (attr) {
				_v3$3:
				while (true) {
					switch (attr.$) {
						case 'Width':
							if (attr.a.$ === 'Fill') {
								return true;
							} else {
								break _v3$3;
							}
						case 'Height':
							if (attr.a.$ === 'Fill') {
								return true;
							} else {
								break _v3$3;
							}
						case 'Attr':
							return true;
						default:
							break _v3$3;
					}
				}
				return false;
			});
		return A3(
			$mdgriffith$elm_ui$Element$Input$applyLabel,
			_Utils_ap(
				A2(
					$elm$core$List$filterMap,
					$elm$core$Basics$identity,
					_List_fromArray(
						[
							$elm$core$Maybe$Just($mdgriffith$elm_ui$Element$alignLeft),
							$elm$core$Maybe$Just(
							$mdgriffith$elm_ui$Element$Input$tabindex(0)),
							$elm$core$Maybe$Just(
							$mdgriffith$elm_ui$Internal$Model$htmlClass('focus')),
							$elm$core$Maybe$Just($mdgriffith$elm_ui$Element$Region$announce),
							$elm$core$Maybe$Just(
							$mdgriffith$elm_ui$Internal$Model$Attr(
								A2($elm$html$Html$Attributes$attribute, 'role', 'radiogroup'))),
							function () {
							if (prevNext.$ === 'Nothing') {
								return $elm$core$Maybe$Nothing;
							} else {
								var _v1 = prevNext.a;
								var prev = _v1.a;
								var next = _v1.b;
								return $elm$core$Maybe$Just(
									$mdgriffith$elm_ui$Element$Input$onKeyLookup(
										function (code) {
											if (_Utils_eq(code, $mdgriffith$elm_ui$Element$Input$leftArrow)) {
												return $elm$core$Maybe$Just(
													input.onChange(prev));
											} else {
												if (_Utils_eq(code, $mdgriffith$elm_ui$Element$Input$upArrow)) {
													return $elm$core$Maybe$Just(
														input.onChange(prev));
												} else {
													if (_Utils_eq(code, $mdgriffith$elm_ui$Element$Input$rightArrow)) {
														return $elm$core$Maybe$Just(
															input.onChange(next));
													} else {
														if (_Utils_eq(code, $mdgriffith$elm_ui$Element$Input$downArrow)) {
															return $elm$core$Maybe$Just(
																input.onChange(next));
														} else {
															if (_Utils_eq(code, $mdgriffith$elm_ui$Element$Input$space)) {
																var _v2 = input.selected;
																if (_v2.$ === 'Nothing') {
																	return $elm$core$Maybe$Just(
																		input.onChange(prev));
																} else {
																	return $elm$core$Maybe$Nothing;
																}
															} else {
																return $elm$core$Maybe$Nothing;
															}
														}
													}
												}
											}
										}));
							}
						}()
						])),
				events),
			input.label,
			optionArea);
	});
var $mdgriffith$elm_ui$Element$Input$radio = $mdgriffith$elm_ui$Element$Input$radioHelper($mdgriffith$elm_ui$Element$Input$Column);
var $author$project$R10$FormComponents$UI$fontSizeSubTitle = $mdgriffith$elm_ui$Element$Font$size(18);
var $author$project$R10$FormComponents$Single$Radio$viewRadioLabel = F3(
	function (palette, label, helperText) {
		return (label === '') ? $mdgriffith$elm_ui$Element$none : A2(
			$mdgriffith$elm_ui$Element$column,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$paddingEach(
					{bottom: 24, left: 10, right: 0, top: 10}),
					$author$project$R10$FormComponents$UI$fontSizeSubTitle,
					$mdgriffith$elm_ui$Element$spacing($author$project$R10$FormComponents$UI$genericSpacing)
				]),
			_List_fromArray(
				[
					A2(
					$mdgriffith$elm_ui$Element$paragraph,
					_List_Nil,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$text(label)
						])),
					A3(
					$author$project$R10$FormComponents$UI$viewHelperText,
					palette,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$Font$size(14),
							$mdgriffith$elm_ui$Element$alpha(0.5),
							$mdgriffith$elm_ui$Element$paddingEach(
							{bottom: 0, left: 0, right: 0, top: $author$project$R10$FormComponents$UI$genericSpacing})
						]),
					helperText)
				]));
	});
var $mdgriffith$elm_ui$Element$Input$Option = F2(
	function (a, b) {
		return {$: 'Option', a: a, b: b};
	});
var $mdgriffith$elm_ui$Element$Input$optionWith = F2(
	function (val, view) {
		return A2($mdgriffith$elm_ui$Element$Input$Option, val, view);
	});
var $author$project$R10$FormComponents$Single$Radio$isSelected = function (optionState) {
	switch (optionState.$) {
		case 'Selected':
			return true;
		case 'Idle':
			return false;
		default:
			return false;
	}
};
var $author$project$R10$FormComponents$Single$Radio$viewRadioOption = F2(
	function (_v0, optionState) {
		var disabled = _v0.disabled;
		var palette = _v0.palette;
		var focused = _v0.focused;
		var value = _v0.value;
		var label = _v0.label;
		var _v1 = function () {
			var _v2 = _Utils_Tuple2(
				$author$project$R10$FormComponents$Single$Radio$isSelected(optionState),
				disabled);
			if (_v2.a) {
				if (_v2.b) {
					return {
						innerCircleColor: A2($author$project$R10$FormComponents$UI$Color$primaryA, 0.5, palette),
						innerCircleSize: 10,
						outerCircleColor: A2($author$project$R10$FormComponents$UI$Color$primaryA, 0.5, palette)
					};
				} else {
					return {
						innerCircleColor: A2($author$project$R10$FormComponents$UI$Color$primaryA, 1, palette),
						innerCircleSize: 10,
						outerCircleColor: A2($author$project$R10$FormComponents$UI$Color$primaryA, 1, palette)
					};
				}
			} else {
				if (_v2.b) {
					return {
						innerCircleColor: A2($author$project$R10$FormComponents$UI$Color$primaryA, 0, palette),
						innerCircleSize: 0,
						outerCircleColor: A2($author$project$R10$FormComponents$UI$Color$containerA, 0.5, palette)
					};
				} else {
					return {
						innerCircleColor: A2($author$project$R10$FormComponents$UI$Color$primaryA, 0, palette),
						innerCircleSize: 0,
						outerCircleColor: A2($author$project$R10$FormComponents$UI$Color$containerA, 1, palette)
					};
				}
			}
		}();
		var innerCircleSize = _v1.innerCircleSize;
		var innerCircleColor = _v1.innerCircleColor;
		var outerCircleColor = _v1.outerCircleColor;
		var innerCircle = A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'transition', 'all 0.13s')),
					$mdgriffith$elm_ui$Element$Background$color(innerCircleColor),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(innerCircleSize)),
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(innerCircleSize)),
					$mdgriffith$elm_ui$Element$Border$rounded(20),
					$mdgriffith$elm_ui$Element$centerX,
					$mdgriffith$elm_ui$Element$centerY
				]),
			$mdgriffith$elm_ui$Element$none);
		var selector = A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$htmlAttribute(
					A2($elm$html$Html$Attributes$style, 'transition', 'all 0.13s')),
					$mdgriffith$elm_ui$Element$width(
					$mdgriffith$elm_ui$Element$px(20)),
					$mdgriffith$elm_ui$Element$height(
					$mdgriffith$elm_ui$Element$px(20)),
					$mdgriffith$elm_ui$Element$centerX,
					$mdgriffith$elm_ui$Element$centerY,
					$mdgriffith$elm_ui$Element$behindContent(innerCircle),
					$mdgriffith$elm_ui$Element$Border$rounded(20),
					$mdgriffith$elm_ui$Element$Border$width(2),
					$mdgriffith$elm_ui$Element$Border$color(outerCircleColor)
				]),
			$mdgriffith$elm_ui$Element$none);
		return A2(
			$mdgriffith$elm_ui$Element$row,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(5),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
					]),
				disabled ? _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'cursor', 'auto'))
					]) : _List_Nil),
			_List_fromArray(
				[
					A2(
					$author$project$R10$FormComponents$UI$viewSelectShadow,
					{
						disabled: disabled,
						focused: focused && $author$project$R10$FormComponents$Single$Radio$isSelected(optionState),
						palette: palette
					},
					selector),
					A2(
					$mdgriffith$elm_ui$Element$paragraph,
					_List_Nil,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$text(label)
						]))
				]));
	});
var $author$project$R10$FormComponents$Single$Radio$viewRadioOptions = F3(
	function (args, focused, fieldOption) {
		return A2(
			$mdgriffith$elm_ui$Element$Input$optionWith,
			fieldOption.value,
			$author$project$R10$FormComponents$Single$Radio$viewRadioOption(
				{disabled: args.disabled, focused: focused, label: fieldOption.label, palette: args.palette, value: fieldOption.value}));
	});
var $author$project$R10$FormComponents$Single$Radio$viewRadio = F3(
	function (attrs, model, args) {
		var fixedValue = model.value;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_Utils_ap(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(10),
						$mdgriffith$elm_ui$Element$alignTop,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
					]),
				attrs),
			A2(
				$mdgriffith$elm_ui$Element$Input$radio,
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$spacing(5),
							$mdgriffith$elm_ui$Element$alignTop,
							$mdgriffith$elm_ui$Element$Events$onFocus(
							args.toMsg(
								$author$project$R10$FormComponents$Single$Common$OnFocus(
									A3($author$project$R10$FormComponents$Single$Common$getSelectedOrFirst, args.fieldOptions, model.value, model.select)))),
							$mdgriffith$elm_ui$Element$Events$onLoseFocus(
							args.toMsg(
								$author$project$R10$FormComponents$Single$Common$OnLoseFocus(model.value))),
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
						]),
					args.disabled ? _List_fromArray(
						[
							$mdgriffith$elm_ui$Element$htmlAttribute(
							$elm$html$Html$Attributes$tabindex(-1))
						]) : _List_Nil),
				{
					label: A2(
						$mdgriffith$elm_ui$Element$Input$labelAbove,
						_List_Nil,
						A3($author$project$R10$FormComponents$Single$Radio$viewRadioLabel, args.palette, args.label, args.helperText)),
					onChange: args.disabled ? $elm$core$Basics$always(
						args.toMsg(
							$author$project$R10$FormComponents$Single$Common$OnOptionSelect(model.value))) : A2($elm$core$Basics$composeL, args.toMsg, $author$project$R10$FormComponents$Single$Common$OnOptionSelect),
					options: A2(
						$elm$core$List$map,
						A2($author$project$R10$FormComponents$Single$Radio$viewRadioOptions, args, model.focused),
						args.fieldOptions),
					selected: $elm$core$Maybe$Just(fixedValue)
				}));
	});
var $author$project$R10$FormComponents$Single$view = F3(
	function (attrs, model, conf) {
		var args = {
			disabled: conf.disabled,
			fieldOptions: conf.fieldOptions,
			helperText: conf.helperText,
			key: conf.key,
			label: conf.label,
			leadingIcon: $elm$core$Maybe$Nothing,
			maxDisplayCount: 5,
			palette: conf.palette,
			requiredLabel: conf.requiredLabel,
			searchFn: $author$project$R10$FormComponents$Single$defaultSearchFn,
			selectOptionHeight: 36,
			singleType: conf.singleType,
			style: conf.style,
			toMsg: conf.toMsg,
			toOptionEl: $author$project$R10$FormComponents$Single$defaultToOptionEl(
				{
					msgOnSelect: A2($elm$core$Basics$composeR, $author$project$R10$FormComponents$Single$Common$OnOptionSelect, conf.toMsg),
					search: model.search
				}),
			trailingIcon: $elm$core$Maybe$Just(
				$author$project$R10$FormComponents$Single$defaultTrailingIcon(
					{opened: model.opened, palette: conf.palette})),
			validation: conf.validation
		};
		var _v0 = args.singleType;
		if (_v0.$ === 'SingleCombobox') {
			return A3($author$project$R10$FormComponents$Single$Combobox$view, attrs, model, args);
		} else {
			return A3($author$project$R10$FormComponents$Single$Radio$viewRadio, attrs, model, args);
		}
	});
var $author$project$R10$Form$Internal$MakerForView$viewSingleSelection = F4(
	function (args, singleType, fieldOptions, formConf) {
		return A3(
			$author$project$R10$FormComponents$Single$view,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width(
					A2(
						$mdgriffith$elm_ui$Element$maximum,
						900,
						A2($mdgriffith$elm_ui$Element$minimum, 300, $mdgriffith$elm_ui$Element$fill)))
				]),
			{focused: args.focused, opened: args.active, scroll: args.fieldState.scroll, search: args.fieldState.search, select: args.fieldState.select, value: args.fieldState.value},
			{
				disabled: args.fieldState.disabled,
				fieldOptions: fieldOptions,
				helperText: args.fieldConf.helperText,
				key: $author$project$R10$Form$Internal$Key$toString(args.key),
				label: args.fieldConf.label,
				palette: args.palette,
				requiredLabel: args.fieldConf.requiredLabel,
				singleType: $author$project$R10$Form$Internal$Converter$singleTypeFromFieldConfToComponent(singleType),
				style: args.style,
				toMsg: A3($author$project$R10$Form$Msg$OnSingleMsg, args.key, args.fieldConf, formConf),
				validation: A3($author$project$R10$Form$Internal$Converter$fromFieldStateValidationToComponentValidation, args.fieldConf.validationSpecs, args.fieldState.validation, args.translator)
			});
	});
var $author$project$R10$Form$Msg$TogglePasswordShow = function (a) {
	return {$: 'TogglePasswordShow', a: a};
};
var $author$project$R10$FormComponents$Text$TextEmail = {$: 'TextEmail'};
var $author$project$R10$FormComponents$Text$TextUsername = {$: 'TextUsername'};
var $author$project$R10$FormComponents$Text$TextWithPattern = function (a) {
	return {$: 'TextWithPattern', a: a};
};
var $author$project$R10$Form$Internal$Converter$textTypeFromFieldConfToComponent = function (typeText) {
	switch (typeText.$) {
		case 'TextPlain':
			return $author$project$R10$FormComponents$Text$TextPlain;
		case 'TextUsername':
			return $author$project$R10$FormComponents$Text$TextUsername;
		case 'TextEmail':
			return $author$project$R10$FormComponents$Text$TextEmail;
		case 'TextPasswordCurrent':
			return $author$project$R10$FormComponents$Text$TextPasswordCurrent;
		case 'TextPasswordNew':
			return $author$project$R10$FormComponents$Text$TextPasswordNew;
		case 'TextMultiline':
			return $author$project$R10$FormComponents$Text$TextMultiline;
		default:
			var pattern = typeText.a;
			return $author$project$R10$FormComponents$Text$TextWithPattern(pattern);
	}
};
var $author$project$R10$Form$Internal$MakerForView$viewText = F3(
	function (args, textType, formConf) {
		return A3(
			$author$project$R10$FormComponents$Text$view,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width(
					A2(
						$mdgriffith$elm_ui$Element$maximum,
						900,
						A2($mdgriffith$elm_ui$Element$minimum, 300, $mdgriffith$elm_ui$Element$fill)))
				]),
			_List_Nil,
			{
				disabled: args.fieldState.disabled,
				focused: args.focused,
				helperText: args.fieldConf.helperText,
				idDom: args.fieldConf.idDom,
				label: args.fieldConf.label,
				leadingIcon: $elm$core$Maybe$Nothing,
				msgOnChange: A3($author$project$R10$Form$Msg$ChangeValue, args.key, args.fieldConf, formConf),
				msgOnEnter: $elm$core$Maybe$Just(
					$author$project$R10$Form$Msg$Submit(formConf)),
				msgOnFocus: $author$project$R10$Form$Msg$GetFocus(args.key),
				msgOnLoseFocus: $elm$core$Maybe$Just(
					A2($author$project$R10$Form$Msg$LoseFocus, args.key, args.fieldConf)),
				msgOnTogglePasswordShow: $elm$core$Maybe$Just(
					$author$project$R10$Form$Msg$TogglePasswordShow(args.key)),
				palette: args.palette,
				requiredLabel: args.fieldConf.requiredLabel,
				showPassword: args.fieldState.showPassword,
				style: args.style,
				textType: $author$project$R10$Form$Internal$Converter$textTypeFromFieldConfToComponent(textType),
				trailingIcon: $elm$core$Maybe$Nothing,
				validation: A3($author$project$R10$Form$Internal$Converter$fromFieldStateValidationToComponentValidation, args.fieldConf.validationSpecs, args.fieldState.validation, args.translator),
				value: args.fieldState.value
			});
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntityField = F3(
	function (args, fieldConf, formConf) {
		var newKey = A2($author$project$R10$Form$Internal$Key$composeKey, args.key, fieldConf.id);
		var focused = A2($author$project$R10$Form$Internal$MakerForView$isFocused, newKey, args.formState.focused);
		var fieldState = A2(
			$elm$core$Maybe$withDefault,
			$author$project$R10$Form$Internal$FieldState$init,
			A2($author$project$R10$Form$Internal$Dict$get, newKey, args.formState.fieldsState));
		var active = A2($author$project$R10$Form$Internal$MakerForView$isActive, newKey, args.formState.active);
		var args2 = {active: active, fieldConf: fieldConf, fieldState: fieldState, focused: focused, key: newKey, palette: args.palette, style: args.style, translator: args.translator};
		var field = function () {
			var _v0 = fieldConf.type_;
			switch (_v0.$) {
				case 'TypeText':
					var typeText = _v0.a;
					return A3($author$project$R10$Form$Internal$MakerForView$viewText, args2, typeText, formConf);
				case 'TypeBinary':
					var typeBinary = _v0.a;
					return A3($author$project$R10$Form$Internal$MakerForView$viewBinary, args2, typeBinary, formConf);
				case 'TypeSingle':
					var typeSingle = _v0.a;
					var options = _v0.b;
					return A4($author$project$R10$Form$Internal$MakerForView$viewSingleSelection, args2, typeSingle, options, formConf);
				default:
					return $mdgriffith$elm_ui$Element$text('TODO');
			}
		}();
		return _List_fromArray(
			[field]);
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntitySubTitle = F2(
	function (palette, titleConf) {
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing($author$project$R10$FormComponents$UI$genericSpacing),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$paragraph,
						_List_fromArray(
							[$author$project$R10$FormComponents$UI$fontSizeSubTitle]),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text(titleConf.title)
							])),
						A3(
						$author$project$R10$FormComponents$UI$viewHelperText,
						palette,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$alpha(0.5),
								$mdgriffith$elm_ui$Element$Font$size(14),
								$mdgriffith$elm_ui$Element$paddingEach(
								{bottom: 0, left: 0, right: 0, top: $author$project$R10$FormComponents$UI$genericSpacing})
							]),
						titleConf.helperText)
					]))
			]);
	});
var $author$project$R10$FormComponents$UI$fontSizeTitle = $mdgriffith$elm_ui$Element$Font$size(24);
var $author$project$R10$Form$Internal$MakerForView$viewEntityTitle = F2(
	function (palette, titleConf) {
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(12),
						$mdgriffith$elm_ui$Element$paddingEach(
						{bottom: 0, left: 0, right: 0, top: 40}),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$paragraph,
						_List_fromArray(
							[$author$project$R10$FormComponents$UI$fontSizeTitle]),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text(titleConf.title)
							])),
						A3($author$project$R10$FormComponents$UI$viewHelperText, palette, _List_Nil, titleConf.helperText)
					]))
			]);
	});
var $author$project$R10$Form$Msg$ChangeTab = F2(
	function (a, b) {
		return {$: 'ChangeTab', a: a, b: b};
	});
var $author$project$R10$Form$Internal$FieldState$NotValid = {$: 'NotValid'};
var $author$project$R10$Form$Internal$FieldState$NotYetValidated2 = {$: 'NotYetValidated2'};
var $author$project$R10$Form$Internal$FieldState$Valid = {$: 'Valid'};
var $author$project$R10$Form$Internal$FieldState$isValid = function (validation) {
	if (validation.$ === 'NotYetValidated') {
		return $author$project$R10$Form$Internal$FieldState$NotYetValidated2;
	} else {
		var listValidationMessage = validation.a;
		return A3(
			$elm$core$List$foldl,
			F2(
				function (validationMessage, acc) {
					if (validationMessage.$ === 'MessageErr') {
						return $author$project$R10$Form$Internal$FieldState$NotValid;
					} else {
						return acc;
					}
				}),
			$author$project$R10$Form$Internal$FieldState$Valid,
			listValidationMessage);
	}
};
var $author$project$R10$Form$Internal$Update$entitiesWithErrorsForOnlyExistingValidations = F2(
	function (allKeys, fieldsState) {
		return A2(
			$elm$core$List$filter,
			function (_v0) {
				var key = _v0.a;
				var fieldState = A2(
					$elm$core$Maybe$withDefault,
					$author$project$R10$Form$Internal$FieldState$init,
					A2($author$project$R10$Form$Internal$Dict$get, key, fieldsState));
				var _v1 = $author$project$R10$Form$Internal$FieldState$isValid(fieldState.validation);
				switch (_v1.$) {
					case 'NotYetValidated2':
						return false;
					case 'NotValid':
						return true;
					default:
						return false;
				}
			},
			allKeys);
	});
var $author$project$R10$Form$Internal$Update$isExistingFormFieldsValid = F2(
	function (conf, state) {
		var allKeys = A2($author$project$R10$Form$Internal$Update$allValidationKeysMaker, conf, state);
		var fieldsWithErrors_ = A2($author$project$R10$Form$Internal$Update$entitiesWithErrorsForOnlyExistingValidations, allKeys, state.fieldsState);
		return _Utils_eq(
			$elm$core$List$head(fieldsWithErrors_),
			$elm$core$Maybe$Nothing);
	});
var $author$project$R10$FormComponents$UI$Color$mouseOverSurface = $author$project$R10$FormComponents$UI$Color$onSurfaceA(0.04);
var $author$project$R10$FormComponents$UI$Color$surfaceA = F2(
	function (alpha, palette) {
		return $author$project$R10$FormComponents$UI$Color$fromPaletteColor(
			A2($author$project$R10$FormComponents$UI$Palette$withOpacity, alpha, palette.surface));
	});
var $author$project$R10$Form$Internal$MakerForView$viewTab = F3(
	function (args, fieldState, _v0) {
		var index = _v0.index;
		var selected = _v0.selected;
		var entity = _v0.entity;
		var label = _v0.label;
		var valid = A2(
			$author$project$R10$Form$Internal$Update$isExistingFormFieldsValid,
			_List_fromArray(
				[entity]),
			args.formState);
		var _v1 = fieldState.disabled ? {clickOverlay: $mdgriffith$elm_ui$Element$none, opacity: 0.5} : {
			clickOverlay: A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Events$onClick(
						A2(
							$author$project$R10$Form$Msg$ChangeTab,
							args.key,
							$author$project$R10$Form$Internal$Conf$getId(entity))),
						$mdgriffith$elm_ui$Element$pointer,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$htmlAttribute(
						$elm$html$Html$Attributes$class('ripple')),
						$mdgriffith$elm_ui$Element$mouseOver(
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Background$color(
								$author$project$R10$FormComponents$UI$Color$mouseOverSurface(args.palette))
							]))
					]),
				$mdgriffith$elm_ui$Element$none),
			opacity: 1
		};
		var opacity = _v1.opacity;
		var clickOverlay = _v1.clickOverlay;
		var _v2 = selected ? {
			circleBackground: A2($author$project$R10$FormComponents$UI$Color$surfaceA, opacity, args.palette),
			circleBorder: A2($author$project$R10$FormComponents$UI$Color$primaryA, opacity, args.palette),
			circleText: A2($author$project$R10$FormComponents$UI$Color$primaryA, opacity, args.palette),
			labelText: A2($author$project$R10$FormComponents$UI$Color$primaryA, opacity, args.palette)
		} : {
			circleBackground: A2($author$project$R10$FormComponents$UI$Color$surfaceA, opacity, args.palette),
			circleBorder: A2($author$project$R10$FormComponents$UI$Color$labelA, opacity, args.palette),
			circleText: A2($author$project$R10$FormComponents$UI$Color$labelA, opacity, args.palette),
			labelText: A2($author$project$R10$FormComponents$UI$Color$labelA, opacity, args.palette)
		};
		var circleBackground = _v2.circleBackground;
		var circleBorder = _v2.circleBorder;
		var circleText = _v2.circleText;
		var labelText = _v2.labelText;
		return A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					A2($mdgriffith$elm_ui$Element$paddingXY, 8, 0),
					$mdgriffith$elm_ui$Element$inFront(clickOverlay)
				]),
			A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Background$color(
						$author$project$R10$FormComponents$UI$Color$surface(args.palette)),
						A2($mdgriffith$elm_ui$Element$paddingXY, 8, 24),
						$mdgriffith$elm_ui$Element$spacing(8),
						$mdgriffith$elm_ui$Element$Font$color(labelText)
					]),
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$inFront(
								A2(
									$mdgriffith$elm_ui$Element$el,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$Background$color(
											$author$project$R10$FormComponents$UI$Color$surface(args.palette))
										]),
									$author$project$R10$FormComponents$UI$showValidationIcon_(
										{
											displayValidation: true,
											maybeValid: $elm$core$Maybe$Just(valid),
											palette: args.palette
										}))),
								$mdgriffith$elm_ui$Element$height(
								$mdgriffith$elm_ui$Element$px(24)),
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$px(24)),
								$mdgriffith$elm_ui$Element$Border$rounded(24),
								$mdgriffith$elm_ui$Element$Background$color(circleBackground),
								$mdgriffith$elm_ui$Element$Font$color(circleText),
								$mdgriffith$elm_ui$Element$Border$innerShadow(
								{
									blur: 0,
									color: circleBorder,
									offset: _Utils_Tuple2(0, 0),
									size: 1
								})
							]),
						A2(
							$mdgriffith$elm_ui$Element$el,
							_List_fromArray(
								[$mdgriffith$elm_ui$Element$centerY, $mdgriffith$elm_ui$Element$centerX]),
							$mdgriffith$elm_ui$Element$text(
								$elm$core$String$fromInt(index + 1)))),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink)
							]),
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$text(label),
								A2(
								$mdgriffith$elm_ui$Element$el,
								_Utils_ap(
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$Font$size(11),
											$mdgriffith$elm_ui$Element$clip,
											$mdgriffith$elm_ui$Element$Font$color(
											$author$project$R10$FormComponents$UI$Color$error(args.palette)),
											$mdgriffith$elm_ui$Element$htmlAttribute(
											A2($elm$html$Html$Attributes$style, 'transition', 'all 0.15s ease-out'))
										]),
									valid ? _List_fromArray(
										[
											$mdgriffith$elm_ui$Element$width(
											$mdgriffith$elm_ui$Element$px(0)),
											$mdgriffith$elm_ui$Element$height(
											$mdgriffith$elm_ui$Element$px(0))
										]) : _List_fromArray(
										[
											$mdgriffith$elm_ui$Element$width(
											$mdgriffith$elm_ui$Element$px(80)),
											$mdgriffith$elm_ui$Element$height(
											$mdgriffith$elm_ui$Element$px(11))
										])),
								$mdgriffith$elm_ui$Element$text('Validation error'))
							]))
					])));
	});
var $author$project$R10$FormComponents$Validations$ClearOrCheck = {$: 'ClearOrCheck'};
var $author$project$R10$FormComponents$Validations$ErrorOrCheck = {$: 'ErrorOrCheck'};
var $author$project$R10$FormComponents$Validations$NoIcon = {$: 'NoIcon'};
var $author$project$R10$Form$Internal$Converter$fromFormValidationIconToComponentValidationIcon = function (formIcon) {
	switch (formIcon.$) {
		case 'NoIcon':
			return $author$project$R10$FormComponents$Validations$NoIcon;
		case 'ClearOrCheck':
			return $author$project$R10$FormComponents$Validations$ClearOrCheck;
		default:
			return $author$project$R10$FormComponents$Validations$ErrorOrCheck;
	}
};
var $author$project$R10$Form$Internal$MakerForView$getEntityKey = F2(
	function (args, entity) {
		var id = function () {
			switch (entity.$) {
				case 'EntityWrappable':
					var entityId = entity.a;
					return entityId;
				case 'EntityWithBorder':
					var entityId = entity.a;
					return entityId;
				case 'EntityNormal':
					var entityId = entity.a;
					return entityId;
				case 'EntityWithTabs':
					var entityId = entity.a;
					return entityId;
				case 'EntityMulti':
					var entityId = entity.a;
					return entityId;
				case 'EntityField':
					var fieldConf = entity.a;
					return fieldConf.id;
				case 'EntityTitle':
					var entityId = entity.a;
					return entityId;
				default:
					var entityId = entity.a;
					return entityId;
			}
		}();
		return A2($author$project$R10$Form$Internal$Key$composeKey, args.key, id);
	});
var $author$project$R10$Form$Internal$FieldConf$initValidationSpecs = {
	hidePassedValidationStyle: false,
	showPassedValidationMessages: false,
	validation: _List_fromArray(
		[$author$project$R10$Form$Internal$FieldConf$NoValidation]),
	validationIcon: $author$project$R10$Form$Internal$FieldConf$NoIcon
};
var $author$project$R10$Form$Internal$FieldConf$init = {
	helperText: $elm$core$Maybe$Nothing,
	id: '',
	idDom: $elm$core$Maybe$Nothing,
	label: '',
	requiredLabel: $elm$core$Maybe$Nothing,
	type_: $author$project$R10$Form$Internal$FieldConf$TypeText($author$project$R10$Form$Internal$FieldConf$TextPlain),
	validationSpecs: $elm$core$Maybe$Just($author$project$R10$Form$Internal$FieldConf$initValidationSpecs)
};
var $author$project$R10$Form$Internal$MakerForView$getFieldConfig = function (entity) {
	if (entity.$ === 'EntityField') {
		var fieldConf = entity.a;
		return fieldConf;
	} else {
		return $author$project$R10$Form$Internal$FieldConf$init;
	}
};
var $mdgriffith$elm_ui$Element$clipY = A2($mdgriffith$elm_ui$Internal$Model$Class, $mdgriffith$elm_ui$Internal$Flag$overflow, $mdgriffith$elm_ui$Internal$Style$classes.clipY);
var $author$project$R10$FormComponents$Validations$animatedList = function (elements) {
	var transition = $mdgriffith$elm_ui$Element$htmlAttribute(
		A2($elm$html$Html$Attributes$style, 'transition', 'all 0.15s ease-in, opacity 0.15s 0.2s ease-in'));
	var wrappedLine = A2(
		$mdgriffith$elm_ui$Element$el,
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$padding(0),
				$mdgriffith$elm_ui$Element$alpha(0),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'min-height', '0px')),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'max-height', '0px')),
				$mdgriffith$elm_ui$Element$Font$size(0),
				transition
			]),
		$mdgriffith$elm_ui$Element$none);
	var expandedLine = $mdgriffith$elm_ui$Element$el(
		_List_fromArray(
			[
				$mdgriffith$elm_ui$Element$paddingEach(
				{bottom: 0, left: 0, right: 0, top: 6}),
				$mdgriffith$elm_ui$Element$Font$size(14),
				$mdgriffith$elm_ui$Element$alpha(1),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'min-height', '24px')),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'max-height', '64px')),
				transition,
				$mdgriffith$elm_ui$Element$clipY
			]));
	return A2(
		$mdgriffith$elm_ui$Element$column,
		_Utils_ap(
			_List_fromArray(
				[$mdgriffith$elm_ui$Element$alignTop, transition]),
			($elm$core$List$length(elements) > 0) ? _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$paddingEach(
					{bottom: 0, left: 0, right: 0, top: $author$project$R10$FormComponents$UI$genericSpacing})
				]) : _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$padding(0)
				])),
		_Utils_ap(
			A2($elm$core$List$map, expandedLine, elements),
			A2($elm$core$List$repeat, 5, wrappedLine)));
};
var $author$project$R10$FormComponents$UI$Color$success = A2(
	$elm$core$Basics$composeR,
	function ($) {
		return $.success;
	},
	$author$project$R10$FormComponents$UI$Color$fromPaletteColor);
var $author$project$R10$FormComponents$Validations$viewValidationIcon = F2(
	function (palette, validationIcon) {
		var iconAttrs = _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$width(
				$mdgriffith$elm_ui$Element$px(16)),
				$mdgriffith$elm_ui$Element$height(
				$mdgriffith$elm_ui$Element$px(16))
			]);
		switch (validationIcon.$) {
			case 'NoIcon':
				return {invalidIcon: $mdgriffith$elm_ui$Element$none, validIcon: $mdgriffith$elm_ui$Element$none};
			case 'ClearOrCheck':
				return {
					invalidIcon: A3(
						$author$project$R10$FormComponents$UI$icons.validation_clear,
						iconAttrs,
						$author$project$R10$Color$Utils$elementColorToColor(
							$author$project$R10$FormComponents$UI$Color$error(palette)),
						24),
					validIcon: A3(
						$author$project$R10$FormComponents$UI$icons.validation_check,
						iconAttrs,
						$author$project$R10$Color$Utils$elementColorToColor(
							$author$project$R10$FormComponents$UI$Color$success(palette)),
						24)
				};
			default:
				return {
					invalidIcon: A3(
						$author$project$R10$FormComponents$UI$icons.validation_error,
						iconAttrs,
						$author$project$R10$Color$Utils$elementColorToColor(
							$author$project$R10$FormComponents$UI$Color$error(palette)),
						24),
					validIcon: A3(
						$author$project$R10$FormComponents$UI$icons.validation_check,
						iconAttrs,
						$author$project$R10$Color$Utils$elementColorToColor(
							$author$project$R10$FormComponents$UI$Color$success(palette)),
						24)
				};
		}
	});
var $author$project$R10$FormComponents$Validations$viewValidationMessage = F3(
	function (palette, validationIcon, validationMessage) {
		if (validationMessage.$ === 'MessageOk') {
			var string = validationMessage.a;
			return A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$spacing(4)
					]),
				_List_fromArray(
					[
						A2($author$project$R10$FormComponents$Validations$viewValidationIcon, palette, validationIcon).validIcon,
						A3(
						$author$project$R10$FormComponents$UI$viewHelperText,
						palette,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								$author$project$R10$FormComponents$UI$Color$success(palette))
							]),
						$elm$core$Maybe$Just(string))
					]));
		} else {
			var string = validationMessage.a;
			return A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$spacing(4)
					]),
				_List_fromArray(
					[
						A2($author$project$R10$FormComponents$Validations$viewValidationIcon, palette, validationIcon).invalidIcon,
						A3(
						$author$project$R10$FormComponents$UI$viewHelperText,
						palette,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$Font$color(
								$author$project$R10$FormComponents$UI$Color$error(palette))
							]),
						$elm$core$Maybe$Just(string))
					]));
		}
	});
var $author$project$R10$FormComponents$Validations$viewValidation = F3(
	function (palette, validationIcon, validation) {
		if (validation.$ === 'NotYetValidated') {
			return $author$project$R10$FormComponents$Validations$animatedList(_List_Nil);
		} else {
			var listValidationMessage = validation.a;
			return $author$project$R10$FormComponents$Validations$animatedList(
				A2(
					$elm$core$List$map,
					A2($author$project$R10$FormComponents$Validations$viewValidationMessage, palette, validationIcon),
					listValidationMessage));
		}
	});
var $author$project$R10$Form$Internal$MakerForView$viewWithValidationMessage = F3(
	function (args, entity, listEl) {
		var validationIcon = $author$project$R10$Form$Internal$Converter$fromFormValidationIconToComponentValidationIcon(
			A2(
				$elm$core$Maybe$withDefault,
				$author$project$R10$Form$Internal$FieldConf$NoIcon,
				A2(
					$elm$core$Maybe$map,
					function ($) {
						return $.validationIcon;
					},
					$author$project$R10$Form$Internal$MakerForView$getFieldConfig(entity).validationSpecs)));
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
					]),
				_Utils_ap(
					listEl,
					_List_fromArray(
						[
							A3(
							$author$project$R10$FormComponents$Validations$viewValidation,
							args.palette,
							validationIcon,
							A3(
								$author$project$R10$Form$Internal$Converter$fromFieldStateValidationToComponentValidation,
								$author$project$R10$Form$Internal$MakerForView$getFieldConfig(entity).validationSpecs,
								A2(
									$elm$core$Maybe$withDefault,
									$author$project$R10$Form$Internal$FieldState$init,
									A2(
										$author$project$R10$Form$Internal$Dict$get,
										A2($author$project$R10$Form$Internal$MakerForView$getEntityKey, args, entity),
										args.formState.fieldsState)).validation,
								args.translator))
						])))
			]);
	});
var $mdgriffith$elm_ui$Element$Border$widthXY = F2(
	function (x, y) {
		return A2(
			$mdgriffith$elm_ui$Internal$Model$StyleClass,
			$mdgriffith$elm_ui$Internal$Flag$borderWidth,
			A5(
				$mdgriffith$elm_ui$Internal$Model$BorderWidth,
				'b-' + ($elm$core$String$fromInt(x) + ('-' + $elm$core$String$fromInt(y))),
				y,
				x,
				y,
				x));
	});
var $mdgriffith$elm_ui$Element$Border$widthEach = function (_v0) {
	var bottom = _v0.bottom;
	var top = _v0.top;
	var left = _v0.left;
	var right = _v0.right;
	return (_Utils_eq(top, bottom) && _Utils_eq(left, right)) ? (_Utils_eq(top, right) ? $mdgriffith$elm_ui$Element$Border$width(top) : A2($mdgriffith$elm_ui$Element$Border$widthXY, left, top)) : A2(
		$mdgriffith$elm_ui$Internal$Model$StyleClass,
		$mdgriffith$elm_ui$Internal$Flag$borderWidth,
		A5(
			$mdgriffith$elm_ui$Internal$Model$BorderWidth,
			'b-' + ($elm$core$String$fromInt(top) + ('-' + ($elm$core$String$fromInt(right) + ('-' + ($elm$core$String$fromInt(bottom) + ('-' + $elm$core$String$fromInt(left))))))),
			top,
			right,
			bottom,
			left));
};
var $mdgriffith$elm_ui$Internal$Model$Padding = F5(
	function (a, b, c, d, e) {
		return {$: 'Padding', a: a, b: b, c: c, d: d, e: e};
	});
var $mdgriffith$elm_ui$Internal$Model$Spaced = F3(
	function (a, b, c) {
		return {$: 'Spaced', a: a, b: b, c: c};
	});
var $mdgriffith$elm_ui$Internal$Model$extractSpacingAndPadding = function (attrs) {
	return A3(
		$elm$core$List$foldr,
		F2(
			function (attr, _v0) {
				var pad = _v0.a;
				var spacing = _v0.b;
				return _Utils_Tuple2(
					function () {
						if (pad.$ === 'Just') {
							var x = pad.a;
							return pad;
						} else {
							if ((attr.$ === 'StyleClass') && (attr.b.$ === 'PaddingStyle')) {
								var _v3 = attr.b;
								var name = _v3.a;
								var t = _v3.b;
								var r = _v3.c;
								var b = _v3.d;
								var l = _v3.e;
								return $elm$core$Maybe$Just(
									A5($mdgriffith$elm_ui$Internal$Model$Padding, name, t, r, b, l));
							} else {
								return $elm$core$Maybe$Nothing;
							}
						}
					}(),
					function () {
						if (spacing.$ === 'Just') {
							var x = spacing.a;
							return spacing;
						} else {
							if ((attr.$ === 'StyleClass') && (attr.b.$ === 'SpacingStyle')) {
								var _v6 = attr.b;
								var name = _v6.a;
								var x = _v6.b;
								var y = _v6.c;
								return $elm$core$Maybe$Just(
									A3($mdgriffith$elm_ui$Internal$Model$Spaced, name, x, y));
							} else {
								return $elm$core$Maybe$Nothing;
							}
						}
					}());
			}),
		_Utils_Tuple2($elm$core$Maybe$Nothing, $elm$core$Maybe$Nothing),
		attrs);
};
var $mdgriffith$elm_ui$Element$wrappedRow = F2(
	function (attrs, children) {
		var _v0 = $mdgriffith$elm_ui$Internal$Model$extractSpacingAndPadding(attrs);
		var padded = _v0.a;
		var spaced = _v0.b;
		if (spaced.$ === 'Nothing') {
			return A4(
				$mdgriffith$elm_ui$Internal$Model$element,
				$mdgriffith$elm_ui$Internal$Model$asRow,
				$mdgriffith$elm_ui$Internal$Model$div,
				A2(
					$elm$core$List$cons,
					$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.wrapped)))),
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
							attrs))),
				$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
		} else {
			var _v2 = spaced.a;
			var spaceName = _v2.a;
			var x = _v2.b;
			var y = _v2.c;
			var newPadding = function () {
				if (padded.$ === 'Just') {
					var _v5 = padded.a;
					var name = _v5.a;
					var t = _v5.b;
					var r = _v5.c;
					var b = _v5.d;
					var l = _v5.e;
					if ((_Utils_cmp(r, x / 2) > -1) && (_Utils_cmp(b, y / 2) > -1)) {
						var newTop = t - (y / 2);
						var newRight = r - (x / 2);
						var newLeft = l - (x / 2);
						var newBottom = b - (y / 2);
						return $elm$core$Maybe$Just(
							A2(
								$mdgriffith$elm_ui$Internal$Model$StyleClass,
								$mdgriffith$elm_ui$Internal$Flag$padding,
								A5(
									$mdgriffith$elm_ui$Internal$Model$PaddingStyle,
									A4($mdgriffith$elm_ui$Internal$Model$paddingNameFloat, newTop, newRight, newBottom, newLeft),
									newTop,
									newRight,
									newBottom,
									newLeft)));
					} else {
						return $elm$core$Maybe$Nothing;
					}
				} else {
					return $elm$core$Maybe$Nothing;
				}
			}();
			if (newPadding.$ === 'Just') {
				var pad = newPadding.a;
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asRow,
					$mdgriffith$elm_ui$Internal$Model$div,
					A2(
						$elm$core$List$cons,
						$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.wrapped)))),
						A2(
							$elm$core$List$cons,
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$shrink),
							A2(
								$elm$core$List$cons,
								$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
								_Utils_ap(
									attrs,
									_List_fromArray(
										[pad]))))),
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(children));
			} else {
				var halfY = -(y / 2);
				var halfX = -(x / 2);
				return A4(
					$mdgriffith$elm_ui$Internal$Model$element,
					$mdgriffith$elm_ui$Internal$Model$asEl,
					$mdgriffith$elm_ui$Internal$Model$div,
					attrs,
					$mdgriffith$elm_ui$Internal$Model$Unkeyed(
						_List_fromArray(
							[
								A4(
								$mdgriffith$elm_ui$Internal$Model$element,
								$mdgriffith$elm_ui$Internal$Model$asRow,
								$mdgriffith$elm_ui$Internal$Model$div,
								A2(
									$elm$core$List$cons,
									$mdgriffith$elm_ui$Internal$Model$htmlClass($mdgriffith$elm_ui$Internal$Style$classes.contentLeft + (' ' + ($mdgriffith$elm_ui$Internal$Style$classes.contentCenterY + (' ' + $mdgriffith$elm_ui$Internal$Style$classes.wrapped)))),
									A2(
										$elm$core$List$cons,
										$mdgriffith$elm_ui$Internal$Model$Attr(
											A2(
												$elm$html$Html$Attributes$style,
												'margin',
												$elm$core$String$fromFloat(halfY) + ('px' + (' ' + ($elm$core$String$fromFloat(halfX) + 'px'))))),
										A2(
											$elm$core$List$cons,
											$mdgriffith$elm_ui$Internal$Model$Attr(
												A2(
													$elm$html$Html$Attributes$style,
													'width',
													'calc(100% + ' + ($elm$core$String$fromInt(x) + 'px)'))),
											A2(
												$elm$core$List$cons,
												$mdgriffith$elm_ui$Internal$Model$Attr(
													A2(
														$elm$html$Html$Attributes$style,
														'height',
														'calc(100% + ' + ($elm$core$String$fromInt(y) + 'px)'))),
												A2(
													$elm$core$List$cons,
													A2(
														$mdgriffith$elm_ui$Internal$Model$StyleClass,
														$mdgriffith$elm_ui$Internal$Flag$spacing,
														A3($mdgriffith$elm_ui$Internal$Model$SpacingStyle, spaceName, x, y)),
													_List_Nil))))),
								$mdgriffith$elm_ui$Internal$Model$Unkeyed(children))
							])));
			}
		}
	});
var $author$project$R10$Form$Internal$MakerForView$maker_ = F3(
	function (args, branchConfig, rootFormConf) {
		return $elm$core$List$concat(
			A2(
				$elm$core$List$map,
				function (entity) {
					return A3(
						$author$project$R10$Form$Internal$MakerForView$viewWithValidationMessage,
						args,
						entity,
						function () {
							switch (entity.$) {
								case 'EntityWrappable':
									var entityId = entity.a;
									var entities = entity.b;
									return A3(
										$author$project$R10$Form$Internal$MakerForView$viewEntityWrappable,
										_Utils_update(
											args,
											{
												key: A2($author$project$R10$Form$Internal$Key$composeKey, args.key, entityId)
											}),
										entities,
										rootFormConf);
								case 'EntityWithBorder':
									var entityId = entity.a;
									var entities = entity.b;
									return A3(
										$author$project$R10$Form$Internal$MakerForView$viewEntityWithBorder,
										_Utils_update(
											args,
											{
												key: A2($author$project$R10$Form$Internal$Key$composeKey, args.key, entityId)
											}),
										entities,
										rootFormConf);
								case 'EntityNormal':
									var entityId = entity.a;
									var entities = entity.b;
									return A3(
										$author$project$R10$Form$Internal$MakerForView$viewEntityNormal,
										_Utils_update(
											args,
											{
												key: A2($author$project$R10$Form$Internal$Key$composeKey, args.key, entityId)
											}),
										entities,
										rootFormConf);
								case 'EntityWithTabs':
									var entityId = entity.a;
									var titleEntityList = entity.b;
									return A3(
										$author$project$R10$Form$Internal$MakerForView$viewEntityWithTabs,
										_Utils_update(
											args,
											{
												key: A2($author$project$R10$Form$Internal$Key$composeKey, args.key, entityId)
											}),
										titleEntityList,
										rootFormConf);
								case 'EntityMulti':
									var entityId = entity.a;
									var entities = entity.b;
									return A3(
										$author$project$R10$Form$Internal$MakerForView$viewEntityMulti,
										_Utils_update(
											args,
											{
												key: A2($author$project$R10$Form$Internal$Key$composeKey, args.key, entityId)
											}),
										entities,
										rootFormConf);
								case 'EntityField':
									var fieldConf = entity.a;
									return A3($author$project$R10$Form$Internal$MakerForView$viewEntityField, args, fieldConf, rootFormConf);
								case 'EntityTitle':
									var titleConf = entity.b;
									return A2($author$project$R10$Form$Internal$MakerForView$viewEntityTitle, args.palette, titleConf);
								default:
									var titleConf = entity.b;
									return A2($author$project$R10$Form$Internal$MakerForView$viewEntitySubTitle, args.palette, titleConf);
							}
						}());
				},
				branchConfig));
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntityMulti = F3(
	function (args, entities, formConf) {
		var activeKeys = A2($author$project$R10$Form$Internal$Helpers$getMultiActiveKeys, args.key, args.formState);
		var quantity = $elm$core$List$length(activeKeys);
		return $elm$core$List$singleton(
			A2(
				$mdgriffith$elm_ui$Element$column,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(10),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				$elm$core$List$concat(
					A2(
						$elm$core$List$indexedMap,
						F2(
							function (index, newKey) {
								return A6($author$project$R10$Form$Internal$MakerForView$viewEntityMultiHelper, args, quantity, index, newKey, entities, formConf);
							}),
						activeKeys))));
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntityMultiHelper = F6(
	function (args, quantity, index, newKey, entities, formConf) {
		var shadow = F2(
			function (size_, a) {
				return $mdgriffith$elm_ui$Element$Border$shadow(
					{
						blur: 0,
						color: A2($author$project$R10$FormComponents$UI$Color$labelA, a, args.palette),
						offset: _Utils_Tuple2(0, 0),
						size: size_
					});
			});
		var removeColor = $author$project$R10$FormComponents$UI$Color$label(args.palette);
		var plusColor = $author$project$R10$FormComponents$UI$Color$label(args.palette);
		var iconSize = 18;
		var iconCommonAttrs = F4(
			function (widthPx, heightPx, color, rotateDeg) {
				return _List_fromArray(
					[
						$mdgriffith$elm_ui$Element$htmlAttribute(
						A2($elm$html$Html$Attributes$style, 'transition', 'all 0.2s ')),
						$mdgriffith$elm_ui$Element$Border$rounded(2),
						$mdgriffith$elm_ui$Element$centerX,
						$mdgriffith$elm_ui$Element$centerY,
						$mdgriffith$elm_ui$Element$width(
						$mdgriffith$elm_ui$Element$px(widthPx)),
						$mdgriffith$elm_ui$Element$height(
						$mdgriffith$elm_ui$Element$px(heightPx)),
						$mdgriffith$elm_ui$Element$Background$color(color),
						$mdgriffith$elm_ui$Element$rotate(
						$elm$core$Basics$degrees(rotateDeg))
					]);
			});
		var buttonAttrs = _List_fromArray(
			[
				$mdgriffith$elm_ui$Element$Border$width(1),
				$mdgriffith$elm_ui$Element$Border$rounded(5),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				$elm$html$Html$Attributes$class('ripple')),
				$mdgriffith$elm_ui$Element$htmlAttribute(
				A2($elm$html$Html$Attributes$style, 'transition', 'all 0.11s ease-out')),
				$mdgriffith$elm_ui$Element$padding(8),
				$mdgriffith$elm_ui$Element$width(
				$mdgriffith$elm_ui$Element$px(28)),
				$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
				A2(shadow, 10, 0),
				$mdgriffith$elm_ui$Element$Border$color(
				A2($author$project$R10$FormComponents$UI$Color$containerA, 0.5, args.palette)),
				$mdgriffith$elm_ui$Element$mouseOver(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$Border$color(
						A2($author$project$R10$FormComponents$UI$Color$containerA, 1, args.palette))
					])),
				$mdgriffith$elm_ui$Element$focused(
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alpha(1),
						A2(shadow, 1, 1),
						$mdgriffith$elm_ui$Element$Border$color(
						A2($author$project$R10$FormComponents$UI$Color$containerA, 1, args.palette))
					]))
			]);
		var buttonToAddEntity = A2(
			$mdgriffith$elm_ui$Element$Input$button,
			buttonAttrs,
			{
				label: A2(
					$mdgriffith$elm_ui$Element$el,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$width(
							$mdgriffith$elm_ui$Element$px(iconSize)),
							$mdgriffith$elm_ui$Element$height(
							$mdgriffith$elm_ui$Element$px(iconSize)),
							$mdgriffith$elm_ui$Element$inFront(
							A2(
								$mdgriffith$elm_ui$Element$el,
								A4(iconCommonAttrs, iconSize, 2, plusColor, 0),
								$mdgriffith$elm_ui$Element$none)),
							$mdgriffith$elm_ui$Element$inFront(
							A2(
								$mdgriffith$elm_ui$Element$el,
								A4(iconCommonAttrs, 2, iconSize, plusColor, 0),
								$mdgriffith$elm_ui$Element$none))
						]),
					$mdgriffith$elm_ui$Element$none),
				onPress: $elm$core$Maybe$Just(
					$author$project$R10$Form$Msg$AddEntity(args.key))
			});
		var buttonToRemoveEntity = function (key_) {
			return A2(
				$mdgriffith$elm_ui$Element$Input$button,
				buttonAttrs,
				{
					label: A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width(
								$mdgriffith$elm_ui$Element$px(iconSize)),
								$mdgriffith$elm_ui$Element$height(
								$mdgriffith$elm_ui$Element$px(iconSize)),
								$mdgriffith$elm_ui$Element$htmlAttribute(
								A2($elm$html$Html$Attributes$style, 'transition', 'all 0.2s ')),
								$mdgriffith$elm_ui$Element$inFront(
								A2(
									$mdgriffith$elm_ui$Element$el,
									A4(iconCommonAttrs, iconSize, 2, removeColor, 45),
									$mdgriffith$elm_ui$Element$none)),
								$mdgriffith$elm_ui$Element$inFront(
								A2(
									$mdgriffith$elm_ui$Element$el,
									A4(iconCommonAttrs, 2, iconSize, removeColor, -135),
									$mdgriffith$elm_ui$Element$none))
							]),
						$mdgriffith$elm_ui$Element$none),
					onPress: $elm$core$Maybe$Just(
						$author$project$R10$Form$Msg$RemoveEntity(key_))
				});
		};
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$row,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$spacing(10),
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
					]),
				_List_fromArray(
					[
						_Utils_eq(quantity - 1, index) ? buttonToAddEntity : buttonToRemoveEntity(newKey),
						A2(
						$mdgriffith$elm_ui$Element$column,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								$author$project$R10$Form$Internal$MakerForView$spacingGeneric
							]),
						A3(
							$author$project$R10$Form$Internal$MakerForView$maker_,
							_Utils_update(
								args,
								{key: newKey}),
							entities,
							formConf))
					]))
			]);
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntityNormal = F3(
	function (args, entities, formConf) {
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$el,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alignTop,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$author$project$R10$Form$Internal$MakerForView$spacingGeneric
					]),
				A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$author$project$R10$Form$Internal$MakerForView$spacingGeneric,
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
						]),
					A3($author$project$R10$Form$Internal$MakerForView$maker_, args, entities, formConf)))
			]);
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntityWithBorder = F3(
	function (args, entities, formConf) {
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$el,
				_Utils_ap(
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$alignTop,
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
							$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
						]),
					$author$project$R10$FormComponents$UI$borderEntityWithBorder(args.palette)),
				A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$author$project$R10$Form$Internal$MakerForView$paddingGeneric,
							$author$project$R10$Form$Internal$MakerForView$spacingGeneric,
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
						]),
					A3($author$project$R10$Form$Internal$MakerForView$maker_, args, entities, formConf)))
			]);
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntityWithTabs = F3(
	function (args, titleEntityList, formConf) {
		var tabSpacer = A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width(
					A2($mdgriffith$elm_ui$Element$maximum, 40, $mdgriffith$elm_ui$Element$fill)),
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill)
				]),
			$mdgriffith$elm_ui$Element$none);
		var paddingPx = 8;
		var firstEntity = $elm$core$List$head(titleEntityList);
		var maybeSelectedEntity = function () {
			var _v3 = A2($author$project$R10$Form$Internal$Dict$get, args.key, args.formState.activeTabs);
			if (_v3.$ === 'Just') {
				var key_ = _v3.a;
				var _v4 = $elm$core$List$head(
					A2(
						$elm$core$List$filter,
						function (_v5) {
							var entity = _v5.b;
							return _Utils_eq(
								$author$project$R10$Form$Internal$Conf$getId(entity),
								key_);
						},
						titleEntityList));
				if (_v4.$ === 'Just') {
					var entity_ = _v4.a;
					return $elm$core$Maybe$Just(entity_);
				} else {
					return firstEntity;
				}
			} else {
				return firstEntity;
			}
		}();
		var emptyTab = A2(
			$mdgriffith$elm_ui$Element$el,
			_List_fromArray(
				[
					$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
					$mdgriffith$elm_ui$Element$moveLeft(paddingPx),
					$mdgriffith$elm_ui$Element$Background$color(
					A3($mdgriffith$elm_ui$Element$rgb, 1, 1, 1))
				]),
			$mdgriffith$elm_ui$Element$none);
		if (maybeSelectedEntity.$ === 'Just') {
			var _v1 = maybeSelectedEntity.a;
			var selectedEntity = _v1.b;
			return _Utils_ap(
				_List_fromArray(
					[
						A2(
						$mdgriffith$elm_ui$Element$el,
						_List_fromArray(
							[
								$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
								$mdgriffith$elm_ui$Element$behindContent(
								A2(
									$mdgriffith$elm_ui$Element$el,
									_List_fromArray(
										[
											$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
											$mdgriffith$elm_ui$Element$centerY,
											A2($mdgriffith$elm_ui$Element$paddingXY, paddingPx, 0)
										]),
									A2(
										$mdgriffith$elm_ui$Element$el,
										_List_fromArray(
											[
												$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
												$mdgriffith$elm_ui$Element$Border$widthEach(
												{bottom: 1, left: 0, right: 0, top: 0}),
												$mdgriffith$elm_ui$Element$Border$color(
												$author$project$R10$FormComponents$UI$Color$container(args.palette))
											]),
										$mdgriffith$elm_ui$Element$none)))
							]),
						A2(
							$mdgriffith$elm_ui$Element$row,
							_List_fromArray(
								[
									$mdgriffith$elm_ui$Element$scrollbars,
									$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
								]),
							function (items) {
								return _Utils_ap(
									items,
									_List_fromArray(
										[emptyTab]));
							}(
								$elm$core$List$concat(
									A2(
										$elm$core$List$indexedMap,
										F2(
											function (index, _v2) {
												var label = _v2.a;
												var entity = _v2.b;
												var newKey = A2(
													$author$project$R10$Form$Internal$Key$composeKey,
													args.key,
													$author$project$R10$Form$Internal$Conf$getId(entity));
												var fieldState = A2(
													$elm$core$Maybe$withDefault,
													$author$project$R10$Form$Internal$FieldState$init,
													A2($author$project$R10$Form$Internal$Dict$get, newKey, args.formState.fieldsState));
												return _Utils_ap(
													_List_fromArray(
														[
															A3(
															$author$project$R10$Form$Internal$MakerForView$viewTab,
															args,
															fieldState,
															{
																entity: entity,
																index: index,
																label: label,
																selected: _Utils_eq(
																	$author$project$R10$Form$Internal$Conf$getId(selectedEntity),
																	$author$project$R10$Form$Internal$Conf$getId(entity))
															})
														]),
													(!_Utils_eq(
														index + 1,
														$elm$core$List$length(titleEntityList))) ? _List_fromArray(
														[tabSpacer]) : _List_Nil);
											}),
										titleEntityList)))))
					]),
				A3(
					$author$project$R10$Form$Internal$MakerForView$maker_,
					args,
					_List_fromArray(
						[selectedEntity]),
					formConf));
		} else {
			return _List_Nil;
		}
	});
var $author$project$R10$Form$Internal$MakerForView$viewEntityWrappable = F3(
	function (args, entities, formConf) {
		return _List_fromArray(
			[
				A2(
				$mdgriffith$elm_ui$Element$wrappedRow,
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$alignTop,
						$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$fill),
						$author$project$R10$Form$Internal$MakerForView$spacingGeneric
					]),
				A3($author$project$R10$Form$Internal$MakerForView$maker_, args, entities, formConf))
			]);
	});
var $author$project$R10$Form$Internal$MakerForView$maker = F2(
	function (args, formConf) {
		return A3($author$project$R10$Form$Internal$MakerForView$maker_, args, formConf, formConf);
	});
var $author$project$R10$Form$viewWithOptions = F3(
	function (form, msgMapper, args) {
		return A2(
			$elm$core$List$map,
			$mdgriffith$elm_ui$Element$map(msgMapper),
			A4(
				$elm$core$Maybe$withDefault,
				$author$project$R10$Form$Internal$MakerForView$maker,
				args.maker,
				{
					formState: form.state,
					key: $author$project$R10$Form$Internal$Key$empty,
					palette: A2($elm$core$Maybe$withDefault, $author$project$R10$FormComponents$UI$Palette$light, args.palette),
					style: args.style,
					translator: A2($elm$core$Maybe$withDefault, $author$project$R10$Form$defaultTranslator, args.translator)
				},
				form.conf));
	});
var $author$project$Main$view = function (model) {
	return A3(
		$mdgriffith$elm_ui$Element$layoutWith,
		{
			options: _List_fromArray(
				[
					$mdgriffith$elm_ui$Element$focusStyle(
					{backgroundColor: $elm$core$Maybe$Nothing, borderColor: $elm$core$Maybe$Nothing, shadow: $elm$core$Maybe$Nothing})
				])
		},
		_List_fromArray(
			[
				$author$project$R10$Color$AttrsBackground$background($author$project$Main$theme),
				$mdgriffith$elm_ui$Element$padding(20),
				$author$project$R10$FontSize$normal
			]),
		A2(
			$mdgriffith$elm_ui$Element$column,
			_Utils_ap(
				$author$project$R10$Card$high($author$project$Main$theme),
				_List_fromArray(
					[
						$mdgriffith$elm_ui$Element$centerX,
						$mdgriffith$elm_ui$Element$centerY,
						$mdgriffith$elm_ui$Element$width(
						A2($mdgriffith$elm_ui$Element$maximum, 460, $mdgriffith$elm_ui$Element$fill)),
						$mdgriffith$elm_ui$Element$height($mdgriffith$elm_ui$Element$shrink),
						$mdgriffith$elm_ui$Element$spacing(30)
					])),
			_List_fromArray(
				[
					A3(
					$author$project$R10$Svg$Logos$rakuten,
					_List_Nil,
					$author$project$R10$Color$Svg$logo($author$project$Main$theme),
					32),
					$author$project$Main$viewCreditCard(model.form.state),
					A2(
					$mdgriffith$elm_ui$Element$column,
					_List_fromArray(
						[
							$mdgriffith$elm_ui$Element$spacing(20),
							$mdgriffith$elm_ui$Element$width($mdgriffith$elm_ui$Element$fill)
						]),
					A3(
						$author$project$R10$Form$viewWithOptions,
						model.form,
						$author$project$Main$MsgForm,
						{
							maker: $elm$core$Maybe$Nothing,
							palette: $elm$core$Maybe$Just(
								$author$project$R10$Form$themeToPalette($author$project$Main$theme)),
							style: $author$project$R10$Form$style.filled,
							translator: $elm$core$Maybe$Nothing
						})),
					A2(
					$mdgriffith$elm_ui$Element$map,
					$author$project$Main$MsgForm,
					A2(
						$author$project$R10$Button$primary,
						_List_Nil,
						{
							label: $mdgriffith$elm_ui$Element$text('Submit'),
							libu: $author$project$R10$Libu$Bu(
								$elm$core$Maybe$Just(
									$author$project$R10$Form$msg.submit(model.form.conf))),
							theme: $author$project$Main$theme
						}))
				])));
};
var $author$project$Main$main = $elm$browser$Browser$sandbox(
	{init: $author$project$Main$init, update: $author$project$Main$update, view: $author$project$Main$view});
_Platform_export({'Main':{'init':$author$project$Main$main(
	$elm$json$Json$Decode$succeed(_Utils_Tuple0))(0)}});}(this));