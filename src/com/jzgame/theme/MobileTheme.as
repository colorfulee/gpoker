package com.jzgame.theme
{
	import com.jzgame.common.utils.ResManager;
	import com.spellife.util.HtmlTransCenter;
	import com.starling.theme.StyleProvider;
	
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.NumericStepper;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.Scroller;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleButton;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.text.TextBlockTextEditor;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale9Textures;
	import feathers.themes.StyleNameFunctionTheme;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Shape;
	import starling.textures.Texture;
	
	public class MobileTheme extends StyleNameFunctionTheme
	{
		/***********
		 * name:    MobileTheme
		 * data:    Nov 18, 2015
		 * author:  jim
		 * des:
		 ***********/
		private static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		private static const ORIGINAL_DPI_IPAD_RETINA:int = 264;
		private var scale:Number = 1;
		private var regularFontDescription:FontDescription;
		private var FONT_NAME:String = "Arial";
		public function MobileTheme()
		{
			super();
			
			initialize();
		}
		
		private function initialize():void
		{
			this.initializeScale();
			this.initializeGlobals();
			this.initializeStyleProviders();
		}
		/**
		 * 设置style 
		 * 
		 */		
		private function initializeStyleProviders():void
		{
			// button
			this.getStyleProviderForClass( Button ).defaultStyleFunction = this.setButtonStyles;
			//alert
			this.getStyleProviderForClass( Alert ).defaultStyleFunction = this.setAlertStyles;
			//radio
			this.getStyleProviderForClass( Radio ).defaultStyleFunction = this.setRadioStyles;
			//check
			this.getStyleProviderForClass( Check ).defaultStyleFunction = this.setCheckStyles;
			//progress bar
			this.getStyleProviderForClass( ProgressBar ).defaultStyleFunction = this.setProgressBarStyles;
			//slider
			this.getStyleProviderForClass( Slider ).defaultStyleFunction = this.setSliderStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(Slider.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setSimpleButtonStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK, this.setHorizontalSliderMinimumTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK, this.setHorizontalSliderMaximumTrackStyles);
			//scroll bar
			this.getStyleProviderForClass( SimpleScrollBar ).defaultStyleFunction = this.setSimpleScrollBarStyles;
			//toggle switch
			this.getStyleProviderForClass( ToggleSwitch ).defaultStyleFunction = this.setToggleSwitchStyles;
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_ON_TRACK, this.setToggleSwitchOnTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_OFF_TRACK, this.setToggleSwitchOffTrackStyles);
			this.getStyleProviderForClass(Button).setFunctionForStyleName(ToggleSwitch.DEFAULT_CHILD_STYLE_NAME_THUMB, this.setToggleSwitchThumbStyles);
			//numeric step
			this.getStyleProviderForClass( NumericStepper ).defaultStyleFunction = this.setNumericStepperStyles;
			
			this.getStyleProviderForClass( TextFieldTextRenderer )
			.setFunctionForStyleName( Alert.DEFAULT_CHILD_STYLE_NAME_MESSAGE, setAlertMessageStyles );
			
			this.getStyleProviderForClass( Header )
			.setFunctionForStyleName( Alert.DEFAULT_CHILD_STYLE_NAME_MESSAGE, setAlertHeaderStyles  );
			
			getStyleProviderForClass( ButtonGroup )
			.setFunctionForStyleName( Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP, setAlertButtonGroupStyles );
			
			getStyleProviderForClass( Radio )
			.setFunctionForStyleName( StyleProvider.CUSTOM_RADIO_WITH_CHECK, setCustomRadioStyles );
			
			getStyleProviderForClass( ToggleButton )
			.setFunctionForStyleName( StyleProvider.CUSTOM_TAB_BUTTON_IN_MAIL, setCustomTabButtonStyles );
			
			getStyleProviderForClass( Button  )
			.setFunctionForStyleName( StyleProvider.CUSTOM_SIMPLEBAR_IN_MAIL, setCustomScrollBarStyles );
			//numeric stepper
			getStyleProviderForClass( TextInput )
			.setFunctionForStyleName( StyleProvider.CUSTOM_TEXT_INPUT_IN_NUM_STEPPER, setNumericStepperCustomTextInputStyles );
			
			getStyleProviderForClass( Button  )
			.setFunctionForStyleName( StyleProvider.CUSTOM_INC_IN_NUM_STEPPER, setCustomNumIncreStepperStyles );
			getStyleProviderForClass( Button  )
			.setFunctionForStyleName( StyleProvider.CUSTOM_DECC_IN_NUM_STEPPER, setCustomNumDecreStepperStyles );
			
			getStyleProviderForClass( Button  )
			.setFunctionForStyleName( StyleProvider.CUSTOM_BUTTON_IN_MESSAGE, setInviteButtonStyles );
			getStyleProviderForClass( Button  )
			.setFunctionForStyleName( StyleProvider.CUSTOM_BUTTON_IN_PRE_OPERATE, setCustomPreOperateButtonStyles );
			//list
			
			this.getStyleProviderForClass(Header).defaultStyleFunction = this.setHeaderStyles;
//			//alert
//			this.getStyleProviderForClass(Alert).defaultStyleFunction = this.setAlertStyles;
//			this.getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP, this.setAlertButtonGroupStyles);
//			this.getStyleProviderForClass(Button).setFunctionForStyleName(THEME_STYLE_NAME_ALERT_BUTTON_GROUP_BUTTON, this.setAlertButtonGroupButtonStyles);
//			this.getStyleProviderForClass(Header).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setHeaderWithoutBackgroundStyles);
////			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_MESSAGE, this.setAlertMessageTextRendererStyles);
//			
//			//button
//			this.getStyleProviderForClass(Button).defaultStyleFunction = this.setButtonStyles;
//			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_CALL_TO_ACTION_BUTTON, this.setCallToActionButtonStyles);
//			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_QUIET_BUTTON, this.setQuietButtonStyles);
//			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_DANGER_BUTTON, this.setDangerButtonStyles);
//			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_BACK_BUTTON, this.setBackButtonStyles);
//			this.getStyleProviderForClass(Button).setFunctionForStyleName(Button.ALTERNATE_STYLE_NAME_FORWARD_BUTTON, this.setForwardButtonStyles);
//			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(Button.DEFAULT_CHILD_STYLE_NAME_LABEL, this.setButtonLabelStyles);
//			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_QUIET_BUTTON_LABEL, this.setQuietButtonLabelStyles);
//			
//			//button group
//			this.getStyleProviderForClass(ButtonGroup).defaultStyleFunction = this.setButtonGroupStyles;
//			this.getStyleProviderForClass(Button).setFunctionForStyleName(ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setButtonGroupButtonStyles);
//			this.getStyleProviderForClass(ToggleButton).setFunctionForStyleName(ButtonGroup.DEFAULT_CHILD_STYLE_NAME_BUTTON, this.setButtonGroupButtonStyles);
//			this.getStyleProviderForClass(TextBlockTextRenderer).setFunctionForStyleName(THEME_STYLE_NAME_BUTTON_GROUP_BUTTON_LABEL, this.setButtonGroupButtonLabelStyles);

		}
		/**
		 * 设置全局 
		 * 
		 */		
		private function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			};
			
			this.regularFontDescription = new FontDescription(FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
//			
//			FeathersControl.defaultTextEditorFactory = function():ITextEditor
//			{
//				return new StageTextTextEditor();
//			};
		}
		protected var _originalDPI:int;
		/**
		 * 设置dpi 
		 * 
		 */		
		private function initializeScale():void
		{
			var scaledDPI:int = DeviceCapabilities.dpi / Starling.contentScaleFactor;
			var originalDPI:Number = ORIGINAL_DPI_IPHONE_RETINA;
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
			}
			this.scale = scaledDPI / this._originalDPI;
			
			this.gridSize = Math.round(88 * this.scale);
			this.smallGutterSize = Math.round(11 * this.scale);
		}
		
		private function setButtonStyles( button:Button ):void
		{
			var back:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_btn_button1"),new Rectangle(25,25,1,1));
//			button.defaultSkin = new Scale9Image( back );
			button.defaultSkin = new Image(ResManager.defaultAssets.getTexture("common_btn_button1"));
			var down:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("common_btn_button2"),new Rectangle(25,25,1,1));
			button.downSkin = new Image(ResManager.defaultAssets.getTexture("common_btn_button2"));
