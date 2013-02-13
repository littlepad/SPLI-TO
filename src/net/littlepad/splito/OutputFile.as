package net.littlepad.splito 
{
	import by.blooddy.crypto.image.JPEGEncoder;
	
	import net.littlepad.splito.events.OutputFileEvent;
	
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.OutputProgressEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class OutputFile extends EventDispatcher
	{
		private var _stream:FileStream;
		
		/**
		 * コンストラクタ
		 */
		public function OutputFile()
		{
		}
		
		/**
		 * 出力ファイルを生成する
		 * @param loader Loader
		 * @param scale 写真のスケール
		 * @param rect 写真のトリミング範囲
		 * @param fileName 書き出すファイル名
		 */
		public function create(loader:Loader, scale:Number, rect:Rectangle, fileName:String):void
		{
			// 写真のサイズ変更
			var bmd:BitmapData = changePhotoScale(loader, scale);
			
			// 写真のトリミング
			var trimingBmd:BitmapData = trimingPhoto(bmd, rect);
			
			//  JPEGエンコード
			var jpg:ByteArray = JPEGEncoder.encode(trimingBmd,100);
			
			// 画像ファイルの書き出し
			outputFile(jpg, fileName);
		}
		
		/**
		 * 写真のトリミング
		 * @param bmd BitmapData
		 * @param rect トリミング範囲
		 * @return トリミングしたBitmapData
		 */
		private function trimingPhoto(bmd:BitmapData, rect:Rectangle):BitmapData
		{
			var ba:ByteArray = bmd.getPixels(rect);
			ba.position = 0;
			
			var result:BitmapData = new BitmapData(rect.width, rect.height);
			result.setPixels(new Rectangle(0, 0, rect.width, rect.height), ba);
			
			return result;
		}
		
		/**
		 * 写真のサイズ変更
		 * @param loader Loader
		 * @param scale 写真のスケール
		 * @return リサイズした画像のBitmapData
		 */
		private function changePhotoScale(loader:Loader, scale:Number):BitmapData
		{
			var orgWidth:Number = loader.width;
			var orgHeight:Number = loader.height;
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xFFFFFF);
			s.graphics.drawRect(0, 0, orgWidth, orgHeight);
			s.graphics.endFill();
			s.addChild(loader);
			
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			var result:BitmapData = new BitmapData(orgWidth*scale, orgHeight*scale);
			result.draw(s, matrix, null, null, null, true);
			
			return result;
		}
		
		/**
		 * 画像ファイルの書き出し
		 * @param ba ByteArray
		 * @param fileName ファイル名
		 */
		private function outputFile(ba:ByteArray, fileName:String):void
		{
			var file:File = File.desktopDirectory.resolvePath(fileName);
			_stream = new FileStream();
			_stream.openAsync(file, FileMode.WRITE);
			_stream.addEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);
			_stream.writeBytes(ba);
		}
		
		/**
		 * ファイル書き出しプログレスハンドラ
		 * @param event OutputProgressEvent
		 */
		private function outputProgressHandler(event:OutputProgressEvent):void
		{
			dispatchEvent(new OutputFileEvent(OutputFileEvent.PROGRESS, 100 - (event.bytesPending / event.bytesTotal)*100));
			if(event.bytesPending == 0){
				_stream.removeEventListener(OutputProgressEvent.OUTPUT_PROGRESS, outputProgressHandler);
				_stream.close();
				dispatchEvent(new OutputFileEvent(OutputFileEvent.COMPLETE));
			}
		}
	}
}