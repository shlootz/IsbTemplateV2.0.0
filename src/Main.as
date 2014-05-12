package 
{
	import abstract.AbstractPool;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.BridgeGraphics;
	import bridge.IBridgeGraphics;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import nape.space.Space;
	import signals.ISignalsHub;
	import signals.Signals;
	import signals.SignalsHub;
	import starling.animation.Juggler;
	import starling.utils.AssetManager;
	import starlingEngine.StarlingEngine;
	import template.symbols.Symbol;
	import template.symbols.SymbolsManager;
	import template.wheels.Wheel;
	import template.wheels.WheelsManager;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Main extends Sprite 
	{
		
		private var _wheelsManager:WheelsManager;
		private var _symbolsManager:SymbolsManager;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private var _canvasSize:Point = new Point(800, 600);
		private var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
																		_canvasSize,
																		StarlingEngine,
																		AssetManager,
																		SignalsHub,
																		AbstractPool,
																		Juggler,
																		Space
																		);
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			// add the graphics engine to the display list
			addChild(_bridgeGraphics.engine as DisplayObject);
			// register a listener for the starling ready signal
			(_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, initEngine);							
		}
		
		private function initEngine(signal:String, obj:Object):void
		{
			(_bridgeGraphics.assetsManager).enqueue("../bin/assets1x/mainAtlas.png", 
													"../bin/assets1x/mainAtlas.xml"
													);
													
			(_bridgeGraphics.assetsManager).loadQueue(function(ratio:Number):void
				{
					trace("Loading assets, progress:", ratio);
					if (ratio == 1)
					{	
						buildSymbols();
						buildWheels();
						_wheelsManager.populateWheels();
						buildUI();
					}
				});													
		}
		
		private function buildUI():void
		{
			var spinBtn:IAbstractButton = _bridgeGraphics.requestButton();
			spinBtn.upSkin_ = _bridgeGraphics.requestImage("spinButtonStatic");
			spinBtn.hoverSkin_ = _bridgeGraphics.requestImage("spinButtonHover");
			spinBtn.downSkin_ = _bridgeGraphics.requestImage("spinButtonDown");
			
			spinBtn.addEventListener("triggered", button_triggeredHandler);
			
			_bridgeGraphics.addChild(spinBtn);
			spinBtn.x = 300;
			spinBtn.y = 520;
		}
		
		private function button_triggeredHandler(e:Object):void
		{
			_wheelsManager.doSpin();
		}
		
		private function buildSymbols():void
		{
			_symbolsManager = new SymbolsManager();
			
			for (var i:uint = 0; i < 12; i++ )
			{
				var img:IAbstractImage = _bridgeGraphics.requestImage("s" + String(i + 1));
				_symbolsManager.addSymbol(new Symbol(img));
			}
		}
		
		private function buildWheels():void
		{
			var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();
			layersVO.addLayer("wheels", 0, null, true);
			_bridgeGraphics.initLayers(layersVO.layers);
			
			_wheelsManager = new WheelsManager(_bridgeGraphics, _symbolsManager.symbols, layersVO.retrieveLayer("wheels"));
			
			for (var i:uint = 0; i < 6; i++ )
			{
				_wheelsManager.addWheel(String(i), new Wheel());
			}
		}
		
	}
	
}