package common.datastructures.doublylinkedlist
{
	/**
	 * DoublyLinkedList
	 * 
	 */
	
	public class DoublyLinkedList
	{		
		private var _count : int;
		
		public var head : DoublyLinkedListNode;
		public var tail : DoublyLinkedListNode;
		
		public function DoublyLinkedList(... args)
		{			
			addLoneNode(null);
			_count = 0;
			
			if (args.length > 0) append.apply(this, args);			
		}
		
		/**
		 * Swaps two nodes datum, not their positions.
		 * 
		 * @param	a	A node to be swapped
		 * @param	b	A node to be swapped
		 * 
		 */
		
		public function swap(a : DoublyLinkedListNode, b : DoublyLinkedListNode) : Boolean
		{			
			if (!(isNodeXInside(a) && isNodeXInside(b)))
			{				
				return false;				
			}
			
			var c : * = a.data;			
			a.data = b.data;
			b.data = c;
			
			return true;			
		}
		
		/**
		 * 'Walks' a node from head to tail, executing a user function on every node
		 * 
		 */ 
		
		public function walk(operation : Function) : void
		{			
			var nodeHolder : DoublyLinkedListNode = head;
			
			while (nodeHolder) {				
				operation(nodeHolder);
				nodeHolder = nodeHolder.next;				
			}			
		}
		
		public function append(... args) : DoublyLinkedListNode
		{			
			var nodeHolder : DoublyLinkedListNode = new DoublyLinkedListNode(args[0]);
			
			if (head) {
				addTail(nodeHolder);				
			} else {				
				addLoneNode(nodeHolder);				
			}
			
			if (args.length > 1)
			{				
				var firstNode : DoublyLinkedListNode = nodeHolder;				
				var i : int = 1;
				
				while (i < args.length) {					
					nodeHolder = new DoublyLinkedListNode(args[i]);					
					addTail(nodeHolder);					
					i++;					
				}
				
				_count += args.length;
				
				return firstNode;				
			}
			
			onAddition();
			
			return nodeHolder;			
		}
		
		public function prepend(... args) : DoublyLinkedListNode
		{			
			var argumentCount : int = args.length;			
			var nodeHolder : DoublyLinkedListNode = new DoublyLinkedListNode(args[int(argumentCount - 1)]);
			
			if (head)
			{				
				addHead(nodeHolder);
			}
			else
			{				
				addLoneNode(nodeHolder);
			}
			
			if (argumentCount > 1)
			{				
				var firstNode : DoublyLinkedListNode = nodeHolder;
				var i : int = argumentCount - 2;
				
				while (i >= 0)
				{
					nodeHolder = new DoublyLinkedListNode(args[i]);					
					addHead(nodeHolder);					
					i--;
				}
				
				_count += argumentCount;
				
				return firstNode;				
			}
			
			onAddition();
			
			return nodeHolder;			
		}
		
		public function insertValueAfter(target : DoublyLinkedListNode, value : *) : DoublyLinkedListNode
		{			
			if (target)
			{				
				var nodeHolder : DoublyLinkedListNode = new DoublyLinkedListNode(value);
				
				this.insertXAfterY(nodeHolder, target);
				
				if (target == this.tail)
				{					
					this.tail = target.next;
				}
				
				onAddition();
				
				return nodeHolder;
			}
			else
			{				
				return append(value);
			}			
		}
		
		public function insertValueBefore(target : DoublyLinkedListNode, value : *) : DoublyLinkedListNode
		{			
			if (target)
			{				
				var nodeHolder : DoublyLinkedListNode = new DoublyLinkedListNode(value);
				
				this.insertXBeforeY(nodeHolder, target);
				
				if (target == this.head)
				{					
					this.head = this.head.prev;
				}
				
				onAddition();
				
				return nodeHolder;				
			}
			else
			{				
				return prepend(value);
			}
		}
		
		/**
		 * 
		 * Returns true if successful, the node's value if argument is null.
		 * 
		 * Acts like pop() if argument is null.
		 * 
		 * @param	target	The node to be removed.
		 * 
		 */
		
		public function remove(target : DoublyLinkedListNode) : *
		{			
			if (target != null)
			{				
				if (target == head)
				{ 					
					this.head = this.head.next;
				}
				else if (target == tail)
				{					
					this.tail = this.tail.prev;					
				}
				
				unlinkX(target);
				
				clearEnds();
				
				onRemoval();
				
				target.data = null;
				
				return true;
			}
			else
			{				
				return popTail();
			}			
		}
		
		/**
		 * Merges one or more linked lists.
		 * This list's tail appends arguments' heads.
		 * 
		 * Does not merge if the calling list has no nodes.
		 * 
		 * It is likely not to work.
		 * 
		 */
		
		public function merge(... args) : void
		{
			var argumentCount : int = args.length;
			
			var listHolder : DoublyLinkedList;
			
			var i : int = 0;
			
			while (i < argumentCount)
			{				
				listHolder = args[i];
				
				if (listHolder.head)
				{					
					tail.next = listHolder.head;
					listHolder.head.prev = tail;
					
					tail = listHolder.tail;
					
					_count += listHolder.length;					
				}
				
				i++;
			}
		}
		
		/**
		 * 
		 * @return	A copy of this list.
		 * 
		 */
		
		public function copy() : DoublyLinkedList
		{			
			var result : DoublyLinkedList = new DoublyLinkedList();
			
			appendListXToY(this, result);
			
			return result;
		}
		
		/**
		 * 
		 * @return	The concatenation of the argument lists and this list.
		 * 
		 */
		
		public function concat(... args) : DoublyLinkedList
		{			
			if ( args.length == 0)
				return this.copy();
			
			var result : DoublyLinkedList = new DoublyLinkedList();
			
			appendListXToY(this, result);
			
			var argumentCount : int = args.length;			
			var i : int = 0;
			
			while (i < argumentCount)
			{				
				appendListXToY(args[i], result);				
				i++				
			}
			
			return result;			
		}
		
		public function clear():void
		{			
			// Get the head
			var nodeHolder : DoublyLinkedListNode = this.head;
			
			// Clear the head
			this.head = null;
			
			var nextHolder : DoublyLinkedListNode;
			
			while (nodeHolder)
			{				
				// Fetch next node
				nextHolder = nodeHolder.next;
				
				removeLinks(nodeHolder);
				
				// Advance to next node
				nodeHolder = nextHolder;				
			}
			
			_count = 0;			
		}
		
		public function get length() : int
		{
			
			return _count;
			
		}
		
		public function isEmpty() : Boolean
		{			
			return _count == 0;
		}
		
		public function toArray() : Array
		{		
			var result : Array = new Array;			
			var nodeHolder : DoublyLinkedListNode = head;
			
			while (nodeHolder) {
				result.push(nodeHolder.data);
				nodeHolder = nodeHolder.next;				
			}
			
			return result;			
		}
		
		public function unlinkX(X : DoublyLinkedListNode) : void
		{			
			if (X.prev)
			{				
				tiePrev(X);
			}
			
			if (X.next)
			{
				tieNext(X);
			}
			
			removeLinks(X);			
		}
		
		/** 
		 * Verifies if the list contains the data argument provided 
		 */
		
		public function contains(data : *) : Boolean {			
			var nodeHolder : DoublyLinkedListNode = head;
			
			while (nodeHolder) {				
				// Compare vertex data
				if (nodeHolder.data == data) { return true; }
				
				nodeHolder = nodeHolder.next;				
			}
			
			return false;			
		}
		
		private function addHead(node : DoublyLinkedListNode) : void
		{			
			insertXBeforeY(node, head);
			head = head.prev;			
		}
		
		private function popTail() : *
		{			
			var result : * = tail.data;
			
			if ( this.length == 1 )
			{				
				addLoneNode(null);
			}
			else
			{				
				this.tail = this.tail.prev;
				this.tail.next = null;				
			}
			
			onRemoval();
			
			return result;			
		}
		
		private function appendListXToY(X : DoublyLinkedList, Y : DoublyLinkedList) : void
		{
			var nodeHolder : DoublyLinkedListNode = X.head;
			
			while (nodeHolder) {
				Y.append(nodeHolder.data);
				nodeHolder = nodeHolder.next;				
			}			
		} 
		
		private function addTail(node : DoublyLinkedListNode) : void
		{			
			insertXAfterY(node, tail);
			tail = tail.next;			
		}
		
		private function addLoneNode(node : DoublyLinkedListNode) : void
		{			
			head = tail = node;			
		}
		
		private function insertXAfterY(X : DoublyLinkedListNode, Y : DoublyLinkedListNode):void
		{			
			X.next = Y.next;
			X.prev = Y;
			
			// Tie Y's next
			if (Y.next)
			{				
				Y.next.prev = X;				
			}
			
			Y.next = X;			
		}
		
		private function insertXBeforeY(X : DoublyLinkedListNode, Y : DoublyLinkedListNode) : void
		{			
			X.next = Y;
			X.prev = Y.prev;
			
			if (Y.prev)
			{				
				Y.prev.next = X;				
			}
			
			Y.prev = X;			
		}
		
		private function tiePrev(X : DoublyLinkedListNode) : void
		{			
			if (X.prev)
			{				
				X.prev.next = X.next;
			}			
		}
		
		private function tieNext(X : DoublyLinkedListNode) : void
		{			
			if (X.next)
			{				
				X.next.prev = X.prev;				
			}
		}
		
		private function removeLinks(X : DoublyLinkedListNode) : void
		{			
			X.next = X.prev = null;			
		}
		
		private function clearEnds() : void
		{			
			if (head == null)
			{				
				tail = null;
				return;				
			}
		}
		
		private function onAddition() : void {		
			_count++;		
		}
		
		private function onRemoval() : void {			
			_count--;			
		}
		
		private function isNodeXInside(node : DoublyLinkedListNode) : Boolean {			
			
			var nodeHolder : DoublyLinkedListNode = head;
			
			while (nodeHolder) {
				if (nodeHolder == node) {
					return true;
				}
				
				nodeHolder = nodeHolder.next;				
			}
			
			return false;			
		}
	}
}