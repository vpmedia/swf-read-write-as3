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
	import org.libspark.swfassist.swf.tags.SoundFormatConstants;
	import flash.utils.ByteArray;
	
	public class SoundDataMP3 extends AbstractSoundData
	{
		public function SoundDataMP3(format:uint = 0)
		{
			super(format != 0 ? format : SoundFormatConstants.MP3);
		}
		
		private var _seekSamples:uint = 0;
		private var _mp3Frames:ByteArray = new ByteArray();
		
		public function get seekSamples():uint
		{
			return _seekSamples;
		}
		
		public function set seekSamples(value:uint):void
		{
			_seekSamples = value;
		}
		
		public function get mp3Frames():ByteArray
		{
			return _mp3Frames;
		}
		
		public function set mp3Frames(value:ByteArray):void
		{
			mp3Frames = value;
		}
	}
}