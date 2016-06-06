package com.jzgame.common.utils.logging.publishers
{
	import com.jzgame.common.utils.logging.ILogPublisher;
	import com.jzgame.common.utils.logging.LogRecord;
	import com.jzgame.common.utils.logging.Tracer;
	import com.jzgame.common.utils.logging.publishers.AbstractLogPublisher;
	
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Provides a logger publisher that uses Longing display the log.
	 * The LongingPublisher send log to Longing application.
	 * @author Rakuten
	 *
	 */
	public class LongingPublisher extends AbstractLogPublisher implements ILogPublisher
	{
		//==========================================================================
		//  Variables
		//==========================================================================
		/**
		 * connecation name.
		 */
		public static const CONN_NAME:String = "_austin_log_console";
		
		/**
		 * connecation function Name.
		 */
		public static const CONN_FUN:String = "log";
		
		/**
		 * the lacal connection
		 */
		private var conn:LocalConnection;
		
		//==========================================================================
		//  Constructor
		//==========================================================================
		/**
		 * Constructs a new <code>LongingPublisher</code> instance.
		 *
		 */
		public function LongingPublisher()
		{
			super();
			
			conn = new LocalConnection();
			conn.addEventListener(StatusEvent.STATUS, onStatus);
		}
		
		//==========================================================================
		//  Methods
		//==========================================================================
		/**
		 * send logRecord to Longing.
		 * @param logRecord
		 *
		 */
		override public function publish(logRecord:LogRecord):void
		{
			if (this.isLoggable(logRecord))
			{
				conn.send(CONN_NAME, CONN_FUN, toObject(logRecord));
			}
		}
		
		/**
		 * logRecord to Object.
		 * @param logRecord
		 * @return
		 *
		 */
		private function toObject(logRecord:LogRecord):Object
		{
			var result:Object =
				{
					date:logRecord.getDate(),
						level:
						{
							name:logRecord.getLevel().name,
								value:logRecord.getLevel().value
						},
						loggerName:logRecord.getLoggerName(),
						message:logRecord.getMessage()
				};
			return result;
		}
		
		//==========================================================================
		//  Event handlers
		//==========================================================================
		private function onStatus(event:StatusEvent):void
		{
			switch (event.level)
			{
				case "status":
					break;
				case "error":
					Tracer.logger.removePublisher(this);
					Tracer.warn(getQualifiedClassName(this) + " publish failed!");
					break;
			}
		}
	}
}
