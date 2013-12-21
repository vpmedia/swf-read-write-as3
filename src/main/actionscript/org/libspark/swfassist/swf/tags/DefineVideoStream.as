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
	public class DefineVideoStream extends AbstractTag
	{
		public function DefineVideoStream(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_VIDEO_STREAM);
		}
		
		private var _characterId:uint = 0;
		private var _numFrames:uint = 0;
		private var _width:uint = 0;
		private var _height:uint = 0;
		private var _deblockingFlags:uint = 0;
		private var _smoothing:Boolean = false;
		private var _codecId:uint = 0;
		
		public function get characterId():uint
		{
			return _characterId;
		}
		
		public function set characterId(value:uint):void
		{
			_characterId = value;
		}
		
		public function get numFrames():uint
		{
			return _numFrames;
		}
		
		public function set numFrames(value:uint):void
		{
			_numFrames = value;
		}
		
		public function get width():uint
		{
			return _width;
		}
		
		public function set width(value:uint):void
		{
			_width = value;
		}
		
		public function get height():uint
		{
			return _height;
		}
		
		public function set height(value:uint):void
		{
			_height = value;
		}
		
		public function get deblockingFlags():uint
		{
			return _deblockingFlags;
		}
		
		public function set deblockingFlags(value:uint):void
		{
			_deblockingFlags = value;
		}
		
		public function get smoothing():Boolean
		{
			return _smoothing;
		}
		
		public function set smoothing(value:Boolean):void
		{
			_smoothing = value;
		}
		
		public function get codecId():uint
		{
			return _codecId;
		}
		
		public function set codecId(value:uint):void
		{
			_codecId = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineVideoStream(this);
		}
	}
}