//			button.downSkin = new Scale9Image( down );
//			
//			button.padding = 20;
//			button.gap = 15;
			button.defaultLabelProperties.isHTML = true;
			button.defaultLabelProperties.textFormat = new TextFormat(HtmlTransCenter.Arial(), 20, 0xb3a7db, true );
//				new ElementFormat( new FontDescription( "_sans" ), 18, 0x333333 );
		}
		/**
		 * 设置radio 
		 * @param radio
		 * 
		 */		
		private function setCustomRadioStyles(radio:Radio):void
		{
			radio.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_auto1"));
			radio.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_auto2"));
			radio.defaultSelectedSkin = new Image(ResManager.tableAssets.getTexture("table_btn_auto2"));
		}
		/**
		 * 设置操作台预选按钮样式 
		 * @param button
		 * 
		 */		
		private function setCustomPreOperateButtonStyles(button:Button):void
		{
			button.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_auto1"));
			button.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_auto2"));
		}
		/**
		 * 设置tab 样式
		 * @param radio
		 */		
		private function setCustomTabButtonStyles(button:ToggleButton):void
		{
			button.defaultSkin = new Image(ResManager.tableAssets.getTexture("table_btn_auto1"));
			button.downSkin = new Image(ResManager.tableAssets.getTexture("table_btn_auto2"));
			button.defaultSelectedSkin = new Image(ResManager.defaultAssets.getTexture("common_lable_buy2"));
			button.hasLabelTextRenderer = false;
		}
		
		private function setAlertButtonGroupStyles (group:ButtonGroup):void
		{
			group.direction = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			group.gap = 20;
			group.lastGap = 20;
			group.padding = 20;
			group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
		}
		
		protected var gridSize:int;
		protected var smallGutterSize:int;
		private function setAlertHeaderStyles (header:Header):void
		{
			header.paddingTop = 20;
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
//			header.padding = this.smallGutterSize;
//			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
//			alertHeader.paddingTop = 50;
//			alertHeader.textFormat = new TextFormat(HtmlTransCenter.Arial(),16,0xff0000);
//			alertHeader.border = true;
//			alertHeader.width = 200;
			header.title = "ffffffff";
			header.titleProperties.textFormat = new TextFormat(HtmlTransCenter.Arial(),26,0xb3a7db);
		}
		
		protected function setHeaderStyles(header:Header):void
		{
			header.minWidth = this.gridSize;
			header.minHeight = this.gridSize;
//			header.padding = this.smallGutterSize;
			header.gap = this.smallGutterSize;
			header.titleGap = this.smallGutterSize;
//			header.paddingTop = 20;
			header.padding = 20;
			
			header.titleProperties.textFormat = new TextFormat(HtmlTransCenter.Arial(),26,0xb3a7db);
//			var backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, this.scale);
//			backgroundSkin.width = this.gridSize;
//			backgroundSkin.height = this.gridSize;
//			header.backgroundSkin = backgroundSkin;
		}
		
