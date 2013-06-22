package com.trivia.system
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.db.model.DbModel;
	import com.trivia.db.service.DbService;
	import com.trivia.game.controller.command.FinishGameCommand;
	import com.trivia.game.controller.command.FinishGameTapCommand;
	import com.trivia.game.controller.command.MenuButtonTapCommand;
	import com.trivia.game.controller.command.MessageScreenCommand;
	import com.trivia.game.controller.command.NextQuestionTapCommand;
	import com.trivia.game.controller.command.OptionButtonTapCommand;
	import com.trivia.game.controller.command.StartGameCommand;
	import com.trivia.game.event.GameEvent;
	import com.trivia.game.event.MessageEvent;
	import com.trivia.game.event.QuestionEvent;
	import com.trivia.game.model.GameModel;
	import com.trivia.game.model.MessageModel;
	import com.trivia.game.view.event.MessageScreenEvent;
	import com.trivia.game.view.screen.MessageScreen;
	import com.trivia.game.view.screen.MessageScreenMediator;
	import com.trivia.game.view.screen.QuestionScreen;
	import com.trivia.game.view.screen.QuestionScreenMediator;
	import com.trivia.mainmenu.controller.command.StartButtonTapCommand;
	import com.trivia.mainmenu.event.MainMenuEvent;
	import com.trivia.mainmenu.view.event.MainMenuScreenEvent;
	import com.trivia.mainmenu.view.screen.MainMenuScreen;
	import com.trivia.mainmenu.view.screen.MainMenuScreenMediator;
	import com.trivia.resource.IStyleModel;
	import com.trivia.resource.StyleModel;
	import com.trivia.screen.controller.command.ChangeScreenRequestCommand;
	import com.trivia.screen.controller.command.SetupScreenSystemCommand;
	import com.trivia.screen.event.ScreenEvent;
	import com.trivia.screen.event.SetupScreenEvent;
	import com.trivia.screen.model.ScreenModel;
	import com.trivia.screen.view.screen.Canvas;
	import com.trivia.screen.view.screen.CanvasMediator;
	import com.trivia.sound.command.PlaySoundCommand;
	import com.trivia.sound.command.PlaySoundWithExposeCommand;
	import com.trivia.sound.command.StopAllSoundCommand;
	import com.trivia.sound.command.StopSoundCommand;
	import com.trivia.sound.event.SoundEffectExposeEvent;
	import com.trivia.sound.event.SoundEvent;
	import com.trivia.sound.model.SoundModel;
	import com.trivia.system.controller.command.StartupCommand;
	import com.trivia.system.view.StageMediator;
	import com.trivia.system.view.StarlingStage;
	
	import org.robotlegs.mvcs.StarlingContext;
	
	import starling.display.DisplayObjectContainer;
	
	public class BootstrapContext extends StarlingContext
	{
		public function BootstrapContext(contextView:DisplayObjectContainer, autoStartup:Boolean = true)
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void
		{
			this.mapMediators();
			this.mapInjectors();
			this.mapCommands();
		
			super.startup();
		}
		
		override public function shutdown():void
		{
			this.unmapMediators();
			this.unmapInjectors();
			this.unmapCommands();
			
			super.shutdown();
		}
		
		private function mapMediators():void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Mapping Mediators...');
			
			this.mediatorMap.mapView(StarlingStage, StageMediator);
			this.mediatorMap.mapView(Canvas, CanvasMediator);
			this.mediatorMap.mapView(MainMenuScreen, MainMenuScreenMediator);
			this.mediatorMap.mapView(QuestionScreen, QuestionScreenMediator);
			this.mediatorMap.mapView(MessageScreen, MessageScreenMediator);
		}
		
		private function unmapMediators():void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Unmapping Mediators...');
			
			this.mediatorMap.unmapView(StarlingStage);
			this.mediatorMap.unmapView(Canvas);
			this.mediatorMap.unmapView(MainMenuScreen);
			this.mediatorMap.unmapView(QuestionScreen);
			this.mediatorMap.unmapView(MessageScreen);
		}
		
		private function mapInjectors():void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Mapping Injectors...');
			
			this.injector.mapSingleton(DbService);
			this.injector.mapSingleton(ScreenModel);
			this.injector.mapSingleton(DbModel);
			this.injector.mapSingletonOf(IStyleModel, StyleModel);
			this.injector.mapSingleton(Config);
			this.injector.mapSingleton(GameModel);
			this.injector.mapSingleton(MessageModel);
			this.injector.mapSingleton(SoundModel);
		}
		
		private function unmapInjectors():void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Unmapping Injectors...');
			
			this.injector.unmap(DbService);
			this.injector.unmap(ScreenModel);
			this.injector.unmap(DbModel);
			this.injector.unmap(IStyleModel);
			this.injector.unmap(Config);
			this.injector.unmap(GameModel);
			this.injector.unmap(MessageModel);
			this.injector.unmap(SoundModel);
		}
		
		private function mapCommands():void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Mapping Commands...');
			
			this.commandMap.mapEvent(ScreenEvent.STARTUP_COMPLETE, SetupScreenSystemCommand, ScreenEvent);
			this.commandMap.mapEvent(ScreenEvent.REQUEST_CHANGE, ChangeScreenRequestCommand, ScreenEvent);
			this.commandMap.mapEvent(SetupScreenEvent.SETUP_SCREEN_COMPLETE, StartupCommand, SetupScreenEvent);
			this.commandMap.mapEvent(MainMenuEvent.START_BUTTON_TAP, StartButtonTapCommand);
			this.commandMap.mapEvent(GameEvent.CREATE_NEW_GAME, StartGameCommand);
			this.commandMap.mapEvent(QuestionEvent.OPTION_BUTTON_TAP, OptionButtonTapCommand);
			
			this.commandMap.mapEvent(MessageEvent.CORRECT_ANSWER, MessageScreenCommand);
			this.commandMap.mapEvent(MessageEvent.FINISH_GAME, MessageScreenCommand);
			this.commandMap.mapEvent(MessageEvent.TIMEOUT, MessageScreenCommand);
			this.commandMap.mapEvent(MessageEvent.WRONG_ANSWER, MessageScreenCommand);
			
			this.commandMap.mapEvent(MessageEvent.NEXT_QUESTION_TAPPED, NextQuestionTapCommand);
			this.commandMap.mapEvent(MessageEvent.FINISH_GAME_TAPPED, FinishGameTapCommand);
			
			this.commandMap.mapEvent(QuestionEvent.MENU_BUTTON_TAP, MenuButtonTapCommand);
			this.commandMap.mapEvent(QuestionEvent.FINISH_GAME, FinishGameCommand);
			
			this.commandMap.mapEvent(SoundEvent.PLAY, PlaySoundCommand);
			this.commandMap.mapEvent(SoundEvent.STOP, StopSoundCommand);
			this.commandMap.mapEvent(SoundEvent.STOP_ALL, StopAllSoundCommand);
			this.commandMap.mapEvent(SoundEffectExposeEvent.EXPOSE, PlaySoundWithExposeCommand);
		}
		
		private function unmapCommands():void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Unmapping Commands...');
			
			this.commandMap.unmapEvent(ScreenEvent.STARTUP_COMPLETE, SetupScreenSystemCommand, ScreenEvent);
			this.commandMap.unmapEvent(ScreenEvent.REQUEST_CHANGE, ChangeScreenRequestCommand, ScreenEvent);
			this.commandMap.unmapEvent(SetupScreenEvent.SETUP_SCREEN_COMPLETE, StartupCommand, SetupScreenEvent);
			this.commandMap.unmapEvent(MainMenuEvent.START_BUTTON_TAP, StartButtonTapCommand);
			this.commandMap.unmapEvent(GameEvent.CREATE_NEW_GAME, StartGameCommand);
			this.commandMap.unmapEvent(QuestionEvent.OPTION_BUTTON_TAP, OptionButtonTapCommand);
			
			this.commandMap.unmapEvent(MessageEvent.CORRECT_ANSWER, MessageScreenCommand);
			this.commandMap.unmapEvent(MessageEvent.FINISH_GAME, MessageScreenCommand);
			this.commandMap.unmapEvent(MessageEvent.TIMEOUT, MessageScreenCommand);
			this.commandMap.unmapEvent(MessageEvent.WRONG_ANSWER, MessageScreenCommand);
			
			this.commandMap.unmapEvent(MessageEvent.NEXT_QUESTION_TAPPED, NextQuestionTapCommand);
			this.commandMap.unmapEvent(MessageEvent.FINISH_GAME_TAPPED, FinishGameTapCommand);
			
			this.commandMap.unmapEvent(QuestionEvent.MENU_BUTTON_TAP, MenuButtonTapCommand);
			this.commandMap.unmapEvent(QuestionEvent.FINISH_GAME, FinishGameCommand);
			
			this.commandMap.unmapEvent(SoundEvent.PLAY, PlaySoundCommand);
			this.commandMap.unmapEvent(SoundEvent.STOP, StopSoundCommand);
			this.commandMap.unmapEvent(SoundEvent.STOP_ALL, StopAllSoundCommand);
			this.commandMap.unmapEvent(SoundEffectExposeEvent.EXPOSE, PlaySoundWithExposeCommand);
		}
	}
}