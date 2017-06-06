package common.datastructures.interfaces
{
	public interface IIteratorImperative
	{		
		function advance() : *;
		function canAdvance() : Boolean;
		
		function get position() : *;
		function set position(vector : *):void;
		
		function get direction() : *;
		function set direction(vector : *):void;	
		
		function get data() : *;
		function set data(content : *):void;
		
		function get target() : *;
		function set target(content : *):void;		
	}
}