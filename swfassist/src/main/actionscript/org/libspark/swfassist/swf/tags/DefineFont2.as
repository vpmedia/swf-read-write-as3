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
	import org.libspark.swfassist.swf.structures.LanguageCode;
	
	public class DefineFont2 extends DefineFont
	{
		public function DefineFont2(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_FONT2);
		}
		
		private var _hasLayout:Boolean = false;
		private var _isShiftJIS:Boolean = false;
		private var _isSmallText:Boolean = false;
		private var _isANSI:Boolean = false;
		private var _areWideCodes:Boolean = false;
		private var _isItalic:Boolean = false;
		private var _isBold:Boolean = false;
		private var _languageCode:LanguageCode = new LanguageCode();
		private var _fontName:String;
		private var _numGlyphs:uint = 0;
		private var _codeTable:Array = [];
		private var _fontAscent:uint = 0;
		private var _fontDescent:uint = 0;
		private var _fontLeading:uint = 0;
		private var _fontAdvancedTable:Array = [];
		private var _fontBoundsTable:Array = [];
		private var _kerningTable:Array = [];
		
		public function get hasLayout():Boolean
		{
			return _hasLayout;
		}
		
		public function set hasLayout(value:Boolean):void
		{
			_hasLayout = value;
		}
		
		public function get isShiftJIS():Boolean
		{
			return _isShiftJIS;
		}
		
		public function set isShiftJIS(value:Boolean):void
		{
			_isShiftJIS = value;
		}
		
		public function get isSmallText():Boolean
		{
			return _isSmallText;
		}
		
		public function set isSmallText(value:Boolean):void
		{
			_isSmallText = value;
		}
		
		public function get isANSI():Boolean
		{
			return _isANSI;
		}
		
		public function set isANSI(value:Boolean):void
		{
			_isANSI = value;
		}
		
		public function get areWideCodes():Boolean
		{
			return _areWideCodes;
		}
		
		public function set areWideCodes(value:Boolean):void
		{
			_areWideCodes = value;
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
		
		public function get languageCode():LanguageCode
		{
			return _languageCode;
		}
		
		public function set languageCode(value:LanguageCode):void
		{
			_languageCode = value;
		}
		
		public function get fontName():String
		{
			return _fontName;
		}
		
		public function set fontName(value:String):void
		{
			_fontName = value;
		}
		
		public function get numGlyphs():uint
		{
			return _numGlyphs;
		}
		
		public function set numGlyphs(value:uint):void
		{
			_numGlyphs = value;
		}
		
		public function get codeTable():Array
		{
			return _codeTable;
		}
		
		public function set codeTable(value:Array):void
		{
			_codeTable = value;
		}
		
		public function get fontAscent():uint
		{
			return _fontAscent;
		}
		
		public function set fontAscent(value:uint):void
		{
			_fontAscent = value;
		}
		
		public function get fontDescent():uint
		{
			return _fontDescent;
		}
		
		public function set fontDescent(value:uint):void
		{
			_fontDescent = value;
		}
		
		public function get fontLeading():uint
		{
			return _fontLeading;
		}
		
		public function set fontLeading(value:uint):void
		{
			_fontLeading = value;
		}
		
		public function get fontAdvancedTable():Array
		{
			return _fontAdvancedTable;
		}
		
		public function set fontAdvancedTable(value:Array):void
		{
			_fontAdvancedTable = value;
		}
		
		public function get fontBoundsTable():Array
		{
			return _fontBoundsTable;
		}
		
		public function set fontBoundsTable(value:Array):void
		{
			_fontBoundsTable = value;
		}
		
		public function get kerningTable():Array
		{
			return _kerningTable;
		}
		
		public function set kerningTable(value:Array):void
		{
			_kerningTable = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineFont2(this);
		}
	}
}