package classes
{
	import starling.display.Image;
	import starling.display.Sprite;
	import classes.Main;
	/**
	 * ...
	 * @author CatalinI
	 */
	public class Particle extends Sprite 
	{
		
		
		private var _speedX:Number = 0;
		private var _speedY:Number = 0;
		private var _spin:Number = 0;
		private var _image:Image;
		
		public function Particle()
		{
			_image = new Image(Assets.getAtlas().getTexture("particleEat"));
			this.addChild(_image);
		}
		
		public function get speedX():Number 
		{
			return _speedX;
		}
		
		public function set speedX(value:Number):void 
		{
			_speedX = value;
		}
		
		public function get speedY():Number 
		{
			return _speedY;
		}
		
		public function set speedY(value:Number):void 
		{
			_speedY = value;
		}
		
		public function get spin():Number 
		{
			return _spin;
		}
		
		public function set spin(value:Number):void 
		{
			_spin = value;
		}
	}
	
}