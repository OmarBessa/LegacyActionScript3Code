package common.tools
{
	import common.datastructures.graph.GraphVertex;

	/**
	 * Type checking utility class
	 * 
	 * ORIGINAL_PROJECT	PrototypeWebCrawler
	 * CREATION_DATE	07_03_10	18:23
	 * 
	 */
	
	public class TypeTool
	{		
		/**
		 * 
		 * ORIGINAL_PROJECT	PrototypeWebCrawler
		 * CREATION_DATE	06_23_10	22:34
		 * REFACTOR_DATE	07_03_10	18:23	Designo: Moved from StringIterator.
		 */
		
		public static function isNotNull(obj : *) : Boolean
		{			
			if (obj != null)
			{				
				return true;
			}
			else
			{				
				return false;
			}			
		}
		
		/**
		 * 
		 * ORIGINAL_PROJECT	PrototypeWebCrawler
		 * CREATION_DATE	07_06_10	19:32
		 */
		
		public static function areNotNull(... args) : Boolean
		{			
			var i : int = 0;
			
			while (i < args.length - 1)
			{				
				if (TypeTool.isNotNull(args[i]) == false)
				{
					return false;
				}
				else
				{
					continue;
				}
			}
			
			return true;
		}
		
		
		/**
		 * 
		 * ORIGINAL_PROJECT	PrototypeWorkLogParser
		 * CREATION_DATE	06_20_10	13:10
		 * REFACTOR_DATE	07_12_10	19:00	Designo: Moved from 'LogParser' to 'TypeTool'.
		 */
		
		public static function isArray2D(source : Array) : Boolean
		{			
			if (isArrayFullOfArrays(source))
			{
				return true;
			}
			else
			{				
				return false;				
			}			
		}
		
		/**
		 * 
		 * ORIGINAL_PROJECT	PrototypeWorkLogParser
		 * CREATION_DATE	06_20_10	Start: 12:35	Finish: 12:54
		 * REFACTOR_DATE	07_12_10	19:00	Designo: Moved from 'LogParser' to 'TypeTool'.
		 */
		
		public static function isArrayFullOfArrays(target : Array) : Boolean
		{			
			var isArrayConsistent:Boolean = true;
			
			// Is all of the array filled with arrays? ( is it 'consistent' )
			for (var i:int = 0; i < target.length; i++)
			{				
				if (target[i] is Array == false)
				{
					isArrayConsistent = false;
					break;
				}				
			}
			
			return isArrayConsistent;			
		}
		
		public static function isXGraphVertex(X : *) : Boolean
		{			
			if ( X is GraphVertex)
			{				
				return true;
			}
			else
			{				
				return false;
			}			
		}
		
		public static function isNotFailure(X : *) : Boolean
		{						
			if (X is null)
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