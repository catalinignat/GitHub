package classes
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.core.Starling;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author CatalinI
	 */
	public class Main extends Sprite 
	{
		[Embed(source="../images/cer.png")]
		private var Sky:Class;
				
		[Embed(source="../images/nori.png")]
		private var Clouds:Class;
						
		[Embed(source="../images/pamant.png")]
		private var Ground:Class;
								
		[Embed(source="../images/munti.png")]
		private var Mountains:Class;
		
		
		private var _aircraft:MovieClip;
		
		private var _sky:Image;
		private var _clouds:Image;
		private var _ground:Image;
		private var _mountains:Image;
		private var _map:Sprite = new Sprite();
		private var _touch:Touch;
		private var _touchX:Number = 0;
		private var _touchY:Number = 0;
		private var _particles:Vector.<Particle>;
		private var _gameSpeed:Number = 7;
		private const AIRCRAFT_POSITION_X:Number = 100;
		
		private var gunParticle:PDParticleSystem;
		private var _gunParticles:Vector.<PDParticleSystem>;
		
		public function Main()
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		private function initialize(e:Event):void 
		{
			_sky = Image.fromBitmap(new Sky());
			this.addChild(_sky);
						
			_clouds = Image.fromBitmap(new Clouds());
			_map.addChild(_clouds);
														
			_mountains = Image.fromBitmap(new Mountains());
			_mountains.y = 363;
			_map.addChild(_mountains);
									
			_ground = Image.fromBitmap(new Ground());
			_ground.x = 0;
			_ground.y = 425.9;
			_map.addChild(_ground);
			
			this.addChild(_map);
			
			stage.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
			
			
			var aircraftTexture:Texture = Texture.fromBitmap(new Assets.Textures());
			var aircraftXmlData:XML = XML(new Assets.AnimData());
			var aircraftTextureAtlas:TextureAtlas = new TextureAtlas(aircraftTexture, aircraftXmlData);
				//Fetch the sprite sequence form the texture using their name
			_aircraft = new MovieClip(aircraftTextureAtlas.getTextures("aircraft"), 24);
			
			_aircraft.x = AIRCRAFT_POSITION_X;
			_aircraft.y = 200;
			addChild(_aircraft);
			stage.addEventListener(TouchEvent.TOUCH, touchHandler);
			
			Starling.juggler.add(_aircraft);
			
			_particles = new Vector.<Particle>();
			_gunParticles = new Vector.<PDParticleSystem>();
			
		}
		
		private function touchHandler(e:TouchEvent):void 
		{
			_touch = e.getTouch(stage);
			if(_touch)
			{
					switch(_touch.phase)
					{
						case TouchPhase.HOVER:
						_touchX = _touch.globalX;
						_touchY = _touch.globalY;
						break;
					case TouchPhase.BEGAN:
						fire();
						break;
					}
			}
		}
		
		private function fire():void 
		{
			gunParticle = new PDParticleSystem(new XML(new AssetsParticles.ParticleXML()), Texture.fromBitmap(new AssetsParticles.ParticleTexture()));
			Starling.juggler.add(gunParticle);
			this.addChild(gunParticle);
			gunParticle.x = _aircraft.x + _aircraft.width;
			gunParticle.y = _aircraft.y + _aircraft.height / 2;
			gunParticle.start();
			_gunParticles.push(gunParticle);
		}
		private function onEnterFrame(e:Event):void
		{
			_clouds.x -= _gameSpeed /  15;
			_ground.x -= _gameSpeed * 2;
			_mountains.x -= _gameSpeed;
			if (_clouds.x < -984)
				_clouds.x = 0;
			if (_ground.x < -1000)
				_ground.x = 0;
			if (_mountains.x < -1000)
				_mountains.x = 0;
			_aircraft.y -= (_aircraft.y - _touchY) * 0.1;
			
			createparticles();
		}
		
		private function createparticles():void
		{
			var count:int = 5;
			
			while (count > 0)
			{
				count--;
				var particle:Particle = new Particle();
				this.addChild(particle);
				
				particle.x = _aircraft.x - Math.random() * 40 -20;
				particle.y = _aircraft.y + Math.random() * 40;
				particle.alpha = .2;
				
				particle.speedX = Math.random() * 2 + 1;
				particle.speedY = Math.random() * 5;
				particle.spin = Math.random() * 15;
				//particle.scaleX = particle.scaleY = Math.random() * 0.3 + 0.3;
				
				_particles.push(particle);
			}
			animateParticles();
		}
		private function animateParticles():void
		{
			for (var i:uint = 0; i < _particles.length; i++)
			{
				_particles[i].x -= 10;
				_particles[i].rotation += 0.1;
				
				if (_particles[i].x < 0)
				{
					this.removeChild(_particles[i]);
					_particles.splice(i, 1);
				}
			}
			
			for (i = 0; i < _gunParticles.length; i++)
			{
				_gunParticles[i].x += _gameSpeed * 5;
				if (_gunParticles[i].x > 1000)
				{
					this.removeChild(_gunParticles[i]);
					_gunParticles.splice(i, 1);
				}
			}
		}
	}
}