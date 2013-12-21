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
	public class ZoneData
	{
		private var _alignmentCoordinate:Number = 0;
		private var _range:Number = 0;
		
		public function get alignmentCoordinate():Number
		{
			return _alignmentCoordinate;
		}
		
		public function set alignmentCoordinate(value:Number):void
		{
			_alignmentCoordinate = value;
		}
		
		public function get range():Number
		{
			return _range;
		}
		
		public function set range(value:Number):void
		{
			_range = value;
		}
	}
}