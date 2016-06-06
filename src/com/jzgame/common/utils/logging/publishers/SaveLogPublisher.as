package com.jzgame.common.utils.logging.publishers
{
	import com.jzgame.common.utils.logging.ILogPublisher;
	import com.jzgame.common.utils.logging.LogRecord;
	
	/**
	 * 
	 * @author Rakuten
	 * 
	 */
	public class SaveLogPublisher extends AbstractLogPublisher implements ILogPublisher
	{
		static public const ALL_LOG:Array = [];
		
		public function SaveLogPublisher()
		{
		}
		
		override public function publish(logRecord:LogRecord):void
		{
			if (isLoggable(logRecord))
			{
				ALL_LOG.push(format(logRecord));
			}
		}
		
		private function format(logRecord:LogRecord):String
		{
			var formatted:String;
			formatted = "[" + logRecord.getLevel().name + "]\t" + 
				logRecord.getDate().toTimeString().slice(0, 8) + " " + 
				logRecord.getMessage();
			return formatted;
		}
	}
}