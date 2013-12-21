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
	public class GradientRecord
	{
		private var _ratio:uint = 0;
		private var _color:RGBA = new RGBA();
		
		public function get ratio():uint
		{
			return _ratio;
		}
		
		public function set ratio(value:uint):void
		{
			_ratio = value;
		}
		
		/**
		 * Swfassist ignores ALPHA if this record is part of Shape1 or Shape2.
		 */
		public function get color():RGBA
		{
			return _color;
		}
		
		public function set color(value:RGBA):void
		{
			_color = value;
		}
	}
}