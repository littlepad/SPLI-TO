package net.littlepad.splito.events
{
	import flash.events.Event;
	
	public class SplitPageModelEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "splitPageModelEventLoadComplete";
		private var _data:*;
		
		public function SplitPageModelEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}

		public function get data():*
		{
			return _data;
		}

		public function set data(value:*):void
		{
			_data = value;
		}

	}
}