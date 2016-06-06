package com.jzgame.common.utils.logging.publishers
{
	import com.jzgame.common.utils.logging.ILogPublisher;
	import com.jzgame.common.utils.logging.LogLevel;
	import com.jzgame.common.utils.logging.LogRecord;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 *  This class provides the basic functionality required by the logging framework
	 *  for a target implementation.
	 * @author Rakuten
	 *
	 */
	public class AbstractLogPublisher implements ILogPublisher
	{
		//==========================================================================
		//  Constructor
		//==========================================================================
		/**
		 * Can"t Constructs the <code>AbstractLogPublisher</code> instance.
		 *
		 */
		public function AbstractLogPublisher()
		{
			//        AbstractHandler.handlerClass(this, AbstractLogPublisher);
			
			this._level = LogLevel.ALL;
		}
		
		//==========================================================================
		//  Properties
		//==========================================================================
		
		//----------------------------------
		//  level
		//----------------------------------
		/**
		 * @private
		 * Storage for the level property.
		 */
		private var _level:LogLevel;
		
		/**
		 * @inheritDoc
		 */
		public function get level():LogLevel
		{
			return _level;
		}
		
		public function set level(value:LogLevel):void
		{
			_level = value;
		}
		
		//==========================================================================
		//  Methods
		//==========================================================================
		
		/**
		 * @inheritDoc
		 */
		public function publish(logRecord:LogRecord):void
		{
		}
		
		/**
		 * @inheritDoc
		 */
		public function isLoggable(logRecord:LogRecord):Boolean
		{
			if (this.level > logRecord.getLevel())
			{
				
				return false;
			}
			
			return true;
		}
		
		/**
		 * Return a string of the AbstractLogPublisher
		 * @return
		 * @see Object#toString()
		 */
		public function toString():String
		{
			return "[object " + getQualifiedClassName(this) + "]";
		}
	}
}
