package com.trivia.sound.model
{
	public class EmbeddedSounds
	{
		[Embed(source="../../../../../rsrc/sounds/background.mp3")]
		public static const BACKGROUND:Class;
		
		[Embed(source="../../../../../rsrc/sounds/correct-answer.mp3")]
		public static const CORRECT_ANSWER:Class;
		
		[Embed(source="../../../../../rsrc/sounds/failed-answer.mp3")]
		public static const FAILED_ANSWER:Class;
		
		[Embed(source="../../../../../rsrc/sounds/game-over.mp3")]
		public static const GAME_OVER:Class;
		
		[Embed(source="../../../../../rsrc/sounds/tap.mp3")]
		public static const TAP:Class;
		
		[Embed(source="../../../../../rsrc/sounds/time-running-out.mp3")]
		public static const TIME_RUNNING_OUT:Class;
		
		[Embed(source="../../../../../rsrc/sounds/winned.mp3")]
		public static const WINNED:Class;
	}
}