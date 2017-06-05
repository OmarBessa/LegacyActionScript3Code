package common.functional
{
	/**
	 * For Lambdas which handle the Object class. (and some utility functions)
	 * 
	 */
	
	public class O
	{
		
		import common.tools.StringTool;
		
		
		/**
		 * Its select for objects (targets the values)
		 * 
		 */
		
		public static function select(source : Object, fn : Function, destination : Object) : Object {			
			for (var property : String in source) {				
				if ( fn( source[property] ) == true ) {
					destination[property] = source[property];
				}				
			}
			
			return destination;			
		}
		
		
		/**
		 * Its map for objects (targets the values)
		 * 
		 */
		
		public static function map(source : Object, fn : Function, destination : Object) : Object {			
			for ( var property : String in source ) {
				destination[property] = fn(source[property]);
			}			
			return destination;			
		}
		
		/**
		 * F.walk on an object property->value pairs.
		 * 
		 */
		
		public static function walkPairs(fn : Function, source : Object) : void {			
			for (var property : String in source) {
				fn(property, source[property]);
			}
		}
		
		/**
		 * Fills an array with the input Object properties'
		 * 
		 */
		
		public static function propertiesToArray(obj : Object) : Array {
			var result : Array = new Array;
			
			for (var property : String in obj) {
				result.push(property);
			}
			
			return result;
		}
		
		/**
		 * Converts an array of string to properties in an object.<br/>
		 * <br/>
		 * e.g.<br/>
		 * <br/>
		 * [--array--]------>[-object--]<br/> 
		 * a[0] = "a";------>r.a = null;<br/>
		 * a[1] = "b";------>r.b = null;<br/>
		 * a[2] = "c";------>r.c = null;<br/>
		 * 
		 */
		
		public static function arrayOfStringsToPropertiesInObject(arrayOfStrings : Array, result : Object) : Object {
			var i : int = 0;
			while (i < arrayOfStrings.length) {
				result[arrayOfStrings[i]] = null;
				i = i + 1;
			}
			
			return result;
		}
		
		/**
		 * Retrieves the amount of properties an Object has.
		 * 
		 */
			
		public static function getLength(obj : Object) : int {			
			var r : int = 0;
			
			for (var property : String in obj) {
				r++;
			}
			
			return r;
		}
			
		public static function setProperty(to : Object, property : String, value : *) : void {
			to[property] = value;
		}
			
		public static function objectToXML(obj : *) : String {
			
			var r : String = "<" + StringTool.getNameFromClassString(obj) + ">";
			
			for (var property : String in obj) {
				
				if (obj[property] is Array) {
					r = r + "<" + property + ">" + obj[property].toString() + "</" + property + ">";
				} else {
					r = r + "<" + property + ">" + obj[property] + "</" + property + ">";
				}
				
			}
			
			r = r + "</" + StringTool.getNameFromClassString( obj ) + ">";
			
			return r;			
		}
			
		/**
		 * A simple assignment<br/>
		 * to[property] = value;
		 */
		
		public static function assign(to : Object, property : String, value : *) : void {
			to[property] = value;
		}
	}
}