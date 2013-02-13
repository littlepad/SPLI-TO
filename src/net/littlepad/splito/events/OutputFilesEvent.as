package net.littlepad.splito.events
{
	import flash.events.Event;

	public class OutputFilesEvent extends Event
	{
		public static const PROGRESS:String = "outputFielsProgress";
		public static const COMPLETE:String = "outputFilesComplete";
		private var _parcent:uint;
		
		public function OutputFilesEvent(type:String, parcent:uint = 0, bubbles:Boolean=false, cancelable:Boolean=false)
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