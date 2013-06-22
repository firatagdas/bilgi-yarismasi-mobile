package com.trivia.sound.event
{
	import flash.events.Event;
	
	public class SoundEffectExposeEvent extends Event
	{
		public static const EXPOSE:String = 'soundExpose';
		
		protected var _soundType:String;
		protected var _soundClass:Class;
		
		public function SoundEffectExposeEvent(type:String, soundType:String, soundClass:Class)
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
			return new SoundEffectExposeEvent(this.type, this._soundType, this._soundClass);
		}
	}
}