package com.trivia.sound.event
{
	import com.trivia.sound.model.SoundType;
	
	import flash.events.Event;
	
	public class SoundEvent extends Event
	{
		public static const PLAY:String = 'play';
		public static const STOP:String = 'stop';
		public static const STOP_ALL:String = 'stopAll';
		
		protected var _soundType:String;
		protected var _soundClass:Class;
		
		public function SoundEvent(type:String, soundType:String = null, soundClass:Class = null)
		{
			super(type);
			
			this._soundType = soundType;
			this._soundClass = soundClass;
		}
		
		public function get soundType():String
		{
			return this._soundType;
		}
		
		public function get soundClass():Class
		{
			return this._soundClass;
		}
		
		override public function clone():Event
		{
			return new SoundEvent(this.type, this._soundType, this._soundClass);
		}
	}
}