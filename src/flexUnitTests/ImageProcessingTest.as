package flexUnitTests
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	import flexunit.framework.Assert;
	
	import net.littlepad.splito.utils.ImageProcessing;

	public class ImageProcessingTest
	{	
		private var _bmd:BitmapData;
		
		[Before]
		public function setUp():void
		{
			_bmd = new BitmapData(300, 200);
		}
		
		[After]
		public function tearDown():void
		{
			_bmd = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testTriming():void
		{
			var rect:Rectangle = new Rectangle(0, 0, 100, 200);
			var bmd:BitmapData = ImageProcessing.triming(_bmd, rect);
			Assert.assertEquals(bmd.rect.x, rect.x);
			Assert.assertEquals(bmd.rect.y, rect.y);
			Assert.assertEquals(bmd.rect.width, rect.width);
			Assert.assertEquals(bmd.rect.height, rect.height);
		}
		
		[Test]
		public function testChangeScale():void
		{
			var bmd:BitmapData = ImageProcessing.changeScale(_bmd, 0.5);
			Assert.assertEquals(bmd.width, _bmd.width * 0.5);
			Assert.assertEquals(bmd.height, _bmd.height * 0.5);
		}
		
	}
}