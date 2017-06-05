package common.tools
{
	public class StringTool
	{
		public static function getNameFromClassString(classString : String) : String {			
			if ( classString.search("class") != -1 ) {
				return classString.toString().replace("[class ","").replace("]","");
			} else if ( classString.search("object") != -1 ) {
				return classString.toString().replace("[object ","").replace("]","");
			}
			
			return "";			
		}
		
		public static function concatenate(x : String, y : String) : String { 
			return x + y; 
		}
		
		public static function areEquals(x : String, y : String) : Boolean {
			return Boolean(x == y);
		}
		
		public static function getStringBetweenTwoPatterns(source : String, startPattern : String, endPattern : String) : String {			
			var start : int = source.search(startPattern);
			var end : int = source.search(endPattern);
			
			var name : String = source.substring(start + startPattern.length, end);
			
			return name;
		}
	}
}