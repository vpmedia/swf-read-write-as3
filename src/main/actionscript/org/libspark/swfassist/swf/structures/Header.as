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
	public class Header
	{
		private var _isCompressed:Boolean = false;
		private var _version:uint = 0;
		private var _frameSize:Rect = new Rect();
		private var _frameRate:Number = 0;
		private var _numFrames:uint = 0;
		
		public function get isCompressed():Boolean
		{
			return _isCompressed;
		}
		
		public function set isCompressed(value:Boolean):void
		{
			_isCompressed = value;
		}
		
		// UI8
		public function get version():uint
		{
			return _version;
		}
		
		public function set version(value:uint):void
		{
			_version = value;
		}
		
		// RECT
		public function get frameSize():Rect
		{
			return _frameSize;
		}
		
		public function set frameSize(value:Rect):void
		{
			_frameSize = value;
		}
		
		// UI16
		public function get frameRate():Number
		{
			return _frameRate;
		}
		
		public function set frameRate(value:Number):void
		{
			_frameRate = value;
		}
		
		// UI16
		public function get numFrames():uint
		{
			return _numFrames;
		}
		
		public function set numFrames(value:uint):void
		{
			_numFrames = value;
		}
	}
}