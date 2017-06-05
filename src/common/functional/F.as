package common.functional
{
	import net.juluvu.common.functional.F;

	public class F
	{
		public static const _ : * = {};
		
		/**
		 * AKA fold, foldl (In the regular functional literature)
		 */
		
		public static function reduce(fn : Function, start : *, collection : *) : *
		{
			var	result	: *;
			result	= start;
			
			var i : int = 0;
			
			while (i < collection.length)
			{
				result = fn(result, collection[i]);
				i++;				
			}
			
			return result;
		}
		
		/**
		 * Counts how many items in a collection satisfy a particular condition.
		 * 
		 * A performance-wise way of doing:
		 * 	F.select( condition, collection ).length
		 */
		
		public static function count(condition : Function, collection : Array) : int
		{			
			var i : int = 0;
			var l : int = collection.length;
			var c : int = 0;
			
			while (i < l)
			{
				if (condition(collection[i])) {
					c++;
				}
				
				i++;				
			}
			
			return c;			
		}
		
		/**
		 * Returns a list of every member of a collection that return true for a function.
		 */ 
		
		public static function select(fn : Function, collection : *, resultHolder : * = null) : Array
		{
			
			var result : Array;
			
			if (resultHolder == null) {
				result = new Array;
			} else {
				result = resultHolder;
			}
			
			if (collection is Array)
			{				
				var i : int = 0;
				var l : int = collection.length;
								
				while (i < l)
				{					
					if (fn(collection[i])) {						
						result.push(collection[i]);						
					}
					
					i++;					
				}			
			}
			else if (collection is Object)
			{				
				for each (var value : * in collection)
				{					
					if (fn(value))
					{					
						result.push(value);					
					}					
				}				
			}			
			
			return result;
		}
		
		/**
		 * Maps objects with bracket access.
		 * 
		 * Applies a function to every member of a collection.
		 * 
		 * @param	collection	An object with bracket access.
		 * 
		 * @return	An array with the results of the function for every member.
		 */ 
		
		public static function map(collection : *, fn : Function, resultHolder : * = null) : *
		{
			var result : *;			
			if (resultHolder == null) {			
				result = new Array;			
			} else {				
				result = resultHolder;				
			}
			
			var i : int = 0;			
			while (i < collection.length) {
				result[i] = fn(collection[i]);
				i = i + 1;
			}
			
			return result;			
		}
		
		/**
		 * Executes a function on every member of a collection.
		 * 
		 * It is identical to map, with the exceptions that it will not output a collection of results,
		 * and the collection argument's length gets memoized before the loop.
		 */ 
		
		public static function walk(fn : Function, collection : * ) : void
		{			
			var i : int = 0;
			
			// Since the collection's length is prone to side-effects, retrieving the first
			// sample of its value, will guarantee this loop sees completion when performing
			// actions that may alter length. (e.g. adding or removing objs)
			var l : int = collection.length;
			
			if (collection is Array) {				
				while (i < l) {					
					fn(collection[i]);			
					i++;					
				}				
			} else if (collection is Object) {				
				for each (var value : * in collection) { fn(value); }				
			}			
		}
		
		/**
		 * 
		 * Returns a function which executes a series of functions sequentially (from left to right) 
		 * over the same argument.
		 * 
		 */ 
		
		public static function sequence(... fns) : Function
		{			
			return function (x : *) : * {
				var result : * = x;
				
				var i : int = 0;
				while (i < fns.length) {						
					result = fns[i](result);
					i++;
				}
				
				return result;				
			};
		}
		
		/**
		 * Same as sequence but in reverse argument-list order.
		 * 
		 * NOTE	The lines capturing the arguments do not seem necessary.
		 * 
		 *		var functions : Array;
		 * 		functions = args;
		 * 
		 * 		Try to eliminate them. 
		 */ 
		
		public static function compose(... args) : Function
		{
			
			return (
				function (x : *) : *
				{					
					var functions : Array;
					functions = args;
					
					var i : int = functions.length;
					var result : *;
					
					result = x;
					
					while ( i > 0 )
					{
						result = functions[i-1](result);
						i--;
					}
					
					return result;
				}
			);
		}
		
		/**
		 * Returns a function that returns `true` when all the arguments, applied
		 * to the returned function's arguments, returns true.
		 */
		
		public static function and(... fns) : Function {			
			return function () : Boolean {				
				var i : int = 0;
				
				while (i < fns.length) {
					
					if (fns[i].apply(fns[i],arguments) == false) {
						return false;
					}
					
					i = i + 1;					
				}
				
				return true;
			}		
		}
		
		/**
		 * Returns a function that returns `true` when any of the arguments, applied
		 * to the returned function's arguments, returns true.
		 */
		
		public static function or(... functions) : Function
		{
			return (
				function (x : *) : Boolean
				{					
					var value : Boolean = false;
					
					var i : int = 0;
					while (i < functions.length)
					{
						if	((value = functions[i](x)))
							break;
						
						i++;						
					}
					
					return value;
				}
			);			
		}
		
		/**
		 * Returns true when any element in the collection returns true for fn.
		 */
		
		public static function some(fn : Function, collection : *) : Boolean
		{
			var value : Boolean = false;
			var i : int = 0;
			while (i < collection.length)
			{
				if (value = fn( collection[i]))
					break;
				
				i++;
			}
			
			return value;			
		}
		
		/**
		 * Returns true when all elements in the collection return true for fn.
		 * 
		 * LOG
		 * 13.05.28 02:50	Added String exception (its monkey patching, but good)
		 */
		
		public static function every(fn : Function, collection : *) : Boolean
		{
			var i : int = 0;
			
			if (collection == null) {
				return false;
			}
			
			if (collection.length == 0)
				return false;
			
			if (collection is String) {				
				while (i < collection.length)
				{
					if (fn(collection.charAt(i)) == false)
						return false;
					
					i++;					
				}				
			} else {				
				while (i < collection.length)
				{
					if (fn( collection[i]) == false)
						return false;
					
					i++;
				}
			}
			
			return true;
		}
		
		/**
		 * Returns a function which returns true when fn is false
		 */
		
		public static function not(fn : Function) : Function
		{
			return function () : Boolean {		 				
				return !fn.apply(fn,arguments);		 				
			};
		}
		
		/**
		 * Returns a function that returns true when this function's arguments
		 * applied to that functions are always the same.  The returned function
		 * short-circuits.
		 * 
		 * It compares two functions on the basis that they should produce the same output
		 * with same input.
		 * 
		 * NOTE	Looks like the AND function. I wonder if it is good for something else.
		 */
		
		public static function equal(... fns) : Function
		{			
			if (!fns.length)
				return F.K(true);
			
			return (
				function(... args) : Boolean
				{					
					// Calculate first function output
					var value : Boolean = fns[0].apply(this, args);
					
					// Compare all other functions outputs
					var i : int = 1;
					
					while (i < fns.length)
					{						
						if (value != fns[i].apply(this, args))
							return false;
						
						i++;
					}
					
					return true;
				}
			);			
		}
		
		/**
		 * Returns a function that takes an object as an argument, and applies <br/>
		 * object's "selectedMethod" method with "arguments". <br/>
		 * <br/>
		 * Its closure belongs to the object invoking the method.
		 */
		
		public static function invoke(selectedMethod : String, ... arguments) : Function
		{
			// A copy of the arguments, just in case
			var args : Array = arguments.slice();
			
			return function (object : *) : * {
				return object[selectedMethod].apply(object, args);        				
			};
		}
		
		/**
		 * 
		 * Returns a function that takes an object, and returns the value of its
		 * `name` property. 
		 * <br/>
		 * Name can be either a string or an int
		 * 
		 */
		
		public static function pluck(name : *) : Function
		{
			return function(object : *) : * {				
				return object[name];				
			};
		}
		
		/**
		 * Returns a function that, while $pred(value)$ is true, applies `fn` to
		 * $value$ to produce a new value, which is used as an input for the next round.
		 * The returned function returns the first $value$ for which $pred(value)$
		 * is false.
		 */
		
		public static function until(pred : Function, fn : Function) : Function
		{
			return (
				function (value : *) : *
				{
					while (!pred(value))
						value = fn(value);
					
					return value;
				}
			);
		}
		
		/**
		 * Bounds a function to an object, can curry arguments optionally.
		 * This function's curry starts from the right side. (i.e. rcurry)
		 * 
		 * 
		 * NOTE	Identical in implementation to the curry function. Since arguments don't seem
		 * 		to be enabled for input without calling the apply or call methods, which REQUIRE
		 * 		the 'this' object.
		 */
		
		public static function bind(fn : Function, thisObj : * = null, ... curriedArgs) : Function
		{			
			var theArgs : Array = curriedArgs.slice();
			
			return (
				function (... args) : *
				{					
					return fn.apply(thisObj, args.concat(theArgs));					
				}
			);			
		}
		
		/**
		 * Curries arguments from the left.
		 * 
		 * Identical to the bind function, but the 'this' object is null by default.
		 * 
		 * NOTE	Identical in implementation to the bind function. Since arguments don't seem
		 * 		to be enabled for input without calling the apply or call methods, which REQUIRE
		 * 		the 'this' object.
		 * 
		 * NOTE	[REFACTORING]	Retest this. It didn't curry arguments from left.
		 * NOTE	[REFACTORED]	28/11/2010 20:32
		 * NOTE	[CHANGE]		28/11/2010 19:13	Changed 'apply' thisobject from null to fn
		 * NOTE	[CHANGE]		06/11/2011 07:58	Added no-arguments case and some comments.
		 */
		
		public static function curry( fn : Function, ... curriedArgs ) : Function
		{
			if ( curriedArgs.length > 0 ) {				
				// Curry the function traditionally
				return function (... nonCurriedArgs) : * {					
					return fn.apply(fn, curriedArgs.concat(nonCurriedArgs));					
				};				
			} else {				
				// Just apply the function (useful for some closures)
				return function (... nonCurriedArgs) : * {					
					return fn.apply(fn, nonCurriedArgs);					
				};				
			}
		}
		
		/**
		 * Returns a function $f$ such that $f(args2)$ is equivalent to
		 * the underlying function applied to a combination of $args$ and $args2$.
		 *
		 * `args` is a partially-specified argument: it's a list with "holes",
		 * specified by the special value `_`.  It is combined with $args2$ as
		 * follows:
		 *
		 * From left to right, each value in $args2$ fills in the leftmost
		 * remaining hole in `args`.  Any remaining values
		 * in $args2$ are appended to the result of the filling-in process
		 * to produce the combined argument list.
		 *
		 * If the combined argument list contains any occurrences of `_`, the result
		 * of the application of $f$ is another partial function.  Otherwise, the
		 * result is the same as the result of applying the underlying function to
		 * the combined argument list.
		 * 
		 * NOTE	Test this!
		 */
		
		public static function partial(fn : Function, arguments : Array) : Function
		{
			var _ : * = F._;
			
			var args : Array = arguments.slice();
			
			// Fetch substitution positions
			var subpos : Array = new Array;
			
			var i : int = 0;			
			while (i < arguments.length) {
				if (arguments[i] == _ ) {					
					subpos.push(i);		
				}
				
				i++;				
			}
			
			return function() : *
			{
				// Create argument array with blanks (specialized = partialArgs + filled blanks)
				var specialized : Array = args.concat(arguments.slice(subpos.length));
				
				// Fill in the blanks from left to right
				var j : int = 0;
				
				while (j < Math.min(subpos.length, arguments.length)) {					
					specialized[subpos[j]] = arguments[j];					
					j++;					
				}
				
				// Check for remaining blanks and return a partial function if needed
				j = 0;
				
				while (j < specialized.length) {
					if (specialized[j] == _) {
						return F.partial(fn, specialized);
					}
					
					j++;
				}
				
				return fn.apply(this, specialized);
			};
		}
		
		/**
		 * The identity function
		 * 
		 * Returns its argument
		 */
		
		public static function I(x : *) : *
		{
			return x;
		}
		
		/**
		 * Returns a function which returns a value x
		 */
		
		public static function K(x : *) : Function {
			return function() : * { return x; };
		}
	}
}