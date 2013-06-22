package com.trivia.game.view.screen
{
	import com.trivia.game.event.MessageEvent;
	import com.trivia.game.view.event.MessageScreenEvent;
	import com.trivia.resource.IStyleModel;
	
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.events.FeathersEventType;
	
	import flash.errors.IllegalOperationError;
	
	import flashx.textLayout.formats.TextAlign;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.deg2rad;
	
	public class MessageScreen extends Screen
	{
		protected var _isInited:Boolean = false;
		
		protected var _styleModel:IStyleModel;
		protected var _textureAtlas:TextureAtlas;
		
		protected var _background:Image;
		protected var _backgroundLayer:Sprite;
		
		protected var _contextLayer:Sprite;
		
		protected var _messageText:TextFieldTextRenderer;
		protected var _messageIcon:Image;
		protected var _scoreText:TextFieldTextRenderer;
		protected var _buttonContainer:Sprite;
		protected var _buttonBackground:Image;
		protected var _button:Button;
		
		public function MessageScreen()
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
		
		public function set score(value:int):void
		{
			this._scoreText.text = 'Score: ' + value;
			this.layout();
		}
		
		public function set type(value:String):void
		{
			var textureName:String;
			var buttonClickCallback:Function;
			
			switch (value)
			{
				case MessageEvent.CORRECT_ANSWER:
					textureName = 'correct-answer-icon';
					this._messageText.text = 'Dogru Cevap';
				break;
				case MessageEvent.FINISH_GAME:
					textureName = 'correct-answer-icon';
					this._messageText.text = 'Yarismayi Kazandiniz';
				break;
				case MessageEvent.WRONG_ANSWER:
					this._messageText.text = 'Yanlis Cevap';
					textureName = 'wrong-answer-icon';
				break;
				case MessageEvent.TIMEOUT:
					textureName = 'wrong-answer-icon';
					this._messageText.text = 'Sure Bitti';
				break;
			}
			
			if (textureName != null)
			{
				this.setIcon(textureName);
			}
			
			switch (value)
			{
				case MessageEvent.CORRECT_ANSWER:
					this.setTriggerButton('Sonraki Soru', dispathNextQuestion);
				break;
				default:
					this.setTriggerButton('Oyunu Bitir', dispatchFinishGame);
			}
			
			this.layout();
		}
		
		protected function buildUI():void
		{
			// containers
			this._backgroundLayer = new Sprite();
			this.addChild(this._backgroundLayer);
			
			this._background = new Image(this._textureAtlas.getTexture('background'));
			this._backgroundLayer.addChild(this._background);
			
			this._contextLayer = new Sprite();
			this.addChild(this._contextLayer);
			
			this._messageText = new TextFieldTextRenderer();
			this._messageText.textFormat = this._styleModel.messageTextFormat;
			this._messageText.textFormat.align = TextAlign.CENTER;
			this._messageText.text = 'N/A';
			this._messageText.embedFonts = true;
			this._contextLayer.addChild(this._messageText);
			
			this._scoreText = new TextFieldTextRenderer();
			this._scoreText.textFormat = this._styleModel.scoreTextFormat;
			this._scoreText.textFormat.align = TextAlign.CENTER;
			this._scoreText.text = 'N/A';
			this._scoreText.embedFonts = true;
			this._contextLayer.addChild(this._scoreText);
		
			this.layout();
		}
		
		protected function initListeners():void
		{
			this.owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, this.handleScreenReady);
		}
		
		protected function setIcon(textureName:String):void
		{
			if (this._messageIcon != null)
			{
				this._messageIcon.removeFromParent(true);
			}
			
			this._messageIcon = new Image(this._textureAtlas.getTexture(textureName));
			this._contextLayer.addChild(this._messageIcon);
			
			this.layout();
		}
		
		protected function setTriggerButton(text:String, tapCallback:Function):void
		{
			if (this._button != null)
			{
				this._button.removeFromParent(true);
			}
			else
			{
				this._buttonContainer = new Sprite();
				this._buttonBackground = new Image(this._textureAtlas.getTexture('next-question-button-background'));
				this._buttonBackground.x = 3;
				this._buttonContainer.addChild(this._buttonBackground);
				this._contextLayer.addChild(this._buttonContainer);
			}
			
			this._button = new Button();
			this._button.defaultSkin = new Quad(this._buttonBackground.width, this._buttonBackground.height, 0xFFFFFF);
			this._button.defaultSkin.alpha = 0;
			this._button.label = text;
			this._button.labelFactory = this._styleModel.labelFactory;
			this._button.defaultLabelProperties.textFormat = this._styleModel.finishButtonTextFormat;
			this._button.defaultLabelProperties.textFormat.align = TextAlign.CENTER;
			this._button.addEventListener(Event.TRIGGERED, tapCallback);
			
			this._buttonContainer.addChild(this._button);
		}
		
		protected function layout():void
		{
			this._messageText.validate();
			this._messageText.x = (this._background.width - this._messageText.width) / 2;
			this._messageText.y = 60;
			
			if (this._messageIcon != null)
			{
				this._messageIcon.y = 115;
				this._messageIcon.x = (this._background.width - this._messageIcon.width) / 2; 
			}
			
			this._scoreText.validate();
			this._scoreText.x = (this._background.width - this._scoreText.width) / 2;
			this._scoreText.y = 225;
			
			if (this._button != null)
			{
				this._button.validate();
				this._button.pivotX = this._button.width / 2 >> 0;
				this._button.x = this._button.pivotX;
				this._button.rotation = deg2rad(-4);
				
				this._buttonContainer.y = 272;
				this._buttonContainer.x = (this._background.width - this._buttonContainer.width) / 2;
			}
		}
		
		protected function dispathNextQuestion():void
		{
			this.dispatchEvent(new MessageScreenEvent(MessageScreenEvent.NEXT_QUESTION_TAPPED));
		}
		
		protected function dispatchFinishGame():void
		{
			this.dispatchEvent(new MessageScreenEvent(MessageScreenEvent.FINISH_GAME_TAPPED));
		}
		
		protected function handleScreenReady(e:Event):void
		{
			if (this.owner && this.owner.activeScreenID == this.screenID)
			{
				this.owner.removeEventListener(FeathersEventType.TRANSITION_COMPLETE, this.handleScreenReady);
				this.dispatchEvent(new MessageScreenEvent(MessageScreenEvent.SCREEN_READY));
			}
		}
		
		protected function checkIsInited():void
		{
			if (!this._isInited)
			{
				throw new IllegalOperationError('The init function must be called first.');
			}
		}
	}
}