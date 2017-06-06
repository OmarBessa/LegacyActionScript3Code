package common.datastructures.interfaces
{
	public interface ISet
	{		
		function contains(x : *) : Boolean;
		function plus(... args) : void;
		function minus(... args) : *;
		function union(x : ISet) : ISet;
		function intersection(x : ISet) : ISet;
		function complement(x : ISet) : ISet;
		function symmetricDifference(x : ISet)	: ISet;
		function cross(x : ISet) : ISet;
		function getPowerSet() : ISet;
		function get size() : int;
		
		/**
		 * 
		 * Retrieves all instances of an element from the set
		 * 
		 */
		
		function findAll(x : *) : Array;
		function fromArray(x : Array) : void;
		function toArray() : Array;
		function equals(x : ISet) : Boolean;
		
		/**
		 * 
		 * Makes every subset element a primary member of the subset.
		 * That means that elements will no longer be held in subsets of the set, but the set itself.
		 * This is an irreversible action. 
		 * 
		 */
		
		function flatten() : void;
	}
}