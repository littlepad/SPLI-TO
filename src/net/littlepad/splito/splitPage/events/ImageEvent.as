package net.littlepad.splito.splitPage.events
{
	import flash.events.Event;
	
	public class ImageEvent extends Event
	{
		public static const READY:String = "ready";
		
		public function ImageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}