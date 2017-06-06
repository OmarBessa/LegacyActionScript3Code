package common.functional
{
	public class Comparison
	{		
		public static function isNotEqualTo(Y : *) : Function
		{			
			return function (X : *) : Boolean {
				return X != Y;					
			};			
		}
		
		public static function isEqualTo(Y : *) : Function
		{			
			return function (X : *) : Boolean {				
				return X == Y;					
			};			
		}
		
		/**
		 * Returns a function that returns true if the supplied value is larger
		 * than the argument provided to create it.
		 */
		
		public static function isGreater(than : *) : Function
		{			
			return function (x : *) : Boolean {					
				return x > than;					
			};			
		}
		
		public static function isSmaller(than : *) : Function
		{
			return function (x : *) : Boolean {
				return x < than;
			};			
		}
		
		public static function isOfType(datatype : *) : Function
		{			
			return function (X : *) : Boolean {
				return Boolean(X is datatype.prototype.constructor);					
			};			
		}
		
		public static function isXOfTypeY(x : Object, y : Class) : Boolean {			
			if (x is y) {
				return true;
			} else {
				return false;
			}			
		}
		
		/**
		 * Generates a function which compares two objects.
		 * 
		 * The generated function returns true if the objects are the same, member by member.
		 */
		
		public static function objsAreEqual(x : Object, y : Object) : Function
		{			
			return function () : Boolean
			{				
				for (var property : String in x)
				{
					if (x[property] != y[property])
						return false;					
				}
				
				return true;
			}			
		}
		
		/**
		 * A specific case of objsAreEqual (choosing the properties to be compared).
		 */
		
		public static function propertiesAreEqual(properties : Array) : Function
		{			
			return function (a : Object, b : Object) : Boolean
			{				
				for each (var property : String in properties)
				{					
					if (a[property] != b[property]) {
						return false;
					}					
				}
				
				return true;				
			};			
		}
		
		/**
		 * Generates a function which compares a string to a pattern.
		 * 
		 * The generated function returns true if the string matches, false otherwise.
		 */
		
		public static function matchesPattern(regex : RegExp) : Function {			
			return function (target : String) : Boolean {				
				if (target.search(regex) != -1) {
					return true;
				} else {
					return false;
				}				
			};
		}
		
		/**
		 * Generates a function which compares a string to a string.
		 * 
		 * The generated function returns true if the string matches, false otherwise.
		 */
		
		public static function matchesString(pattern : String) : Function {			
			return function (target : String) : Boolean {				
				if (target.search(pattern) != -1) { 
					return true;	
				} else { 
					return false; 
				}				
			};
		}
	}
}