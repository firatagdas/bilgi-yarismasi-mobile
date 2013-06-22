 package com.trivia.screen.view.screen
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.screen.event.ScreenEvent;
	import com.trivia.screen.event.SetupScreenEvent;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	import starling.events.Event;
	
	public class CanvasMediator extends StarlingMediator
	{
		[Inject]
		public var canvas:Canvas;
		
		override public function onRegister():void
		{
			this.addContextListener(SetupScreenEvent.LOADED_SCREEN_LIST, this.handleLoadScreenList, SetupScreenEvent);
			this.addContextListener(ScreenEvent.CHANGE, this.handleChange, ScreenEvent);
			
			this.canvas.init();
			
			this.dispatch(new ScreenEvent(ScreenEvent.STARTUP_COMPLETE));
		}
		
		override public function onRemove():void
		{
			this.removeContextListener(SetupScreenEvent.LOADED_SCREEN_LIST, this.handleLoadScreenList, SetupScreenEvent);
			this.removeContextListener(ScreenEvent.CHANGE, this.handleChange, ScreenEvent);
		}
		
		protected function handleChange(e:ScreenEvent):void
		{
			Console.instance.log(LogType.NOTIFICATION, this, 'Changing screen.');
			this.canvas.screenId = e.screenId;
		}
		
		protected function handleLoadScreenList(e:SetupScreenEvent):void
		{
			Console.instance.log(LogType.NOTIFICATION, this, 'Main screen loaded screen list.');
			this.canvas.screenList = e.screenList;
			
			this.dispatch(new SetupScreenEvent(SetupScreenEvent.SETUP_SCREEN_COMPLETE));
		}
	}
}