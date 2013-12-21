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
	public class ZoneRecord
	{
		private var _zoneData:Array = [];
		private var _zoneMaskX:Boolean = false;
		private var _zoneMaskY:Boolean = false;
		
		public function get numZoneData():uint
		{
			return zoneData.length;
		}
		
		public function get zoneData():Array
		{
			return _zoneData;
		}
		
		public function set zoneData(value:Array):void
		{
			_zoneData = value;
		}
		
		public function get zoneMaskX():Boolean
		{
			return _zoneMaskX;
		}
		
		public function set zoneMaskX(value:Boolean):void
		{
			_zoneMaskX = value;
		}
		
		public function get zoneMaskY():Boolean
		{
			return _zoneMaskY;
		}
		
		public function set zoneMaskY(value:Boolean):void
		{
			_zoneMaskY = value;
		}
	}
}