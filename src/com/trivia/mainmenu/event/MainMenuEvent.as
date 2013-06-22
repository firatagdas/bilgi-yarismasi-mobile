package com.trivia.mainmenu.event
{
	import flash.events.Event;
	
	public class MainMenuEvent extends Event
	{
		public static const START_BUTTON_TAP:String = 'startButtonTap';
		
		public function MainMenuEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new MainMenuEvent(this.type);
		}
	}
}