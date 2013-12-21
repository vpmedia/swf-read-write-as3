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

package org.libspark.swfassist.swf.tags
{
	public class DefineFontName extends AbstractTag
	{
		public function DefineFontName(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_FONT_NAME);
		}
		
		private var _fontId:uint = 0;
		private var _fontName:String;
		private var _fontCopyright:String;
		
		public function get fontId():uint
		{
			return _fontId;
		}
		
		public function set fontId(value:uint):void
		{
			_fontId = value;
		}
		
		public function get fontName():String
		{
			return _fontName;
		}
		
		public function set fontName(value:String):void
		{
			_fontName = value;
		}
		
		public function get fontCopyright():String
		{
			return _fontCopyright;
		}
		
		public function set fontCopyright(value:String):void
		{
			_fontCopyright = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineFontName(this);
		}
	}
}