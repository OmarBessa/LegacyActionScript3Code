package common.datastructures.mathematicalset
{
	import common.datastructures.interfaces.ISet;
	import common.datastructures.tuple.Duple;
	import common.functional.Comparison;
	import common.functional.E;
	import common.functional.F;
	import common.oldfunctors.ConvertByRepeatedDivision;
	import common.oldfunctors.XEqualsY;
	import common.oldfunctors.interfaces.IFunctor;

	// NOTE [OPTIMIZATION] Try not to rely that much on 'toArray()'
	
	public class ArrayedSet implements ISet
	{		
		private var _data : Array;
		
		public function ArrayedSet(... args) : void
		{			
			_data = new Array;
			E.install();
			
			_data.push.apply(this, args);
		}
		
		/**
		 * 
		 * When applied to a set, it does not mean that the Set is a subset of this one.
		 * It means that it has at least one value of it.
		 * 
		 */
		
		public function contains(x : *) : Boolean
		{			
			if (x is ISet || x is Array)
			{
				return containsAllComparisons(getComparisonsFor(x));
			}
			else
			{				
				return F.some(Comparison.isEqualTo(x), _data);
			}			
		}
		
		/**
		 * 
		 * Adds elements to the set. This is not a multiset, no repeated values are allowed.
		 * 
		 * The + Symbol ( because AS3 lacks operator overloading )
		 * 
		 * 
		 */
		
		public function plus(... args) : void
		{			
			var uniqueArgs : Array = F.select(
				F.not(
					getEqualityFor(this._data)
				), 
				args
			);
			
			this._data.push.apply(this, uniqueArgs);			
		}
		
		/**
		 * 
		 * The - Symbol ( because AS3 lacks operator overloading )
		 * 
		 * Finds, removes and returns an element or a set of them in the set.
		 * 
		 */
		
		public function minus(... args) : *
		{			
			var thereIsAMatchFor : Function = this.getEqualityFor(args);
			
			this._data = F.select(
				F.not(thereIsAMatchFor),
				this._data
			);			
		}
		
		/**
		 * 
		 * Union works element by element
		 * 
		 * The union does not modify any involved set.
		 * 
		 * @return	The union of this set and the argument set.
		 * 
		 */
		
		public function union(x : ISet) : ISet
		{			
			var	result : ISet = new ArrayedSet;
			result.plus.apply(result, this.toArray());
			result.plus.apply(result, x.toArray());
			//result.minus.apply( result, x.intersection( this ).toArray() );
			
			return result;			
		}
		
		/**
		 * 
		 * It does not get non-unique values.
		 * 
		 * @return	The intersection of this set and the argument set.
		 * 
		 */
		
		public function intersection(x : ISet) : ISet
		{			
			var temp : Array;
			
			// NOTE [OPTIMIZATION] This could be merged with cross()
			// Perform all comparisons ( a x b )
			temp = F.map(
				// Compare every a to every b
				this.getComparisonsFor(x.toArray()),
				F.select['partial'](F._, _data)
			);
			
			// Filter not-found and not-unique matches 
			temp = F.select(
				F.sequence(
					F.pluck('length'),
					Comparison.isNotEqualTo(0)					
				),
				temp
			);
			
			// Replace arrays with its first element
			temp = F.map(temp, F.pluck('0'));			
			
			var	result : ISet = new ArrayedSet;
			result.fromArray(temp);
			
			return result;		
		}
		
		/**
		 * 
		 * Complement works element by element.
		 * 
		 * Involved sets do not get modified.
		 * 
		 * U - A
		 * 
		 */
		
		public function complement(x : ISet) : ISet
		{			
			var	result : ISet = new ArrayedSet;
			result.plus.apply(result, x.toArray());
			result.minus.apply(result, this.toArray());
			
			return result;			
		}
		
		/**
		 * 
		 * Involved sets do not get modified.
		 * 
		 * ( A union B ) - ( A intersection B )
		 * 
		 */
		
		public function symmetricDifference(x : ISet) : ISet
		{			
			var intersection : ISet = this.intersection(x);
			var union : ISet = this.union(x);
			
			union.minus.apply(union, intersection.toArray());
			
			return union; 			
		}
		
		/**
		 * 
		 * Returns an ArrayedSet of Duples containing all member of the cross product.
		 * 
		 * Involved sets do not get modified.
		 * 
		 * A X B
		 * 
		 */
		
		public function cross(x : ISet) : ISet
		{			
			var result	: ISet = new ArrayedSet;
			var holder	: Array = x.toArray();
			
			var i : int = 0;
			var iLen : int = holder.length;
			
			var j : int = 0;
			var jLen : int = _data.length;
			
			while (i < iLen)
			{				
				while (j < jLen)
				{					
					result.plus(new Duple(holder[i], _data[j]));					
					j++;					
				}
				
				i++;				
			}
			
			return result;
		}
		
		public function getPowerSet() : ISet
		{			
			var result : ISet = new ArrayedSet;
			var binaryConverter : IFunctor = new ConvertByRepeatedDivision( 0, "01");
			
			var readIndicesFromBinary : Function = function (x : String) : Array { 				
				var index : int;
				var result : Array = new Array;
				var strLen : int = x.length;
				
				while (index < strLen)
				{
					if (x.charAt(index) == "1")			
						result.push(strLen - index - 1);
					
					index++;					
				}
				
				return result;
			};
			
			var source : Array = this.toArray();
			
			var i : int = 0;
			var l : int = int(Math.pow(this.size, 2 )) - 1;
			var c : String = "";
			
			// Adding the Empty Set
			result.plus(new ArrayedSet());
			
			// Initialize powerset collection vars
			var powerSetMemberIndices : Array;
			
			var powerSetMemberCount : int;
			var powerSetMemberCounter : int;
			var powerSetMemberCollector : ArrayedSet;
			
			while (i < l)
			{				
				c = binaryConverter.run( i );
				
				// Get current PowerSet member
				powerSetMemberIndices = readIndicesFromBinary(c);
				
				// Reset powerset collection vars
				powerSetMemberCount = powerSetMemberIndices.length;
				
				if ( powerSetMemberCount > 0 )
				{					
					powerSetMemberCounter = 0;
					powerSetMemberCollector = new ArrayedSet();
					
					// Get all elements of the current powerset member
					while( powerSetMemberCounter < powerSetMemberCount ) 
					{						
						powerSetMemberCollector.plus( 
							source[powerSetMemberIndices[powerSetMemberCounter]]
						);
						
						powerSetMemberCounter++;						
					}
					
					// Add powerset member to results
					result.plus(
						powerSetMemberCollector
					);					
				}
				
				i++;				
			}			
			
			return result;
		}
		
		public function get size() : int
		{			
			return _data.length;			
		}
		
		/**
		 * 
		 * Retrieves all instances of an element from the set
		 * 
		 */
		
		public function findAll(x : *) : Array
		{			
			return F.select(Comparison.isEqualTo(x), this._data);			
		}
		
		/**
		 * Copies the input array as the set's new data.
		 * Overrides all previous data.
		 */
		
		public function fromArray(i : Array) : void
		{			
			_data = i.slice();			
		}
		
		/**
		 * 
		 * Returns all set elements as an array.
		 * 
		 */
		
		public function toArray() : Array
		{			
			return _data.slice();			
		}
		
		/**
		 * Compares a set for equality member by member, ordered.
		 * 
		 * @param	The set to be compared
		 */
		
		public function equals(x : ISet) : Boolean
		{			
			var equals : IFunctor = new XEqualsY;
			
			return equals.run(this._data, x.toArray());
		}
		
		/**
		 * 
		 * 
		 */
		
		public function flatten() : void
		{			
			var _subsets : Array = F.select( 
				Comparison.isOfType(ArrayedSet), 
				this._data
			);
			
			var pushSubset : Function = function (x : ArrayedSet) : void
			{				
				var temp : Array = x.toArray();
				
				F.walk(this.plus, temp);				
			}
			
			F.walk(this.minus, _subsets);
			
			F.walk(pushSubset, _subsets);			
		}
		
		/**
		 * 
		 * Makes an array of equalities. Functions which return true for a given match.
		 * 
		 * NOTE	[REFACTORING]	Mmm, I don't like this. It seems to suck needless cycles for empty arrays.
		 * 
		 */
		
		private function getEqualityFor( X : Array ) : Function
		{			
			// Construct an equality function
			return	F.or.apply( 
				null,
				// Get all equality functions
				F.map(
					X,
					Comparison.isEqualTo
				)
			);			
		}
		
		/**
		 * 
		 * Has this set got AT LEAST ONE subset X?
		 * 
		 * @param	An array of comparison functions
		 * 
		 * NOTE	this has almost the same 'skeleton' as the multiple argument part of ArrayedSet.minus()
		 */
		
		private function containsAllComparisons(X : Array) : Boolean
		{			
			var result : Boolean = false;
			
			var i : int = 0;
			var j : int = 0;
			
			while (i < _data.length)
			{
				while (j < X.length)
				{					
					if (X[j](_data[i]))
					{						
						X.splice(j, 1);				
						break;						
					}
					
					j++;					
				}
				
				i++;				
			}
			
			if (X.length == 0)
				result = true;
			
			return result;			
		}
		
		/**
		 * Has this set got at least one item in collection X?
		 */
		
		private function containsOneOfComparisons(X : *) : Boolean
		{			
			return F.some(
				F.some['partial']( F._, _data ), 
				X
			);
		}
		
		/**
		 * 
		 * @return	One comparison function per each member of X. Null if unavailable.
		 * 
		 */ 
		
		private function getComparisonsFor(x : *) : Array
		{			
			var result : Array = new Array;
			var temp : Array;
			
			if ( x is ISet)
			{				
				temp = x.toArray();				
			}
			else if (x is Array)
			{				
				temp = x;
			}
			else
			{				
				trace( "Exception: Can not retrieve comparisons for this datatype." );
				return null;				
			}
			
			result = F.map(
				temp,
				Comparison.isEqualTo 
			); 
			
			return result;
		}
	}
}