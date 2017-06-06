package common.datastructures.graph
{
	import common.datastructures.interfaces.IDataHolder;

	public class GraphVertex implements IDataHolder
	{		
		private var _data : *;
		
		public function GraphVertex(data : *)
		{			
			this.data = data;			
		}
		
		public function get data() : *
		{			
			return _data;			
		}
		
		public function set data(i : *) : void
		{
			_data = i;		
		}	
	}
}