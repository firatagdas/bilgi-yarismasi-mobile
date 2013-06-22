package com.trivia.game.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.event.QuestionEvent;
	import com.trivia.mainmenu.view.screen.MainMenuScreenMediator;
	import com.trivia.screen.event.ScreenEvent;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class MenuButtonTapCommand extends StarlingCommand
	{
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.dispatch(new QuestionEvent(QuestionEvent.FINISH_GAME));
			this.dispatch(new ScreenEvent(ScreenEvent.REQUEST_CHANGE, MainMenuScreenMediator.ID));
		}
	}
}