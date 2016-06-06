package com.spellife.util
{
	import com.spellife.event.GameTimeEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;

	[Event(name="timer",type="flash.events.TimerEvent")]
    public class RealGameTimer extends EventDispatcher
    {
        private var _gameTimer:GameTimer;
        private var _count:Number = 0;
        private var _interval:Number = 40;
		private var _running:Boolean;

        public function RealGameTimer(delay:Number = 40)
        {
            _interval = delay;
            init();
        }

        public function get delay() : Number
        {
            return _interval;
        }

        public function set delay(param1:Number) : void
        {
            _interval = param1;
            _gameTimer.frameInterval = _interval;
        }

        private function init() : void
        {
            _gameTimer = new GameTimer(_interval);
        }
		/**
		 * 
		 * @return 
		 * 
		 */		
		public function get isRunning():Boolean
		{
			return _running;
		}

        public function start() : void
        {
            _gameTimer.addEventListener(GameTimeEvent.FORBIDDEN, forbiddenHandler);
            _gameTimer.addEventListener(GameTimeEvent.TICK, trikHandler);
            _gameTimer.addEventListener(GameTimeEvent.SECOND, secondHandler);
            _gameTimer.start();
			
			_running = true;
        }

        public function stop() : void
        {
            _gameTimer.stop();
            _gameTimer.removeEventListener(GameTimeEvent.FORBIDDEN, forbiddenHandler);
            _gameTimer.removeEventListener(GameTimeEvent.TICK, trikHandler);
            _gameTimer.removeEventListener(GameTimeEvent.SECOND, secondHandler);
			_count = 0;
			_running = false;
        }

        private function secondHandler(event:GameTimeEvent) : void
        {
            dispatchEvent(event.clone());
        }

        private function forbiddenHandler(event:Event) : void
        {
            dispatchEvent(event.clone());
        }

        private function trikHandler(event:GameTimeEvent) : void
        {
            _count = _count + event.interval;
            while (_count >= _interval)
            {
                _count -= _interval;
                dispatchEvent(new TimerEvent(TimerEvent.TIMER));
            }
        }
		
		public function dispose():void
		{
			stop();
			_gameTimer = null;
		}
    }
}
