package common.datastructures.doublylinkedlist
{
	import common.datastructures.interfaces.IFetcher;
	import common.datastructures.interfaces.IIteratorImperative;
	import common.tools.RangeTool;

	/**
	 * Doubly linked list iterator.
	 * 
	 * Starts at its head.
	 */
	
	public class DoublyLinkedListIterator implements IIteratorImperative, IFetcher
	{		
		private var _currentNode	: DoublyLinkedListNode;
		private var _targetList		: DoublyLinkedList;
		private var _direction		: int;		
		private var _position		: int;
		
		private var _step			: Function;
		private var _canStep		: Function;
		
		public function DoublyLinkedListIterator(target : DoublyLinkedList = null) : void
		{			
			_targetList = target;
			
			_currentNode = _targetList.head;
			_position = 0;
			
			this.direction = 1;			
		}
		
		/**
		 * Advances the iterator, returns its current data and performs the step. 
		 * The current data pointer is moved to the next position.
		 * 
		 */
		
		public function advance() : *
		{			
			if (canAdvance())
			{				
				var dataHolder : * = _currentNode.data;
				
				_step();
				
				return dataHolder;
			}
			
			return null;
		}
		
		public function canAdvance() : Boolean
		{			
			return Boolean(_currentNode);
		}
		
		public function get position() : *
		{			
			return _position;			
		}
		
		/**
		 * @param vector	Can be an integer index, a Position argument, or a particular node.
		 * 
		 */
		
		public function set position(vector : *) : void
		{			
			if (vector is int)
			{				
				advanceToPosition(vector);				
			}
			else if (vector is DoublyLinkedListNode)
			{				
				goToNode(vector);
			}			
		}
		
		public function get direction() : *
		{			
			return _direction;			
		}
		
		public function set direction(vector : *) : void
		{			
			_direction = vector;			
			selectAdvanceMethodOnDirection(_direction);
		}	
		
		public function get data() : *
		{			
			return _currentNode;
		}
		
		/**
		 * 
		 * Returns the node it is addressing
		 * 
		 */
		
		public function set data(content : *) : void
		{			
			_currentNode = content;
		}
		
		public function get target() : *
		{
			return _targetList;			
		}
		
		public function set target(content : *) : void
		{			
			_targetList = content;
		}
		
		/**
		 * Retrieval with no side-effects to the iterator.
		 * 
		 * Fetches the data and if not possible, returns a 'Failure' object.
		 * 
		 */
		
		public function fetch(position : *) : *
		{			
			var previousPosition : int = this.position;
			
			if (!this.advanceToPosition(position)) {				
				return null;			
			}
			
			var result : * = this.data;
			
			this.position = previousPosition;
			
			return result;
		}
		
		private function forth() : void
		{			
			_currentNode = _currentNode.next;
			_position++;			
		}
		
		private function back() : void
		{			
			_currentNode = _currentNode.prev;
			_position--;			
		}
		
		private function advanceToPosition(position : int) : Boolean
		{
			
			if (!RangeTool.isInBounds(position, _targetList))
			{				
				return false;				
			} 
			
			if (position == 0)
			{				
				_currentNode = _targetList.head;
				_position = 0;
				return true;
			}
			
			if (position == (_targetList.length - 1))
			{				
				_currentNode = _targetList.tail;
				_position = _targetList.length - 1;
				return true;				
			}
			
			selectAdvanceMethodOnDirection(selectDirectionOnShortestRouteTo(position));
			
			while (position != this.position)
			{				
				this.advance();				
			}
			
			if (position == this.position)
			{				
				return true;				
			}
			
			return false;			
		}
		
		private function selectDirectionOnShortestRouteTo(X : int) : int
		{			
			var delta : int = X - this.position;
			
			if (delta > 0)
			{				
				return 1;				
			}
			else if (delta < 0)
			{				
				return -1;
			}
			else
			{				
				return 1;
			}			
		}
		
		private function selectAdvanceMethodOnDirection(direction : int) : void
		{			
			if (direction > 0)
			{				
				_step = this.forth;				
			}
			else if (direction < 0)
			{				
				_step = this.back;
			}
			else
			{				
				_step = this.forth;
			}			
		}
		
		/**
		 * TESTED	NO
		 * 
		 * Goes to an specific node inside the target. In case the target does not contain it, it will do nothing.
		 */
		
		private function goToNode(node : DoublyLinkedListNode) : void
		{			
			// #CASE: Head
			if (node == this._targetList.head) {				
				_position = 0;
				_currentNode = node;
			// #CASE: Tail
			} else if (node == this._targetList.tail) {				
				_position = this._targetList.length - 1;
				_currentNode = node;				
			} else {				
				var count : int = 1;
				var holder : DoublyLinkedListNode = this._targetList.head.next;
				while (holder) {					
					if (holder == node) { 
						this._position = count;
						this._currentNode = node;
						break;
					}
					
					count = count + 1;
					holder = holder.next;
				}				
			}			
		}
	}
}