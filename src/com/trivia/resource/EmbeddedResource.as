package com.trivia.resource
{
	public class EmbeddedResource
	{	
		[Embed(source="../../../../rsrc/atlasses/game.png", mimeType="image/png")]
		public static const GAME:Class;
		
		[Embed(source="../../../../rsrc/atlasses/game.xml", mimeType="application/octet-stream")]
		public static const GAME_XML:Class;
		
		[Embed(source="../../../../rsrc/fonts/frhnd.ttf", embedAsCFF="false", fontFamily="Freehand521 BT")]
		public static const PRIMARY_FONT:Class;
		
		[Embed(source="../../../../rsrc/fonts/tt.ttf", embedAsCFF="false", fontFamily="Secondary")]
		public static const SECONDARY_FONT:Class;
	}
}