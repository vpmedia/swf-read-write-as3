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
	import org.libspark.swfassist.swf.tags.SoundFormatConstants;
	
	public class SoundDataADPCM extends AbstractSoundData
	{
		public function SoundDataADPCM(format:uint = 0)
		{
			super(format != 0 ? format : SoundFormatConstants.ADPCM);
		}
		
		private var _soundData:ByteArray = new ByteArray();
		
		/**
		private var _adpcmCodeSize:uint = 2;
		private var _adpcmPackets:Array = [];
		/**/
		
		public function get soundData():ByteArray
		{
			return _soundData;
		}
		
		public function set soundData(value:ByteArray):void
		{
			_soundData = value;
		}
		
		/**
		public function get adpcmCodeSize():uint
		{
			return _adpcmCodeSize;
		}
		
		public function set adpcmCodeSize(value:uint):void
		{
			_adpcmCodeSize = value;
		}
		
		public function get numAdpcmPackets():uint
		{
			return adpcmPackets.length;
		}
		
		public function get adpcmPackets():Array
		{
			return _adpcmPackets;
		}
		
		public function set adpcmPackets(value:Array):void
		{
			_adpcmPackets = value;
		}
		/**/
	}
}