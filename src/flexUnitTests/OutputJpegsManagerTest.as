package flexUnitTests
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import flexunit.framework.Assert;
	
	import net.littlepad.splito.files.OutputJpegsManager;
	import net.littlepad.splito.data.ImportFileData;
	import net.littlepad.splito.data.OutputSettingData;
	import net.littlepad.splito.events.OutputJpegsEvent;
	import net.littlepad.splito.resources.PageType;
	import net.littlepad.splito.utils.FileName;
	
	import org.flexunit.async.Async;
	
	public class OutputJpegsManagerTest
	{		
		private var _outputJpegs:OutputJpegsManager;
		private var _loader:Loader;
		private var _scale:Number = 1;
		private var _leftRect:Rectangle;
		private var _rightRect:Rectangle;
		private var _fileUrl:String = "/flexUnitTests/jpg/IMG_2209.JPG";
		private var _leftFile:File;
		private var _rightFile:File;
		
		[Before(async)]
		public function setUp():void
		{		
			_loader = new Loader();
			Async.handleEvent(this, _loader.contentLoaderInfo, Event.COMPLETE, onLoaderCompleteHandler, 500);
			_loader.load(new URLRequest("/flexUnitTests/jpg/IMG_2209.JPG"));
		}
		
		private function onLoaderCompleteHandler(event:Event, passThroughData:Object):void
		{
		}
		
		[After]
		public function tearDown():void
		{
			_leftFile.deleteFile();
			_rightFile.deleteFile();
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
		public function testCreate():void
		{
			_leftRect = new Rectangle(0, 0, 100, 100);
			_rightRect = new Rectangle(0, 0, 100, 100);
			var bmd:BitmapData = new BitmapData(_loader.width, _loader.height);
			bmd.draw(_loader, null, null, null, null, true);
			_outputJpegs = new OutputJpegsManager(new ImportFileData(bmd, _fileUrl), new OutputSettingData(_scale, _leftRect, _rightRect));
			Async.handleEvent(this, _outputJpegs, OutputJpegsEvent.COMPLETE, outputJpegsCompleteHandler, 500);
			_outputJpegs.create();
		}
		
		
		private function outputJpegsCompleteHandler(event:OutputJpegsEvent, passThroughData:Object):void
		{
			var leftFileUrl:String = File.desktopDirectory.url + "/" + FileName.getOutputJpegName(_fileUrl, PageType.LEFT);
			var rightFileUrl:String = File.desktopDirectory.url + "/" + FileName.getOutputJpegName(_fileUrl, PageType.RIGHT);
			_leftFile = new File(leftFileUrl);
			_rightFile = new File(rightFileUrl);
			Assert.assertTrue(_leftFile.exists);
			Assert.assertTrue(_rightFile.exists);
			
			var loaderLeft:Loader = new Loader();
			Async.handleEvent(this, loaderLeft.contentLoaderInfo, Event.COMPLETE, loaderLeftComplete, 500, {rightFileUrl:rightFileUrl});
			loaderLeft.load(new URLRequest(leftFileUrl));
		}
		
		private function loaderLeftComplete(event:Event, passThroughData:Object):void
		{
			Assert.assertEquals(event.target.width, 100);
			Assert.assertEquals(event.target.height, 100);
			loaderRightJpeg(passThroughData.rightFileUrl);
		}
			
		private function loaderRightJpeg(url:String):void
		{
			var loaderRight:Loader = new Loader();
			Async.handleEvent(this, loaderRight.contentLoaderInfo, Event.COMPLETE, loaderRightComplete, 500);
			loaderRight.load(new URLRequest(url));
		}
		
		private function loaderRightComplete(event:Event, passThroughData:Object):void
		{
			Assert.assertEquals(event.target.width, 100);
			Assert.assertEquals(event.target.height, 100);
		}
		
	}
}