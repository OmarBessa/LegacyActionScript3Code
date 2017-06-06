package common.datastructures.tuple
{
	import common.datastructures.interfaces.IEquals;
		
	public class Duple implements IEquals
	{			
		private var _a	: *;
		private var _b	: *;
		
		public function Duple (a : * = null, b : * = null) : void
		{				
			this.a = a;
			this.b = b;				
		}
		
		public function get a() : *
		{				
			return _a;				
		}
		
		public function set a(i : *) : void
		{				
			_a = i;				
		}
		
		public function get b() : *
		{				
			return _b;
		}
		
		public function set b(i : *) : void
		{				
			_b = i;				
		}
		
		public function equals(b : *) : Boolean
		{				
			if ((this.a == b.a) && (this.b == b.b))
			{	
				return true;
			}
			else
			{				
				return false;
			}
		}
		
		public function toString() : String
		{				
			return ("{" + _a + ", " + _b + "}");
		}
	}
}