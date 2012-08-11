package net.littlepad.splito
{
	import net.littlepad.splito.events.OutputFileEvent;
	import net.littlepad.splito.events.OutputFilesEvent;
	
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;

	public class OutputFiles extends EventDispatcher
	{
		private var _outputFileLeft:OutputFile;
		private var _outputFileRight:OutputFile;
		private var _loader:Loader;
		private var _scale:Number;
		private var _leftRect:Rectangle;
		private var _rightRect:Rectangle;
		private var _fileUrl:String;
		private var _isLeftFileOutputed:Boolean;
		
		/**
		 * コンストラクタ
		 * @param loader Loader
		 * @param scale スケール
		 * @param leftRect 左ページの出力エリア
		 * @param rightRect 右ページの出力エリア
		 * @param fileUrl 画像ファイルのURL
		 */
		public function OutputFiles(loader:Loader, scale:Number, leftRect:Rectangle, rightRect:Rectangle, fileUrl:String)
		{
			_loader = loader;
			_scale = scale;
			_leftRect = leftRect;
			_rightRect = rightRect;
			_fileUrl = fileUrl;
		}
		
		/**
		 * 画像生成
		 */
		public function create():void
		{
			_outputFileLeft = new OutputFile();
			_outputFileRight = new OutputFile();
			outputLeftFile();
		}
		
		/**
		 * 左ページの画像ファイル書き出し
		 */
		private function outputLeftFile():void
		{
			_outputFileLeft.addEventListener(OutputFileEvent.PROGRESS, outputFileProgressHandler);
			_outputFileLeft.addEventListener(OutputFileEvent.COMPLETE, outputFileCompleteHandler);
			_outputFileLeft.create(_loader, _scale, _leftRect, FileName.getOutputFileName(_fileUrl, FileName.LEFT_PAGE));
		}
		
		/**
		 * 右ページの画像ファイル書き出し
		 */
		private function outputRightFile():void
		{
			_outputFileRight.addEventListener(OutputFileEvent.PROGRESS, outputFileProgressHandler);
			_outputFileRight.addEventListener(OutputFileEvent.COMPLETE, outputFileCompleteHandler);
			_outputFileRight.create(_loader, _scale, _rightRect, FileName.getOutputFileName(_fileUrl, FileName.RIGHT_PAGE));
		}
		
		/**
		 * 左ページ画像書き出しのイベント削除
		 */
		private function removeLeftFileEvent():void
		{
			_outputFileLeft.removeEventListener(OutputFileEvent.PROGRESS, outputFileProgressHandler);
			_outputFileLeft.removeEventListener(OutputFileEvent.COMPLETE, outputFileCompleteHandler);
		}
		
		/**
		 * 右ページ画像書き出しのイベント削除
		 */
		private function removeRightFileEvent():void
		{
			_outputFileRight.removeEventListener(OutputFileEvent.PROGRESS, outputFileProgressHandler);
			_outputFileRight.removeEventListener(OutputFileEvent.COMPLETE, outputFileCompleteHandler);
		}
		
		/**
		 * 画像ファイル出力プログレスハンドラ
		 * @param event OutputFileEvent
		 */
		private function outputFileProgressHandler(event:OutputFileEvent):void
		{
			if(!_isLeftFileOutputed){
				dispatchEvent(new OutputFilesEvent(OutputFilesEvent.PROGRESS, uint(event.parcent/2)));
			} else {
				dispatchEvent(new OutputFilesEvent(OutputFilesEvent.PROGRESS, uint(event.parcent/2 + 50)));
			}
		}
		
		/**
		 * 画像ファイル出力完了ハンドラ
		 * @param event OutputFileEvent
		 */
		private function outputFileCompleteHandler(event:OutputFileEvent):void
		{
			if(_isLeftFileOutputed){
				removeRightFileEvent();
				dispatchEvent(new OutputFilesEvent(OutputFilesEvent.COMPLETE));
			} else {
				_isLeftFileOutputed = true;
				removeLeftFileEvent();
				outputRightFile();
			}
		}
	}
}