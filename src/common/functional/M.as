package common.functional
{
	public class M
	{
		/**
		 * Returns a function which clamps a given object's attributes to a max.
		 *  
		 */
		
		public static function clampMax (x : Object) : Function
		{
			return function (attribute : String, max : Number) : void
			{
				if (x[attribute] > max)
					x[attribute] = max;
			};
		}
		
		/**
		 * Creates a function which iterates through the values of a sine function. <br/>
		 * The function can be interpreted as: F(x) = A * Sin(x) + B <br/>
		 * A = yDeltaMax <br/>
		 * B = yStart <br/>
		 * x = angle in degrees <br/>
		 * <br/>
		 * Each iteration counts as a step of one degree.<br/>
		 * The counter returns int values<br/>
		 * <br/>
		 * @param	xMin	The starting x from where it is evaluated. Usually 0 (for positive values).
		 * @param	xMax	The last x coordinate to be evaluated. Usually 180 (for positive values).
		 * @param	yStart	A value added to the final result. If xMin is 0, it corresponds to the starting Y.
		 * @param	yDeltaMax	How far up in y can the function go.
		 **/
		
		public static function makeSineCounter(xMin : int, xMax : int, yStart : int, yDeltaMax : int) : Function {
			var i : int = xMin;
			return function () : int {
				if (i == xMax) {
					i = xMin;
				} else {
					i = i + 1;
				}
				
				return int(					
					(
						// Get sine in degrees
						Math.sin(i*(Math.PI/180)) 
						* 
						yDeltaMax 
					) 
				)
				+
				yStart;				
			};			
		}
	}
}