//		protected function setHeaderTitleProperties(textRenderer:TextBlockTextRenderer):void
//		{
//			textRenderer.elementFormat = this.headerElementFormat;
//			textRenderer.disabledElementFormat = this.headerDisabledElementFormat;
//		}
		
		private function setAlertMessageStyles(alertText:TextFieldTextRenderer):void
		{
			var tf:TextFormat = new TextFormat(HtmlTransCenter.Arial(),20,0xb3a7db);
//			tf.align = TextFieldAutoSize.HORIZONTAL;
			tf.align = "center";
			alertText.textFormat = tf;
			alertText.border = true;
			alertText.wordWrap = true;
		}
		/**
		 * 设置数量选择 
		 * @param numeric
		 * 
		 */		
		private function setSimpleScrollBarStyles(simScrollBar:SimpleScrollBar):void
		{
			simScrollBar.customThumbStyleName = StyleProvider.CUSTOM_SIMPLEBAR_IN_MAIL;
//			simScrollBar.direction = SimpleScrollBar.DIRECTION_VERTICAL;
//			numeric.
		}
		/**
		 * 设置toggle switch 
		 * @param numeric
		 * 
		 */		
		private function setToggleSwitchStyles(toggle:ToggleSwitch):void
		{
			toggle.offText = "";
			toggle.onText = "";
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;
		}
		
		protected function setToggleSwitchOnTrackStyles(track:Button):void
		{
//			var s3:Scale3Image = new Scale3Image(new Scale3Textures(ResManager.defaultAssets.getTexture("setting_btn_on"),20,40));
//			track.defaultSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_on"));
//			track.defaultSkin = s3;
			track.hasLabelTextRenderer = false;
		}
		
		protected function setToggleSwitchOffTrackStyles(track:Button):void
		{
			track.defaultSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_off"));
			track.hasLabelTextRenderer = false;
		}
		
		protected function setToggleSwitchThumbStyles(thumb:Button):void
		{
			thumb.defaultSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_switch"));
			thumb.downSkin = new Image(ResManager.defaultAssets.getTexture("setting_btn_switch"));
//			this.setButtonStyles(thumb);
//			
//			var frame:Rectangle = this.buttonUpSkinTextures.texture.frame;
//			if(frame)
//			{
//				thumb.width = thumb.height = this.buttonUpSkinTextures.texture.frame.height;
//			}
//			else
//			{
//				thumb.width = thumb.height = this.buttonUpSkinTextures.texture.height;
//			}
			
			thumb.hasLabelTextRenderer = false;
		}
		/**
		 * 设置数量选择 
		 * @param numeric
		 * 
		 */		
		private function setNumericStepperStyles(numeric:NumericStepper):void
		{
			numeric.value = 1;
		}
		/**
		 *  设置alert 
		 * @param alert
		 * 
		 */		
		private function setAlertStyles(alert:Alert):void
		{
			this.setScrollerStyles(alert);
			var back:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_common_bg_popup"),new Rectangle(25,25,1,1));
			var back9:Scale9Image = new Scale9Image(back);
			alert.outerPaddingBottom = 5;
			alert.outerPaddingLeft = 50;
			alert.outerPaddingRight = 50;
			alert.paddingBottom = 20;
			alert.backgroundSkin = back9;

			alert.minHeight = 268;
			alert.minWidth = 311;
//			alert.width = 300;
//			alert.paddingTop = 15;
//			alert.paddingRight = 20;
//			alert.paddingBottom = 15;
//			alert.paddingLeft = 20;
		}
		/**
		 * 设置check样式
		 * @param radio
		 * 
		 */		
		private function setCheckStyles(check:Check):void
		{
			check.defaultIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_checkbox1"));
			check.downIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_checkbox1"));
			check.hoverIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_checkbox1"));
			check.selectedUpIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_checkbox2"));
			check.selectedHoverIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_checkbox2"));
			check.selectedDownIcon = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_checkbox2"));
		}
		/**
		 * 设置radio样式
		 * @param radio
		 * 
		 */		
		private function setRadioStyles(radio:Radio):void
		{
			radio.defaultSkin = new Image(ResManager.defaultAssets.getTexture("rank_btn_unchecked"));
			radio.selectedUpSkin = new Image(ResManager.defaultAssets.getTexture("rank_btn_check"));
			radio.selectedHoverSkin = new Image(ResManager.defaultAssets.getTexture("rank_btn_check"));
			
//			radio.defaultLabelProperties.elementFormat = new ElementFormat(regularFontDescription,20,0x777a9d);
//			radio.selectedDisabledLabelProperties.elementFormat = new ElementFormat(regularFontDescription,20,0x777a9d);
			radio.defaultLabelProperties.textFormat          = StyleProvider.getTF(0x777a9d,20);
			radio.selectedDisabledLabelProperties.textFormat = StyleProvider.getTF(0x777a9d,20);
			radio.gap = 50;
			radio.labelOffsetX = 50;
		}
		/**
		 * 设置progressBar样式 
		 * @param bar
		 * 
		 */		
		protected function setProgressBarStyles(bar:ProgressBar):void
		{
			var s9back:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_recording_bg_timeline2"),new Rectangle(7,5,1,1));
			var backgroundSkin:Scale9Image = new Scale9Image( s9back );
			backgroundSkin.width = 250;
			bar.backgroundSkin = backgroundSkin;
			
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("s9_details_bg_LVbar 2"),new Rectangle(50,5,1,1));
			var fillSkin:Scale9Image = new Scale9Image( s9 );
			fillSkin.width = 20;
			bar.fillSkin = fillSkin;
		}
		/**
		 * @private
		 * The theme's custom style name for the thumb of a vertical SimpleScrollBar.
		 */
		protected static const THEME_STYLE_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String = "metal-works-mobile-vertical-simple-scroll-bar-thumb";
		
		/**
		 * @private
		 * The theme's custom style name for the minimum track of a horizontal slider.
		 */
		protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-minimum-track";
		/**
		 * @private
		 * The theme's custom style name for the maximum track of a horizontal slider.
		 */
		protected static const THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-maximum-track";
		/**
		 * 
		 * @param slider
		 * 
		 */		
		protected function setSliderStyles(slider:Slider):void
		{
			slider.minimum = 0;
			slider.maximum = 100;
			slider.direction = Slider.DIRECTION_HORIZONTAL;
			slider.customMinimumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
			slider.customMaximumTrackStyleName = THEME_STYLE_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
			slider.minHeight = this.controlSize;
            slider.trackLayoutMode = Slider.TRACK_INTERACTION_MODE_TO_VALUE;

//			var s9back:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("table_bg_lever"),new Rectangle(7,5,1,1));
//			var backgroundSkin:Scale9Image = new Scale9Image( s9back );
//			backgroundSkin.width = 250;
//			bar.backgroundSkin = backgroundSkin;
//			
//			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("table_btn_lever 2"),new Rectangle(50,5,1,1));
//			var fillSkin:Scale9Image = new Scale9Image( s9 );
//			fillSkin.width = 20;
//			bar.fillSkin = fillSkin;
		}
		protected function setSimpleButtonStyles(button:Button):void
		{
			button.styleProvider = null;
			button.defaultSkin = new Image(ResManager.tableAssets.getTexture('table_bg_checkbox'));
		}
		
		protected var controlSize:Number = 200;
		protected var wideControlSize:Number = 500;
		protected var backgroundSkinTextures:Texture;
		protected var backgroundDisabledSkinTextures:Texture;
		protected function setHorizontalSliderMinimumTrackStyles(track:Button):void
		{
			track.defaultSkin = new Image(ResManager.tableAssets.getTexture('table_bg_lever'));
			track.hasLabelTextRenderer = false;
		}
		
		protected function setHorizontalSliderMaximumTrackStyles(track:Button):void
		{
			backgroundSkinTextures = (ResManager.tableAssets.getTexture('table_btn_lever'));
			track.defaultSkin = new Image(backgroundSkinTextures);
			track.hasLabelTextRenderer = false;
		}
		
		protected function setScrollerStyles(scroller:Scroller):void
		{
			scroller.horizontalScrollBarFactory = scrollBarFactory;
			scroller.verticalScrollBarFactory = scrollBarFactory;
		}
		/**
		 * 设置滚动条 
		 * @param scrollBar
		 * 
		 */		
		protected function setCustomScrollBarStyles(button:Button):void
		{
			var dshape:Shape = new Shape();
			dshape.graphics.beginFill(0x000000,.5);
			dshape.graphics.drawRect(0,0,10,50);
			dshape.graphics.endFill();
			button.defaultSkin = dshape;
			button.downSkin = dshape;
		}
		/**
		 * 设置选择数量的按钮 
		 * @param Button
		 * 
		 */		
		protected function setCustomNumIncreStepperStyles(button:Button):void
		{
			button.defaultSkin = new Image(ResManager.defaultAssets.getTexture("store_btn_addnumber1"));
			button.downSkin = new Image(ResManager.defaultAssets.getTexture("store_btn_addnumber2"));
			button.defaultIcon = new Image(ResManager.defaultAssets.getTexture("store_icon_add1"));
			button.downIcon = new Image(ResManager.defaultAssets.getTexture("store_icon_add2"));
		}
		/**
		 * 设置选择数量的按钮 
		 * @param Button
		 * 
		 */		
		protected function setCustomNumDecreStepperStyles(button:Button):void
		{
			button.defaultSkin = new Image(ResManager.defaultAssets.getTexture("store_btn_addnumber1"));
			button.downSkin = new Image(ResManager.defaultAssets.getTexture("store_btn_addnumber2"));
			button.downIcon = new Image(ResManager.defaultAssets.getTexture("store_icon_minus2"));
			button.defaultIcon = new Image(ResManager.defaultAssets.getTexture("store_icon_minus1"));
		}
		/**
		 * 设置邀请等的按钮 
		 * @param Button
		 * 
		 */		
		protected function setInviteButtonStyles(button:Button):void
		{
			button.styleProvider = null;
			button.defaultSkin = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_confirm1"));
			button.downSkin = new Image(ResManager.defaultAssets.getTexture("mailbox_btn_confirm2"));
		}
		/**
		 * 输入框
		 * @param textInput
		 * 
		 */		
		protected function setNumericStepperCustomTextInputStyles(textInput:TextInput):void
		{
			textInput.isEnabled = false;
			textInput.isEditable = false;
			textInput.restrict = "0-9";
			textInput.textEditorProperties.textAlign = TextBlockTextEditor.TEXT_ALIGN_CENTER;
			textInput.textEditorProperties.fontSize = 22;
			textInput.textEditorProperties.color = 0xdadada;
			var s9:Scale9Textures = new Scale9Textures(ResManager.defaultAssets.getTexture("store_bg_numberbox")
				,new Rectangle(5,10,1,1));
			var s9i:Scale9Image = new Scale9Image(s9);
			s9i.width = 188;
			textInput.backgroundSkin = s9i;
		}

		protected static function scrollBarFactory():SimpleScrollBar
		{
			return new SimpleScrollBar();
		}
	}
}