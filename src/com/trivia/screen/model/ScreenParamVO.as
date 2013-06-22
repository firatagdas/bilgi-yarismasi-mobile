package com.trivia.screen.model
{
	public class ScreenParamVO
	{
		public var id:String;
		public var screenClass:Class;
		public var properties:Object;
		public var events:Object;
		
		public function ScreenParamVO(id:String, screenClass:Class, events:Object = null, properties:Object = null)
		{
			this.id = id;
			this.screenClass = screenClass;
			this.events = events;
			this.properties = properties;
		}
	}
}