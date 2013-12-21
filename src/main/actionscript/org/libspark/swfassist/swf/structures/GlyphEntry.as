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
	public class GlyphEntry
	{
		private var _glyphIndex:uint = 0;
		private var _glyphAdvance:int = 0;
		
		public function get glyphIndex():uint
		{
			return _glyphIndex;
		}
		
		public function set glyphIndex(value:uint):void
		{
			_glyphIndex = value;
		}
		
		public function get glyphAdvance():int
		{
			return _glyphAdvance;
		}
		
		public function set glyphAdvance(value:int):void
		{
			_glyphAdvance = value;
		}
	}
}