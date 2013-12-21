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
	public class DefineFont extends AbstractTag
	{
		public function DefineFont(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_FONT);
		}
		
		private var _fontId:uint = 0;
		private var _glyphShapeTable:Array = [];
		
		public function get fontId():uint
		{
			return _fontId;
		}
		
		public function set fontId(value:uint):void
		{
			_fontId = value;
		}
		
		public function get numGlyphShapes():uint
		{
			return glyphShapeTable.length;
		}
		
		public function get glyphShapeTable():Array
		{
			return _glyphShapeTable;
		}
		
		public function set glyphShapeTable(value:Array):void
		{
			_glyphShapeTable = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineFont(this);
		}
	}
}