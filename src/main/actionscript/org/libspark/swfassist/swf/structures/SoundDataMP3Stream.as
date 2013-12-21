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
	
	public class SoundDataMP3Stream extends AbstractSoundData
	{
		public function SoundDataMP3Stream(format:uint = 0)
		{
			super(format != 0 ? format : SoundFormatConstants.MP3);
		}
		
		private var _numSamples:uint = 0;
		private var _mp3SoundData:SoundDataMP3 = new SoundDataMP3();
		
		public function get numSamples():uint
		{
			return _numSamples;
		}
		
		public function set numSamples(value:uint):void
		{
			_numSamples = value;
		}
		
		public function get mp3SoundData():SoundDataMP3
		{
			return _mp3SoundData;
		}
		
		public function set mp3SoundData(value:SoundDataMP3):void
		{
			_mp3SoundData = value;
		}
	}
}