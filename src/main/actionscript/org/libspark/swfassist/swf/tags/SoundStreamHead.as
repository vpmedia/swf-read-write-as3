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
	import flash.utils.ByteArray;
	import flash.errors.IllegalOperationError;
	
	public class SoundStreamHead extends AbstractTag
	{
		public function SoundStreamHead(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_SOUND_STREAM_HEAD);
		}
		
		private var _playbackSoundRate:uint = SoundRateConstants.RATE_5_5_KHZ;
		private var _playbackSoundType:uint = SoundTypeConstants.MONO;
		private var _streamSoundCompression:uint = SoundFormatConstants.ADPCM;
		private var _streamSoundRate:uint = SoundRateConstants.RATE_5_5_KHZ;
		private var _streamSoundType:uint = SoundTypeConstants.MONO;
		private var _numStreamSoundSamples:uint = 0;
		private var _latencySeek:uint = 0;
		
		public function get playbackSoundRate():uint
		{
			return _playbackSoundRate;
		}
		
		public function set playbackSoundRate(value:uint):void
		{
			_playbackSoundRate = value;
		}
		
		public function get playbackSoundSize():uint
		{
			return SoundSizeConstants.SIZE_16BIT;
		}
		
		public function set playbackSoundSize(value:uint):void
		{
			if (value != SoundSizeConstants.SIZE_16BIT) {
				throw new IllegalOperationError('SoundStreamHeader.SoundSize is must be 16bit.');
			}
		}
		
		public function get playbackSoundType():uint
		{
			return _playbackSoundType;
		}
		
		public function set playbackSoundType(value:uint):void
		{
			_playbackSoundType = value;
		}
		
		public function get streamSoundCompression():uint
		{
			return _streamSoundCompression;
		}
		
		public function set streamSoundCompression(value:uint):void
		{
			_streamSoundCompression = value;
		}
		
		public function get streamSoundRate():uint
		{
			return _streamSoundRate;
		}
		
		public function set streamSoundRate(value:uint):void
		{
			_streamSoundRate = value;
		}
		
		public function get streamSoundSize():uint
		{
			return SoundSizeConstants.SIZE_16BIT;
		}
		
		public function set streamSoundSize(value:uint):void
		{
			if (value != SoundSizeConstants.SIZE_16BIT) {
				throw new IllegalOperationError('SoundStreamHeader.SoundSize is must be 16bit.');
			}
		}
		
		public function get streamSoundType():uint
		{
			return _streamSoundType;
		}
		
		public function set streamSoundType(value:uint):void
		{
			_streamSoundType = value;
		}
		
		public function get numStreamSoundSamples():uint
		{
			return _numStreamSoundSamples;
		}
		
		public function set numStreamSoundSamples(value:uint):void
		{
			_numStreamSoundSamples = value;
		}
		
		public function get latencySeek():uint
		{
			return _latencySeek;
		}
		
		public function set latencySeek(value:uint):void
		{
			_latencySeek = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitSoundStreamHead(this);
		}
	}
}