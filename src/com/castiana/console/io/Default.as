package com.castiana.console.io
{
	public class Default implements IConsoleAdapter
	{
		public function write(text:String):void
		{
			trace(text);
		}
	}
}