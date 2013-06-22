package com.trivia.db.model
{
	public class DbQueryList
	{
		public static const CREATE_QUESTION_TABLE:String = 'CREATE TABLE IF NOT EXISTS question (question_id INTEGER PRIMARY KEY AUTOINCREMENT, question BLOB)';
		public static const SELECT_QUESTIONS:String = 'SELECT * FROM question ORDER BY question_id';
		public static const INSERT_QUESTION:String = 'INSERT INTO question (question) VALUES (:question)';
		public static const DELETE_QUESTION:String = 'DELETE FROM question WHERE question_id = :question_id'; 
		public static const DROP_QUESTION_TABLE:String = 'DROP TABLE question';
		public static const CLEAR_QUESTIONS:String = 'DELETE FROM question';
		
		public static const CREATE_SCORE_TABLE:String = 'CREATE TABLE IF NOT EXISTS score (score_id INTEGER PRIMARY KEY AUTOINCREMENT, score INTEGER, date BLOB)';
		public static const SELECT_SCORE:String = 'SELECT * FROM score ORDER BY score_id DESC';
		public static const INSERT_SCORE:String = 'INSERT INTO score (score, date) VALUES (:score, :date)';
		public static const DROP_SCORE_TABLE:String = 'DROP TABLE score';
	}
}