package com.trivia.mainmenu.view.screen
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.model.GameModel;
	import com.trivia.mainmenu.event.MainMenuEvent;
	import com.trivia.mainmenu.view.event.MainMenuScreenEvent;
	import com.trivia.resource.IStyleModel;
	import com.trivia.sound.event.SoundEvent;
	import com.trivia.sound.model.EmbeddedSounds;
	import com.trivia.sound.model.SoundType;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	public class MainMenuScreenMediator extends StarlingMediator
	{
		public static const ID:String = 'mainMenu';
		
		[Inject]
		public var mainMenuScreen:MainMenuScreen;
		
		[Inject]
		public var resourceModel:IStyleModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		override public function onRegister():void
		{
			this.addViewListener(MainMenuScreenEvent.START_BUTTON_TAP, this.handleStartButtonTap);
			this.addViewListener(MainMenuScreenEvent.SCREEN_READY, this.handleScreenReady);
			
			this.mainMenuScreen.init(this.resourceModel);
		}
		
		override public function onRemove():void
		{
			this.removeViewListener(MainMenuScreenEvent.START_BUTTON_TAP, this.handleStartButtonTap);
			this.removeViewListener(MainMenuScreenEvent.SCREEN_READY, this.handleScreenReady);
		}
		
		protected function handleStartButtonTap(e:MainMenuScreenEvent):void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Start Button tapped.');
			
			this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.EFFECT, EmbeddedSounds.TAP));
			this.dispatch(new MainMenuEvent(MainMenuEvent.START_BUTTON_TAP));
		}
		
		protected function handleScreenReady(e:MainMenuScreenEvent):void
		{
			if (this.gameModel.isGameFinished())
			{
				this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.EFFECT, EmbeddedSounds.GAME_OVER));
			}
		}
	}
}