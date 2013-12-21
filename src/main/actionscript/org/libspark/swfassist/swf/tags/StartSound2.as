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
	import org.libspark.swfassist.swf.structures.SoundInfo;
	
	public class StartSound2 extends AbstractTag
	{
		public function StartSound2(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_START_SOUND2);
		}
		
		private var _soundClassName:String;
		private var _soundInfo:SoundInfo = new SoundInfo();
		
		public function get soundClassName():String
		{
			return _soundClassName;
		}
		
		public function set soundClassName(value:String):void
		{
			_soundClassName = value;
		}
		
		public function get soundInfo():SoundInfo
		{
			return _soundInfo;
		}
		
		public function set soundInfo(value:SoundInfo):void
		{
			_soundInfo = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitStartSound2(this);
		}
	}
}