package template.wheels 
{
	import bridge.IBridgeGraphics;
	import starlingEngine.elements.EngineSprite;
	import template.symbols.Symbol;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Wheel extends EngineSprite
	{
		
		private var _symbols:Vector.<Symbol> = new Vector.<Symbol>();
		
		public function Wheel() 
		{
			
		}
		
		public function spin():void
		{
			
		}
		
		public function storeSymbol(symbol:Symbol):void
		{
			_symbols.push(symbol);
		}
		
		public function updateSymbols(bridgeGraphics:IBridgeGraphics):void
		{
			for (var i:uint = 0; i < _symbols.length; i++ )
			{
				var symbolID:int = 1 + Math.round(Math.random() * 12);
				_symbols[i].updateSymbol(bridgeGraphics.requestImage("s"+symbolID));
			}
		}
		
	}

}