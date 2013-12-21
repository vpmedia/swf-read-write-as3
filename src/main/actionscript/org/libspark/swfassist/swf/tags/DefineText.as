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
	import org.libspark.swfassist.swf.structures.Rect;
	import org.libspark.swfassist.swf.structures.Matrix;
	import org.libspark.swfassist.swf.structures.TextRecord;
	
	public class DefineText extends AbstractTag
	{
		public function DefineText(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_TEXT);
		}
		
		private var _characterId:uint = 0;
		private var _textBounds:Rect = new Rect();
		private var _textMatrix:Matrix = new Matrix();
		private var _textRecords:Array = [];
		
		public function get characterId():uint
		{
			return _characterId;
		}
		
		public function set characterId(value:uint):void
		{
			_characterId = value;
		}
		
		public function get textBounds():Rect
		{
			return _textBounds;
		}
		
		public function set textBounds(value:Rect):void
		{
			_textBounds = value;
		}
		
		public function get textMatrix():Matrix
		{
			return _textMatrix;
		}
		
		public function set textMatrix(value:Matrix):void
		{
			_textMatrix = value;
		}
		
		public function get numTextRecords():uint
		{
			return textRecords.length;
		}
		
		public function get textRecords():Array
		{
			return _textRecords;
		}
		
		public function set textRecords(value:Array):void
		{
			_textRecords = value;
		}
		
		public function clearTextRecords():void
		{
			if (numTextRecords > 0) {
				textRecords.splice(0, numTextRecords);
			}
		}
		
		public function addTextRecord(record:TextRecord):void
		{
			textRecords.push(record);
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineText(this);
		}
	}
}