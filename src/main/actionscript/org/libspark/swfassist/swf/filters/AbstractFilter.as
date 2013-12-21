package org.libspark.swfassist.swf.filters
{
	public class AbstractFilter implements Filter
	{
		public function AbstractFilter(filterId:uint)
		{
			this.filterId = filterId;
		}
		
		private var _filterId:uint;
		
		public function get filterId():uint
		{
			return _filterId;
		}
		
		public function set filterId(value:uint):void
		{
			_filterId = value;
		}
	}
}