package com.jzgame.common.controller
{
import com.jzgame.common.services.HttpService;
import com.jzgame.common.services.http.HttpRequest;
import com.jzgame.common.services.http.events.HttpRequestEvent;

import flash.events.IEventDispatcher;

import robotlegs.bender.bundles.mvcs.Command;

/**
 * 通过http发送请求
 * @author Rakuten
 * 
 */
public class HttpRequestCommand extends Command
{
    public function HttpRequestCommand()
    {
        super();
    }
	
	[Inject]
	public var event:HttpRequestEvent;
	
	[Inject]
	public var httpService:HttpService;
	
	[Inject]
	public var eventDispatcher:IEventDispatcher;

    override public function execute():void
    {
		httpService.send(event.data as HttpRequest);
    }
}
}
