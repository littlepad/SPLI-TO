package net.littlepad.splito.models
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	
	import net.littlepad.splito.events.SplitPageModelEvent;
	
	public class SplitPageModel extends EventDispatcher
	{
		private var _jpegUrl:String;
		private var _jpegBmp:Bitmap;
		
		public function SplitPageModel()
		{
		}

		/**
		 * JPEGの読み込み処理
		 * @param url JPEGファイルのURL
		 */
		public function loadJpeg(url:String):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(event:Event):void {
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, arguments.callee);
				_jpegBmp = loader.content as Bitmap;
				dispatchEvent(new SplitPageModelEvent(SplitPageModelEvent.LOAD_COMPLETE));
			});
			loader.load(new URLRequest(url));
		}
		
		public function set jpegUrl(value:String):void
		{
			_jpegUrl = value;
		}
		
		public function get jpegUrl():String
		{
			return _jpegUrl;
		}
		
		public function get jpegBmp():Bitmap
		{
			return _jpegBmp;
		}
	}
}