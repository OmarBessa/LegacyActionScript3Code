package common.datastructures.tuple
{
	/**
	 * 
	 * A 4-tuple
	 * 
	 * ORIGINAL_PROJECT	PrototypeWebCrawler
	 * CREATION_DATE	07_09_10 05:02
	 * 
	 */
	
	public class Quadruple
	{		
		private var _a	: *;
		private var _b	: *;
		private var _c	: *;
		private var _d	: *;
		
		public function Quadruple(a : * = null, b : * = null, c : * = null, d : * = null) : void
		{			
			this.a = a;
			this.b = b;
			this.c = c;
			this.d = d;			
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
		
		public function get d() : *
		{			
			return _d;
		}
		
		public function set d(i : *) : void
		{			
			_d = i;			
		}
	}
}