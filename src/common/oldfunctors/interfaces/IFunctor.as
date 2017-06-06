package common.oldfunctors.interfaces
{
	/**
	 * 
	 * ORIGINAL_PROJECT	PrototypeWebCrawler
	 * CREATION_DATE	06_29_10	18:23
	 * 
	 */
	
	public interface IFunctor
	{		
		function setInput(... args) : void;
		function get input() : *;
		function get state() : *;
		function run(... args) : *;
		function get output() : *;
	}
}