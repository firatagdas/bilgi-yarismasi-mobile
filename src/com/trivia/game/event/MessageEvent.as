package com.trivia.game.event
{
	import flash.events.Event;
	
	public class MessageEvent extends Event
	{
		public static const CORRECT_ANSWER:String = 'correctAnswer';
		public static const WRONG_ANSWER:String = 'wrongAnswer';
		public static const TIMEOUT:String = 'timeout';
		public static const FINISH_GAME:String = 'finishGame';
		
		public static const NEXT_QUESTION_TAPPED:String = 'nextQuestionTapped';
		public static const FINISH_GAME_TAPPED:String = 'finishGameTapped';
		
		public function MessageEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new MessageEvent(this.type);
		}
	}
}