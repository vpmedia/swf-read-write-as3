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
	public class SoundStreamHead2 extends SoundStreamHead
	{
		public function SoundStreamHead2(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_SOUND_STREAM_HEAD2);
		}
		
		private var _playbackSoundSize:uint = SoundSizeConstants.SIZE_8BIT;
		private var _streamSoundSize:uint = SoundSizeConstants.SIZE_8BIT;
		
		public override function get playbackSoundSize():uint
		{
			return _playbackSoundSize;
		}
		
		public override function set playbackSoundSize(value:uint):void
		{
			_playbackSoundSize = value;
		}
		
		public override function get streamSoundSize():uint
		{
			return _streamSoundSize;
		}
		
		public override function set streamSoundSize(value:uint):void
		{
			_streamSoundSize = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitSoundStreamHead2(this);
		}
	}
}