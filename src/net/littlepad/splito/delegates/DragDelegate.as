package net.littlepad.splito.delegates
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import net.littlepad.splito.views.pages.SplitPageView;

	public class DragDelegate
	{
		private var _target:SplitPageView;
		
		/**
		 * コンストラクタ
		 */
		public function DragDelegate()
		{
			
		}
		
		/**
		 * 初期化
		 * @param target ターゲット
		 */
		public function init(target:SplitPageView):void
		{
			_target = target;
			_target.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_target.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * 移動開始
		 * @param event MouseEvent
		 */
		private function onMouseDown(event:MouseEvent):void
		{
			_target.leftPage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			_target.leftPage.image.startDrag(false, new Rectangle(
				_target.SPLIT_PAGE_WIDTH - _target.leftPage.image.sourceWidth * _target.scale, 
				_target.SPLIT_PAGE_HEIGHT - _target.leftPage.image.sourceHeight * _target.scale, 
				_target.leftPage.image.sourceWidth * _target.scale - _target.SPLIT_PAGE_WIDTH, 
				_target.leftPage.image.sourceHeight * _target.scale - _target.SPLIT_PAGE_HEIGHT
			));
		}
		
		/**
		 * 移動中
		 * @param event Event
		 */
		private function onEnterFrame(event:Event):void
		{
			_target.rightPage.setImagePosition(_target.leftPage.image.x, _target.leftPage.image.y);
		}
		
		/**
		 * 移動終了
		 * @param event MouseEvent
		 */
		private function onMouseUp(event:MouseEvent):void
		{
			_target.leftPage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			_target.rightPage.setImagePosition(_target.leftPage.image.x, _target.leftPage.image.y);
			_target.leftPage.image.stopDrag();
		}

	}
}