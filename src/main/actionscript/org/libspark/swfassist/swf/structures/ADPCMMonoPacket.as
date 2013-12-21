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
	import flash.utils.ByteArray;
	
	public class ADPCMMonoPacket
	{
		private var _initialSample:uint = 0;
		private var _initialIndex:uint = 0;
		private var _adpcmCodeData:ByteArray = new ByteArray();
		
		public function get initialSample():uint
		{
			return _initialSample;
		}
		
		public function set initialSample(value:uint):void
		{
			_initialSample = value;
		}
		
		public function get initialIndex():uint
		{
			return _initialIndex;
		}
		
		public function set initialIndex(value:uint):void
		{
			_initialIndex = value;
		}
		
		public function get adpcmCodeData():ByteArray
		{
			return _adpcmCodeData;
		}
		
		public function set adpcmCodeData(value:ByteArray):void
		{
			_adpcmCodeData = value;
		}
	}
}