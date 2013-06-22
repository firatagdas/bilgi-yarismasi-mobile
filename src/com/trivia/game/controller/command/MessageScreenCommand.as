package com.trivia.game.controller.command
{
	import com.trivia.game.event.MessageEvent;
	import com.trivia.game.model.MessageModel;
	import com.trivia.game.view.screen.MessageScreenMediator;
	import com.trivia.screen.event.ScreenEvent;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class MessageScreenCommand extends StarlingCommand
	{
		[Inject]
		public var messageEvent:MessageEvent;
		
		[Inject]
		public var messageModel:MessageModel;
		
		override public function execute():void
		{
			this.messageModel.setMessageType(this.messageEvent.type);
			this.dispatch(new ScreenEvent(ScreenEvent.REQUEST_CHANGE, MessageScreenMediator.ID));
		}
	}
}