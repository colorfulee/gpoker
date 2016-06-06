package com.spellife.util
{
	import com.spellife.event.GameTimeEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;

    public class GameTimer extends EventDispatcher
    {
        private var _frameInterval:int = 50;
        private var tick:Sprite;
        private var prevTime:int;
        private var interval:int = 0;
        private var secondI:int = 0;
        private var vaildateTime:Date;
        private var vaildateStep:Number;

        public function GameTimer(interval:uint)
        {
            this.tick = new Sprite();
            this.frameInterval = interval;
        }

        public function get frameInterval() : int
        {
            return this._frameInterval;
        }

        public function set frameInterval(param1:int) : void
        {
            this._frameInterval = param1;
        }

        public function start() : void
        {
            this.prevTime = getTimer();
            this.tick.addEventListener(Event.ENTER_FRAME, this.tickHandler);
        }

        public function stop() : void
        {
            this.tick.removeEventListener(Event.ENTER_FRAME, this.tickHandler);
        }

        private function tickHandler(event:Event) : void
        {
            var intervalTime:Number = 0;
            var now:Number = getTimer();
            var tickEvent:GameTimeEvent = new GameTimeEvent(GameTimeEvent.TICK, now - this.prevTime);
            this.prevTime = now;
            this.interval += tickEvent.interval;
            this.secondI  += tickEvent.interval;
            dispatchEvent(tickEvent);
            if (this.interval >= this.frameInterval)
            {
                this.interval = 0;
                dispatchEvent(new GameTimeEvent(GameTimeEvent.FRAME, 0));
            }
			//防止变速齿轮
            if (this.secondI >= GameTimeEvent.ONE_SECOND)
            {
                this.secondI = this.secondI - GameTimeEvent.ONE_SECOND;
                dispatchEvent(new GameTimeEvent(GameTimeEvent.SECOND, 0));
                if (this.vaildateTime == null)
                {
                    this.vaildateTime = new Date();
                    this.vaildateStep = now;
                }
                intervalTime = new Date().getTime() - this.vaildateTime.getTime() + this.vaildateStep;
				//当前跑的时间与第一次打点到现在的时间
				//查看差是否大于10s
                if (now - intervalTime > 10000)
                {
                    this.tick.removeEventListener(Event.ENTER_FRAME, this.tickHandler);
                    dispatchEvent(new Event(GameTimeEvent.FORBIDDEN));
                }
            }
        }
    }
}
