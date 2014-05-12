package template.symbols 
{
	import bridge.abstract.IAbstractImage;
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import starlingEngine.elements.EngineSprite;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class Symbol extends EngineSprite
	{
		
		private var _symbolGraphics:IAbstractImage;
		private var _currX:Number;
		private var _currY:Number;
		private var _dir:Number = 0;
		
		public var yOffset:Number = 0;
		
		public function Symbol(img:IAbstractImage) 
		{
			_symbolGraphics = img;
			this.addNewChild(_symbolGraphics);
			
			_currX = this.x;
			_currY = yOffset;
			
			animate();
		}
		
		public function updateSymbol(newSymbol:IAbstractImage):void
		{
			_symbolGraphics.newTexture = newSymbol.currentTexture;
			_symbolGraphics.readjustSize();
			_symbolGraphics.y = (126 - _symbolGraphics.height) / 2;
			
			animate();
		}
		
		public function animate():void
		{	
			_dir = 1 - Math.random() * 2;
			
			TweenLite.to(this, 1, { x:_currX + _dir * Math.random() * 10, y:yOffset + _dir * Math.random() * 10, ease:Elastic.easeOut } );
		}
		
	}

}