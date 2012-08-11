package net.littlepad.splito.splitPage
{
	public class Config
	{
		/**
		 * A6サイズ (105mm x 148mm)
		 * 180dpi時のピクセル値
		 */
		public static const A6_WIDTH:Number = 1446;
		public static const A6_HEIGHT:Number = 2038;
		
		/**
		 * ドブサイズ (3mm)
		 * 180dpi時のピクセル値
		 */
		public static const CLIPPING_WIDTH:Number = 42;
		public static const CLIPPING_HEIGHT:Number = 42;
		
		/**
		 * 印刷サイズ（A6サイズ + ドブ）
		 * 180dpi時のピクセル値
		 */
		public static const A6_PRINT_WIDTH:Number = A6_WIDTH + CLIPPING_WIDTH * 2;
		public static const A6_PRINT_HEIGHT:Number = A6_HEIGHT + CLIPPING_HEIGHT * 2;
		
		/**
		 * ノド部分の余裕値 (5mm)
		 * 180dpi時のピクセル値
		 */
		public static const THROAT_MARGIN:Number = 70;
	}
}