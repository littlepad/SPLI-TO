package net.littlepad.splito.views.pages
{
	import net.littlepad.splito.configs.PageConfig;

	public class RightPageView extends PageView
	{
		public function RightPageView()
		{
			super();
		}
		
		override protected function setView():void
		{
			super.setView();
			this.line.xFrom = PageConfig.CLIPPING_WIDTH + PageConfig.THROAT_MARGIN;
			this.line.xTo = PageConfig.CLIPPING_WIDTH + PageConfig.THROAT_MARGIN;
			this.line.yFrom = 0;
			this.line.yTo = PageConfig.A6_PRINT_HEIGHT;
			this.base.source = "assets/rightBase.png";
		}
		
		/**
		 * 画像の位置調整
		 * @param leftPageX 左ページのx座標
		 * @param leftPageY 左ページのy座標
		 */
		public function setImagePosition(leftPageX:Number, leftPageY:Number):void
		{
			image.x = leftPageX - PageConfig.A6_PRINT_WIDTH + (PageConfig.CLIPPING_WIDTH + PageConfig.THROAT_MARGIN)*2;
			image.y = leftPageY;
		}
		
	}
}