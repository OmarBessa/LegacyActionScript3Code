package common.oldfunctors
{
	import common.oldfunctors.interfaces.IFunctor;

	public class PairIsEqualAt
	{		
		private var equals : IFunctor = new XEqualsY;
		
		/**
		 * Compares two members with a [] access method
		 */
		
		public function Do(pairA : Object, pairB : Object, X : *) : Boolean
		{		
			return equals.run(pairA[X], pairB[X]);
		}
	}
}