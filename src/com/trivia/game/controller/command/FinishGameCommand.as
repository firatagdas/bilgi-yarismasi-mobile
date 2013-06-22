package com.trivia.game.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.model.GameModel;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class FinishGameCommand extends StarlingCommand
	{
		[Inject]
		public var gameModel:GameModel;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.gameModel.finishGame();
		}
	}
}