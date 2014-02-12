package net.littlepad.splito.module.output.images.events
{
	import flash.events.Event;

	public class OutputJpegEvent extends Event
	{
		public static const PROGRESS:String = "outputJpegProgress";
		public static const COMPLETE:String = "outputJpegComplete";
		private var _parcent:Number;
		
		public function OutputJpegEvent(type:String, parcent:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			_parcent = parcent;
			super(type, bubbles, cancelable);
		}

		public function get parcent():Number
		{
			return _parcent;
		}

	}
}