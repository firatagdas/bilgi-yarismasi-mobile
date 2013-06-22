package com.trivia.game.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.game.event.MessageEvent;
	import com.trivia.game.event.QuestionEvent;
	import com.trivia.game.model.GameModel;
	import com.trivia.game.vo.GameDataVO;
	import com.trivia.game.vo.QuestionDataVO;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class OptionButtonTapCommand extends StarlingCommand
	{
		[Inject]
		public var questionEvent:QuestionEvent;
		
		[Inject]
		public var gameModel:GameModel;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			var gameData:GameDataVO = this.gameModel.getCurrentGameData();
			var currentQuestion:QuestionDataVO = this.gameModel.getCurrentQuestionData();
			
			if (currentQuestion.answer == this.questionEvent.answerIndex)
			{
				Console.instance.log(LogType.CHECKPOINT, this, 'Correct answer!');
				
				this.gameModel.addScore(gameData.scoreOfEachQuestion);
				
				var currentIndex:int = gameData.currentQuestionIndex;
				if (++currentIndex < gameData.questions.length)
				{
					this.gameModel.setQuestionIndex(currentIndex);
					this.dispatch(new MessageEvent(MessageEvent.CORRECT_ANSWER));
				}
				else
				{
					this.dispatch(new MessageEvent(MessageEvent.FINISH_GAME));
				}
			}
			else
			{
				Console.instance.log(LogType.CHECKPOINT, this, 'Wrong answer. Correct answer is ' + currentQuestion.answer + '.');
				
				this.dispatch(new MessageEvent(MessageEvent.WRONG_ANSWER));
			}
		}
	}
}