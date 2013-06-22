package com.trivia.sound.command
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.sound.event.SoundEvent;
	import com.trivia.sound.model.SoundModel;
	
	import org.robotlegs.mvcs.StarlingCommand;
	
	public class StopAllSoundCommand extends StarlingCommand
	{
		[Inject]
		public var soundModel:SoundModel;
		
		[Inject]
		public var soundEvent:SoundEvent;
		
		override public function execute():void
		{
			Console.instance.log(LogType.COMMAND, this);
			
			this.soundModel.stopAll();
		}
	}
}