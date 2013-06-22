package com.trivia.game.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.view.screen.MessageScreenMediator;
	import com.trivia.game.view.screen.QuestionScreenMediator;
	import com.trivia.screen.event.ScreenEvent;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class NextQuestionTapCommand extends StarlingCommand
	{
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.dispatch(new ScreenEvent(ScreenEvent.REQUEST_CHANGE, QuestionScreenMediator.ID));
		}
	}
}