package flexUnitTests
{
	import flexUnitTests.FileNameTest;
	import flexUnitTests.OutputJpegTest;
	import flexUnitTests.OutputJpegsManagerTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AllTests
	{
		public var test1:flexUnitTests.FileNameTest;
		public var test2:flexUnitTests.OutputJpegsManagerTest;
		public var test3:flexUnitTests.OutputJpegTest;
		
	}
}