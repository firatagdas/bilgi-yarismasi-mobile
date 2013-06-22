package com.castiana.console
{
	import avmplus.getQualifiedClassName;
	
	import com.castiana.console.io.Default;
	import com.castiana.console.io.IConsoleAdapter;
	import com.castiana.util.StringUtil;

	public class Console
	{
		protected static var _instance:Console;
		
		protected var adapter:IConsoleAdapter;
		
		public function Console()
		{
			if (_instance == null)
			{
				_instance = this;
			}

			this.setAdapter(new Default());
		}
		
		public function setAdapter(adapter:IConsoleAdapter):void
		{
			this.adapter = adapter;
		}
		
		public function getAdapter():IConsoleAdapter
		{
			return this.adapter;
		}
		
		public static function get instance():Console
		{
			return _instance ? _instance : new Console();
		}
		
		public function log(logType:int, sender:Object, message:String = ''):void
		{
			var formattedLog:String = this.getFormattedString(this.getCurrentTimestamp(), LogType.getLogTypeString(logType), getQualifiedClassName(sender), message);
			var lineBreak:String = this.getWriteBreak();
			var adapter:IConsoleAdapter = this.getAdapter();
			
			adapter.write(formattedLog);
			adapter.write(lineBreak);
		}
		
		protected function getFormattedString(timestamp:String, logType:String, senderClass:String, message:String):String
		{
			return StringUtil.sprintf('%s | %-10s | %s | %s', getCurrentTimestamp(), logType, senderClass, message);
		}
		
		protected function getCurrentTimestamp():String
		{
			var date:Date = new Date();
			return StringUtil.sprintf("%02d-%02d-%d %02d:%02d:%02d", date.date, date.month + 1, date.fullYear, date.hours, date.minutes, date.seconds);
		}
		
		protected function getWriteBreak():String
		{
			return StringUtil.repeat('-', 150);
		}
	}
}