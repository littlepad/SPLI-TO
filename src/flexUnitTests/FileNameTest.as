package flexUnitTests
{
	import flexunit.framework.Assert;
	import net.littlepad.splito.FileName;
	
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
			Assert.assertEquals(FileName.OUTPUT_DIRECTORY + "fuga_left.jpg", FileName.getOutputFileName("/hoge/hoge/fuga.jpg", FileName.LEFT_PAGE));
			Assert.assertEquals(FileName.OUTPUT_DIRECTORY + "fuga_right.jpg", FileName.getOutputFileName("/hoge/hoge/fuga.jpg", FileName.RIGHT_PAGE));
		}
	}
}