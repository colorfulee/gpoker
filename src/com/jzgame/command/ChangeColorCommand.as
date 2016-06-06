package com.jzgame.command
{
	import robotlegs.bender.bundles.mvcs.Command;
	
	public class ChangeColorCommand extends Command
	{
		public function ChangeColorCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			trace("ChangeColorCommandChangeColorCommand");
		}
	}
}