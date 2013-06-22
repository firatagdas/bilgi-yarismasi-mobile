package com.trivia.screen.event
{
	import flash.events.Event;
	
	public class ScreenEvent extends Event
	{
		public static const STARTUP_COMPLETE:String = 'startupComplete';
		public static const REQUEST_CHANGE:String = 'requestChangeScreen';
		public static const CHANGE:String = 'changeScreen';
		
		protected var _screenId:String;
		
		public function ScreenEvent(type:String, screenId:String = null)
		{
			super(type);
			this._screenId = screenId;
		}
		
		public function get screenId():String
		{
			return this._screenId;
		}
		
		override public function clone():Event
		{
			return new ScreenEvent(this.type, this._screenId);
		}
	}
}