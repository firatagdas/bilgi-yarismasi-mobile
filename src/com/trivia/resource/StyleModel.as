package com.trivia.resource
{
	import feathers.controls.text.TextFieldTextRenderer;
	
	import flash.display.Bitmap;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import org.robotlegs.mvcs.Actor;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class StyleModel extends Actor implements IStyleModel
	{
		protected var _textureCacheDictionary:Dictionary = new Dictionary();
		
		public function StyleModel()
		{
			super();
		}
		
		public function get headerTextFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 25, this.secondaryColor, true);
		}
		
		public function get timerTextFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 35, this.secondaryColor, true);
		}
		
		public function get timerCountFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 43, this.tertiaryColor, true);
		}
		
		public function get questionTextFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 30, this.secondaryColor, true);
		}
		
		public function get optionTextFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 30, this.tertiaryColor, true);
		}
		
		public function get messageTextFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 37, this.quarternaryColor, true); 
		}
		
		public function get scoreTextFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 27, this.secondaryColor, true);
		}
		
		public function get finishButtonTextFormat():TextFormat
		{
			return new TextFormat(this.primaryFont, 26, this.secondaryColor, true);
		}
		
		public function get primaryColor():uint
		{
			return 0x000000;
		}
		
		public function get secondaryColor():uint
		{
			return 0x613700;
		}
		
		public function get tertiaryColor():uint
		{
			return 0xFFFFFF;
		}
		
		public function get quarternaryColor():uint
		{
			return 0x107802;
		}
		
		public function get primaryFont():String
		{
			return 'Freehand521 BT';
		}
		
		public function get secondaryFont():String
		{
			return '';
		}
		
		public function labelFactory():TextFieldTextRenderer
		{
			var renderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			renderer.embedFonts = true;
			
			return renderer;
		}
		
		public function getTexture(textureName:String):Texture
		{
			if (!_textureCacheDictionary.hasOwnProperty(textureName))
			{
				_textureCacheDictionary[textureName] = Texture.fromBitmap((new EmbeddedResource[textureName]() as Bitmap));
			}
			
			return _textureCacheDictionary[textureName];
		}
		
		public function getAtlas(textureName:String):TextureAtlas
		{
			return new TextureAtlas(getTexture(textureName), new XML((new EmbeddedResource[textureName + '_XML']())));
		}
	}
}