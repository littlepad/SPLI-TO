package net.littlepad.splito 
{
	public class FileName
	{
		public static const LEFT_PAGE:String = "leftPage";
		public static const RIGHT_PAGE:String = "RightPage";
		public static const OUTPUT_DIRECTORY:String = "tolot_output/";
		
		public function FileName()
		{
		}
		
		/**
		 * 出力ファイル名をつける
		 * @param fileUrl オリジナルのファイルURL
		 * @param pageType 左ページの画像か右ページの画像か
		 * @return 出力するファイル名
		 */
		public static function getOutputFileName(fileUrl:String, pageType:String):String
		{
			var newFileName:String = FileName.OUTPUT_DIRECTORY + getFileNameFromUrl(fileUrl);
			var identifier:String;
			switch(pageType){
				case LEFT_PAGE:
					identifier = "_left.jpg";
					break;
				case RIGHT_PAGE:
					identifier = "_right.jpg";
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
	}
}