package net.littlepad.splito.utils
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	/**
	 * 画像の加工をするクラス
	 */
	public class ImageProcessing
	{
		public function ImageProcessing()
		{
		}
		
		/**
		 * 画像のトリミング
		 * @param bmd BitmapData
		 * @param rect トリミング範囲
		 * @return トリミングしたBitmapData
		 */
		public static function triming(bmd:BitmapData, rect:Rectangle):BitmapData
		{
			var ba:ByteArray = bmd.getPixels(rect);
			ba.position = 0;
			
			var result:BitmapData = new BitmapData(rect.width, rect.height);
			result.setPixels(new Rectangle(0, 0, rect.width, rect.height), ba);
			
			return result;
		}
		
		/**
		 * 画像のサイズ変更
		 * @param bmd リサイズする画像のBitmapData
		 * @param scale 画像のスケール
		 * @return リサイズした画像のBitmapData
		 */
		public static function changeScale(bmd:BitmapData, scale:Number):BitmapData
		{
			var orgWidth:Number = bmd.width;
			var orgHeight:Number = bmd.height;
			var result:BitmapData = new BitmapData(orgWidth*scale, orgHeight*scale);
			var matrix:Matrix = new Matrix();
			
			matrix.scale(scale, scale);
			result.draw(bmd, matrix, null, null, null, true);
			
			return result;
		}
	}
}