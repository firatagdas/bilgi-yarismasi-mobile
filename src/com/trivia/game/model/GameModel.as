package com.trivia.game.model
{
	import com.trivia.db.model.DbModel;
	import com.trivia.game.event.GameEvent;
	import com.trivia.game.event.QuestionEvent;
	import com.trivia.game.vo.GameDataVO;
	import com.trivia.game.vo.GameModelDataVO;
	import com.trivia.game.vo.QuestionDataVO;
	
	import org.robotlegs.mvcs.Actor;
	
	public class GameModel extends Actor
	{
		[Inject]
		public var dbModel:DbModel;
		
		protected var _modelData:GameModelDataVO;
		
		public function GameModel()
		{
			this._modelData = new GameModelDataVO();
		}
		
		public function createNewGame(questionCountInGame:int, timeToAnswer:int, scoreOfEachQuestion:int):void
		{
			var gameData:GameDataVO = new GameDataVO();
			gameData.currentQuestionIndex = 0;
			gameData.questionCountInGame = questionCountInGame;
			gameData.timeToAnswer = timeToAnswer;
			gameData.totalScore = 0;
			gameData.questions = this.createRandomQuestionList(questionCountInGame);
			gameData.scoreOfEachQuestion = scoreOfEachQuestion;
			
			this._modelData.gameData = gameData;
			this._modelData.justFinished = false;
		}
		
		public function doCorrectAnswer():void
		{
			var gameData:GameDataVO = this._modelData.gameData;
			var currentIndex:int = gameData.currentQuestionIndex;
			
			gameData.totalScore += gameData.scoreOfEachQuestion;
			if (++currentIndex < gameData.questions.length)
			{
				gameData.currentQuestionIndex = currentIndex;
				this.dispatch(new QuestionEvent(QuestionEvent.POST_CORRECT_ANSWER)); 
			}
			else
			{
				this.dispatch(new GameEvent(GameEvent.FINISH_GAME));	
			}
		}
		
		public function doWrongAnswer():void
		{
			this.dispatch(new QuestionEvent(QuestionEvent.POST_WRONG_ANSWER));
		}
		
		public function finishGame():void
		{
			this._modelData.gameData = null;
			this._modelData.justFinished = true;
		}
		
		public function isGameFinished():Boolean
		{
			return this._modelData.justFinished;
		}
		
		public function getCurrentGameData():GameDataVO
		{
			return this._modelData.gameData;
		}
		
		public function getCurrentQuestionData():QuestionDataVO
		{	
			return this._modelData.gameData.questions[this._modelData.gameData.currentQuestionIndex];
		}
		
		public function addScore(value:int):void
		{
			this._modelData.gameData.totalScore += value;
		}
		
		public function setQuestionIndex(questionIndex:int):void
		{
			this._modelData.gameData.currentQuestionIndex = questionIndex;
		}
		
		protected function createRandomQuestionList(questionCountInGame:int):Vector.<QuestionDataVO>
		{
			var questionList:Vector.<QuestionDataVO> = this.dbModel.fetchQuestionList();
			var i:int;
			var rand:int;
			var randomList:Vector.<QuestionDataVO> = new Vector.<QuestionDataVO>();
			
			if (questionList.length <= questionCountInGame)
			{
				randomList = questionList;
			}
			else
			{
				for (i = 0; i < questionCountInGame; i++)
				{
					rand = Math.random() * 10000 % questionList.length;
					randomList.push(questionList[rand]);
					
					questionList.splice(rand, 1);
				}
			}
			
			return randomList;
		}
	}
}