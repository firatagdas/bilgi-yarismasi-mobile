package com.trivia.sound.model
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class SoundInfo
	{
		public var soundClass:Class;
		public var sound:Sound;
		public var position:int;
		public var loops:int;
		public var type:String;
		public var state:String;
		public var channel:SoundChannel;
		public var transform:SoundTransform;
	}
}