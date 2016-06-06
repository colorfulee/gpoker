package com.jzgame.view.windows.task
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.common.utils.SignalCenter;
	import com.jzgame.common.vo.TaskVO;
	import com.jzgame.util.ItemStringUtil;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	
	import starling.display.Image;
	import starling.events.Event;
	
	public class TaskListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    TaskListItem
		 * data:    Nov 27, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _defaultWidth:Number = 638;
		private var _defaultHeight:Number = 121;
		
		private var _back:Scale9Image;
		private var _title:Label;
		private var _desc:Label;
		private var _bonus:Label;
		private var _status:Label;
		private var _getReward:Button;
		public function TaskListItem()
		{
			super();
			
			init();
		}
		
		private function init():void
		{
			this.hasLabelTextRenderer = false;
			
			styleProvider = null;
			
			var s9t:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_mailbox_normalbg_mails")
				,new Rectangle(15,15,1,1));
			_back = new Scale9Image(s9t);
			_back.width = 638;
			_back.height = 121;
			addChild(_back);
			
			_title = new Label;
			_title.setSize(460,55);
			_title.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22,HtmlTransCenter.Arial());
			addChild(_title);
			_title.x = 20;
			_title.y = 10;
			
			_desc = new Label;
			_desc.setSize(460,55);
			_desc.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22,HtmlTransCenter.Arial());
			addChild(_desc);
			_desc.x = 20;
			_desc.y = 45;
			
			_bonus = new Label;
			_bonus.setSize(460,55);
			_bonus.textRendererProperties.textFormat = StyleProvider.getTF(0xb81662,18,HtmlTransCenter.Arial());
			addChild(_bonus);
			_bonus.x = 20;
			_bonus.y = 80;
			
			_status = new Label;
			_status.setSize(60,55);
			_status.textRendererProperties.textFormat = StyleProvider.getTF(0x6e7091,24,HtmlTransCenter.Arial());
			addChild(_status);
			_status.x = 320 + 235;
			_status.y = 50;
			
			_getReward = new Button();
			_getReward.styleProvider = null;
			_getReward.defaultSkin = new Image(ResManager.defaultAssets.getTexture("mission_btn_reward1"));
			_getReward.downSkin = new Image(ResManager.defaultAssets.getTexture("mission_btn_reward2"));
			_getReward.defaultIcon = new Image(ResManager.defaultAssets.getTexture("mission_txt_reward1"));
			_getReward.downIcon = new Image(ResManager.defaultAssets.getTexture("mission_txt_reward1"));
			addChild(_getReward);
			_getReward.x = 501;
			_getReward.y = 30;
			
			_getReward.addEventListener(Event.TRIGGERED, getRewardHandler);
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			if(!value)return;
			var vo:TaskVO = value as TaskVO;
			_title.text = vo.taskConfigVO.name;
			_desc.text = vo.taskConfigVO.desc.replace("[num]",vo.taskConfigVO.point);
			_bonus.text = ItemStringUtil.getItemString(vo.taskConfigVO.bonus);
			_status.text = vo.current+"/"+vo.taskConfigVO.point;
			
			if(vo.current >= Number(vo.taskConfigVO.point))
			{
				_status.visible = false;
				_getReward.visible = true;
			}else
			{
				_getReward.visible = false;
				_status.visible = true;
			}
		}
		/**
		 * 领取奖励 
		 * @param e
		 * 
		 */		
		private function getRewardHandler(e:Event):void
		{
			var vo:TaskVO = data as TaskVO;
			SignalCenter.onTaskReward.dispatch(uint(vo.taskConfigVO.id));
		}
		/**
		 * 析构 
		 * 
		 */		
		override public function dispose():void
		{
			super.dispose();
			
			_back.dispose();
			_title.dispose();
			_desc.dispose();
			_bonus.dispose();
			_status.dispose();
			_getReward.dispose();
			DisplayManager.clearItemStage(this);
		}
	}
}