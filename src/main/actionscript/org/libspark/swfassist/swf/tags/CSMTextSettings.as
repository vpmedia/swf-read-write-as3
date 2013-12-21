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
	public class CSMTextSettings extends AbstractTag
	{
		public function CSMTextSettings(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_CSMTEXT_SETTINGS);
		}
		
		private var _textId:uint = 0;
		private var _useFlashType:Boolean = false;
		private var _gridFit:uint = CSMGridFitConstants.DO_NOT_USE;
		private var _thickness:Number = 0;
		private var _sharpness:Number = 0;
		
		public function get textId():uint
		{
			return _textId;
		}
		
		public function set textId(value:uint):void
		{
			_textId = value;
		}
		
		public function get useFlashType():Boolean
		{
			return _useFlashType;
		}
		
		public function set useFlashType(value:Boolean):void
		{
			_useFlashType = value;
		}
		
		public function get gridFit():uint
		{
			return _gridFit;
		}
		
		public function set gridFit(value:uint):void
		{
			_gridFit = value;
		}
		
		public function get thickness():Number
		{
			return _thickness;
		}
		
		public function set thickness(value:Number):void
		{
			_thickness = value;
		}
		
		public function get sharpness():Number
		{
			return _sharpness;
		}
		
		public function set sharpness(value:Number):void
		{
			_sharpness = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitCSMTextSettings(this);
		}
	}
}