package common.datastructures.tuple
{
	import common.datastructures.interfaces.IEquals;

	public class Triple implements IEquals
	{		
		private var _a	: *;
		private var _b	: *;
		private var _c	: *;
		
		public function Triple (a : * = null, b : * = null, c : * = null) : void
		{			
			this.a = a;
			this.b = b;
			this.c = c;
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
		
		public function get c() : *
		{			
			return _c;
		}
		
		public function set c(i : *) : void
		{
			_c = i;
		}
		
		public function equals(a : *) : Boolean
		{			
			if (!(a is Triple))
				return false;
			
			if (( a.a == this.a) && (a.b == this.b) && (a.c == this.c))
			{				
				return true;
			}
			else
			{
				return false;
			}
		}
	}
}