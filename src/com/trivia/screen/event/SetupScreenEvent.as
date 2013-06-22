package com.trivia.screen.event
{
	import com.trivia.screen.model.ScreenParamVO;
	
	import feathers.controls.Screen;
	
	import flash.events.Event;
	
	public class SetupScreenEvent extends Event
	{
		public static const LOADED_SCREEN_LIST:String = 'loadedScreenList';
		public static const SETUP_SCREEN_COMPLETE:String = 'setupScreenComplete';
		
		protected var _screenList:Vector.<ScreenParamVO>;
		
		public function SetupScreenEvent(type:String, screenList:Vector.<ScreenParamVO> = null)
		{
			super(type);
			this._screenList = screenList;
		}
		
		public function get screenList():Vector.<ScreenParamVO>
		{
			return this._screenList;
		}
		
		override public function clone():Event
		{
			return new SetupScreenEvent(this.type, this._screenList);
		}
	}
}