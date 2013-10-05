package net.littlepad.splito.events
{
	import flash.events.Event;
	
	public class MainEvent extends Event
	{
		public static const SAVE_BUTTON_CLICKED:String = "saveButtonClicked";
		
		public function MainEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}