package com.trivia.db.model
{
	import com.trivia.db.service.DbService;
	import com.trivia.game.vo.QuestionDataVO;
	
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DbModel extends Actor
	{
		[Inject]
		public var dbService:DbService;
		
		protected var _classAliasses:Vector.<Class> = new <Class>[
			QuestionDataVO,
			String
		];
		
		public function DbModel()
		{
			super();
			this.registerClassAliasses();
		}
		
		public function fetchQuestionList():Vector.<QuestionDataVO>
		{
			var questionList:Vector.<QuestionDataVO> = new Vector.<QuestionDataVO>();
			var data:Array = this.dbService.query(DbQueryList.SELECT_QUESTIONS);
			
			if (data != null)
			{
				var i:int;
				var len:int = data.length;
				var questionData:QuestionDataVO;
				
				for (i = 0; i < len; i++)
				{
					questionData = data[i].question;
					questionData.questionId = data[i].id;
					questionList.push(questionData);
				}
			}
			
			return questionList;
		}
		
		public function insertQuestion(question:QuestionDataVO):void
		{
			this.dbService.query(DbQueryList.INSERT_QUESTION, {
				':question': question
			});
		}

		public function clearQuestions():void
		{
			this.dbService.query(DbQueryList.CLEAR_QUESTIONS);
		}
		
		protected function registerClassAliasses():void
		{
			var i:int;
			var len:int = this._classAliasses.length;
			var classIdentifier:Class;
			var className:String; 
			
			for (i = 0; i < len; i++)
			{
				classIdentifier = this._classAliasses[i] as Class;
				className = getQualifiedClassName(classIdentifier);
				className = className.split('::').pop();
				
				registerClassAlias(className, classIdentifier);
			}
		}
	}
}