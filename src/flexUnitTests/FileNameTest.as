package flexUnitTests
{
	import flexunit.framework.Assert;
	
	import net.littlepad.splito.utils.FileName;
	import net.littlepad.splito.resources.PageType;
	
	public class FileNameTest
	{		
		[Before]
		public function setUp():void
		{
		}
		
		[After]
		public function tearDown():void
		{
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
		public function testGetFileNameFromUrl():void
		{
			var fileName:String = FileName.getFileNameFromUrl("/hoge/hoge/fuga.jpg");
			Assert.assertEquals("fuga.jpg", fileName);
		}
		
		[Test]
		public function testGetOutputFileName():void
		{
			Assert.assertEquals("tolot_output/fuga_left.jpg", FileName.getOutputJpegName("/hoge/hoge/fuga.jpg", PageType.LEFT));
			Assert.assertEquals("tolot_output/fuga_right.jpg", FileName.getOutputJpegName("/hoge/hoge/fuga.jpg", PageType.RIGHT));
		}
	}
}