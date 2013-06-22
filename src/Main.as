package
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.system.view.StarlingStage;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import starling.core.Starling;

	[SWF(frameRate="60", backgroundColor="#000000", width="640", height="960")]
	public class Main extends Sprite
	{
		protected var _starling:Starling;
		
		public function Main()
		{
			super();
			
			if (this.stage)
			{
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
			}
			
			this.mouseEnabled = this.mouseChildren = false;
			this.loaderInfo.addEventListener(Event.COMPLETE, this.handleLoaderInfoComplete);
		}
		
		private function handleLoaderInfoComplete(e:Event):void
		{
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			
			var canvasRect:Rectangle = new Rectangle(0, 0, this.stage.fullScreenWidth, this.stage.fullScreenHeight);
			
			this._starling = new Starling(StarlingStage, this.stage, canvasRect);
			this._starling.stage.stageWidth = 320;
			this._starling.stage.stageHeight = 480;
			this._starling.simulateMultitouch = true;
			this._starling.antiAliasing = 1;
			this._starling.enableErrorChecking = false;
			this._starling.start();
			
			CONFIG::debugMode
			{
				this._starling.showStatsAt('right');
			}
			
			this.stage.addEventListener(Event.RESIZE, handleStageResize, false, int.MAX_VALUE, true);
			this.stage.addEventListener(Event.ACTIVATE, handleStageActivate, false, 0, true);
			this.stage.addEventListener(Event.DEACTIVATE, handleStageDeactivate, false, 0, true);
			
			Console.instance.log(LogType.NOTIFICATION, this, 'Starling started.');
		}
		
		private function handleStageResize(e:Event):void
		{
			Console.instance.log(LogType.NOTIFICATION, this, 'Stage resized.');
		}
		
		private function handleStageDeactivate(event:Event):void
		{
			this._starling.stop();
			this.stage.addEventListener(Event.ACTIVATE, handleStageActivate, false, 0, true);
			
			Console.instance.log(LogType.NOTIFICATION, this, 'Stage deactivated.');
		}
		
		private function handleStageActivate(event:Event):void
		{	
			this.stage.removeEventListener(Event.ACTIVATE, handleStageActivate);
			this._starling.start();
			
			Console.instance.log(LogType.NOTIFICATION, this, 'Stage activated.');
		}
	}
}