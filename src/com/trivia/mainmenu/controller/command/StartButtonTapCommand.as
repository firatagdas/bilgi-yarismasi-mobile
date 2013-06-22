package com.trivia.mainmenu.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.event.GameEvent;
	import com.trivia.game.view.screen.QuestionScreenMediator;
	import com.trivia.screen.event.ScreenEvent;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class StartButtonTapCommand extends StarlingCommand
	{
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.dispatch(new GameEvent(GameEvent.CREATE_NEW_GAME));
		}
	}
}