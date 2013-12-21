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
	import org.libspark.swfassist.swf.structures.RGBA;
	
	public class DefineEditText extends AbstractTag
	{
		public function DefineEditText(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_EDIT_TEXT);
		}
		
		private var _characterId:uint = 0;
		private var _bounds:Rect = new Rect();
		private var _hasText:Boolean = false;
		private var _wordWrap:Boolean = false;
		private var _multiline:Boolean = false;
		private var _password:Boolean = false;
		private var _readOnly:Boolean = false;
		private var _hasTextColor:Boolean = false;
		private var _hasMaxLength:Boolean = false;
		private var _hasFont:Boolean = false;
		private var _hasFontClass:Boolean = false;
		private var _autoSize:Boolean = false;
		private var _hasLayout:Boolean = false;
		private var _noSelect:Boolean = false;
		private var _border:Boolean = false;
		private var _wasStatic:Boolean = false;
		private var _html:Boolean = false;
		private var _useOutlines:Boolean = false;
		private var _fontId:uint = 0;
		private var _fontClass:String;
		private var _fontHeight:uint = 0;
		private var _textColor:RGBA = new RGBA();
		private var _maxLength:uint = 0;
		private var _align:uint = TextAlignConstants.LEFT;
		private var _leftMargin:uint = 0;
		private var _rightMargin:uint = 0;
		private var _indent:uint = 0;
		private var _leading:int = 0;
		private var _variableName:String;
		private var _initialText:String;
		
		public function get characterId():uint
		{
			return _characterId;
		}
		
		public function set characterId(value:uint):void
		{
			_characterId = value;
		}
		
		public function get bounds():Rect
		{
			return _bounds;
		}
		
		public function set bounds(value:Rect):void
		{
			_bounds = value;
		}
		
		public function get hasText():Boolean
		{
			return _hasText;
		}
		
		public function set hasText(value:Boolean):void
		{
			_hasText = value;
		}
		
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void
		{
			_wordWrap = value;
		}
		
		public function get multiline():Boolean
		{
			return _multiline;
		}
		
		public function set multiline(value:Boolean):void
		{
			_multiline = value;
		}
		
		public function get password():Boolean
		{
			return _password;
		}
		
		public function set password(value:Boolean):void
		{
			_password = value;
		}
		
		public function get readOnly():Boolean
		{
			return _readOnly;
		}
		
		public function set readOnly(value:Boolean):void
		{
			_readOnly = value;
		}
		
		public function get hasTextColor():Boolean
		{
			return _hasTextColor;
		}
		
		public function set hasTextColor(value:Boolean):void
		{
			_hasTextColor = value;
		}
		
		public function get hasMaxLength():Boolean
		{
			return _hasMaxLength
		}
		
		public function set hasMaxLength(value:Boolean):void
		{
			_hasMaxLength = value;
		}
		
		public function get hasFont():Boolean
		{
			return _hasFont;
		}
		
		public function set hasFont(value:Boolean):void
		{
			_hasFont = value;
		}
		
		public function get hasFontClass():Boolean
		{
			return _hasFontClass;
		}
		
		public function set hasFontClass(value:Boolean):void
		{
			_hasFontClass = value;
		}
		
		public function get autoSize():Boolean
		{
			return _autoSize;
		}
		
		public function set autoSize(value:Boolean):void
		{
			_autoSize = value;
		}
		
		public function get hasLayout():Boolean
		{
			return _hasLayout;
		}
		
		public function set hasLayout(value:Boolean):void
		{
			_hasLayout = value;
		}
		
		public function get noSelect():Boolean
		{
			return _noSelect;
		}
		
		public function set noSelect(value:Boolean):void
		{
			_noSelect = value;
		}
		
		public function get border():Boolean
		{
			return _border;
		}
		
		public function set border(value:Boolean):void
		{
			_border = value;
		}
		
		public function get wasStatic():Boolean
		{
			return _wasStatic;
		}
		
		public function set wasStatic(value:Boolean):void
		{
			_wasStatic = value;
		}
		
		public function get html():Boolean
		{
			return _html;
		}
		
		public function set html(value:Boolean):void
		{
			_html = value;
		}
		
		public function get useOutlines():Boolean
		{
			return _useOutlines;
		}
		
		public function set useOutlines(value:Boolean):void
		{
			_useOutlines = value;
		}
		
		public function get fontId():uint
		{
			return _fontId;
		}
		
		public function set fontId(value:uint):void
		{
			_fontId = value;
		}
		
		public function get fontClass():String
		{
			return _fontClass;
		}
		
		public function set fontClass(value:String):void
		{
			_fontClass = value;
		}
		
		public function get fontHeight():uint
		{
			return _fontHeight;
		}
		
		public function set fontHeight(value:uint):void
		{
			_fontHeight = value;
		}
		
		public function get textColor():RGBA
		{
			return _textColor;
		}
		
		public function set textColor(value:RGBA):void
		{
			_textColor = value;
		}
		
		public function get maxLength():uint
		{
			return _maxLength;
		}
		
		public function set maxLength(value:uint):void
		{
			_maxLength = value;
		}
		
		public function get align():uint
		{
			return _align;
		}
		
		public function set align(value:uint):void
		{
			_align = value;
		}
		
		public function get leftMargin():uint
		{
			return _leftMargin;
		}
		
		public function set leftMargin(value:uint):void
		{
			_leftMargin = value;
		}
		
		public function get rightMargin():uint
		{
			return _rightMargin;
		}
		
		public function set rightMargin(value:uint):void
		{
			_rightMargin = value;
		}
		
		public function get indent():uint
		{
			return _indent;
		}
		
		public function set indent(value:uint):void
		{
			_indent = value;
		}
		
		public function get leading():int
		{
			return _leading;
		}
		
		public function set leading(value:int):void
		{
			_leading = value;
		}
		
		public function get variableName():String
		{
			return _variableName;
		}
		
		public function set variableName(value:String):void
		{
			_variableName = value;
		}
		
		public function get initialText():String
		{
			return _initialText;
		}
		
		public function set initialText(value:String):void
		{
			_initialText = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineEditText(this);
		}
	}
}