package net.littlepad.splito.events
{
	import flash.events.Event;
	
	public class MainModelEvent extends Event
	{
		public static const OUTPUT_COMPLETE:String = "mainModelOutputComplete";
		public static const OUTPUT_PROGRESS:String = "mainModelOutputProgress";
		public static const LOAD_ERROR:String = "mainModelLoadError";
		private var _parcent:Number;
		
		public function MainModelEvent(type:String, parcent:Number=0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_parcent = parcent;
		}

		public function get parcent():Number
		{
			return _parcent;
		}

	}
}