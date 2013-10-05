package net.littlepad.splito.module.output.images 
{
	import by.blooddy.crypto.image.JPEGEncoder;
	
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.events.OutputProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import net.littlepad.splito.module.output.images.events.OutputJpegEvent;
	
	/**
	 * JPEGファイルを出力を管理するクラス
	 */
	public class OutputJpeg extends EventDispatcher
	{
		private var _stream:FileStream;
		
		/**
		 * コンストラクタ
		 */
		public function OutputJpeg()
		{
		}
		
		/**
		 * JPEGファイルを生成する
		 * @param bmd 画像のBitmapData
		 * @param file 書き出すファイル
		 */
		public function create(bmd:BitmapData, file:File):void
		{
			//  JPEGエンコード
			var jpg:ByteArray = JPEGEncoder.encode(bmd,100);
			
			// JPEGファイルの書き出し
			output(jpg, file);
		}
		
		/**
		 * JPEGファイルの書き出し
		 * @param ba ByteArray
		 * @param fileName ファイル
		 */
		private function output(ba:ByteArray, file:File):void
		{
			_stream = new FileStream();
			_stream.openAsync(file, FileMode.WRITE);
			_stream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);
			_stream.writeBytes(ba);
		}
		
		/**
		 * JPEG書き出しプログレスハンドラ
		 * @param event OutputProgressEvent
		 */
		private function outputProgressHandler(event:OutputProgressEvent):void
		{
			dispatchEvent(new OutputJpegEvent(OutputJpegEvent.PROGRESS, 100 - (event.bytesPending / event.bytesTotal)*100));
			if(event.bytesPending != 0) return;
			outputComplete();
		}
		
		/**
		 * JPEG書き出し完了
		 */
		private function outputComplete():void
		{
			_stream.removeEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);
			_stream.close();
			dispatchEvent(new OutputJpegEvent(OutputJpegEvent.COMPLETE));
		}
	}
}