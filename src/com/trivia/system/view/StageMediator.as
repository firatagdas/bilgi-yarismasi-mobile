package com.trivia.system.view
{
	
	import com.trivia.screen.event.ScreenEvent;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	public class StageMediator extends StarlingMediator
	{
		[Inject]
		public var stageView:StarlingStage;
		
		override public function onRegister():void
		{
			this.dispatch(new ScreenEvent(ScreenEvent.STARTUP_COMPLETE));
		}
	}
}