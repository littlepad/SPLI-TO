package flexUnitTests
{
	import flexUnitTests.FileNameTest;
	import flexUnitTests.OutputFileTest;
	import flexUnitTests.OutputFilesTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class AllTests
	{
		public var test1:flexUnitTests.FileNameTest;
		public var test2:flexUnitTests.OutputFilesTest;
		public var test3:flexUnitTests.OutputFileTest;
		
	}
}