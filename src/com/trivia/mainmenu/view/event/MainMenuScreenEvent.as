package com.trivia.mainmenu.view.event
{
	import com.trivia.mainmenu.view.screen.MainMenuScreen;
	
	import starling.events.Event;
	
	public class MainMenuScreenEvent extends Event
	{
		public static const START_BUTTON_TAP:String = 'startButtonTap';
		public static const SCREEN_READY:String = 'mainMenuScreenReady';
		
		public function MainMenuScreenEvent(type:String)
		{
			super(type);
		}
		
		public function clone():Event
		{
			return new MainMenuScreenEvent(this.type);
		}
	}
}