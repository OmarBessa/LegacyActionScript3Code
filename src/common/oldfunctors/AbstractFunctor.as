package common.oldfunctors
{
	import common.datastructures.interfaces.IDataHolder;
	import common.datastructures.interfaces.ISet;
	import common.datastructures.mathematicalset.ArrayedSet;
	import common.oldfunctors.interfaces.IFunctor;

	/**
	 * 
	 * ORIGINAL_PROJECT	PrototypeWebCrawler
	 * CREATION_DATE	06_29_10	19:29
	 * 
	 * Not so abstract functor...
	 * 
	 */
	
	public class AbstractFunctor implements IFunctor
	{		
		protected var _input : Object;
		
		// Memoized input count value
		protected var _inputCount : int = -1;
		
		public function AbstractFunctor():void
		{			
			// ASSUMPTION	Every instantiation will input arguments before execution
		}
		
		public function setInput(... args) : void
		{			
			var argslen : int = args.length;
			
			if ( argslen == 0 )
				return;
			
			if ( argslen > this.argsLength())
			{				
				trace( "Incorrect argument number. Expected at most " + this.argsLength() + ", got " + args.length );
				return;				
			}
			
			this.setInputOnType.apply(this, args);
		}
		
		public function get input():*
		{			
			return _input;
		}
		
		public function get state():*
		{			
			return true;			
		}
		
		public function run(... args) : *
		{			
			this.setInput.apply(this, args);
			
			this.execute();
			
			return this.output;			
		}
		
		/**
		 * 
		 * Override me!
		 * 
		 */
		
		public function execute() : void {}
		
		/**
		 * 
		 * Override me!
		 * 
		 */
		
		public function get output():*
		{			
			return null;
		}
		
		/**
		 * Counts the arguments in the Functor's input method
		 * 
		 */
		
		protected function argsLength() : int
		{	
			if (_inputCount == -1) { _inputCount = this.countObjectMethods(_input); }			
			return _inputCount;			
		}
		
		protected function setInputOnType(... args) : void
		{			
			var i : int = 0;
			var l : int = args.length;
			var c : *;			
			
			var tickList : ISet = new ArrayedSet;		
			var inputIndex : int = 0;
			
			// for each argument
			while (i < l)
			{				
				// Get cursor
				c = args[i];
				
				// Filter null values
				if (c == null)
					tickList.plus(i);
				
				inputIndex = 0;	
				
				// NOTE	[OPTIMIZATION]	This lookup could be replaced by an array or, mmm...an input obj?
				for (var j : * in _input)
				{										
					// Filtering null argument, matching argument and input obj indices
					if (inputIndex == i && c == null)
						tickList.plus(j);
					
					inputIndex++;
					
					if (!tickList.contains(i) && !tickList.contains(j))
					{						
						// NOTE	[OPTIMIZATION,DEPENDENCY] SearchRegExp needs this, mmm, prune it later.
						if (_input[j] is IDataHolder)
						{							
							_input[j].data = c;
							
							tickList.plus(i);
							tickList.plus(j);
							
							break;							
						}
						else if (_input[j] is c.constructor)
						{							
							_input[j] = c;
							
							tickList.plus(i);
							tickList.plus(j);
							
							break;
						}						
					}
				}
				
				i++;
			}			
		}
		
		// NOTE [REFACTORING] This should be moved elsewhere. It's just a tool.
		
		protected function countObjectMethods(x : Object) : int
		{			
			var i : int = 0;
			
			for each (var j : * in x)
			i++;
			
			return i;
		}
	}
}