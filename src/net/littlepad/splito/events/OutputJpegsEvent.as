package net.littlepad.splito.events
{
	import flash.events.Event;

	public class OutputJpegsEvent extends Event
	{
		public static const PROGRESS:String = "outputJpegsProgress";
		public static const COMPLETE:String = "outputJpegsComplete";
		private var _parcent:uint;
		
		public function OutputJpegsEvent(type:String, parcent:uint = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_parcent = parcent;
			super(type, bubbles, cancelable);
		}

		public function get parcent():uint
		{
			return _parcent;
		}

	}
}