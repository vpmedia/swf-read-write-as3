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
	import flash.errors.IllegalOperationError;
	import org.libspark.swfassist.swf.structures.LanguageCode;
	
	public class DefineFontInfo2 extends DefineFontInfo
	{
		public function DefineFontInfo2(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_FONT_INFO2);
		}
		
		private var _languageCode:LanguageCode = new LanguageCode();
		
		public override function get isShiftJIS():Boolean
		{
			return false;
		}
		
		public override function set isShiftJIS(value:Boolean):void
		{
			if (value) {
				throw new IllegalOperationError('DefineFontInfo2.isShiftJIS is must be false.');
			}
		}
		
		public override function get isANSI():Boolean
		{
			return false;
		}
		
		public override function set isANSI(value:Boolean):void
		{
			if (value) {
				throw new IllegalOperationError('DefineFontInfo2.isANSI is must be false.');
			}
		}
		
		public override function get areWideCodes():Boolean
		{
			return true;
		}
		
		public override function set areWideCodes(value:Boolean):void
		{
			if (!value) {
				throw new IllegalOperationError('DefineFontInfo2.areWideCodes is must be true.');
			}
		}
		
		public function get languageCode():LanguageCode
		{
			return _languageCode;
		}
		
		public function set languageCode(value:LanguageCode):void
		{
			_languageCode = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineFontInfo2(this);
		}
	}
}