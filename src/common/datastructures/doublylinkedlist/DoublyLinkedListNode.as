package common.datastructures.doublylinkedlist
{
	import common.datastructures.interfaces.IDataHolder;

	public class DoublyLinkedListNode implements IDataHolder
	{		
		public var _data : *;
		
		public var prev : DoublyLinkedListNode;
		public var next : DoublyLinkedListNode;		
		
		public function DoublyLinkedListNode(inputData : *)
		{
			next = prev = null;
			data = inputData;
		}
		
		public function get data() : *
		{			
			return this._data;			
		}
		
		public function set data(input : *) : void
		{			
			this._data = input;
		}		
	}
}