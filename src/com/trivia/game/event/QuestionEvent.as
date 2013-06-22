package com.trivia.game.event
{
	import flash.events.Event;
	
	public class QuestionEvent extends Event
	{
		public static const OPTION_BUTTON_TAP:String = 'optionButtonTap';
		public static const MENU_BUTTON_TAP:String = 'menuButtonTap';
		public static const POST_CORRECT_ANSWER:String = 'correctAnswerComplete';
		public static const POST_WRONG_ANSWER:String = 'wrongAnswer';
		
		public static const FINISH_GAME:String = 'finishGameCmd';
		public static const MENU_BUTTON_TAPPED:String = 'menuButtonTapped';
		
		protected var _answerIndex:int;
		
		public function QuestionEvent(type:String, answerIndex:int = -1)
		{
			super(type);
			this._answerIndex = answerIndex;
		}
		
		public function get answerIndex():int
		{
			return this._answerIndex;
		}
		
		override public function clone():Event
		{
			return new QuestionEvent(this.type, this._answerIndex);
		}
	}
}