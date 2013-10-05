package net.littlepad.splito.files
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	
	import net.littlepad.splito.data.ImportFileData;
	import net.littlepad.splito.data.OutputSettingData;
	import net.littlepad.splito.module.output.images.events.OutputJpegEvent;
	import net.littlepad.splito.events.OutputJpegsEvent;
	import net.littlepad.splito.resources.PageType;
	import net.littlepad.splito.utils.FileName;
	import net.littlepad.splito.utils.ImageProcessing;
	import net.littlepad.splito.module.output.images.OutputJpeg;
	
	/**
	 * 左右ページのJPEGを出力するクラス
	 */
	public class OutputJpegsManager extends EventDispatcher
	{
		private var _outputJpegLeft:OutputJpeg;
		private var _outputJpegRight:OutputJpeg;
		private var _bmd:BitmapData;
		private var _scale:Number;
		private var _leftRect:Rectangle;
		private var _rightRect:Rectangle;
		private var _fileUrl:String;
		private var _isLeftJpegOutputed:Boolean;
		private var _leftBmd:BitmapData;
		private var _rightBmd:BitmapData;
		
		/**
		 * コンストラクタ
		 * @param importFileData ImportFileData
		 * @param outputJpegSettingData OutputJpegSettingData
		 */
		public function OutputJpegsManager(importFileData:ImportFileData, outputSettingData:OutputSettingData)
		{
			_bmd = importFileData.bmd;
			_fileUrl = importFileData.fileUrl;
			_scale = outputSettingData.scale;
			_leftRect = outputSettingData.leftRect;
			_rightRect = outputSettingData.rightRect;
		}
		
		/**
		 * JPEG生成
		 */
		public function create():void
		{
			_outputJpegLeft = new OutputJpeg();
			_outputJpegRight = new OutputJpeg();
			imageProcessing();
			outputLeftJpeg();
		}
		
		/**
		 * JPEGの加工
		 */
		private function imageProcessing():void
		{
			_leftBmd = ImageProcessing.changeScale(_bmd, _scale);
			_leftBmd = ImageProcessing.triming(_leftBmd, _leftRect);
			_rightBmd = ImageProcessing.changeScale(_bmd, _scale);
			_rightBmd = ImageProcessing.triming(_rightBmd, _rightRect);
		}
		
		/**
		 * 左ページのJPEG書き出し
		 */
		private function outputLeftJpeg():void
		{
			_outputJpegLeft.addEventListener(OutputJpegEvent.PROGRESS, outputJpegProgressHandler);
			_outputJpegLeft.addEventListener(OutputJpegEvent.COMPLETE, outputJpegCompleteHandler);
			var file:File = File.desktopDirectory.resolvePath(FileName.getOutputJpegName(_fileUrl, PageType.LEFT));
			_outputJpegLeft.create(_leftBmd, file);
		}
		
		/**
		 * 右ページのJPEG書き出し
		 */
		private function outputRightJpeg():void
		{
			_outputJpegRight.addEventListener(OutputJpegEvent.PROGRESS, outputJpegProgressHandler);
			_outputJpegRight.addEventListener(OutputJpegEvent.COMPLETE, outputJpegCompleteHandler);
			var file:File = File.desktopDirectory.resolvePath(FileName.getOutputJpegName(_fileUrl, PageType.RIGHT));
			_outputJpegRight.create(_rightBmd, file);
		}
		
		/**
		 * 左ページJPEG書き出しのイベント削除
		 */
		private function removeLeftJpegEvent():void
		{
			_outputJpegLeft.removeEventListener(OutputJpegEvent.PROGRESS, outputJpegProgressHandler);
			_outputJpegLeft.removeEventListener(OutputJpegEvent.COMPLETE, outputJpegCompleteHandler);
		}
		
		/**
		 * 右ページJPEG書き出しのイベント削除
		 */
		private function removeRightJpegEvent():void
		{
			_outputJpegRight.removeEventListener(OutputJpegEvent.PROGRESS, outputJpegProgressHandler);
			_outputJpegRight.removeEventListener(OutputJpegEvent.COMPLETE, outputJpegCompleteHandler);
		}
		
		/**
		 * JPEG出力プログレスハンドラ
		 * @param event OutputFileEvent
		 */
		private function outputJpegProgressHandler(event:OutputJpegEvent):void
		{
			if(!_isLeftJpegOutputed){
				dispatchEvent(new OutputJpegsEvent(OutputJpegsEvent.PROGRESS, uint(event.parcent/2)));
			} else {
				dispatchEvent(new OutputJpegsEvent(OutputJpegsEvent.PROGRESS, uint(event.parcent/2 + 50)));
			}
		}
		
		/**
		 * JPEGファイル出力完了ハンドラ
		 * @param event OutputFileEvent
		 */
		private function outputJpegCompleteHandler(event:OutputJpegEvent):void
		{
			if(_isLeftJpegOutputed){
				removeRightJpegEvent();
				dispatchEvent(new OutputJpegsEvent(OutputJpegsEvent.COMPLETE));
				return;
			} else {
				_isLeftJpegOutputed = true;
				removeLeftJpegEvent();
				outputRightJpeg();
			}
		}
	}
}