package com.trivia.system.controller.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.db.model.DbModel;
	import com.trivia.db.service.DbService;
	import com.trivia.game.vo.QuestionDataVO;
	import com.trivia.screen.event.ScreenEvent;
	import com.trivia.screen.model.ScreenModel;
	import com.trivia.sound.model.SoundModel;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class StartupCommand extends StarlingCommand
	{
		[Inject]
		public var screenModel:ScreenModel;
		
		[Inject]
		public var dbService:DbService;
		
		[Inject]
		public var dbModel:DbModel;
		
		[Inject]
		public var soundModel:SoundModel;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.dbService.connect();
			
			NativeApplication.nativeApplication.addEventListener(Event.DEACTIVATE, this.applicationDeactivateHandler);
			NativeApplication.nativeApplication.addEventListener(Event.ACTIVATE, this.applicationActivateHandler);

			if (CONFIG::migrateMode)
			{
				migrateQuestions();
			}
			else
			{
				this.dispatch(new ScreenEvent(ScreenEvent.REQUEST_CHANGE, screenModel.getDefaultScreenId()));
			}
		}
		
		protected function applicationDeactivateHandler(e:Event):void
		{
			this.soundModel.setMute(true);
		}
		
		protected function applicationActivateHandler(e:Event):void
		{
			this.soundModel.setMute(false);
		}
		
		private function migrateQuestions():void
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest('./redesigned.txt');
			
			loader.dataFormat = 'text/plain';
			
			loader.addEventListener(Event.COMPLETE, this.handleFileLoad);
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.handleError);
			
			loader.load(request);
		}
		
		private function handleFileLoad(e:Event):void
		{
			Console.instance.log(LogType.CHECKPOINT, this, 'File loaded.');

			Console.instance.log(LogType.NOTIFICATION, this, 'Clearing db...');
			this.dbModel.clearQuestions();
			
			var data:String = (e.target as URLLoader).data;
			var lines:Array = data.split('\n');
			var i:int;
			var len:int = lines.length;
			var questionData:QuestionDataVO;
			var options:Array;
			var parts:Array;
			var answer:String;
			var rIndex:int;
			
			for (i = 0; i < len; i++)
			{
				questionData = new QuestionDataVO();
				
				parts = lines[i].split('*');
				options = parts[1].split('|');
				answer = options[0];
				
				questionData.question = parts[0];
				questionData.options = new Vector.<String>();
				
				while (options.length > 1)
				{
					rIndex = Math.random() * 10000 % options.length;
					questionData.options.push(options[rIndex]);
					
					options.splice(rIndex, 1);
				}
				
				questionData.options.push(options.pop());
				
				rIndex = 0;
				for (rIndex = 0; rIndex < questionData.options.length; rIndex++)
				{
					if (answer == questionData.options[rIndex])
					{
						questionData.answer = rIndex;
						break;
					}
				}
				
				this.dbModel.insertQuestion(questionData);
				Console.instance.log(LogType.NOTIFICATION, this, 'Question Inserted: ' + questionData.question);
			}
		}
		
		private function handleError(e:IOErrorEvent):void
		{
			Console.instance.log(LogType.WARNING, this, 'File could not loaded: ' + e.text);
		}
	}
}