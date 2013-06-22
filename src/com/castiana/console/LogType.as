package com.castiana.console
{
	public class LogType
	{
		public static const COMMAND:int = 0;
		public static const CHECKPOINT:int = 1;
		public static const WARNING:int = 2;
		public static const NOTIFICATION:int = 3;
		
		public static function getLogTypeString(logType:int):String
		{
			var logTypeString:String;
			switch (logType)
			{
				case COMMAND:
					logTypeString = 'COMMAND';
				break;
				case CHECKPOINT:
					logTypeString = 'CHECKPOINT';
				break;
				case WARNING:
					logTypeString = 'WARNING';
				break;
				case NOTIFICATION:
					logTypeString = 'NOTIFICATION';
				break;
				default:
					logTypeString = 'UNKNOWN';
			}
			
			return logTypeString;
		}
	}
}