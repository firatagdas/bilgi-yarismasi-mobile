package com.trivia.game.view.event
{
	import starling.events.Event;

	public class MessageScreenEvent extends Event
	{
		public static const NEXT_QUESTION_TAPPED:String = 'nextQuestionTapped';
		public static const FINISH_GAME_TAPPED:String = 'finishGameTapped';
		public static const SCREEN_READY:String = 'messageScreenReady';
		
		public function MessageScreenEvent(type:String)
		{
			super(type);
		}
		
		public function clone():Event
		{
			return new MessageScreenEvent(this.type);
		}
	}
}