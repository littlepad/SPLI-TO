package net.littlepad.splito.views.pages
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	
	import mx.events.FlexEvent;
	
	import net.littlepad.splito.configs.PageConfig;
	import net.littlepad.splito.events.SplitPageViewEvent;
	import net.littlepad.splito.views.pages.mxml.SplitPageViewBase;
	
	public class SplitPageView extends SplitPageViewBase
	{
		public const SPLIT_PAGE_WIDTH:Number = PageConfig.A6_PRINT_WIDTH * 2 - (PageConfig.CLIPPING_WIDTH + PageConfig.THROAT_MARGIN) * 2;
		public const SPLIT_PAGE_HEIGHT:Number = PageConfig.A6_PRINT_HEIGHT;
		private const PAGE_RATIO:Number = SPLIT_PAGE_WIDTH / SPLIT_PAGE_HEIGHT;
		
		[Bindable]
		public var minScale:Number;
		private var _scale:Number;
		
		public function SplitPageView()
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		/**
		 * 画像を見開きページぴったりに収める
		 */
		public function fitPage():void
		{
			minScale = _scale = getJustFitImageScale();
			resizeImage(_scale);
			dispatchEvent(new SplitPageViewEvent(SplitPageViewEvent.DISPLAY_COMPLETE));
		}
		
		/**
		 * 見開きページにぴったり収まった時のスケールを返す
		 * @return scale
		 */
		private function getJustFitImageScale():Number
		{
			// 横の方が大きい（縦フィット）
			if(leftPage.isTateFit(PAGE_RATIO)) {
				return SPLIT_PAGE_HEIGHT / leftPage.image.sourceHeight;
			}
			// 縦の方が大きい（横フィット）
			return SPLIT_PAGE_WIDTH / leftPage.image.sourceWidth;
		}
		
		/**
		 * 画像をリサイズする
		 * @param newScale 新しいスケール
		 */
		public function resizeImage(newScale:Number):void
		{
			switch(true){
				case newScale >= 1:
					_scale = 1
					break;
				case newScale < minScale:
					_scale = minScale;
					break;
				default:
					_scale = newScale;
			}
			
			setPagesImage();
		}
		
		/**
		 * 左右ページの画像位置とサイズ調整
		 */
		private function setPagesImage():void
		{
			setLeftPageImage();
			setRightPageImage();
		}
		
		/**
		 * 左ページの画像位置とサイズ調整
		 */
		private function setLeftPageImage():void
		{
			leftPage.setImageScale(_scale);
			leftPage.setImagePosition(SPLIT_PAGE_WIDTH, SPLIT_PAGE_HEIGHT, _scale);
		}
		
		/**
		 * 右ページの画像位置とサイズ調整
		 */
		private function setRightPageImage():void
		{
			rightPage.setImageScale(_scale);
			rightPage.setImagePosition(leftPage.image.x, leftPage.image.y);
		}
		
		/**
		 * 左ページの画像の表示範囲を返す
		 */
		public function getLeftPageRect():Rectangle
		{
			return leftPage.getRectanle();
		}
		
		/**
		 * 右ページの画像の表示範囲を返す
		 */
		public function getRightPageRect():Rectangle
		{
			return rightPage.getRectanle();
		}
		
		public function get scale():Number { 
			return _scale;
		}

	}
}