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

package org.libspark.swfassist.swf.tags
{
	import org.libspark.swfassist.swf.structures.SoundData;
	
	public class DefineSound extends AbstractTag
	{
		public function DefineSound(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_SOUND);
		}
		
		private var _soundId:uint = 0;
		private var _soundFormat:uint = SoundFormatConstants.UNCOMPRESSED;
		private var _soundRate:uint = SoundRateConstants.RATE_5_5_KHZ;
		private var _soundSize:uint = SoundSizeConstants.SIZE_8BIT;
		private var _soundType:uint = SoundTypeConstants.MONO;
		private var _numSoundSamples:uint = 0;
		private var _soundData:SoundData = null;
		
		public function get soundId():uint
		{
			return _soundId;
		}
		
		public function set soundId(value:uint):void
		{
			_soundId = value;
		}
		
		public function get soundFormat():uint
		{
			return _soundFormat;
		}
		
		public function set soundFormat(value:uint):void
		{
			_soundFormat = value;
		}
		
		public function get soundRate():uint
		{
			return _soundRate;
		}
		
		public function set soundRate(value:uint):void
		{
			_soundRate = value;
		}
		
		public function get soundSize():uint
		{
			return _soundSize;
		}
		
		public function set soundSize(value:uint):void
		{
			_soundSize = value;
		}
		
		public function get soundType():uint
		{
			return _soundType;
		}
		
		public function set soundType(value:uint):void
		{
			_soundType = value;
		}
		
		public function get numSoundSamples():uint
		{
			return _numSoundSamples;
		}
		
		public function set numSoundSamples(value:uint):void
		{
			_numSoundSamples = value;
		}
		
		public function get soundData():SoundData
		{
			return _soundData;
		}
		
		public function set soundData(value:SoundData):void
		{
			_soundData = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineSound(this);
		}
	}
}