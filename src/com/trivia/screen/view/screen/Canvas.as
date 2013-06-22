package com.trivia.screen.view.screen
{
	import com.trivia.screen.model.ScreenParamVO;
	
	import feathers.controls.Screen;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	
	import starling.animation.Transitions;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Canvas extends Sprite
	{
		protected var _navigator:ScreenNavigator;
		protected var _params:Object = {};
		protected var _isInited:Boolean = false;
		protected var _transitionManager:ScreenSlidingStackTransitionManager;
		
		public function Canvas()
		{
			super();
		}
		
		public function set screenList(value:Vector.<ScreenParamVO>):void
		{
			if (!this._isInited)
			{
				this._params.screenList = value;
				return;
			}
			
			this.setScreens(value);
		}
		
		public function set screenId(value:String):void
		{
			this._navigator.showScreen(value);
		}
		
		public function init():void
		{
			if (this._isInited)
			{
				return;
			}
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.ease = Transitions.EASE_IN;
			this._transitionManager.delay = 1;
			
			if (_params.hasOwnProperty('screenList'))
			{
				this.setScreens(_params.screenList);
			}
			
			this._isInited = true;
		}
		
		protected function setScreens(screenList:Vector.<ScreenParamVO>):void
		{
			var i:int = 0;
			var len:int = screenList.length;
			var screenParam:ScreenParamVO;
			
			for (i = 0; i < len; i++)
			{
				screenParam = screenList[i];
				this._navigator.addScreen(screenParam.id, new ScreenNavigatorItem(screenParam.screenClass, screenParam.events, screenParam.properties));
			}
		}
	}
}