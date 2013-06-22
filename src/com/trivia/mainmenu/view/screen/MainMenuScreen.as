package com.trivia.mainmenu.view.screen
{
	import com.trivia.mainmenu.view.event.MainMenuScreenEvent;
	import com.trivia.resource.IStyleModel;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.events.FeathersEventType;
	
	import flash.geom.Rectangle;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class MainMenuScreen extends Screen
	{
		protected var _backgroundLayer:Sprite;
		protected var _hudLayer:Sprite;
		protected var _background:Image;
		protected var _mainMenuBackground:Image;
		protected var _startButton:Button;
		protected var _startButtonRect:Rectangle = new Rectangle(32, 262, 260, 75);
		
		protected var _styleModel:IStyleModel;
		protected var _textureAtlas:TextureAtlas;
		
		protected var _isInited:Boolean = false;
		
		public function MainMenuScreen()
		{
			super();
		}
		
		public function init(styleModel:IStyleModel):void
		{
			if (this._isInited)
			{
				return;
			}
			
			this._styleModel = styleModel;
			this._textureAtlas = styleModel.getAtlas('GAME');
			
			this.buildUI();
			this.initListeners();
			
			this._isInited = true;
		}
		
		protected function buildUI():void
		{
			this._backgroundLayer = new Sprite();
			this.addChild(this._backgroundLayer);
			
			this._background = new Image(this._textureAtlas.getTexture('background'));
			this._backgroundLayer.addChild(this._background);
			
			this._mainMenuBackground = new Image(this._textureAtlas.getTexture('main-menu'));
			this._backgroundLayer.addChild(this._mainMenuBackground);
			
			this._hudLayer = new Sprite();
			this.addChild(this._hudLayer);
			
			this._startButton = new Button();
			this._startButton.defaultSkin = new Quad(this._startButtonRect.width, this._startButtonRect.height, 0xFFFFFF);
			this._startButton.alpha = 0;
			this._hudLayer.addChild(this._startButton);
		}
		
		override protected function draw():void
		{
			this.layout();
		}
		
		protected function layout():void
		{
			this._startButton.x = this._startButtonRect.x;
			this._startButton.y = this._startButtonRect.y;
		}
		
		protected function initListeners():void
		{
			this.owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, this.handleScreenReady);
			this._startButton.addEventListener(Event.TRIGGERED, handleStartButtonTap);
		}
		
		protected function handleStartButtonTap(e:Event):void
		{
			this.dispatchEvent(new MainMenuScreenEvent(MainMenuScreenEvent.START_BUTTON_TAP));
		}
		
		protected function handleScreenReady(e:Event):void
		{
			if (this.owner && this.owner.activeScreenID == this.screenID)
			{
				this.owner.removeEventListener(FeathersEventType.TRANSITION_COMPLETE, this.handleScreenReady);
				this.dispatchEvent(new MainMenuScreenEvent(MainMenuScreenEvent.SCREEN_READY));
			}
		}
	}
}