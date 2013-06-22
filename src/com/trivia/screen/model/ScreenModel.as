package com.trivia.screen.model
{
	import com.trivia.game.view.screen.MessageScreen;
	import com.trivia.game.view.screen.MessageScreenMediator;
	import com.trivia.game.view.screen.QuestionScreen;
	import com.trivia.game.view.screen.QuestionScreenMediator;
	import com.trivia.mainmenu.view.screen.MainMenuScreen;
	import com.trivia.mainmenu.view.screen.MainMenuScreenMediator;
	import com.trivia.screen.IScreenContext;
	
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	public class ScreenModel extends Actor
	{
		protected var _currentScreenId:String;
		
		protected var _screenList:Vector.<ScreenParamVO> = new <ScreenParamVO>[
			new ScreenParamVO(MainMenuScreenMediator.ID, MainMenuScreen),
			new ScreenParamVO(QuestionScreenMediator.ID, QuestionScreen),
			new ScreenParamVO(MessageScreenMediator.ID, MessageScreen)
		];
		
		protected var _screenListMap:Dictionary = new Dictionary();
		
		protected var _defaultScreenId:String = MainMenuScreenMediator.ID;
		
		public function ScreenModel()
		{
			var i:int;
			var len:int = this._screenList.length;
			var screenParam:ScreenParamVO;
			
			for (i = 0; i < len; i++)
			{
				screenParam = this._screenList[i];
				this._screenListMap[screenParam.id] = screenParam;
			}
		}
		
		public function switchScreen(screenId:String):void
		{
			this._currentScreenId = screenId;
		}
		
		public function getCurrentScreenId():String
		{
			return this._currentScreenId;
		}
		
		public function getScreenList():Vector.<ScreenParamVO>
		{
			return this._screenList;
		}
		
		public function getScreenParamById(screenId:String):ScreenParamVO
		{
			return this._screenListMap[screenId];
		}
		
		public function getDefaultScreenId():String
		{
			return this._defaultScreenId;
		}
	}
}