package com.trivia.game.vo
{
	public class GameDataVO
	{
		public var questions:Vector.<QuestionDataVO>;
		public var currentQuestionIndex:int;
		public var totalScore:int;
		public var questionCountInGame:int;
		public var timeToAnswer:int;
		public var scoreOfEachQuestion:int;
	}
}