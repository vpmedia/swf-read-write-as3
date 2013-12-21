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

package org.libspark.swfassist.swf.structures
{
	public class MorphFillStyle
	{
		private var _fillStyleType:uint = FillStyleTypeConstants.SOLID_FILL;
		private var _startColor:RGBA = new RGBA();
		private var _endColor:RGBA = new RGBA();
		private var _startGradientMatrix:Matrix = new Matrix();
		private var _endGradientMatrix:Matrix = new Matrix();
		private var _gradient:MorphGradient = new MorphGradient();
		private var _bitmapId:uint = 0;
		private var _startBitmapMatrix:Matrix = new Matrix();
		private var _endBitmapMatrix:Matrix = new Matrix();
		
		public function get fillStyleType():uint
		{
			return _fillStyleType;
		}
		
		public function set fillStyleType(value:uint):void
		{
			_fillStyleType = value;
		}
		
		public function get startColor():RGBA
		{
			return _startColor;
		}
		
		public function set startColor(value:RGBA):void
		{
			_startColor = value;
		}
		
		public function get endColor():RGBA
		{
			return _endColor;
		}
		
		public function set endColor(value:RGBA):void
		{
			_endColor = value;
		}
		
		public function get startGradientMatrix():Matrix
		{
			return _startGradientMatrix;
		}
		
		public function set startGradientMatrix(value:Matrix):void
		{
			_startGradientMatrix = value;
		}
		
		public function get endGradientMatrix():Matrix
		{
			return _endGradientMatrix;
		}
		
		public function set endGradientMatrix(value:Matrix):void
		{
			_endGradientMatrix = value;
		}
		
		public function get gradient():MorphGradient
		{
			return _gradient;
		}
		
		public function set gradient(value:MorphGradient):void
		{
			_gradient = value;
		}
		
		public function get bitmapId():uint
		{
			return _bitmapId;
		}
		
		public function set bitmapId(value:uint):void
		{
			_bitmapId = value;
		}
		
		public function get startBitmapMatrix():Matrix
		{
			return _startBitmapMatrix;
		}
		
		public function set startBitmapMatrix(value:Matrix):void
		{
			_startBitmapMatrix = value;
		}
		
		public function get endBitmapMatrix():Matrix
		{
			return _endBitmapMatrix;
		}
		
		public function set endBitmapMatrix(value:Matrix):void
		{
			_endBitmapMatrix = value;
		}
	}
}