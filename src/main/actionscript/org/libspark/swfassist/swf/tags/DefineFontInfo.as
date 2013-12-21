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
	public class DefineFontInfo extends AbstractTag
	{
		public function DefineFontInfo(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_FONT_INFO);
		}
		
		private var _fontId:uint = 0;
		private var _fontName:String;
		private var _isSmallText:Boolean = false;
		private var _isShiftJIS:Boolean = false;
		private var _isANSI:Boolean = true;
		private var _isItalic:Boolean = false;
		private var _isBold:Boolean = false;
		private var _areWideCodes:Boolean = false;
		private var _codeTable:Array = [];
		
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
		
		public function get isSmallText():Boolean
		{
			return _isSmallText;
		}
		
		public function set isSmallText(value:Boolean):void
		{
			_isSmallText = value;
		}
		
		public function get isShiftJIS():Boolean
		{
			return _isShiftJIS;
		}
		
		public function set isShiftJIS(value:Boolean):void
		{
			_isShiftJIS = value;
		}
		
		public function get isANSI():Boolean
		{
			return _isANSI;
		}
		
		public function set isANSI(value:Boolean):void
		{
			_isANSI = value;
		}
		
		public function get isItalic():Boolean
		{
			return _isItalic;
		}
		
		public function set isItalic(value:Boolean):void
		{
			_isItalic = value;
		}
		
		public function get isBold():Boolean
		{
			return _isBold;
		}
		
		public function set isBold(value:Boolean):void
		{
			_isBold = value;
		}
		
		public function get areWideCodes():Boolean
		{
			return _areWideCodes;
		}
		
		public function set areWideCodes(value:Boolean):void
		{
			_areWideCodes = value;
		}
		
		public function get codeTable():Array
		{
			return _codeTable;
		}
		
		public function set codeTable(value:Array):void
		{
			_codeTable = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineFontInfo(this);
		}
	}
}