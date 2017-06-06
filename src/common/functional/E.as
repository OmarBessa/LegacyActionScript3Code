package common.functional
{
	/**
	 * 
	 * This file was written based on code from osteele.com.
	 * 
	 */
	
	
	public class E
	{
		
		public static function install() : void { }
		
		/**
		 * 
		 * SOURCE	[http://osteele.com/javascripts/F/]
		 * 
		 * Returns a function that applies the underlying function to `args`, and
		 * ignores its own arguments.
		 * :: (a... -> b) a... -> (... -> b)
		 * == f.saturate(args...)(args2...) == f(args...)
		 * >> Math.max.curry(1, 2)(3, 4) -> 4
		 * >> Math.max.saturate(1, 2)(3, 4) -> 2
		 * >> Math.max.curry(1, 2).saturate()(3, 4) -> 2
		 * 
		 */
		
		Function.prototype.saturate = function () : Function
		{			
			var fn : Function = this;
			var args : Array = arguments.slice();
			
			return	(
				function () : *
				{					
					return fn.apply(this, args);
				}
			);			
		};
		
		/**
		 * 
		 * SOURCE	[http://osteele.com/javascripts/F/]
		 * 
		 * Returns a bound method on `object`, optionally currying `args`.
		 * == f.bind(obj, args...)(args2...) == f.apply(obj, [args..., args2...])
		 */
		
		Function.prototype.bind = function(object : *) : Function
		{			
			var fn : Function = this;
			// Copy all but first	    
			var args : Array = arguments.slice(1);
			
			return (
				function() : *
				{
					return fn.apply(object, args.concat(arguments.slice()));
				}
			);
		}
		
		/**
		 * 
		 * SOURCE	[http://osteele.com/javascripts/F/]
		 * 
		 * Returns a function that, applied to an argument list $arg2$,
		 * applies the underlying function to $args ++ arg2$.
		 * :: (a... b... -> c) a... -> (b... -> c)
		 * == f.curry(args1...)(args2...) == f(args1..., args2...)
		 *
		 * Note that, unlike in languages with true partial application such as Haskell,
		 * `curry` and `uncurry` are not inverses.  This is a repercussion of the
		 * fact that in JavaScript, unlike Haskell, a fully saturated function is
		 * not equivalent to the value that it returns.  The definition of `curry`
		 * here matches semantics that most people have used when implementing curry
		 * for procedural languages.
		 *
		 * This implementation is adapted from
		 * [http://www.coryhudson.com/blog/2007/03/10/javascript-currying-redux/].
		 * 
		 * NOTE	There is a limitation using this function with '.apply' as the 'this' variable
		 * 		is used to reference the affected function instead of a closure.
		 * 
		 */
		
		
		Function.prototype.curry = function() : Function
		{			
			var fn : Function = this;
			var args : Array = arguments.slice();
			
			return (
				function() : *
				{					
					return fn.apply(this, args.concat(arguments.slice()));
				}
			);
		}
		
		/**
		 * 
		 * Invoking the function returned by this function only passes `n`
		 * arguments to the underlying function.  If the underlying function
		 * is not saturated, the result is a function that passes all its
		 * arguments to the underlying function.  (That is, `aritize` only
		 * affects its immediate caller, and not subsequent calls.)
		 * >> '[a,b]'.lambda()(1,2) -> [1, 2]
		 * >> '[a,b]'.lambda().aritize(1)(1,2) -> [1, undefined]
		 * >> '+'.lambda()(1,2)(3) -> error
		 * >> '+'.lambda().ncurry(2).aritize(1)(1,2)(3) -> 4
		 *
		 * `aritize` is useful to remove optional arguments from a function that
		 * is passed to a higher-order function that supplies *different* optional
		 * arguments.
		 *
		 * For example, many implementations of `map` and other collection
		 * functions, including those in this library, call the function argument
		 *  with both the collection element
		 * and its position.  This is convenient when expected, but can wreak
		 * havoc when the function argument is a curried function that expects
		 * a single argument from `map` and the remaining arguments from when
		 * the result of `map` is applied.
		 * 
		 */
		
		Function.prototype.aritize = function(n : int) : Function
		{			
			var fn : Function = this;
			
			return (
				function() : *
				{					
					return fn.apply(this, arguments.slice(0, n));
				}
			);			
		}
		
		/**
		 * 
		 * Right curry.  Returns a function that, applied to an argument list $args2$,
		 * applies the underlying function to $args2 + args$.
		 * == f.curry(args1...)(args2...) == f(args2..., args1...)
		 * :: (a... b... -> c) b... -> (a... -> c)
		 * 
		 */
		
		Function.prototype.rcurry = function() : Function
		{			
			var fn : Function = this;
			var args : Array = arguments.slice();
			
			return	(
				function() : *
				{					
					return fn.apply(this, arguments.slice(0).concat(args));
				}
			);			
		}
		
		/**
		 * 
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
		 */
		
		Function.prototype.partial = function() : Function
		{			
			var fn : Function = this;
			
			var _ : * = F._;
			
			var args : Array = arguments.slice();
			
			// Fetch substitution positions
			var subpos : Array = new Array;
			
			var i : int = 0;
			
			while (i < arguments.length)
			{				
				if (arguments[i] == _)
				{					
					subpos.push(i);					
				}
				
				i++;				
			}
			
			return (
				function() : *
				{					
					// Create argument array with blanks ( specialized = partialArgs + filled blanks )
					var specialized : Array = args.concat(arguments.slice(subpos.length));
					
					// Fill in the blanks from left to right
					var j : int = 0;
					
					while (j < Math.min(subpos.length, arguments.length))
					{						
						specialized[subpos[j]] = arguments[j];						
						j++;						
					}
					
					// Check for remaining blanks and return a partial function if needed
					j = 0;
					
					while (j < specialized.length)
					{						
						if (specialized[j] == _)
						{							
							return fn['partial'].apply(fn, specialized);							
						}
						
						j++;						
					} 
					
					return fn.apply(this, specialized);
				}
			);
		}
	}
}