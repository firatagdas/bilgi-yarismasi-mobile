package com.trivia.game.view.event
{
	import starling.events.Event;
	
	public class QuestionScreenEvent extends Event
	{
		public static const TIMEOUT:String = 'questionTimeout';
		public static const HALF_TIME:String = 'questionHalfTime';
		public static const MENU_BUTTON_TAP:String = 'questionMenuTap';
		public static const OPTION_BUTTON_TAP:String = 'questionOptionButtonTap';
		public static const SCREEN_READY:String = 'questionScreenReady';
		
		protected var _answerIndex:int;
		
		public function QuestionScreenEvent(type:String, answerIndex:int = -1)
		{
			super(type);
			this._answerIndex = answerIndex;
		}
		
		public function get answerIndex():int
		{
			return this._answerIndex;
		}
		
		public function clone():Event
		{
			return new QuestionScreenEvent(this.type, this._answerIndex);
		}
	}
}