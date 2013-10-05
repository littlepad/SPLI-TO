package net.littlepad.splito.controllers
{
	import flash.desktop.ClipboardFormats;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;
	
	import mx.controls.Alert;
	
	import net.littlepad.splito.delegates.DragDelegate;
	import net.littlepad.splito.delegates.DropDelegate;
	import net.littlepad.splito.events.ImageEvent;
	import net.littlepad.splito.events.SplitPageModelEvent;
	import net.littlepad.splito.models.SplitPageModel;
	import net.littlepad.splito.utils.FileName;
	import net.littlepad.splito.view.pages.SplitPageView;
	
	public class SplitPageController extends EventDispatcher
	{
		private var _view:SplitPageView;
		private var _model:SplitPageModel;
		private var _url:String;
		
		public function SplitPageController(model:SplitPageModel, view:SplitPageView)
		{
			_model = model;
			_view = view;
			init();
		}

		private function init():void
		{
			var dragDelegate:DragDelegate = new DragDelegate();
			dragDelegate.init(_view);
			
			var dropDelegate:DropDelegate = new DropDelegate();
			dropDelegate.init(_view);
			
			_view.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, nativeDragDropHandler);
		}
		
		/**
		 * nativeDragDropHandler
		 * @param event NativeDragEvent
		 */
		private function nativeDragDropHandler(event:NativeDragEvent):void
		{
			var files:Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			droppedFileCheck(files[0]);
		}
		
		private function droppedFileCheck(file:File):void
		{
			_url = file.url;
			
			// ファイルがJPEGかチェック
			if(FileName.isJpeg(_url)) {
				// JPEGの時
				_model.addEventListener(SplitPageModelEvent.LOAD_COMPLETE, loadCompleteHandler);
				_model.loadJpeg(_url);
				
			} else {
				// JPEG以外の時
				Alert.show("JPEGファイルをドロップしてください。", "エラー");
			}
		}
		
		private function loadCompleteHandler(event:SplitPageModelEvent):void
		{
			_model.removeEventListener(SplitPageModelEvent.LOAD_COMPLETE, loadCompleteHandler);
			var bmp:Bitmap = event.data as Bitmap;
			checkImageSize(bmp.width, bmp.height);
		}
		
		/**
		 * 読み込んだ画像がサイズを満たしているかチェック
		 */
		private function checkImageSize(imageWidth:Number, imageHeight:Number):void
		{
			if(imageWidth >= _view.SPLIT_PAGE_WIDTH && imageHeight >= _view.SPLIT_PAGE_HEIGHT) {
				model.jpegUrl = _url;
				setImage();
			} else {
				Alert.show("横サイズ" + _view.SPLIT_PAGE_WIDTH + "ピクセル以上、縦サイズ" + _view.SPLIT_PAGE_HEIGHT + "ピクセル以上の画像を使用してください。", "サイズエラー");
			}
		}
		
		/**
		 * 画像をセット
		 */
		public function setImage():void
		{
			_view.leftPage.addEventListener(ImageEvent.READY, function():void{
				_view.leftPage.removeEventListener(ImageEvent.READY, arguments.callee);
				_view.rightPage.addEventListener(ImageEvent.READY, function():void{
					_view.rightPage.removeEventListener(ImageEvent.READY, arguments.callee);
					// 画像を見開きページぴったりに収める
					_view.fitPage();

				});
				_view.rightPage.setImageSource(model.jpegUrl);
			});
			_view.leftPage.setImageSource(model.jpegUrl);
		}
		
		public function get model():SplitPageModel
		{
			return _model;
		}
	}
}