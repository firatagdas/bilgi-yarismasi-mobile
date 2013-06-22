package com.trivia.system.view
{
	import com.trivia.screen.event.ScreenEvent;
	import com.trivia.screen.view.screen.Canvas;
	import com.trivia.system.BootstrapContext;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StarlingStage extends Sprite
	{
		protected var _bootstrap:BootstrapContext;
		
		public function StarlingStage()
		{
			super();
			
			_bootstrap = new BootstrapContext(this);
			
			this.addEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
		}
		
		protected function handleAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, this.handleAddedToStage);
			
			var canvas:Canvas = new Canvas();
			this.addChild(canvas);
		}
	}
}