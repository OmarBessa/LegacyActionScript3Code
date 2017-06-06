package common.datastructures.doublylinkedlist.tool
{
	import common.datastructures.doublylinkedlist.DoublyLinkedList;
	import common.datastructures.doublylinkedlist.DoublyLinkedListNode;

	public class DLListTool
	{		
		/**
		 * Extracts the first occurrence of an object in a list.
		 */
		
		public static function extract(data : *, from : DoublyLinkedList) : *
		{			
			var startNode : DoublyLinkedListNode = from.head;
			
			while (startNode)
			{				
				if (startNode.data == data)
				{					
					return from.remove(startNode);
				}
				
				startNode = startNode.next;
			}			
		}
		
		/**
		 * Inserts an element after a match on a list.
		 * 
		 */
		
		public static function insert(element : *, onMatch : Function, from : DoublyLinkedList) : void
		{			
			var startNode : DoublyLinkedListNode = from.head;
			
			while (startNode)
			{				
				if (onMatch(startNode.data))
				{					
					from.insertValueAfter(new DoublyLinkedListNode(startNode), element);
					break;
				}
				
				startNode = startNode.next;
			}
		}
	}
}