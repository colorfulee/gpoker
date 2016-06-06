package com.jzgame.view.display
{
	import com.jzgame.common.utils.AssetsCenter;
	import com.jzgame.common.utils.ResManager;
	import com.spellife.display.Face;
	
	import starling.display.Canvas;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class FaceWithFrame extends Sprite
	{
		/*auther     :jim
		* file       :FaceWithFrame.as
		* date       :Mar 30, 2015
		* description:
		*/
		private var _face:Face;
		private var _size:String;
		private var _frame:Image;
		private var _mask:Canvas;
		public function FaceWithFrame(size:String = "small")
		{
			super();
			_size = size;
			_frame = new Image(ResManager.defaultAssets.getTexture("lobby_bg_player"));
			addChild(_frame);
			
			_mask = new Canvas();
//			addChild(_mask);
//			this.mask = _mask;
		}
		
		public function setData(f:String):void
		{
			if(!_face)
			{
				_face = new Face();
				_face.name = f;
//				switch(_size)
//				{
//					case AssetsCenter.FB_FACE_SMALL:
//						_face = new Face(50,50);
//						_face.y = 2;
//						break;
//					case AssetsCenter.FB_FACE_NORMAL:
//						_face = new Face(100,100);
//						_face.y = 4;
//						break;
//					case AssetsCenter.FB_FACE_LARGE:
//						_face = new Face(200,200);
//						_face.y = 4;
//						break;
//					default:
//						_face = new Face(50,50);
//						_face.y = 2;
//						break;
//				}
			}
			if(f == "" || f=="0")
			{
				_face.faceUrl = "";
			}else
			{
				_face.faceUrl = AssetsCenter.getFBFace(f,_size);
			}
			_face.x = 4;
			addChild(_face);
		}
	}
}