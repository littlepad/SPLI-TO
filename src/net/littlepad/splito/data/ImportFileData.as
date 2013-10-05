package net.littlepad.splito.data
{
	import flash.display.BitmapData;

	public class ImportFileData
	{
		private var _bmd:BitmapData;
		private var _fileUrl:String;
		
		public function ImportFileData(bmd:BitmapData, fileUrl:String)
		{
			_bmd = bmd;
			_fileUrl = fileUrl;
		}

		public function get bmd():BitmapData
		{
			return _bmd;
		}

		public function get fileUrl():String
		{
			return _fileUrl;
		}

	}
}