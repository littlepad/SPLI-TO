package flexUnitTests
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import flexunit.framework.Assert;
	
	import org.flexunit.async.Async;
	
	import net.littlepad.splito.events.OutputFileEvent;
	import net.littlepad.splito.OutputFile;
	
	public class OutputFileTest
	{		
		private var _loader:Loader;
		private var _op:OutputFile;
		private const FILE_NAME:String = "output/hoge.jpg";
		private const FILE:File = new File(File.desktopDirectory.url + "/" + FILE_NAME);
		
		[Before(async)]
		public function setUp():void
		{
			_op = new OutputFile();
			
			_loader = new Loader();
			Async.handleEvent(this, _loader.contentLoaderInfo, Event.COMPLETE, onLoaderCompleteHandler, 500);
			_loader.load(new URLRequest("/flexUnitTests/jpg/IMG_2209.JPG"));
		}
		
		protected function onLoaderCompleteHandler(event:Event, passThroughData:Object):void
		{
			
		}
		
		[After]
		public function tearDown():void
		{
			FILE.deleteFile();
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test(async)]
		public function testCreateOutputFile():void
		{
			Async.handleEvent(this, _op, OutputFileEvent.COMPLETE, outputEventHandler, 500);
			_op.create(_loader, 0.5, new Rectangle(0, 0, 100, 100), FILE_NAME);
		}
		
		private function outputEventHandler(event:Event, passThroughData:Object):void
		{
			Assert.assertTrue(FILE.exists);
			var loader:Loader = new Loader();
			
			Async.handleEvent(this, loader.contentLoaderInfo, Event.COMPLETE, function():void{
				Assert.assertEquals(loader.width, 100);
				Assert.assertEquals(loader.height, 100);
			}, 500);
			loader.load(new URLRequest(File.desktopDirectory.url + "/" + FILE_NAME));
		}
	}
}