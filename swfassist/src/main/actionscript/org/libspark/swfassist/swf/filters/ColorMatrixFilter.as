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
	import flash.filters.ColorMatrixFilter;
	
	public class ColorMatrixFilter extends AbstractFilter
	{
		public function ColorMatrixFilter(filterId:uint = 0)
		{
			super(filterId != 0 ? filterId : FilterConstants.ID_COLOR_MATRIX);
		}
		
		private var _matrix:Array = [
			1.0, 0.0, 0.0, 0.0, 0.0,
			0.0, 1.0, 0.0, 0.0, 0.0,
			0.0, 0.0, 1.0, 0.0, 0.0,
			0.0, 0.0, 0.0, 1.0, 0.0
		];
		
		public function get matrix():Array
		{
			return _matrix;
		}
		
		public function set matrix(value:Array):void
		{
			_matrix = value;
		}
		
		public function fromNativeFilter(filter:flash.filters.ColorMatrixFilter):void
		{
			var sourceMatrix:Array = filter.matrix;
			var destMatrix:Array = matrix;
			for (var i:uint = 0; i < 20; ++i) {
				destMatrix[i] = sourceMatrix[i];
			}
		}
		
		public function toNativeFilter():flash.filters.ColorMatrixFilter
		{
			var filter:flash.filters.ColorMatrixFilter = new flash.filters.ColorMatrixFilter();
			var sourceMatrix:Array = matrix;
			var destMatrix:Array = filter.matrix;
			for (var i:uint = 0; i < 20; ++i) {
				destMatrix[i] = sourceMatrix[i];
			}
			return filter;
		}
	}
}