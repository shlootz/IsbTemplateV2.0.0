package template.symbols 
{
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class SymbolsManager 
	{
		
		public var symbols:Vector.<Symbol> = new Vector.<Symbol>;
		
		public function SymbolsManager() 
		{
			
		}
		
		public function addSymbol(symbol:Symbol):void
		{
			symbols.push(symbol);
		}
		
	}

}