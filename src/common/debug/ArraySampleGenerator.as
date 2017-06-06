package common.debug
{	
	import common.functional.F;

	public class ArraySampleGenerator
	{
		
		public function ArraySampleGenerator() : void {}
		
		public function makeArrayOf(generatingFn : Function, size : int) : Array
		{			
			var result : Array = new Array;
			
			var i : int = 0;
			
			while (i < size)
			{				
				result.push(generatingFn());
				i++;				
			}
			
			return result;			
		}
		
		public function randomIntBetween(min : int, max : int) : int
		{			
			return int(Math.floor(Math.random() * (max - min + 1)) + min);			
		}
		
		public function getArrayOfConstant(K : int, size : int) : Array
		{			
			var result : Array = new Array;
			
			var i : int = 0;
			
			while (i < size)
			{				
				result.push(K);
				i++;				
			}
			
			return result;			
		}
		
		public function integerSuccession(toN : int, fromN : int = 0) : Array
		{			
			var result : Array = new Array;
			
			var i : int = fromN;
			
			while (i <= toN)
			{				
				result.push(i);
				i++;				
			}
			
			return result;
		}
		
		/**
		 * 
		 * Makes a multiplyBy function for each integer in the succession range
		 * 
		 */
		
		public function getProductSuccession(toN : int, fromN : int = 0) : Array
		{			
			var makeMultiplyBy : Function =	function(x : int) : Function
			{				
				return (
					function(y : int) : int
					{						
						return x * y;
					}
				);				
			};
			
			var result : *;
			
			result = F.map(integerSuccession(toN, fromN), makeMultiplyBy);
			
			return result;
		}
	}
}