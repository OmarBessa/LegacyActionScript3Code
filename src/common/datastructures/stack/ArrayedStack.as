package common.datastructures.stack
{
	public class ArrayedStack
	{		
		private var _data : Array = new Array;
		
		public function ArrayedStack() {}
		
		public function get length() : int {
			return this._data.length;
		}
		
		public function get top() : * {
			return this._data[this.length - 1];
		}
		
		public function pop() : * {
			return this._data.pop();
		}
		
		public function push(... args) : void {
			this._data.push.apply(null, args);
		}
		
		/** Returns a reference to this stack's data object **/
		
		public function toArray() : Array {
			return this._data;
		}
		
		public function clear() : void {
			while (this._data.pop() != null) {}
		}
	}
}