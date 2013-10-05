package net.littlepad.splito.models
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import net.littlepad.splito.data.ImportFileData;
	import net.littlepad.splito.data.OutputSettingData;
	import net.littlepad.splito.events.MainModelEvent;
	import net.littlepad.splito.events.OutputJpegsEvent;
	import net.littlepad.splito.files.OutputJpegsManager;
	
	public class MainModel extends EventDispatcher
	{
		private var _loader:Loader;
		private var _bmd:BitmapData;
		private var _outputFiles:OutputJpegsManager;
		private var _url:String;
		private var _outputSettingData:OutputSettingData;
		
		public function MainModel()
		{
		}
		
		/**
		 * 画像のロード
		 * @param url 画像のURL
		 */
		public function loadImage(url:String, outputSettingData:OutputSettingData):void
		{
			_url = url;
			_outputSettingData = outputSettingData;
			_loader = new Loader();
			addLoaderEvents();
			_loader.load(new URLRequest(_url));
		}
		
		/**
		 * loaderイベントの追加
		 */
		private function addLoaderEvents():void
		{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteHandler);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		/**
		 * loaderイベントの削除
		 */
		private function removeLoaderEvents():void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadCompleteHandler);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		/**
		 * 画像ロード完了ハンドラ
		 * @param event Event
		 */
		private function loadCompleteHandler(event:Event):void
		{
			removeLoaderEvents();
			outputFiles();
		}
		
		/**
		 * IOErrorハンドラ
		 * @param event IOErrorEvent
		 */
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			removeLoaderEvents();
			dispatchEvent(new MainModelEvent(MainModelEvent.LOAD_ERROR));
		}
		
		public function outputFiles():void
		{
			convertLoaderToBitmapData();
			createOutputFiles(_url, _outputSettingData);
		}
		
		/**
		 * loaderをBitmapDataに変換
		 */
		private function convertLoaderToBitmapData():void
		{
			_bmd = new BitmapData(_loader.width, _loader.height);
			_bmd.draw(_loader, null, null, null, null, true);
		}
		
		/**
		 * 出力画像の生成
		 */
		private function createOutputFiles(url:String, outputSettingData:OutputSettingData):void
		{
			var importFileData:ImportFileData = new ImportFileData(_bmd, url);
			_outputFiles = new OutputJpegsManager(importFileData, outputSettingData);
			_outputFiles.addEventListener(OutputJpegsEvent.COMPLETE, splitFileCompleteHandler);
			_outputFiles.addEventListener(OutputJpegsEvent.PROGRESS, splitFileProgressHandler);
			_outputFiles.create();
		}
		
		/**
		 * 画像書き出しプログレスハンドラ
		 * @param event OutputFilesEvent
		 */
		private function splitFileProgressHandler(event:OutputJpegsEvent):void
		{
			dispatchEvent(new MainModelEvent(MainModelEvent.OUTPUT_PROGRESS, event.parcent));
		}
		
		/**
		 * 画像書き出し完了ハンドラ
		 * @param event OutputFilesEvent
		 */
		private function splitFileCompleteHandler(event:OutputJpegsEvent):void
		{
			removeOutputFilesEvents();
			dispatchEvent(new MainModelEvent(MainModelEvent.OUTPUT_COMPLETE));
		}
		
		/**
		 * OutputFilesイベント削除
		 */
		private function removeOutputFilesEvents():void
		{
			_outputFiles.removeEventListener(OutputJpegsEvent.COMPLETE, splitFileCompleteHandler);
			_outputFiles.removeEventListener(OutputJpegsEvent.PROGRESS, splitFileProgressHandler);
		}
		
	}
}