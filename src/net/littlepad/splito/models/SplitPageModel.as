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
				var bmp:Bitmap = loader.content as Bitmap;
				dispatchEvent(new SplitPageModelEvent(SplitPageModelEvent.LOAD_COMPLETE, bmp));
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
	}
}