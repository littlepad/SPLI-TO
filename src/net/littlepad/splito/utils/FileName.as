package net.littlepad.splito.utils 
{
	import net.littlepad.splito.configs.FileConfig;
	import net.littlepad.splito.resources.PageType;
	
	/**
	 * ファイル名を管理するクラス
	 */
	public class FileName
	{	
		public function FileName()
		{
		}
		
		/**
		 * 書き出すJPEGのファイル名をつける
		 * @param fileUrl オリジナルのファイルURL
		 * @param pageType 左ページの画像か右ページの画像か
		 * @return 出力するファイル名
		 */
		public static function getOutputJpegName(fileUrl:String, pageType:String):String
		{
			var newFileName:String = FileConfig.OUTPUT_DIRECTORY + getFileNameFromUrl(fileUrl);
			var identifier:String;
			
			switch(pageType){
				case PageType.LEFT:
					identifier = FileConfig.LEFT_PAGE_IDENTIFIER;
					break;
				
				case PageType.RIGHT:
					identifier = FileConfig.RIGHT_PAGE_IDENTIFIER;
					break;
			}
			
			return newFileName.replace(/.jpg/i, identifier);
		}
		
		/**
		 * ファイルのURLからファイル名だけ抜き出す
		 * @param FileUrl ファイルのURL
		 * @return ファイル名
		 */
		public static function getFileNameFromUrl(fileUrl:String):String
		{
			return fileUrl.substring(fileUrl.lastIndexOf("/") + 1, fileUrl.length);
		}
		
		/**
		 * JPEGかどうかチェック
		 * @param fileName ファイル名
		 * @return Boolean
		 */
		public static function isJpeg(fileName:String):Boolean
		{
			var pattern:RegExp = /\.(jpg|jpeg|jpe)$/i;
			
			if(pattern.exec(fileName) != null){
				return true;
			} else {
				return false;
			}
		}
	}
}