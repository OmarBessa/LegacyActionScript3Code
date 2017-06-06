package common.oldfunctors
{
	public class ArrayPairIsEqualAt
	{
		/**
		 * Compares two arrays member by member 
		 */
		
		public function Do(pairA : Object, pairB : Object, X : *) : Boolean
		{			
			return new ArrayEqualsArray().run(pairA[X], pairB[X]);
		}
	}
}