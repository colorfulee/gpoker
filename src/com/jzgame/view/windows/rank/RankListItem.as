package com.jzgame.view.windows.rank
{
	import com.jzgame.common.utils.DisplayManager;
	import com.jzgame.common.utils.ResManager;
	import com.jzgame.util.NumUtil;
	import com.jzgame.view.display.FaceWithFrame;
	import com.jzgame.vo.RankListItemVO;
	import com.spellife.feathers.SLLabel;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Point;
	
	import feathers.controls.renderers.DefaultListItemRenderer;
	
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Shape;
	
	public class RankListItem extends DefaultListItemRenderer
	{
		/***********
		 * name:    RankListItem
		 * data:    Dec 7, 2015
		 * author:  jim
		 * des:
		 ***********/
		private var _name:SLLabel;
		private var _field:SLLabel = new SLLabel;
		private var _face:FaceWithFrame;
		private var _indexIcon:Image;
		private var _underLine:Shape;
		private var _indexNum:QuadBatch;
		public function RankListItem()
		{
			super();
			
			hasLabelTextRenderer = false;
		}
		
		override protected function initialize():void
		{
			_name = new SLLabel;
			_name.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			_name.setSize(150,30);
			_name.setLocation(209,20);
			addChild(_name);
			
			_field = new SLLabel;
			_field.setSize(150,30);
			_field.setLocation(474,20);
			_field.textRendererProperties.textFormat = StyleProvider.getTF(0x100f17,22);
			addChild(_field);
			
			_face = new FaceWithFrame();
			_face.scaleX = _face.scaleY = .5;
			_face.x = 130;
			_face.y = 5;
			addChild(_face);
			
			_underLine = new Shape;
			_underLine.graphics.beginFill(0x100f17,1);
			_underLine.graphics.drawRect(0,0,672,2);
			_underLine.graphics.endFill();
			addChild(_underLine);
			_underLine.y = 70;
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			var vo:RankListItemVO = RankListItemVO(data);
			if(!vo)return;
			_field.text = NumUtil.n2kb(Number(vo.field));
			_name.text = vo.name;
			_face.setData(vo.fbID);
			
			if(_indexNum)
			{
				_indexNum.removeFromParent(true);
				_indexNum = null;
			}
			
			if(_indexIcon)
			{
				_indexIcon.removeFromParent(true);
				_indexIcon = null;
			}
			
			switch(vo.index)
			{
				case 1:
					_indexIcon = new Image(ResManager.defaultAssets.getTexture("rank_icon_gold"));
					_indexIcon.x = 20;
					_indexIcon.y = 6;
					addChild(_indexIcon);
					break;
				case 2:
					_indexIcon = new Image(ResManager.defaultAssets.getTexture("rank_icon_silver"));
					_indexIcon.x = 20;
					_indexIcon.y = 6;
					addChild(_indexIcon);
					break;
				case 3:
					_indexIcon = new Image(ResManager.defaultAssets.getTexture("rank_icon_copper"));
					_indexIcon.x = 20;
					_indexIcon.y = 6;
					addChild(_indexIcon);
					break;
				default:
					_indexNum = StyleProvider.getNum(vo.index);
					DisplayManager.centerByPoint(_indexNum,new Point(50,40));
					addChild(_indexNum);
					break;
			}
		}
		
		override public function dispose():void
		{
			super.dispose();
			if(_indexIcon)
			{
				_indexIcon.removeFromParent(true);
				_indexIcon = null;
			}
			
			if(_indexNum)
			{
				_indexNum.removeFromParent(true);
				_indexNum = null;
			}
		}
	}
}