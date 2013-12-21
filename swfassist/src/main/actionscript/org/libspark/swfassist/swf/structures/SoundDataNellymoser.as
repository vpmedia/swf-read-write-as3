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
	
	public class SoundDataNellymoser extends AbstractSoundData
	{
		public function SoundDataNellymoser(format:uint = 0)
		{
			super(format != 0 ? format : SoundFormatConstants.NELLYMOSER);
		}
		
		private var _soundData:ByteArray = new ByteArray();
		
		public function get soundData():ByteArray
		{
			return _soundData;
		}
		
		public function set soundData(value:ByteArray):void
		{
			_soundData = value;
		}
	}
}