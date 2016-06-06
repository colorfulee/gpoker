package com.jzgame.command
{
import com.jzgame.enmu.DebugInfoType;
import com.jzgame.events.DebugInfoEvent;
import com.jzgame.common.utils.logging.Tracer;

import robotlegs.bender.bundles.mvcs.Command;

/**
 * 
 * @author Rakuten
 * 
 */
public class DebugInfoCommand extends Command
{
    public function DebugInfoCommand()
    {
        super();
    }

	[Inject]
	public var event:DebugInfoEvent;
	
    override public function execute():void
    {
		var text:String = event.text;
		var color:uint = 0xffffff;
		switch(event.debugType)
		{
			case DebugInfoType.ERROR:
//				color = 0xff0000;
				Tracer.error(text);
				break;
			case DebugInfoType.INFO:
//				color = 0xffffff;
				Tracer.info(text);
				break;
			case DebugInfoType.NET:
//				color = 0xFF0066;
				Tracer.info(text);
				break;
			case DebugInfoType.GUIDE:
//				color = 0xFF00FF;
				Tracer.warn(text);
				break;
			case DebugInfoType.SEND_NET:
//				color = 0x064F80;
				Tracer.info(text);
				break;
			default:
//				color = event.showColor;
				Tracer.debug(text);
				break;
		}
    }
}
}
