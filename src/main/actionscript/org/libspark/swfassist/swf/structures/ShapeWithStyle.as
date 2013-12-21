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
	public class ShapeWithStyle extends Shape
	{
		private var _fillStyles:FillStyleArray = new FillStyleArray();
		private var _lineStyles:LineStyleArray = new LineStyleArray();
		
		public function get fillStyles():FillStyleArray
		{
			return _fillStyles;
		}
		
		public function set fillStyles(value:FillStyleArray):void
		{
			_fillStyles = value;
		}
		
		public function get lineStyles():LineStyleArray
		{
			return _lineStyles;
		}
		
		public function set lineStyles(value:LineStyleArray):void
		{
			_lineStyles = value;
		}
	}
}