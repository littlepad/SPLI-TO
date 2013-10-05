package flexUnitTests
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	
	import flexunit.framework.Assert;
	
	import net.littlepad.splito.module.output.images.OutputJpeg;
	import net.littlepad.splito.module.output.images.events.OutputJpegEvent;
	
	import org.flexunit.async.Async;
	
	public class OutputJpegTest
	{		
		private var _loader:Loader;
		private var _op:OutputJpeg;
		private const FILE_NAME:String = "output/hoge.jpg";
		private const FILE:File = new File(File.desktopDirectory.url + "/" + FILE_NAME);
		
		[Before(async)]
		public function setUp():void
		{
			_op = new OutputJpeg();
			
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
		public function testCreateOutputJpeg():void
		{
			Async.handleEvent(this, _op, OutputJpegEvent.COMPLETE, outputEventHandler, 500);
			var bmd:BitmapData = new BitmapData(_loader.width, _loader.height);
			bmd.draw(_loader, null, null, null, null, true);
			_op.create(bmd, FILE);
		}
		
		private function outputEventHandler(event:Event, passThroughData:Object):void
		{
			Assert.assertTrue(FILE.exists);
			var loader:Loader = new Loader();
			
			Async.handleEvent(this, loader.contentLoaderInfo, Event.COMPLETE, function():void{
				Assert.assertEquals(loader.width, _loader.width);
				Assert.assertEquals(loader.height, _loader.height);
			}, 500);
			loader.load(new URLRequest(FILE.url));
		}
	}
}