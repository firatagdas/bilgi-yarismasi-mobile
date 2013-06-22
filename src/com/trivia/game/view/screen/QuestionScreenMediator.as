package com.trivia.game.view.screen
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.event.GameEvent;
	import com.trivia.game.event.MessageEvent;
	import com.trivia.game.event.QuestionEvent;
	import com.trivia.game.model.GameModel;
	import com.trivia.game.view.event.QuestionScreenEvent;
	import com.trivia.game.vo.GameDataVO;
	import com.trivia.game.vo.QuestionDataVO;
	import com.trivia.resource.EmbeddedResource;
	import com.trivia.resource.IStyleModel;
	import com.trivia.sound.event.SoundEffectExposeEvent;
	import com.trivia.sound.event.SoundEvent;
	import com.trivia.sound.model.EmbeddedSounds;
	import com.trivia.sound.model.SoundType;
	
	import org.robotlegs.mvcs.StarlingMediator;
	
	import starling.textures.TextureAtlas;
	
	public class QuestionScreenMediator extends StarlingMediator
	{
		public static const ID:String = 'questionScreen';
		
		[Inject]
		public var styleModel:IStyleModel;
		
		[Inject]
		public var gameModel:GameModel;
		
		[Inject]
		public var questionScreen:QuestionScreen;
		
		override public function onRegister():void
		{
			this.addViewListener(QuestionScreenEvent.TIMEOUT, this.handleTimeout);
			this.addViewListener(QuestionScreenEvent.MENU_BUTTON_TAP, this.handleMenuButtonTap);
			this.addViewListener(QuestionScreenEvent.OPTION_BUTTON_TAP, this.handleOptionButtonTap);
			this.addViewListener(QuestionScreenEvent.SCREEN_READY, this.handleScreenReady);
			this.addViewListener(QuestionScreenEvent.HALF_TIME, this.handleHalfTime);
			
			this.questionScreen.init(this.styleModel);
			
			var gameData:GameDataVO = this.gameModel.getCurrentGameData();
			var questionData:QuestionDataVO = this.gameModel.getCurrentQuestionData();
			
			this.questionScreen.question = questionData.question;
			this.questionScreen.questionNumber = gameData.currentQuestionIndex + 1;
			this.questionScreen.questionTotal = gameData.questions.length;
			this.questionScreen.options = questionData.options;
			this.questionScreen.score = gameData.totalScore;
			this.questionScreen.timerCount = gameData.timeToAnswer;
		}
		
		override public function onRemove():void
		{
			this.removeViewListener(QuestionScreenEvent.TIMEOUT, this.handleTimeout);
			this.removeViewListener(QuestionScreenEvent.MENU_BUTTON_TAP, this.handleMenuButtonTap);
			this.removeViewListener(QuestionScreenEvent.OPTION_BUTTON_TAP, this.handleOptionButtonTap);
			this.removeViewListener(QuestionScreenEvent.SCREEN_READY, this.handleScreenReady);
			this.removeViewListener(QuestionScreenEvent.HALF_TIME, this.handleHalfTime);
		}
		
		protected function handleTimeout(e:QuestionScreenEvent):void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Timeout!.');
			
			this.dispatch(new MessageEvent(MessageEvent.TIMEOUT));
		}
		
		protected function handleHalfTime(e:QuestionScreenEvent):void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'Half time!.');
			this.dispatch(new SoundEffectExposeEvent(SoundEffectExposeEvent.EXPOSE, SoundType.BACKGROUND, EmbeddedSounds.TIME_RUNNING_OUT));
		}
		
		protected function handleMenuButtonTap(e:QuestionScreenEvent):void
		{
			this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.EFFECT, EmbeddedSounds.TAP));
			
			this.dispatch(new QuestionEvent(QuestionEvent.MENU_BUTTON_TAP));
		}
		
		protected function handleOptionButtonTap(e:QuestionScreenEvent):void
		{
			this.dispatch(new SoundEvent(SoundEvent.STOP, SoundType.EFFECT));
			this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.EFFECT, EmbeddedSounds.TAP));
			this.dispatch(new QuestionEvent(QuestionEvent.OPTION_BUTTON_TAP, e.answerIndex));
		}
		
		protected function handleScreenReady(e:QuestionScreenEvent):void
		{
			this.dispatch(new SoundEvent(SoundEvent.STOP, SoundType.SOUND));
			this.dispatch(new SoundEvent(SoundEvent.PLAY, SoundType.BACKGROUND, EmbeddedSounds.BACKGROUND));
		}
	}
}