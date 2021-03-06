package net.littlepad.splito.configs
{
	public class PageConfig
	{
		/**
		 * A6サイズ (105mm x 148mm)
		 */
		public static const A6_WIDTH:Number = 1446;
		public static const A6_HEIGHT:Number = 2038;
		
		/**
		 * ドブサイズ (3mm)
		 */
		public static const CLIPPING_WIDTH:Number = 42;
		public static const CLIPPING_HEIGHT:Number = 42;
		
		/**
		 * 印刷サイズ（A6サイズ + ドブ）
		 */
		public static const A6_PRINT_WIDTH:Number = A6_WIDTH + CLIPPING_WIDTH * 2;
		public static const A6_PRINT_HEIGHT:Number = A6_HEIGHT + CLIPPING_HEIGHT * 2;
		
		/**
		 * ノド部分の余裕値 (5mm)
		 */
		public static const THROAT_MARGIN:Number = 70;
	}
}