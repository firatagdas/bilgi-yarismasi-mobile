package com.trivia.sound.model
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.plugins.VolumePlugin;
	import com.trivia.sound.vo.SoundModelDataVO;
	
	import flash.events.Event;
	import flash.media.AudioPlaybackMode;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	public class SoundModel extends Actor
	{
		protected var _modelData:SoundModelDataVO;
		
		protected var _soundDictionary:Dictionary;
		
		public function SoundModel()
		{
			this._modelData = new SoundModelDataVO();
			this._soundDictionary = new Dictionary();
			
			SoundMixer.audioPlaybackMode = AudioPlaybackMode.AMBIENT;
			TweenPlugin.activate([VolumePlugin]);
			
			this.setVolume(60);
		}
		
		public function setVolume(volume:int):void
		{
			this._modelData.volume = this.convertToVolume(volume);
		}
		
		public function getVolume():int
		{
			return this.convertFromVoluem(this._modelData.volume);
		}
		
		public function setMute(value:Boolean):void
		{
			if (value)
			{
				if (!this._modelData.isMuted)
				{
					SoundMixer.soundTransform = new SoundTransform(0);
					this._modelData.isMuted = true;
				}
			}
			else if (this._modelData.isMuted)
			{
				SoundMixer.soundTransform = new SoundTransform(1);
				this._modelData.isMuted = false;
			}
		}
		
		public function play(soundClass:Class, type:String, onComplete:Function = null):void
		{
			this.remove(type);
			
			var soundInfo:SoundInfo = new SoundInfo();
			soundInfo.sound = new soundClass();
			soundInfo.soundClass = soundClass;
			soundInfo.state = SoundState.PLAYING;
			soundInfo.transform = new SoundTransform(this._modelData.volume);
			soundInfo.loops = SoundType.BACKGROUND == type ? 9999 : 1;
			soundInfo.position = 0;
			soundInfo.channel = soundInfo.sound.play(0, soundInfo.loops, soundInfo.transform);
			
			if (onComplete != null)
			{
				soundInfo.channel.addEventListener(Event.SOUND_COMPLETE, onComplete, false, 0, true);
			}
			
			this._soundDictionary[type] = soundInfo;
		}
		
		public function pause(type:String):void
		{
			if (!this._soundDictionary.hasOwnProperty(type))
			{
				return;
			}

			var soundInfo:SoundInfo = this._soundDictionary[type];
			if (soundInfo.state == SoundState.PLAYING)
			{
				soundInfo.position = soundInfo.channel.position;
				soundInfo.channel.stop();
				
				soundInfo.state = SoundState.PAUSED;
			}
		}
		
		public function pauseWithFadeOut(type:String, onFadeOutComplete:Function = null):void
		{
			if (!this._soundDictionary.hasOwnProperty(type))
			{
				return;
			}
			
			var soundInfo:SoundInfo = this._soundDictionary[type];
			if (soundInfo.state == SoundState.PLAYING)
			{
				soundInfo.position = soundInfo.channel.position;
				soundInfo.state = SoundState.IS_IN_PROGRESS;
				
				var onComplete:Function = this.bindFn(this.handleCompleteFadeOut, [ soundInfo, onFadeOutComplete ]);
				TweenLite.to(soundInfo.transform, 0.7, { volume: 0, onComplete: onComplete });
			}
		}
		
		public function resume(type:String):void
		{
			if (!this._soundDictionary.hasOwnProperty(type))
			{
				return;
			}
			
			var soundInfo:SoundInfo = this._soundDictionary[type];
			if (soundInfo.state == SoundState.PAUSED || soundInfo.state == SoundState.STOPPED)
			{
				soundInfo.channel = null;
				soundInfo.channel = soundInfo.sound.play(soundInfo.position, soundInfo.loops, soundInfo.transform);
				
				soundInfo.state = SoundState.PLAYING;
			}
		}
		
		public function resumeWithFadeIn(type:String, onFadeInComplete:Function = null):void
		{
			if (!this._soundDictionary.hasOwnProperty(type))
			{
				return;
			}
			
			var soundInfo:SoundInfo = this._soundDictionary[type];
			if (soundInfo.state == SoundState.PAUSED || soundInfo.state == SoundState.STOPPED)
			{
				soundInfo.channel = null;
				soundInfo.transform.volume = 0;
				soundInfo.channel = soundInfo.sound.play(soundInfo.position, soundInfo.loops, soundInfo.transform);
				
				soundInfo.state = SoundState.IS_IN_PROGRESS;
				
				var onComplete:Function = this.bindFn(this.handleCompleteFadeIn, [ soundInfo, onFadeInComplete ]);
				TweenLite.to(soundInfo.transform, 0.7, { volume: this._modelData.volume, onComplete: onComplete });
			}
		}
		
		public function stop(type:String):void
		{
			if (!this._soundDictionary.hasOwnProperty(type))
			{
				return;
			}
			
			var soundInfo:SoundInfo = this._soundDictionary[type];
			if (soundInfo.state == SoundState.PLAYING)
			{
				TweenLite.killTweensOf(soundInfo.transform);

				soundInfo.channel.stop();
				soundInfo.transform.volume = this._modelData.volume;
				soundInfo.state = SoundState.STOPPED;
			}
		}
		
		public function playWithExpose(pauseSoundType:String, exposeSoundClass:Class):void
		{
			this.pauseWithFadeOut(pauseSoundType, this.bindFn(this.handleFadeOutComplete, [ pauseSoundType, exposeSoundClass ]));
		}
		
		protected function handleFadeOutComplete(pauseSoundType:String, soundClass:Class):void
		{
			this.play(soundClass, SoundType.EFFECT, this.bindFn(this.handlePlayComplete, [ pauseSoundType ]));
		}
		
		protected function handlePlayComplete(soundType:String):void
		{
			this.resumeWithFadeIn(soundType);
		}
		
		public function remove(type:String):void
		{
			if (!this._soundDictionary.hasOwnProperty(type))
			{
				return;
			}
			
			var soundInfo:SoundInfo = this._soundDictionary[type];
			if (soundInfo.state == SoundState.PLAYING)
			{
				soundInfo.channel.stop();
			}
			
			this._soundDictionary[type] = null;
			delete this._soundDictionary[type];
		}
		
		public function stopAll():void
		{
			for (var i:String in this._soundDictionary)
			{
				this.stop(i);
			}
		}
		
		protected function convertToVolume(value:int):Number
		{
			return value / 100;
		}
		
		protected function convertFromVoluem(volume:Number):int
		{
			return volume * 100 >> 0;
		}
		
		protected function bindFn(callback:Function, args:Array):Function
		{
			var self:SoundModel;
			return function():void
			{
				callback.apply(self, args);
			};
		}
		
		protected function handleCompleteFadeIn(soundInfo:SoundInfo, onFadeInComplete:Function):void
		{
			soundInfo.state = SoundState.PLAYING;
			
			if (onFadeInComplete != null)
			{
				onFadeInComplete.call(this, soundInfo);
			}
		}
		
		protected function handleCompleteFadeOut(soundInfo:SoundInfo, onFadeOutComplete:Function):void
		{
			soundInfo.channel.stop();
			soundInfo.state = SoundState.PAUSED;
			
			if (onFadeOutComplete != null)
			{
				onFadeOutComplete.call(this, soundInfo);
			}
		}
	}
}