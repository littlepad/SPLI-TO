package net.littlepad.splito.events
{
	import flash.events.Event;
	
	public class SplitPageModelEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "splitPageModelEventLoadComplete";
		
		public function SplitPageModelEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}