package com.trivia.db.service
{
	import com.castiana.console.Console;
	import com.castiana.console.LogType;
	import com.trivia.db.model.DbQueryList;
	
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.errors.SQLErrorOperation;
	import flash.events.SQLErrorEvent;
	import flash.filesystem.File;
	import flash.net.FileReference;
	
	import org.robotlegs.mvcs.Actor;
	
	public class DbService extends Actor
	{
		protected var _dbName:String = 'trivia.db';
		
		protected var _sqlConnection:SQLConnection;
		protected var _sqlStatement:SQLStatement;
		
		public function DbService()
		{
			super();
		}
		
		public function connect():void
		{
			if (this._sqlConnection != null)
			{
				return;
			}
			
			var dbFile:File = File.applicationStorageDirectory.resolvePath(this._dbName);
			if (!dbFile.exists)
			{
				var dbTemplate:File = File.applicationDirectory.resolvePath(this._dbName);
				dbTemplate.copyTo(dbFile, true);
			}

			this._sqlConnection = new SQLConnection();
			// this._sqlConnection.addEventListener(SQLEvent.OPEN, this.handleSqlOpen);
			this._sqlConnection.addEventListener(SQLErrorEvent.ERROR, this.handleSqlError, false, 0, true);
			this._sqlConnection.open(dbFile);
			
			this.query(DbQueryList.CREATE_QUESTION_TABLE);
			this.query(DbQueryList.CREATE_SCORE_TABLE);
		}
		
		public function query(queryString:String, parameters:Object = null, prefetch:int = -1):Array
		{	
			var data:Array = null;
			
			this._sqlStatement = new SQLStatement();
			this._sqlStatement.addEventListener(SQLErrorEvent.ERROR, this.handleSqlError, false, 0, true);
			
			this._sqlStatement.sqlConnection = this._sqlConnection;
			
			this._sqlStatement.text = queryString;
			
			if (parameters != null)
			{
				for (var i:String in parameters)
				{
					if (parameters.hasOwnProperty(i))
					{
						this._sqlStatement.parameters[i] = parameters[i];
					}
				}
			}
			
			try
			{
				this._sqlStatement.execute(prefetch);
				data = this._sqlStatement.getResult().data;
			}
			catch (e:SQLError)
			{
				handleSqlError(e);
				data = [];
			}
			
			return data;
		}
		
		protected function handleSqlError(e:SQLError):void
		{
			var message:String = 'SQL Error: ' + e.message;
			if (this._sqlStatement != null)
			{
				message += ' SQL Code: ' + this._sqlStatement.text;
			}
			
			Console.instance.log(LogType.WARNING, this, message);
		}
	}
}