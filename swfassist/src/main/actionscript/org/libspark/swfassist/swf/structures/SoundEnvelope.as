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
	public class SoundEnvelope
	{
		private var _pos44:uint = 0;
		private var _leftLevel:uint = 32768;
		private var _rightLevel:uint = 32768;
		
		public function get pos44():uint
		{
			return _pos44;
		}
		
		public function set pos44(value:uint):void
		{
			_pos44 = value;
		}
		
		public function get leftLevel():uint
		{
			return _leftLevel;
		}
		
		public function set leftLevel(value:uint):void
		{
			_leftLevel = value;
		}
		
		public function get rightLevel():uint
		{
			return _rightLevel;
		}
		
		public function set rightLevel(value:uint):void
		{
			_rightLevel = value;
		}
	}
}