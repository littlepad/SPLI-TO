package net.littlepad.splito.data
{
	import flash.geom.Rectangle;

	public class OutputSettingData
	{
		private var _scale:Number;
		private var _leftRect:Rectangle;
		private var _rightRect:Rectangle;
		
		public function OutputSettingData(scale:Number, leftRect:Rectangle, rightRect:Rectangle)
		{
			_scale = scale;
			_leftRect = leftRect;
			_rightRect = rightRect;
		}
		
		public function get scale():Number
		{
			return _scale;
		}

		public function get leftRect():Rectangle
		{
			return _leftRect;
		}

		public function get rightRect():Rectangle
		{
			return _rightRect;
		}
		
	}
}