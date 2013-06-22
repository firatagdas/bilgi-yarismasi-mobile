package com.trivia.screen.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.screen.IScreenContext;
	import com.trivia.screen.event.ScreenEvent;
	import com.trivia.screen.model.ScreenModel;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class ChangeScreenRequestCommand extends StarlingCommand
	{
		[Inject]
		public var screenEvent:ScreenEvent;
		
		[Inject]
		public var screenModel:ScreenModel;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			var screenId:String = this.screenEvent.screenId;
			
			this.screenModel.switchScreen(screenId);
			
			this.dispatch(new ScreenEvent(ScreenEvent.CHANGE, screenId));
		}
	}
}