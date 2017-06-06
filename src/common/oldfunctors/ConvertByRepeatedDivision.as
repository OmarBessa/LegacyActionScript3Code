package common.oldfunctors
{
	public class ConvertByRepeatedDivision extends AbstractFunctor
	{		
		private var _output : String;
		
		/**
		 * Performs the repeated division method for decimal integer base conversion. 
		 * Takes the decimal value and returns it in the new base.
		 * 
		 * @param input The number to be converted.
		 * @param base The destination base charset.
		 * 
		 * ORIGINAL_PROJECT Textus
		 * CREATION_DATE 01/06/10 10:25
		 */
		
		public function ConvertByRepeatedDivision(source:Number = 0, base:String = "")
		{			
			_input	= new Object;
			
			_input.source = new Number;
			_input.base = new String;
			
			this.setInput(source, base);
			
			_output	= new String("");
		}
		
		override public function execute():void
		{			
			_output = "";
			
			var remainder : int = 0;
			
			while (_input.source >= _input.base.length) 
			{				
				remainder = _input.source % _input.base.length;				
				_output = _input.base.charAt(remainder) + _output;				
				_input.source = _input.source / _input.base.length;				
			}
			
			_output = _input.base.charAt(_input.source) + _output;			
		}
		
		override public function get output() : *
		{			
			return _output;
		}
	}
}