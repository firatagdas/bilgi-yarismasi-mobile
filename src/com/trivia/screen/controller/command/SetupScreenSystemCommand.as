package com.trivia.screen.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.screen.event.SetupScreenEvent;
	import com.trivia.screen.model.ScreenModel;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class SetupScreenSystemCommand extends StarlingCommand
	{	
		[Inject]
		public var screenModel:ScreenModel;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.dispatch(new SetupScreenEvent(SetupScreenEvent.LOADED_SCREEN_LIST, this.screenModel.getScreenList()));
		}
	}
}