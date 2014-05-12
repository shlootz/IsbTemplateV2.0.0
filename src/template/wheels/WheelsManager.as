package template.wheels 
{
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractLayer;
	import bridge.IBridgeGraphics;
	import flash.utils.Dictionary;
	import flash.utils.setInterval;
	import template.symbols.Symbol;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class WheelsManager 
	{
		
		private var _wheels:Vector.<Wheel> = new Vector.<Wheel>;
		private var _bridgeGraphics:IBridgeGraphics;
		private var _container:IAbstractLayer;
		private var _symbols:Vector.<Symbol>;
		
		public function WheelsManager(bridgeGraphics:IBridgeGraphics, symbols:Vector.<Symbol>, layer:IAbstractLayer) 
		{
			_bridgeGraphics = bridgeGraphics;
			_container = layer;
			_symbols = symbols;
		}
		
		public function addWheel(id:String, wheel:Wheel):void
		{
			_wheels.push(wheel);
			_container.addNewChild(wheel);
			wheel.x = (_wheels.length-1) * 126;
		}
		
		public function populateWheels():void
		{
			for (var i:uint = 0; i < _wheels.length; i++ )
			{
				addSymbols(_wheels[i]);
			}
		}
		
		public function doSpin():void
		{
			for (var i:uint = 0; i < _wheels.length; i++ )
			{
				_wheels[i].updateSymbols(_bridgeGraphics);
			}
		}
		
		private function addSymbols(target:Wheel):void
		{
			for (var i:uint = 0; i < 5; i++ )
			{
				var symbolID:int = 1 + Math.round(Math.random() * 12);
				
				var sym:Symbol = new Symbol(_bridgeGraphics.requestImage("s"+symbolID));
				
				target.addNewChild(sym);
				
				target.storeSymbol(sym)
				
				sym.y = 126 * i;
				
				sym.yOffset = 126 * i;
			}
		}
		
	}

}