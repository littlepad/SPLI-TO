package net.littlepad.splito.events
{
	import flash.events.Event;
	
	public class SplitPageEvent extends Event
	{
		public static const DISPLAY_COMPLETE:String = "splitPagePageDisplayComplete";
		
		public function SplitPageEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}