package com.trivia.game.view.screen
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Ease;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quint;
	import com.greensock.easing.RoughEase;
	import com.trivia.game.view.event.QuestionScreenEvent;
	import com.trivia.game.vo.QuestionDataVO;
	import com.trivia.resource.IStyleModel;
	import com.trivia.resource.StyleModel;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.display.TiledImage;
	import feathers.events.FeathersEventType;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	
	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import flashx.textLayout.formats.TextAlign;
	
	import org.osmf.layout.HorizontalAlign;
	
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.HAlign;
	
	public class QuestionScreen extends Screen
	{
		protected var _isInited:Boolean = false;
		
		protected var _styleModel:IStyleModel;
		protected var _textureAtlas:TextureAtlas;
		
		protected var _header:Header;
	
		protected var _background:Image;
		protected var _backgroundLayer:Sprite;
		protected var _screenLayer:Sprite;
		protected var _contextLayer:Sprite;
		
		protected var _menuButton:Button;
		
		protected var _scoreText:TextFieldTextRenderer;
		protected var _scoreValue:TextField;
		
		protected var _timerContainer:ScrollContainer;
		protected var _timer:TextFieldTextRenderer;
		
		protected var _questionCount:int = 0;
		protected var _questionTotal:int = 0;
		
		protected var _questionContainer:Sprite;
		protected var _questionText:TextFieldTextRenderer;
		protected var _questionRect:Rectangle = new Rectangle(27, 20, 215, 110);
		
		protected var _optionsContainer:ScrollContainer;
		
		protected var _totalTime:int;
		protected var _timerValue:int;
		protected var _timerControl:uint;
		
		protected var _interactiveMode:Boolean = false;
		
		public function QuestionScreen()
		{
			super();
		}
		
		public function init(resourceModel:IStyleModel):void
		{
			if (this._isInited)
			{
				return;
			}
			
			this._styleModel = resourceModel;
			this._textureAtlas = resourceModel.getAtlas('GAME');
			
			this.buildUI();
			this.initListeners();
			
			this._isInited = true;
		}
		
		public function set score(value:int):void
		{
			this.checkIsInited();
			
			this._scoreText.text = 'Puan: ' + value;
		}
		
		public function set questionNumber(value:int):void
		{
			this.checkIsInited();
			
			this._questionCount = value;
			this.setQuestionTitle(); 
		}
		
		public function set questionTotal(value:int):void
		{
			this.checkIsInited();
			
			this._questionTotal = value;
			this.setQuestionTitle();
		}
		
		public function set question(value:String):void
		{
			this._questionText.text = value;
			this.locateQuestionText();
		}
		
		public function set options(value:Vector.<String>):void
		{
			while (this._optionsContainer.numChildren > 0)
			{
				this._optionsContainer.getChildAt(0).removeFromParent(true);
			}
			
			var i:int = 0;
			var len:int = value.length;
			for (i = 0; i < len; i++)
			{
				this.createOption(value[i], i);
			}
		}
		
		public function set timerCount(value:int):void
		{
			this._totalTime = this._timerValue = value;
			this._timer.text = '' + value;
		}
		
		public function startTimer():void
		{
			this.clearTimer();
			setTimeout(this.decreaseTime, 1000);	
		}
		
		public function clearTimer():void
		{
			clearTimeout(this._timerControl);
		}
		
		protected function decreaseTime():void
		{
			var newTime:int = this._timerValue - 1;
			if (newTime == (this._totalTime / 2 >> 0))
			{
				this.dispatchEvent(new QuestionScreenEvent(QuestionScreenEvent.HALF_TIME));
			}
				
			this._timer.text = '' + newTime;
			this._timerValue = newTime;
				
			if (newTime == 0)
			{
				this.dispatchEvent(new QuestionScreenEvent(QuestionScreenEvent.TIMEOUT));
			}
			else
			{
				this.startTimer();
			}
		}

		protected function buildUI():void
		{
			// containers
			this._backgroundLayer = new Sprite();
			this.addChild(this._backgroundLayer);
			
			this._screenLayer = new Sprite();
			this.addChild(this._screenLayer);
			
			this._header = new Header();
			this._header.backgroundSkin = new TiledImage(this._textureAtlas.getTexture('header-background'));
			this._screenLayer.addChild(this._header);
			
			this._contextLayer = new Sprite();
			this._screenLayer.addChild(this._contextLayer);
			
			this._questionContainer = new Sprite();
			this._contextLayer.addChild(this._questionContainer);
			
			this._optionsContainer = new ScrollContainer();
			this._contextLayer.addChild(this._optionsContainer);
			
			// header elements
			this._background = new Image(this._textureAtlas.getTexture('background'));
			this._backgroundLayer.addChild(this._background);
			
			this._menuButton = new Button();
			this._menuButton.defaultSkin = new Image(this._textureAtlas.getTexture('menu-button-background'));
			this._menuButton.label = 'Menü';
			this._menuButton.defaultLabelProperties.textFormat = this._styleModel.headerTextFormat;
			this._menuButton.labelOffsetX = -2;
			this._menuButton.labelFactory = this._styleModel.labelFactory;
			
			this._scoreText = new TextFieldTextRenderer();
			this._scoreText.textFormat = this._styleModel.headerTextFormat;
			this._scoreText.textFormat.align = TextAlign.RIGHT;
			this._scoreText.text = 'N/A';
			this._scoreText.embedFonts = true;
			
			this._header.title = 'N/A';
			this._header.titleFactory = this._styleModel.labelFactory;
			this._header.titleProperties.textFormat = this._styleModel.headerTextFormat;
			this._header.titleProperties.embedFonts = true;
			
			this._header.leftItems = new <DisplayObject>[
				this._menuButton				
			];
			
			this._header.rightItems = new <DisplayObject>[
				this._scoreText
			];
			
			// timers
			this._timerContainer = new ScrollContainer();
			this._timer = new TextFieldTextRenderer();
			
			var layout:HorizontalLayout = new HorizontalLayout();
			var timeText:TextFieldTextRenderer = new TextFieldTextRenderer();
			var timerContainer:Sprite = new Sprite();
			var timerBackground:Image = new Image(this._textureAtlas.getTexture('timer-background'));
			
			timerContainer.addChild(timerBackground);
			
			timeText.textFormat = this._styleModel.timerTextFormat;
			timeText.text = 'Süre';
			timeText.width = 60;
			timeText.embedFonts = true;
			
			this._timer.textFormat = this._styleModel.timerCountFormat;
			this._timer.textFormat.align = TextAlign.CENTER;
			this._timer.text = '0';
			this._timer.width = timerBackground.width;
			this._timer.embedFonts = true;
			
			timerContainer.addChild(timerBackground);
			timerContainer.addChild(this._timer);
			
			this._timerContainer.addChild(timeText);
			this._timerContainer.addChild(timerContainer);
			
			this._timerContainer.layout = layout;
			this._contextLayer.addChild(this._timerContainer);
			
			var background:Image = new Image(this._textureAtlas.getTexture('question-background'));
			this._questionContainer.addChild(background);
			
			this._questionText = new TextFieldTextRenderer();
			this._questionText.textFormat = this._styleModel.questionTextFormat;
			this._questionText.textFormat.align = TextAlign.CENTER;
			this._questionText.wordWrap = true;
			this._questionText.text = 'Lorem ipsum dolor sit amet, consectetur. Sherlock holmes is rocks! Riva is rocks!';
			this._questionText.embedFonts = true;
			
			this._questionText.width = this._questionRect.width;
			// this._questionText.height = this._questionRect.height;
			this._questionText.x = this._questionRect.x;
			this._questionText.y = this._questionRect.y;
			
			this._questionContainer.addChild(this._questionText);
			
			// options
			var optionsLayout:VerticalLayout = new VerticalLayout();
			optionsLayout.gap = 5;
			this._optionsContainer.layout = optionsLayout;
		}
		
		protected function initListeners():void
		{
			this._menuButton.addEventListener(Event.TRIGGERED, this.handleMenuButtonTap);
			this.owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, this.handleScreenReady);
			this.addEventListener(Event.REMOVED_FROM_STAGE, this.cleanup);
		}
		
		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();
			
			this._menuButton.y -= 3;
			
			this._scoreText.y = 5;
			this._scoreText.x -= 20;
			
			this._contextLayer.y = this._header.height;
			
			this._timerContainer.validate();
			this._timerContainer.x = this._backgroundLayer.width - this._timerContainer.width;
			this._timerContainer.y = 20;
			this._timer.y = -5;
			this._timer.x = 5;
			this._timerContainer.visible = false;
			
			this._questionContainer.y = 75;
			this._questionContainer.x = (this._backgroundLayer.width - this._questionContainer.width) / 2 >> 0;
			this._questionContainer.visible = false;
			
			this._optionsContainer.validate();
			this._optionsContainer.x = (this._backgroundLayer.width - this._optionsContainer.width) / 2 >> 0;
			this._optionsContainer.y = this._questionContainer.y + this._questionContainer.height + 12;
			
			for (var i:int; i < this._optionsContainer.numChildren; i++)
			{
				this._optionsContainer.getChildAt(i).visible = false;
			}
			
			this.locateQuestionText();
		}
		
		protected function runQuestionAnimation():void
		{
			this._questionContainer.visible = true;
			TweenLite.from(this._questionContainer, 1, { 
				y: - this._questionContainer.height,
				onComplete: this.runOptionsAnimation,
				ease: Elastic.easeOut
			});
		}		

		protected function runOptionsAnimation():void
		{
			var delay:Number = 0;
			var len:int = this._optionsContainer.numChildren;
			var i:int;
			var displayObject:DisplayObject;
			
			this.runScoreAnimation();
			
			for (i = 0; i < len; i++)
			{
				TweenLite.delayedCall(delay, this.runOptionAnimation, [ this._optionsContainer.getChildAt(i), i == len - 1 ]);
				delay += 0.3;
			}
			
			this._timerContainer.visible = true;
		}
		
		protected function runOptionAnimation(displayObject:DisplayObject, lastAnimation:Boolean = false):void
		{
			displayObject.visible = true;
			TweenLite.from(displayObject, 1, {
				x: displayObject.width + 30,
				ease: Elastic.easeOut,
				onComplete: lastAnimation ? this.handleOptionAnimationOnComplete : null
			});
		}
		
		protected function runScoreAnimation():void
		{
			this._timerContainer.visible = true;
			TweenLite.from(this._timerContainer, 0.5, {
				x: - this._timerContainer.width,
				ease: Quint.easeOut
			});
		}
		
		protected function handleOptionAnimationOnComplete():void
		{
			this.startTimer();
		}
		
		protected function checkIsInited():void
		{
			if (!this._isInited)
			{
				throw new IllegalOperationError('The init function must be called first.');
			}
		}
		
		protected function setQuestionTitle():void
		{
			this._header.title = 'Soru: ' + this._questionCount + '/' + this._questionTotal;
		}
		
		protected function createOption(option:String, index:int):void
		{
			var button:Button = new Button();
			button.labelFactory = this._styleModel.labelFactory;
			button.defaultSkin = new Image(this._textureAtlas.getTexture('options-background-' + (index + 1)));
			button.defaultLabelProperties.textFormat = this._styleModel.optionTextFormat;
			button.defaultLabelProperties.textFormat.align = TextAlign.CENTER;
			button.label = option;
			button.name = 'question_index_' + index;
			
			button.addEventListener(Event.TRIGGERED, this.handleButtonTap);
			
			this._optionsContainer.addChild(button);
		}
		
		protected function handleButtonTap(e:Event):void
		{
			if (!this._interactiveMode)
			{
				return;
			}
			
			this.clearTimer();
			
			var i:int = int((e.target as Button).name.substr(String('question_index_').length));
			this.dispatchEvent(new QuestionScreenEvent(QuestionScreenEvent.OPTION_BUTTON_TAP, i));
		}
		
		protected function locateQuestionText():void
		{
			this._questionText.validate();
			this._questionText.y = this._questionRect.y + (this._questionRect.height - this._questionText.height) / 2 >> 0;
		}
		
		protected function handleMenuButtonTap(e:Event):void
		{
			if (!this._interactiveMode)
			{
				return;
			}
			
			this.clearTimer();
			this.dispatchEvent(new QuestionScreenEvent(QuestionScreenEvent.MENU_BUTTON_TAP));
		}
		
		protected function handleScreenReady(e:Event):void
		{
			if (this.owner && this.owner.activeScreenID == this.screenID)
			{
				this._interactiveMode = true;
				
				this.owner.removeEventListener(FeathersEventType.TRANSITION_COMPLETE, this.handleScreenReady);
				this.dispatchEvent(new QuestionScreenEvent(QuestionScreenEvent.SCREEN_READY));
				this.runQuestionAnimation();
			}
		}
		
		protected function cleanup():void
		{
			this.clearTimer();
		}
	}
}