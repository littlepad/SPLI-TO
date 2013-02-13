package net.littlepad.splito.events
{
	import flash.events.Event;

	public class OutputFileEvent extends Event
	{
		public static const PROGRESS:String = "outputFileProgress";
		public static const COMPLETE:String = "outputFileComplete";
		public var parcent:Number;
		
		public function OutputFileEvent(type:String, parcent:Number = 0, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.parcent = parcent;
			super(type, bubbles, cancelable);
		}
	}
}