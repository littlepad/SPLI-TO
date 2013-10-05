package net.littlepad.splito.events
{
	import flash.events.Event;
	
	public class MainModelEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "mainModelEventLoadComplete";
		public static const LOAD_ERROR:String = "mainModelEventLoadError";
		public static const OUTPUT_PROGRESS:String = "mainModelEventOutputProgress";
		public static const OUTPUT_COMPLETE:String = "mainModelEventOutputComplete";
		private var _data:*
		
		public function MainModelEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
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