package com.trivia.game.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.model.GameModel;
	import com.trivia.game.view.screen.QuestionScreenMediator;
	import com.trivia.screen.event.ScreenEvent;
	import com.trivia.system.Config;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class StartGameCommand extends StarlingCommand
	{
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var config:Config;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
		
			this.gameModel.createNewGame(config.questionCountInGame, config.timeToAnswer, config.scoreOfEachQuestion);
			this.dispatch(new ScreenEvent(ScreenEvent.REQUEST_CHANGE, QuestionScreenMediator.ID));
		}
	}
}