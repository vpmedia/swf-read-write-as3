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
	public class Gradient
	{
		private var _spreadMode:uint = SpreadModeConstants.PAD_MODE;
		private var _interpolationMode:uint = InterpolationModeConstants.NORMAL_RGB_MODE;
		private var _gradientRecords:Array = [];
		
		public function get spreadMode():uint
		{
			return _spreadMode;
		}
		
		public function set spreadMode(value:uint):void
		{
			_spreadMode = value;
		}
		
		public function get interpolationMode():uint
		{
			return _interpolationMode;
		}
		
		public function set interpolationMode(value:uint):void
		{
			_interpolationMode = value;
		}
		
		public function get numGradientRecords():uint
		{
			return gradientRecords.length;
		}
		
		public function get gradientRecords():Array
		{
			return _gradientRecords;
		}
		
		public function set gradientRecords(value:Array):void
		{
			_gradientRecords = value;
		}
	}
}