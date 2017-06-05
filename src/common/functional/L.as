package common.functional
{
	public class L
	{	
		/**
		 * Same as F.sequence?
		 * 
		 * It starts from the first element in the collection.
		 * 
		 * TODO This function has dubious functionality consider deleting it
		 * 
		 */
		
		public static function fold(fn : Function, collection : Array) : *
		{				
			var i : int = 1;
			var l : int = collection.length;
			var r : * = fn(collection[0]);
			
			while (i < l)
			{					
				r = fn(r);
				i++;
			}
			
			return r;
		}
		
		/**
		 * Checks an array of objects for equivalence.
		 * 
		 * Much similar to an 'every' function.
		 * 
		 */
		
		public static function equivalence(members : Array) : Boolean
		{
			var i : int = 1;
			var l : int = members.length;
			var f : * = members[0];
			
			while (i < l)
			{
				if (members[i] != f)
					return false;
				
				i++;
			}
			
			return true;
		}
		
		/**
		 * Returns a function that performs an action if its condition is true, 
		 * otherwise it returns void.
		 * 
		 * Applies the same arguments to the condition and the action.
		 * 
		 */
		
		public static function when(condition : Function, action : Function) : Function
		{
			return function () : * {					
				if (condition.apply(null, arguments) == true) {					
					return action.apply(null, arguments);					
				}					
				return void;
			};
		}
		
		/**
		 * N-Map. A generalized way of mapping functions with more than one 
		 * argument.
		 * 
		 * This is another way of mapping functions with several variables.
		 * Instead of currying one argument set after another, in a succession
		 * of partial functions. N-Map maps a function to N-arguments, the
		 * arguments provided need to be necessarily of the same size.
		 * 
		 * @param	fn				The function to be mapped
		 * @param	argumentSets	An array with arrays for each argument in an ordered fashion.
		 * @param	resultHolder	The destination array.
		 * 
		 */
		
		public static function nmap(fn : Function, argumentSets : Array, resultHolder : Array = null) : Array
		{
			// Do nothing if argument sets are not of equal size
			var i : int = 0;
			var argumentSetLength : int = argumentSets[0].length;
			
			while (i < argumentSets.length) {				
				if (argumentSets[i].length != argumentSetLength) { return null; }				
				i = i + 1;
			}
			
			// Get the function output for each argument set
			i = 0;
			var j : int = 0;
			
			var result : Array;
			if (resultHolder == null) {
				result = new Array(argumentSetLength);
			} else {
				result = resultHolder;
			}
			
			var currentArgumentSet : Array = new Array(argumentSets.length);
			
			while (i < argumentSetLength)
			{
				// Get the current argument set
				j = 0;
				
				while (j < argumentSets.length)
				{
					currentArgumentSet[j] = argumentSets[j][i];
					j = j + 1;
				}
				
				// Call the function with the current argument set
				result[i] = fn.apply(fn, currentArgumentSet);
				i = i + 1;
			}
			
			return result;
		}
		
		/**
		 * N-Walk. A generalized way of mapping functions with more than one 
		 * argument.
		 * 
		 * This is another way of mapping functions with several variables.
		 * Instead of currying one argument set after another, in a succession
		 * of partial functions. N-Map maps a function to N-arguments, the
		 * arguments provided need to be necessarily of the same size.
		 * 
		 * @param	fn				The function to be mapped
		 * @param	argumentSets	An array with arrays for each argument in an ordered fashion.
		 * 
		 */
		
		public static function nwalk(fn : Function, argumentSets : Array) : void
		{
			// Do nothing if argument sets are not of equal size
			var i : int = 0;
			var argumentSetLength : int = argumentSets[0].length;
			
			while (i < argumentSets.length) {		
				if (argumentSets[i].length != argumentSetLength) { return void; }				
				i = i + 1;
			}
			
			// Get the function output for each argument set
			i = 0;
			var j : int = 0;
			
			var currentArgumentSet : Array = new Array(argumentSets.length);
			
			while (i < argumentSetLength) {
				// Get the current argument set
				j = 0;
				
				while (j < argumentSets.length) {
					currentArgumentSet[j] = argumentSets[j][i];
					j = j + 1;
				}
				
				// Call the function with the current argument set
				fn.apply(fn, currentArgumentSet);
				i = i + 1;
			}
		}
		
		/**
		 * N-F-Walk. A generalized way of mapping functions with more than one 
		 * argument.
		 * 
		 * The same as N-Walk but allowing some argument sets to be defined as functions 
		 * (the L goes for lazy).
		 * 
		 * This is another way of mapping functions with several variables.
		 * Instead of currying one argument set after another, in a succession
		 * of partial functions. N-Map maps a function to N-arguments, the
		 * arguments provided need to be necessarily of the same size.
		 * 
		 * @param	fn				The function to be mapped
		 * @param	argumentSets	An array with arrays for each argument in an ordered fashion.
		 * 
		 */
		
		public static function nlwalk(fn : Function, argumentSets : Array) : void
		{
			// Do nothing if argument sets are not of equal size
			var i : int = 0;
			var argumentSetLength : int = argumentSets[0].length;
			
			while (i < argumentSets.length) {						
				if (argumentSets[i] is Function == false) {
					if (argumentSets[i].length != argumentSetLength) { return void; }
				}
				
				i = i + 1;
			}
			
			// Get the function output for each argument set
			i = 0;
			var j : int = 0;
			
			var currentArgumentSet : Array = new Array(argumentSets.length);
			
			while (i < argumentSetLength) {
				// Get the current argument set
				j = 0;
				
				while (j < argumentSets.length) {
					if (argumentSets[j] is Function == false) {
						currentArgumentSet[j] = argumentSets[j][i];
					} else {
						currentArgumentSet[j] = argumentSets[j]();
					}
					
					j = j + 1;
				}
				
				// Call the function with the current argument set
				fn.apply(fn, currentArgumentSet);
				i = i + 1;	
			}
		}
		
		/**
		 * "Flexible" walk. <br/>
		 * <br/>
		 * The same as fmap, but only on one set. <br/>
		 * NOTE	By default it gets iterated once per set element.
		 * 
		 * @param	fn	A callback function that receives a set and an index. fn( setA, i )
		 * @param	setA	The origin set.
		 * @param	index	The iteration function, in case a different start is needed.
		 * 
		 */
		
		public static function fwalk(fn : Function, setA : Array, index : Function) : void {
			while (L.walking( fn, setA, index(), setA.length) == true ) {}
		}
		
		/**
		 * Helper function for fwalk. <br/>
		 * <br/>
		 * Allows the loop to afford not using variables. <br/>
		 * NOTE	By default it gets iterated once per set element.
		 * 
		 * @param	fn	The function to be mapped.
		 * @param	setA	The source set. (The domain)
		 * @param	index	An index variable. (for the array, presumably)
		 * @param	end		A length variable, checked against the index. (for the array, presumably)
		 * 
		 */
		
		private static function walking(fn : Function, setA : Array, index : int, end : int) : Boolean {
			if (index < end) {
				fn(setA, index);
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * "Flexible" map. <br/>
		 * 
		 * A way of performing transformations on an array. <br/> 
		 * The callback does not receive an indexed element of setA, instead, it receives setA and an index.<br/>
		 * NOTE	By default it gets iterated once per set element.
		 * 
		 * @param	fn	A callback function that receives both sets and an index. fn( setA, setB, i )
		 * @param	setA	The origin set.
		 * @param	setB	The destination set.
		 * @param	index	The iteration function, in case a different start is needed.
		 * 
		 * @return	setB
		 * 
		 */
		
		public static function fmap(fn : Function, setA : Array, setB : Array, index : Function) : Array {				
			while (L.mapping(fn, setA, setB, index(), setA.length) == true) {}				
			return setB;
		}
		
		/**
		 * Helper function for fmap.
		 * 
		 * Allows the loop to afford not using variables.
		 * 
		 * @param	fn	The function to be mapped.
		 * @param	setA	The source set. (The domain)
		 * @param	setB	The destination set. (The co-domain)
		 * @param	index	An index variable. (for the array, presumably)
		 * @param	end		A length variable, checked against the index. (for the array, presumably)
		 * 
		 */
		
		private static function mapping(fn : Function, setA : Array, setB : Array, index : int, end : int) : Boolean {				
			if (index < end) {
				fn(setA, setB, index);
				return true;
			} else {
				return false;
			}
		}
		
		/**
		 * Creates a function which appends a series of functions 
		 * to a single one (the target). The target's output is not modified.
		 * 
		 * The appended functions get called after the target.
		 * 
		 * Optionally, the appended functions may receive as a parameter the
		 * result of the target.
		 * 
		 */
		
		public static function append(fns : Array, target : Function, useTarget : Boolean = false) : Function
		{
			var r : Function;
			
			if (useTarget)
			{
				r = function () : *
				{
					var r : *;
					
					// Get target's result (if it needs arguments)
					if (arguments.length != 0)
					{
						r = target.apply(target, arguments);							
					}
					// Get target's result (without arguments)
					else
					{
						r = target();
					}
					
					// Call appendages with its result
					var i : int = 0;
					var l : int = fns.length;
					
					while (i < l)
					{
						fns[i](r);
						i++;
					}
					
					// Return original result
					return r;
				};
			}
			else
			{
				r = function () : *
				{						
					var r : *;
					
					r = target();
					
					// Call appendages
					var i : int = 0;
					var l : int = fns.length;
					
					while (i < l)
					{
						fns[i]();
						i++;
					}
					
					// Return original result
					return r;
				};
			}
			
			return r;
		}
		
		/**
		 * Selects only one item from a collection. The first item matching the
		 * condition.
		 * 
		 * Its a 'memory-wise' way of doing...
		 * 
		 * 		F.select( condition, collection )
		 * 
		 * ...without creating an array for only one object.
		 * 
		 * @param	condition	A function which returns true if the chosen element matches.
		 * @param	collection	The collection of objects which is to be traversed.
		 * 
		 * @return	The object if found, null otherwise.
		 * 
		 */
		
		public static function choose(condition : Function, collection : *) : *
		{
			var result : *;
			
			if (collection is Array)
			{
				var i : int = 0;
				var l : int = collection.length;
				
				while (i < l)
				{
					if (condition(collection[i]))
					{
						result = collection[i];
						break;
					}
					
					i++;
				}
				
				result = null;
			}
			else if (collection is Object)
			{
				for each (var value : * in collection)
				{
					if (condition(value))
					{
						result = value;
						break;
					}
				}
				
				result = null;
			}
			
			return result;
		}
		
		/**
		 * Wraps a function for use in an event listener.
		 * 
		 * @fn	The function for wrapping
		 * @useTarget	In this case the function is fed with the event's target
		 * @useEvent	In this case the function is fed with the event
		 * 
		 * If both target & event are set to true, the target takes precedence.
		 * 
		 */
		
		public static function wrapForEvent(fn : Function, useTarget : Boolean = true, useEvent : Boolean = false) : Function
		{
			if (useTarget)
			{
				return function (e : *) : void { fn(e.currentTarget); };
			}
			else if (useEvent)
			{					
				return function (e : *) : void { fn(e); };
			}
			else
			{					
				return function (e : *) : void { fn(); };
			}
		}
		
		/**		 
		 * Returns a function which "fills" a function's arguments with the
		 * provided argument.
		 * 
		 * Useful for reducing the argument count in cases where an argument is
		 * repeated.
		 * 
		 * NOTE	Perhaps a reference to iterate can be done here.
		 * 
		 */
		
		public static function fill(fn : Function) : Function
		{
			return function (x : *) : *
			{
				var i : int = 0;
				var l : int = fn.length;
				var r : Array = new Array(l);
				
				while (i < l)
				{
					r[i] = x;
					i++;
				}
				
				return fn.apply(fn, r);	
			}
		}
		
		public static function lazify(x : Function) : Function
		{
			return function (... args) : *
			{
				// Replace values for results
				var i : int = 0;
				var l : int = args.length;
				var lazifiedValues : Array = new Array(l);
				
				while (i < l)
				{
					if (args[i] is Function)
					{
						lazifiedValues[i] = args[i]();
					}
					else
					{
						lazifiedValues[i] = args[i];							
					}
					
					i++;
				}
				
				return x.apply(x, lazifiedValues);
			}
		}
		
		/**
		 * 
		 * Same as F.sequence, but if the resulting function's argument is a 
		 * function its value gets passed.
		 * 
		 * Returns a function which executes a series of functions sequentially (from left to right) 
		 * over the same argument.
		 * 
		 */ 
		
		public static function lazysequence(... args) : Function
		{
			return (
				function (x : *) : *
				{
					var i : int = 0;
					var result : *;
					var functions : Array;
					
					functions = args;
					
					if (x is Function)
					{
						result = x();
					}
					else
					{
						result = x;
					}
					
					while (i < functions.length)
					{							
						result = functions[i](result);
						i++;
					}
					
					return result;
				}
			);
		}
		
		/**
		 * Calls a series of functions applying the same argument, 
		 * the result does not return any value.
		 * 
		 * Without using arguments it is very similar to doing F.walk( L.call ) 
		 * on an array of functions.
		 * 
		 */
		
		public static function group(...fns) : Function {
			return function() : void {
				var i : int = 0;				
				while(i < fns.length){
					fns[i].apply(fns[i], arguments);
					i = i + 1;
				}				
			}
		}
		
		/**
		 * Returns a function that post-increments an internal integer value 
		 * each time it is called.
		 * 
		 * Despite what it seems, it can be used to create several independent
		 * counters.
		 * 
		 */
		
		public static function counter(start : int, delta : int = 1) : Function {
			var internalInt : int = start - delta;
			return function() : int {
				internalInt = internalInt + delta;
				return internalInt;
			};
		}
		
		/**
		 * Returns a function which creates a new object of the same type as the
		 * given object.
		 * 
		 */
		
		public static function make(x : Object) : Function
		{
			return function () : *
			{
				return new x.constructor();
			};
		}
		
		/**
		 * Returns a function which sets an object's properties from an object 
		 * with matching property names.
		 *
		 *	target.x = properties.x
		 *	target.y = properties.y
		 *
		 * This comes in handy when you don't want to write that object's 
		 * name over and over again.
		 * 
		 * If its parameter 'lazy' is true, values which are functions get
		 * evaluated, and their results are assigned. 
		 * 
		 * This would be useless, and redundant, if I didn't plan to encapsulate 
		 * this as much as possible. (Which perhaps would not be necessary 
		 * after all...)
		 * 
		 * (After bringing this back from another version, I am beginning to see
		 * its usefulness as a higher order function)
		 * 
		 */
		
		public static function copy(propertiesAndValues : Object, lazy : Boolean = false) : Function
		{
			var r : Function;
			
			if (!lazy)
			{
				r = function (x : Object) : void
				{						
					for (var prop : * in propertiesAndValues)
					{
						x[prop] = propertiesAndValues[prop];
					}
				};
			}
			else
			{
				r = function (x : Object) : void
				{
					var c : *;
					
					for (var prop : * in propertiesAndValues)
					{
						c = propertiesAndValues[prop];
						
						if (c is Function)
						{								
							x[prop] = c();								
						}
						else
						{								
							x[prop] = c;								
						}
					}
				};
			}
			
			return r;
		}
		
		/**
		 * Returns a function which sets an object's property to a given value.<br/>
		 * e.g (Creates the assignment)<br/>
		 * 
		 * @param	property	The target object's property.
		 * @param	value	The value to which the property is going to be set.
		 * 
		 */
		
		public static function assignment(property : String, value : *) : Function
		{
			return function (x : *) : void
			{  
				x[property] = value;					
			};
		}
		
		/**
		 * Creates a function which returns a different value each time 
		 * it is called. These values are stored on generation.
		 * 
		 */
		
		public static function spinner(values : Array) : Function
		{
			var valuePool : Array = values.slice();
			var valueIndex : int = 0;
			
			return function () : *
			{
				// Reset on end
				if (valueIndex == valuePool.length)
					valueIndex = 0;
				
				return valuePool[valueIndex++];
			};
		}			
		
		/**
		 * Creates an array of the target parameter an amount of times.
		 * 
		 * A performance-wise way of doing:
		 * 	F.map( target, [ 1, 2, 3, ..., n ] )
		 * 
		 */
		
		public static function iterate(target : Function, amount : int, product : * = null) : *
		{				
			var i : int = 0;
			
			var r : *;
			
			if (product == null)
			{
				r = new Array(amount);
			}
			else
			{
				r = product;
			}
			
			while (i < amount)
			{
				r[i] = target();
				i++;
			}
			
			return r;
		}
		
		/**
		 * Calls the function parameter
		 * 
		 * A performance-wise way of doing:
		 * 	F.invoke( x )
		 */
		
		public static function call(x : Function) : * {		
			return x();		
		}
		
		/**
		 * Returns a function which ignores its parameters (its "closed").
		 * 
		 * A curried call.
		 */
		
		public static function close(fn : Function) : Function {
			return function() : * {
				return fn();
			}
		}
		
		public static function rcurry(fn:Function, ... args) : Function {
			return function(... newArgs) : * { return fn.apply(fn,newArgs.concat(args)); };				
		}
		
		/**
		 *
		 * Creates a function which, applies a function, then returns its argument.
		 * 
		 * addsTwo = modify( addTwo )
		 * 
		 * addsTwo( 1 ) // 3
		 * addsTwo( addsTwo( 1 ) ) // 5
		 * 
		 */
		
		public static function modify(fn : Function) : Function {
			return function(x : *) : * {
				fn(x);
				return x;
			};
		}
		
		/**
		 * "Chains" together a series of functions, each function in the series
		 * provides its result as an argument for the next function.
		 * 
		 * The first function must provide the starting value in the series.
		 * 
		 * It's the same as sequence, but with the first function providing
		 * the initial argument and not taking any arguments. 
		 * 
		 */
		
		public static function chain(... fns) : Function {				
			return function() : * {
				var r : * = fns[0]();
				
				var i : int = 1;
				while (i < fns.length) {
					r = fns[i](r);
					i = i + 1;
				}
				
				return r;	
			}
		}
		
		/**
		 * Transforms an array of values by applying the following rule:
		 * 
		 * a: 1,2,3,...,n
		 * b: 1,3,6,...,n
		 * b[i] = b[i-1] + a[i]
		 * 
		 * @param	values	An Array of integers or Numbers.
		 * @param	to	The result holder.
		 * 
		 * @return	The result.
		 */ 
		
		public static function addPrevious(values : Array, to : Array = null) : Array {
			if (to == null) {
				to = new Array;
			}
			
			to[0] = values[0];
			
			var i : int = 1;
			while (i < values.length) {
				to[i] = to[i-1] + values[i];
				i = i + 1;
			}
			
			return to;
		}
		
		/**
		 * Assigns a set to a target according to its evaluation.
		 * 
		 * @param	condition	An evaluation function.
		 * @param	trueSet	The destination set if true.
		 * @param	falseSet	The destination set if false.
		 * @param	target	The target to be evaluated.
		 */
		
		public static function bifurcation(condition : Function, trueSet : Array, falseSet : Array, target : Object) : void {
			if (condition(target) == true) {
				trueSet.push(target);
			} else {
				falseSet.push(target);
			}
		}
		
		/**
		 * The general case of the "bifurcation" function.
		 * 
		 * @param	condition	An evaluation function.
		 * @param	trueFn	The function to apply if true.
		 * @param	falseFn	The function to apply if false.
		 * @param	args	The arguments to be evaluated.
		 */
		
		public static function dichotomy(condition : Function, trueFn : Function, falseFn : Function, ... args) : void {				
			if (condition.apply(null, args) == true) {
				trueFn.apply(null, args);
			} else {
				falseFn.apply(null, args);
			}
		}
		
		/**
		 * The same as F.sequence but working with several arguments at once.
		 * <br/>
		 * <br/>
		 * NOTE	This does NOT use Function.apply, it uses Function.call, the
		 * difference lies in the "filling" of the arguments, whereas apply
		 * fills the argument list until it can't do anything else; call sends the
		 * complete argument to be evaluated.
		 * <br/>
		 * <br/>
		 * e.g.
		 * <br/>
		 * <br/>
		 * ITakeTwoArgs.apply( null, [ a, b, c ] ); // ITakeTwoArgs( a, b )<br/>
		 * ITakeTwoArgs.call( null, [ a, b, c ] ); // ITakeTwoArgs( [ a, b, c ] )
		 */
		
		public static function sequencedCall(... functions) : Function {
			return function (... argsForSequence) : * {					
				var i : int = 0;					
				var result : Array = argsForSequence;					
				while (i < functions.length) {
					result = functions[i].call(null, result);
					i++;						
				}
				
				return result;
			};
		}
		
		/**
		 * 
		 * Creates a function which applies a function for each argument
		 * it receives.
		 * 
		 * e.g.
		 * 
		 * Functions -> [ Fn1, Fn2, Fn3, ..., FnN ]
		 * Arguments -> [ A,   B,   C,   ..., N   ]
		 * ---------
		 * Result    -> [ Fn1(A), Fn2(B), Fn3(C), ..., FnN( N ) ]
		 * 
		 * The Function and Argument number must match. It is surjective.
		 * This is equivalent to defining a set by extension, in this case, 
		 * the set is the function.
		 * 
		 * Also equivalent to calling fmap with a function to associate 
		 * a set of functions to a set of arguments.
		 * 
		 */
		
		public static function extension(... fns) : Function {
			return function (... args) : void {
				var i : int = 0;
				while (i < fns.length) {
					fns[i](args[i]);
					i = i + 1;
				}
			};
		}
	}
}