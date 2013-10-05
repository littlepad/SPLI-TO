package net.littlepad.splito.view.pages
{
	import net.littlepad.splito.configs.PageConfig;

	public class LeftPageView extends PageView
	{
		public function LeftPageView()
		{
			super();
		}
		
		override protected function setView():void
		{
			super.setView();
			this.line.xFrom = PageConfig.A6_PRINT_WIDTH - (PageConfig.CLIPPING_WIDTH + PageConfig.THROAT_MARGIN);
			this.line.xTo = PageConfig.A6_PRINT_WIDTH - (PageConfig.CLIPPING_WIDTH + PageConfig.THROAT_MARGIN);
			this.line.yFrom = 0;
			this.line.yTo = PageConfig.A6_PRINT_HEIGHT;
			this.base.source = "assets/leftBase.png";
		}
		
		/**
		 * 画像が縦フィットかどうか？
		 * @param pageRatio ページ比率
		 * @return Boolean
		 */
		public function isTateFit(pageRatio:Number):Boolean
		{
			return image.sourceWidth / image.sourceHeight > pageRatio;
		}
		
		/**
		 * 画像の位置調整
		 * @param splitPageWidth 見開きページの横サイズ
		 * @param splitPageHeight 見開きページの縦サイズ
		 * @param scale 拡大縮小率
		 */
		public function setImagePosition(splitPageWidth:Number, splitPageHeight:Number, scale:Number):void
		{
			setImageVerticalPosition(splitPageHeight, scale);
			setImageHolizontalPosition(splitPageWidth, scale);
		}
		
		/**
		 * 画像の縦位置調整
		 * @param splitPageHeight 見開きページの縦サイズ
		 * @param scale 拡大縮小率
		 */
		private function setImageVerticalPosition(splitPageHeight:Number, scale:Number):void
		{
			if(image.sourceHeight*scale + image.y <= splitPageHeight){
				image.y += splitPageHeight - (image.sourceHeight*scale + image.y);
			}
		}
		
		/**
		 * 画像の横位置調整
		 * @param splitPageWidth 見開きページの横サイズ
		 * @param scale 拡大縮小率
		 */
		private function setImageHolizontalPosition(splitPageWidth:Number, scale:Number):void
		{
			if(image.sourceWidth*scale + image.x <= splitPageWidth){
				image.x += splitPageWidth - (image.sourceWidth*scale + image.x);
			}
		}
		

	}
}