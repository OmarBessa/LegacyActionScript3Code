package common.oldfunctors
{
	import common.functional.E;
	import common.functional.F;
	import common.tools.TypeTool;

	public class ArrayEqualsArray extends AbstractFunctor
	{		
		private var _output : Boolean;
		
		public function ArrayEqualsArray(x : Array = null, y : Array = null)
		{			
			_input = new Object;
			
			// On initialization these values should be the same type as parameters
			// That way setInput() will assign them properly
			_input.x = new Array;
			_input.y = new Array;
			
			this.setInput(x, y);
			
			E.install();
		}
		
		override public function execute():void
		{
			if (_input.x.length == _input.y.length)
			{				
				// CASE: Nested array equality (2D Case)
				// NOTE	[MARK] 'Importing dependencies' script didn't work here
				if (TypeTool.isArrayFullOfArrays(_input.x) == true && TypeTool.isArrayFullOfArrays(_input.y) == true)
				{
					var arrayPairIsEqualAt : Function = new ArrayPairIsEqualAt().Do['curry'](_input.x, _input.y); 
					
					_output = F.every(
						arrayPairIsEqualAt,
						integerSuccessionTo(_input.x.length)
					);
				}
				// CASE: Element by element array equality
				else
				{					
					var pairIsEqualAt : Function = new PairIsEqualAt().Do['curry'](_input.x, _input.y);
					
					_output = F.every(
						pairIsEqualAt,
						integerSuccessionTo(_input.x.length)
					);
				}
			}			
			else
			{				
				_output = false;
			}
		}
		
		public function integerSuccessionTo(X : int) : Array
		{			
			var result : Array = new Array;
			var integer : int = 0;
			
			while ( integer <= X)
				result.push(integer++);
			
			return result;
		}
		
		override public function get output():*
		{			
			return _output;			
		}
	}
}