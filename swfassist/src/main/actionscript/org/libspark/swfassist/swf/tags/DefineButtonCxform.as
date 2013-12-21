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
	import org.libspark.swfassist.swf.structures.CXForm;
	
	public class DefineButtonCxform extends AbstractTag
	{
		public function DefineButtonCxform(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_BUTTON_CXFORM);
		}
		
		private var _buttonId:uint = 0;
		private var _buttonColorTransform:CXForm = new CXForm();
		
		public function get buttonId():uint
		{
			return _buttonId;
		}
		
		public function set buttonId(value:uint):void
		{
			_buttonId = value;
		}
		
		public function get buttonColorTransform():CXForm
		{
			return _buttonColorTransform;
		}
		
		public function set buttonColorTransform(value:CXForm):void
		{
			_buttonColorTransform = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineButtonCxform(this);
		}
	}
}