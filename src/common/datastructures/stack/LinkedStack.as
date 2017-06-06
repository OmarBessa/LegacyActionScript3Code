package common.datastructures.stack
{
	import common.datastructures.doublylinkedlist.DoublyLinkedList;

	public class LinkedStack
	{		
		private var _list : DoublyLinkedList;
		
		public function LinkedStack(sourceList : DoublyLinkedList = null) : void
		{			
			if ( sourceList == null )
			{				
				_list = new DoublyLinkedList();
			}
			else
			{				
				_list = sourceList;
			}			
		}
		
		public function top() : *
		{			
			if (_list.length > 0) {
				return this._list.tail.data;
			} else {
				return null;
			}
		}
		
		public function push(value : *) : void
		{			
			_list.append(value);
		}
		
		public function pop() : *
		{			
			return _list.remove(null);			
		}
		
		public function contains(data : *) : Boolean {
			return this._list.contains(data);		
		}
		
		public function clear() : void
		{			
			_list.clear();	
		}		
		
		public function get length() : int
		{			
			return _list.length;
		}
		
		public function isEmpty() : Boolean
		{			
			return _list.length == 0;			
		}
		
		public function toArray() : Array
		{
			return _list.toArray();
		}
	}
}