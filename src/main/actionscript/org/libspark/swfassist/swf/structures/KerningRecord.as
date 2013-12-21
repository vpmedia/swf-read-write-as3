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
	public class KerningRecord
	{
		private var _fontKerningCode1:uint = 0;
		private var _fontKerningCode2:uint = 0;
		private var _fontKerningAdjustment:int = 0;
		
		public function get fontKerningCode1():uint
		{
			return _fontKerningCode1;
		}
		
		public function set fontKerningCode1(value:uint):void
		{
			_fontKerningCode1 = value;
		}
		
		public function get fontKerningCode2():uint
		{
			return _fontKerningCode2;
		}
		
		public function set fontKerningCode2(value:uint):void
		{
			_fontKerningCode2 = value;
		}
		
		public function get fontKerningAdjustment():int
		{
			return _fontKerningAdjustment;
		}
		
		public function set fontKerningAdjustment(value:int):void
		{
			_fontKerningAdjustment = value;
		}
	}
}