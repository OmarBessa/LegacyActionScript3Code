package common.oldfunctors
{
	import common.datastructures.interfaces.IEquals;

	public class XEqualsY extends AbstractFunctor
	{		
		private var _output	: Boolean;
		
		public function XEqualsY(X : * = null, Y : * = null)
		{			
			_input = new Object;			
			
			_input.x = new Object;
			_input.y = new Object;
			
			this.setInput(X, Y);
			
			_output = false;			
		}
		
		override public function execute() : void
		{			
			// CASE: Null 'equality' (only null is null) Mmm, philosophically interesting...
			if (_input.x == null && _input.y == null)
			{				
				_output = true;
			}
			// CASE: Null 'inequality' 
			else
			if ((_input.x == null && _input.y != null) || (_input.x != null && _input.y == null))
			{				
				_output = false
			}
			// CASE: Each array element equals a constant
			else if (_input.x is Array && _input.y is int)
			{				
				var i : int = 0;
				
				_output = true;
				
				while (i < _input.x.length)
				{					
					if (_input.x[i] != _input.y)
					{						
						_output = false;
						break;						
					}
					
					i++;
				}
			}
			// SET: Array equality
			else if (_input.x is Array && _input.y is Array)
			{				
				_output = new ArrayEqualsArray().run(_input.x, _input.y);
			}
			// CASE: Has its own equality method
			else if ((_input.x is IEquals) && (_input.y is IEquals))
			{				
				_output = _input.x.equals(_input.y);
			}
			// CASE: Can be transformed into comparable datatype
			else if ((_input.x.hasOwnProperty('toArray') ) && ( _input.y.hasOwnProperty('toArray')))
			{
				_output = this.run(_input.x.toArray(), _input.y.toArray());
			}
			else
			{				
				_output = ( _input.x == _input.y );				
			}			
		}
		
		// NOTE [OPTIMIZATION,REFACTORING]	This should be generalized. Perhaps a 'fixed' assignment method will do.
		// 									By 'fixed', it is meant that no type comparisons are made for each input.
		
		override public function setInput(... args) : void
		{			
			var argslen : int = args.length;
			
			if (argslen == 0) return;
			
			if (argslen > this.argsLength()) { return; }
			
			_input.x = args[0];
			_input.y = args[1]; 
		}
		
		override public function get output():*
		{			
			return _output;
		}
	}
}