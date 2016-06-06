package com.spellife.display
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class ASFButton extends SimpleButton
	{
		/***********
		 * name:    ASFButton
		 * data:    Nov 30, 2015
		 * author:  jim
		 * des:
		 ***********/
		public static const BLUE:int = 1;
		private static const BLUE_BG:int = 0x6666AA;
		private static const BLUE_TXT:int = 0xFFFFFF;
		
		public static const WHITE:int = 2;
		private static const WHITE_BG:int = 0xFFFFFF;
		private static const WHITE_TXT:int = 0x6666AA;
		
		private const margins:Number=10;
		
		private var _decoration:Object;
		
		private var _text:String;
		
		private var _size:Rectangle;
		
		private var _handler:Function;
		
		private var _condition:Function;
		public function ASFButton(text:String, cond:Function)
		{
			this._condition = cond;
			this.text = text;
			size = null;
		}
		
		public function set decoration(d:Object):void
		{
			this._decoration = d;
			draw();
		}
		
		public function set text(t:String):void
		{
			_text = t.toUpperCase();
			draw();
		}
		
		public function set handler( f:Function ):void
		{
			if(_handler)
				removeEventListener(MouseEvent.CLICK, _handler);
			_handler = f;
			addEventListener( MouseEvent.CLICK, _handler );
		}
		
		public function set size( s:Rectangle ):void
		{
			_size = s;
			draw();
		}
		
		private function draw():void
		{
			
			enabled = _condition == null || _condition();
			
			var _text:String = this._text;
			
			var deco:BitmapData = null;
			if(_decoration != null)
			{
				if(_decoration is String)
				{
					//				var decoTf:TextField = new TextField();
					//				decoTf.defaultTextFormat = new TextFormat( "Arial", 16, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.LEFT );
					//				decoTf.filters = [new DropShadowFilter(2,45,0,.3,1,1,1,1)];
					//				decoTf.text = _decoration as String;
					//				decoTf.width = decoTf.textWidth+10;
					//				decoTf.height = decoTf.textHeight+2;
					//				deco = new BitmapData(int(decoTf.width), int(decoTf.height), true, 0xFFFFFFFF);
					//				deco.draw(decoTf);
					_text = _decoration + ' ' + _text;
				}
				else if(_decoration is DisplayObject)
				{
					deco = new BitmapData(Math.ceil(_decoration.width), Math.ceil(_decoration.height), true, 0);
					deco.draw(_decoration as DisplayObject);
				}
			}
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = new TextFormat( "Arial", 16, 0xFFFFFF, false, false, false, null, null, TextFormatAlign.CENTER );
			tf.filters = [new DropShadowFilter(2,45,0,.3,1,1,1,1)];
			tf.text = _text;
			
			var decoWidth:int = deco!=null ? deco.width + margins : 0; 
			
			if(_size == null)
				_size = new Rectangle(0,0, decoWidth + tf.textWidth + margins*2, tf.textHeight + margins*2);
			
			while( decoWidth + tf.textWidth + margins*2 > _size.width && tf.text.length > 4 )
				tf.text = _text.substr(0, int(Math.min(tf.text.length -1, 1))) + "...";
			tf.width = tf.textWidth+10;
			tf.height = tf.textHeight+2;
			var mText:Matrix = new Matrix();
			mText.translate(-tf.width/2,-tf.height/2);
			
			var up:Sprite = new Sprite();
			up.graphics.beginFill( 0x6666AA ) ;
			up.graphics.drawRect( -_size.width/2, -_size.height/2, _size.width, _size.height );
			up.graphics.endFill();
			if(deco!=null){
				up.graphics.beginBitmapFill(deco);
				up.graphics.drawRect(0-_size.width/2+margins,-_size.height/2+margins,deco.width,deco.height);
			}
			var upText:BitmapData = new BitmapData( Math.ceil(tf.width), Math.ceil(tf.height), true, 0 );
			upText.draw(tf);
			up.graphics.beginBitmapFill(upText, mText, false, false);
			up.graphics.drawRect(0-tf.width/2,-tf.height/2,tf.width,tf.height);
			
			var down:Sprite = new Sprite();
			down.graphics.beginFill( 0x369FE5 ) ;
			down.graphics.drawRect( -_size.width/2, -_size.height/2, _size.width, _size.height );
			down.graphics.endFill();
			if(deco!=null){
				down.graphics.beginBitmapFill(deco);
				down.graphics.drawRect(0-_size.width/2+margins,-_size.height/2+margins,deco.width,deco.height);
			}
			var downText:BitmapData = new BitmapData( Math.ceil(tf.width), Math.ceil(tf.height), true, 0 );
			downText.draw(tf);
			down.graphics.beginBitmapFill(downText, mText, false, false);
			down.graphics.drawRect(-tf.width/2,-tf.height/2,tf.width,tf.height);
			
			this.upState = up;
			this.overState = up;
			this.downState = down;
			this.hitTestState = up;
			
			if(!enabled) this.alpha = .7;
			else this.alpha = 1;
			
			this.mouseEnabled = enabled || false;
			
		}
	}
}