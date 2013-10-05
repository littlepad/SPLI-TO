package net.littlepad.splito.views.pages
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import mx.events.FlexEvent;
	
	import net.littlepad.splito.configs.PageConfig;
	import net.littlepad.splito.events.ImageEvent;
	import net.littlepad.splito.views.pages.mxml.PageViewBase;
	
	public class PageView extends PageViewBase
	{
		public function PageView()
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			this.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function removedFromStageHandler(event:Event):void
		{
			this.removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			image.removeEventListener(FlexEvent.READY, readyHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
		}
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			image.addEventListener(FlexEvent.READY, readyHandler);
			setView();
		}
		
		protected function setView():void
		{
			this.width = PageConfig.A6_PRINT_WIDTH;
			this.height = PageConfig.A6_PRINT_HEIGHT;
			this.mask = pageMask;
		}
		
		private function readyHandler(event:FlexEvent):void
		{
			base.visible = false;
			dispatchEvent(new ImageEvent(ImageEvent.READY));
		}
		
		/**
		 * 画像のスケール調整
		 * @param scale スケール
		 */
		public function setImageScale(scale:Number):void
		{
			image.scaleX = image.scaleY = scale;
		}
		
		/**
		 * 画像のURLを設定
		 * @param url 画像のURL
		 */
		public function setImageSource(url:String):void
		{
			image.source = url;
		}
		
		/**
		 * 画像の表示範囲を返す
		 */
		public function getRectanle():Rectangle
		{
			return new Rectangle(-int(image.x), -int(image.y), int(this.width), int(this.height));
		}
	}
}