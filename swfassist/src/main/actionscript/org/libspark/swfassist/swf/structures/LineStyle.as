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
	public class LineStyle
	{
		private var _width:uint = 20;
		private var _color:RGBA = new RGBA();
		
		public function get width():Number
		{
			return widthTwips / 20;
		}
		
		public function set width(value:Number):void
		{
			widthTwips = value * 20;
		}
		
		public function get widthTwips():uint
		{
			return _width;
		}
		
		public function set widthTwips(value:uint):void
		{
			_width = value;
		}
		
		/**
		 * Swfassist ignores ALPHA if this class defined at Shape1 or Shape2.
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