package net.littlepad.splito.splitPage.delegates
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;
	
	import net.littlepad.splito.splitPage.SplitPage;
	
	public class DropDelegate
	{
		private var _target:SplitPage;
		
		/**
		 * コンストラクタ
		 */
		public function DropDelegate()
		{
		}
		
		/**
		 * 初期化
		 * @param target SplitPage
		 */
		public function init(target:SplitPage):void
		{
			_target = target;
			_target.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onDragEnterHander);
			_target.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onDragDropHandler);
		}
		
		/**
		 * onDragEnterHander
		 * @param event NativeDragEvent
		 */
		private function onDragEnterHander(event:NativeDragEvent):void
		{
			var cb:Clipboard = event.clipboard;
			if(cb.hasFormat(ClipboardFormats.FILE_LIST_FORMAT)){
				NativeDragManager.acceptDragDrop(_target);
			}
		}
		
		/**
		 * onDragEnterHander
		 * @param event NativeDragEvent
		 */
		private function onDragDropHandler(event:NativeDragEvent):void
		{
			var files:Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			var url:String = files[0].url;
			
			// ファイルがJPEGかチェック
			if(checkJpegFileType(url)) {
				// JPEGの時
				
				// 読み込んだ画像がサイズを満たしているかチェック
				var loadedJpegSizeCheck:Function = function(loader:Loader):void {
					if(loader.width >= _target.SPLIT_PAGE_WIDTH && loader.height >= _target.SPLIT_PAGE_HEIGHT) {
						_target.imageFile = new File(url);
						_target.setPhoto();
						
					} else {
						Alert.show("横サイズ" + _target.SPLIT_PAGE_WIDTH + "ピクセル以上、縦サイズ" + _target.SPLIT_PAGE_HEIGHT + "ピクセル以上の画像を使用してください。", "サイズエラー");
					}
				}
				
				loadJpeg(url, loadedJpegSizeCheck);
				
			} else {
				// JPEG以外の時
				Alert.show("JPEGファイルをドロップしてください。", "エラー");
			}
		}
		
		/**
		 * JPEGの読み込み処理
		 * @param url JPEGファイルのURL
		 * @param callback コールバック関数
		 */
		private function loadJpeg(url:String, callback:Function):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, arguments.callee);
				callback(loader);
			});
			loader.load(new URLRequest(url));
		}
		
		
		/**
		 * JPEGかどうかチェック
		 * @param fileName ファイル名
		 * @return Boolean
		 */
		private function checkJpegFileType(fileName:String):Boolean
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