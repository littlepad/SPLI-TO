package net.littlepad.splito.delegates
{
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.events.NativeDragEvent;
	
	import net.littlepad.splito.view.pages.SplitPageView;
	
	
	public class DropDelegate
	{
		private var _target:SplitPageView;
		private var _callback:Function;
		
		/**
		 * コンストラクタ
		 */
		public function DropDelegate()
		{
		}
		
		/**
		 * 初期化
		 * @param target SplitPage
		 * @param callback Function
		 */
		public function init(target:SplitPageView, callback:Function=null):void
		{
			_target = target;
			_callback = callback;
			_target.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, onDragEnterHander);
			//_target.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, onDragDropHandler);
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
		
//		/**
//		 * onDragEnterHander
//		 * @param event NativeDragEvent
//		 */
//		private function onDragDropHandler(event:NativeDragEvent):void
//		{
//			var files:Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
//			_callback(files[0]);
//		}
		
	}
}