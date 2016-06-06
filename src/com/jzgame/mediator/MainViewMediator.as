package com.jzgame.mediator
{
	import com.jzgame.common.services.SocketService;
	import com.jzgame.enmu.EventType;
	import com.jzgame.view.MainView;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.ContextMenu;
	
	import robotlegs.bender.bundles.mvcs.Mediator;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.modularity.api.IModuleConnector;
	
	
	public class MainViewMediator extends Mediator
	{
		[Inject]
		public var mainView:MainView;
		
//		[Inject]
//		public var rSignal:RegisterSignal;
		
//		private var clickSignal:NativeSignal;
		
		[Inject]
		public var moduleContext:IModuleConnector;
		
		[Inject]
		public var myServer:SocketService;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
//		private var stats:Stats;
		public function MainViewMediator()
		{
			super();
		}
		
		override public function initialize():void
		{
//			clickSignal = new NativeSignal(mainView.button, MouseEvent.CLICK,MouseEvent);
//			clickSignal.add(onClick);
//			eventMap.mapListener( mainView.button, MouseEvent.CLICK, onClick);
			addContextListener(EventType.INIT_SCENE,initScene);
			
			eventMap.mapListener(mainView.stage,KeyboardEvent.KEY_DOWN,keyDown);
//			addContextListener(EventType.SOCKET_CONNECTED, connected);
//			addContextListener(EventType.SOCKET_GET_SOMETHING, connecteGetSomething);
//			rSignal.dispatch(mainView.button);
			var contextMenu:ContextMenu = new ContextMenu();
			contextMenu.hideBuiltInItems();
			
			
//			stats = new Stats;
//			contextMenu.customItems = [new ContextMenuItem(GameConfig.VERSION, true, true)];
		}
		
		private function initScene(e:Event):void
		{
			initBg();
			
			loadLobby();
		}
		
		private function initBg():void
		{
//			var bitmap:Bitmap = new Bitmap(mcProxy.getBitmapDataInLoaderInfoByName("mainBg",config.getSourceItemById("mainBg").link));
//			mainView.container.addChild(bitmap);
		}
		
		private function loadLobby():void
		{
			
		}
		
		
		private function changeColor(e:Event):void
		{
			trace("receive change color!");
//			var message:Request = new Request;
//			message.requestData = new ByteArray();
//			message.requestData.writeInt(1);
//			message.commandId = 1;
//			message.requestDataLength = message.requestData.length;
//			var byte:ByteArray = new ByteArray;
//			var length:UInt64 = new UInt64();
//			byte.writeObject(length);
////			byte.endian = Endian.LITTLE_ENDIAN;
////			byte.writeBoolean( true );
//			message.writeTo(byte);
//			byte.position = 0;
//			byte.writeShort(byte.bytesAvailable-16);
//			var sendByte:ByteArray = new ByteArray;
////			byte.position = 0;
////			myServer.send(byte);
//			mainView.appendText("send success!");
//			var transPerson:Person = new Person;
//			transPerson.mergeFrom(byte);
//			//			
//			trace(transPerson.id);
		}
		
		private function connecteGetSomething(e:Event):void
		{
		}
		
		private function connected(e:Event):void
		{
		}
		
		
		/**
		 * 键盘事件 
		 * @param e
		 * 
		 */		
		private function keyDown(e:KeyboardEvent):void
		{
			trace(e.keyCode,e.charCode);
			switch(e.keyCode)
			{
				//ctrl+~
				case 192:
//					if(stats.parent)
//					{
//						mainView.removeChild(stats);
//					}else
//					{
//						mainView.addChild(stats);
//					}
					break;
			}
		}
		
		override public function destroy():void
		{
//			clickSignal.removeAll();
//			eventMap.unmapListener( mainView.button, MouseEvent.CLICK, onClick);
		}
	}
}