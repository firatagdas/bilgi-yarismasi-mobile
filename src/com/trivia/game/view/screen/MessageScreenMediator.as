package com.trivia.game.view.screen
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.event.MessageEvent;
	import com.trivia.game.model.GameModel;
	import com.trivia.game.model.MessageModel;
	import com.trivia.game.view.event.MessageScreenEvent;
	import com.trivia.resource.EmbeddedResource;
	import com.trivia.resource.IStyleModel;
	import com.trivia.sound.event.SoundEvent;
	import com.trivia.sound.model.EmbeddedSounds;
	import com.trivia.sound.model.SoundType;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	public class MessageScreenMediator extends StarlingMediator
	{
		public static const ID:String = 'messageScreen';
		
		[Inject]
		public var styleModel:IStyleModel;
		
		[Inject]
		public var messageScreen:MessageScreen;
		
		[Inject]
		public var messageModel:MessageModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		public function MessageScreenMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			this.addViewListener(MessageScreenEvent.NEXT_QUESTION_TAPPED, this.handleNextQuestionTapped);
			this.addViewListener(MessageScreenEvent.FINISH_GAME_TAPPED, this.handleFinishGameTapped);
			this.addViewListener(MessageScreenEvent.SCREEN_READY, this.handleScreenReady);
			
			this.messageScreen.init(this.styleModel);
			
			this.messageScreen.type = this.messageModel.getMessageType();
			this.messageScreen.score = this.gameModel.getCurrentGameData().totalScore;
		}
		
		override public function onRemove():void
		{
			this.removeViewListener(MessageScreenEvent.NEXT_QUESTION_TAPPED, this.handleNextQuestionTapped);
			this.removeViewListener(MessageScreenEvent.FINISH_GAME_TAPPED, this.handleFinishGameTapped);
			this.removeViewListener(MessageScreenEvent.SCREEN_READY, this.handleScreenReady);
		}
		
		protected function handleNextQuestionTapped(e:MessageScreenEvent):void
		{
			this.dispatch(new MessageEvent(MessageEvent.NEXT_QUESTION_TAPPED));
		}
		
		protected function handleFinishGameTapped(e:MessageScreenEvent):void
		{
			this.dispatch(new MessageEvent(MessageEvent.FINISH_GAME_TAPPED));
		}
		
		protected function handleScreenReady(e:MessageScreenEvent):void
		{
			this.dispatch(new SoundEvent(SoundEvent.STOP, SoundType.BACKGROUND));
			
			switch (this.messageModel.getMessageType())
			{
				case MessageEvent.CORRECT_ANSWER:
					this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.SOUND, EmbeddedSounds.CORRECT_ANSWER));
					break;
				case MessageEvent.TIMEOUT:
				case MessageEvent.WRONG_ANSWER:
					this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.SOUND, EmbeddedSounds.FAILED_ANSWER));
					break;
				case MessageEvent.FINISH_GAME:
					this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.SOUND, EmbeddedSounds.WINNED));
					break;
			}
		}
	}
}