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
	public class TextRecord
	{
		private var _hasFont:Boolean = false;
		private var _hasColor:Boolean = false;
		private var _hasYOffset:Boolean = false;
		private var _hasXOffset:Boolean = false;
		private var _fontId:uint = 0;
		private var _textColor:RGBA = new RGBA();
		private var _xOffset:int = 0;
		private var _yOffset:int = 0;
		private var _textHeight:uint = 0;
		private var _glyphEntries:Array = [];
		
		public function get hasFont():Boolean
		{
			return _hasFont;
		}
		
		public function set hasFont(value:Boolean):void
		{
			_hasFont = value;
		}
		
		public function get hasColor():Boolean
		{
			return _hasColor;
		}
		
		public function set hasColor(value:Boolean):void
		{
			_hasColor = value;
		}
		
		public function get hasXOffset():Boolean
		{
			return _hasXOffset;
		}
		
		public function set hasXOffset(value:Boolean):void
		{
			_hasXOffset = value;
		}
		
		public function get hasYOffset():Boolean
		{
			return _hasYOffset;
		}
		
		public function set hasYOffset(value:Boolean):void
		{
			_hasYOffset = value;
		}
		
		public function get fontId():uint
		{
			return _fontId;
		}
		
		public function set fontId(value:uint):void
		{
			_fontId = value;
		}
		
		/**
		 * Swfassist ignores ALPHA if this class is part of DefineText.
		 */
		public function get textColor():RGBA
		{
			return _textColor;
		}
		
		public function set textColor(value:RGBA):void
		{
			_textColor = value;
		}
		
		public function get xOffset():int
		{
			return _xOffset;
		}
		
		public function set xOffset(value:int):void
		{
			_xOffset = value;
		}
		
		public function get yOffset():int
		{
			return _yOffset;
		}
		
		public function set yOffset(value:int):void
		{
			_yOffset = value;
		}
		
		public function get textHeight():uint
		{
			return _textHeight;
		}
		
		public function set textHeight(value:uint):void
		{
			_textHeight = value;
		}
		
		public function get glyphEntries():Array
		{
			return _glyphEntries;
		}
		
		public function set glyphEntries(value:Array):void
		{
			_glyphEntries = value;
		}
	}
}