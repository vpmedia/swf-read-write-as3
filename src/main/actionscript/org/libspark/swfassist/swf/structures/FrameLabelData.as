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
	public class FrameLabelData
	{
		private var _frameNumber:uint = 0;
		private var _frameLabel:String;
		
		public function get frameNumber():uint
		{
			return _frameNumber;
		}
		
		public function set frameNumber(value:uint):void
		{
			_frameNumber = value;
		}
		
		public function get frameLabel():String
		{
			return _frameLabel;
		}
		
		public function set frameLabel(value:String):void
		{
			_frameLabel = value;
		}
	}
}