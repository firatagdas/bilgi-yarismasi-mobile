package com.trivia.sound.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.sound.event.SoundEffectExposeEvent;
	import com.trivia.sound.event.SoundEvent;
	import com.trivia.sound.model.SoundInfo;
	import com.trivia.sound.model.SoundModel;
	import com.trivia.sound.model.SoundType;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class PlaySoundWithExposeCommand extends StarlingCommand
	{
		[Inject]
		public var soundModel:SoundModel;
		
		[Inject]
		public var soundEffectExposeEvent:SoundEffectExposeEvent;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.soundModel.playWithExpose(this.soundEffectExposeEvent.soundType, this.soundEffectExposeEvent.soundClass); 
		}
	}
}