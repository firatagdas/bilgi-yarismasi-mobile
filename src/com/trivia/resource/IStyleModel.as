package com.trivia.resource
{
	import feathers.controls.text.TextFieldTextRenderer;
	
	import flash.text.TextFormat;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public interface IStyleModel
	{
		function getTexture(textureName:String):Texture;
		
		function getAtlas(textureName:String):TextureAtlas;
		
		function get headerTextFormat():TextFormat;
		
		function get timerTextFormat():TextFormat;
		
		function get timerCountFormat():TextFormat;
		
		function get questionTextFormat():TextFormat;
		
		function get optionTextFormat():TextFormat;
		
		function get messageTextFormat():TextFormat;
		
		function get scoreTextFormat():TextFormat;
		
		function get finishButtonTextFormat():TextFormat;
		
		function get primaryColor():uint;
		
		function get secondaryColor():uint;
		
		function get tertiaryColor():uint;
		
		function get quarternaryColor():uint;
		
		function get primaryFont():String;
		
		function get secondaryFont():String;
		
		function labelFactory():TextFieldTextRenderer;
	}
}