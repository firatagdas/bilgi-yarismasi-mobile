package com.trivia.game.event
{
	import com.trivia.game.vo.GameDataVO;
	
	import flash.events.Event;
	
	public class GameEvent extends Event
	{
		public static const CREATE_NEW_GAME:String = 'createNewGame';
		public static const CREATE_NEW_GAME_COMPLETED:String = 'createNewGameCompleted';
		public static const FINISH_GAME:String = 'finishGame';
		
		public function GameEvent(type:String)
		{
			super(type);
		}
		
		override public function clone():Event
		{
			return new GameEvent(this.type);
		}
	}
}