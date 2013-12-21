/*
 * Copyright(c) 2007 the Spark project.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */

package org.libspark.swfassist.swf.filters
{
	import flash.filters.BlurFilter;
	
	public class BlurFilter extends AbstractFilter
	{
		public function BlurFilter(filterId:uint = 0)
		{
			super(filterId != 0 ? filterId : FilterConstants.ID_BLUR);
		}
		
		private var _blurX:Number = 4.0;
		private var _blurY:Number = 4.0;
		private var _passes:uint = 1;
		
		public function get blurX():Number
		{
			return _blurX;
		}
		
		public function set blurX(value:Number):void
		{
			_blurX = value;
		}
		
		public function get blurY():Number
		{
			return _blurY;
		}
		
		public function set blurY(value:Number):void
		{
			_blurY = value;
		}
		
		public function get passes():uint
		{
			return _passes;
		}
		
		public function set passes(value:uint):void
		{
			_passes = value;
		}
		
		public function fromNativeFilter(filter:flash.filters.BlurFilter):void
		{
			blurX = filter.blurX;
			blurY = filter.blurY;
			passes = filter.quality;
		}
		
		public function toNativeFilter():flash.filters.BlurFilter
		{
			var filter:flash.filters.BlurFilter = new flash.filters.BlurFilter();
			filter.blurX = blurX;
			filter.blurY = blurY;
			filter.quality = passes;
			return filter;
		}
	}
}