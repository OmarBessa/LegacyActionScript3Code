package common.tools
{
	/**
	 * Range checking utility class
	 * 
	 * ORIGINAL_PROJECT	PrototypeWebCrawler
	 * CREATION_DATE	07_03_10	18:19
	 */
	
	public class RangeTool
	{		
		/**
		 * Checks if an integer is within the bounds of an object with the length property (Array, String, ...) <br/>
		 * 
		 * ORIGINAL_PROJECT	PrototypeWebCrawler
		 * CREATION_DATE	07_03_10	15:19
		 * REFACTOR_DATE	07_03_10	18:20	Designo: Moved from StringIterator.
		 * UNITTEST_DATE	07_05_10	22:42	22:45	Designo: Ok.
		 * REFACTOR_DATE	07_05_10	23:20	Designo: Changed name from 'isOutOfBounds' to 'isInBounds'; Reversed functionality.
		 */
		
		public static function isInBounds(n:int, objectWithLength:Object) : Boolean
		{
			if (n > objectWithLength.length - 1)
			{
				return false;				
			}
			else if (n < 0)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
	}
}