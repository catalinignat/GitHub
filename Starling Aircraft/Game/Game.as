package 
{
	import classes.Main;
	import flash.display.Sprite;
	import flash.events.Event;
	import starling.core.Starling;
	
	
	/**
	 * ...
	 * @author CatalinI
	 */
	public class Game extends Sprite 
	{
		private var main:Main;
		private var _starling:Starling;
		
		public function Game()
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			_starling = new Starling(Main, stage);
			_starling.start();
		}
	}
	
}