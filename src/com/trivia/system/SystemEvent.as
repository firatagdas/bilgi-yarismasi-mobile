package com.trivia.system
{
	import flash.events.Event;
	
	import starling.display.DisplayObject;
	
	public class SystemEvent extends Event
	{
		public static const START_UP:String = 'StartUp';
		
		protected var _mainStage:DisplayObject;
		
		public function SystemEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new SystemEvent(this.type);
		}
	}
}