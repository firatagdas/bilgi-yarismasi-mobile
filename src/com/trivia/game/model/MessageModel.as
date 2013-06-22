package com.trivia.game.model
{
	import org.robotlegs.mvcs.Actor;
	
	public class MessageModel extends Actor
	{
		protected var _messageType:String;
		
		public function MessageModel()
		{
			super();
		}
		
		public function setMessageType(messageType:String):void
		{
			this._messageType = messageType;
		}
		
		public function getMessageType():String
		{
			return this._messageType;
		}
	}
}