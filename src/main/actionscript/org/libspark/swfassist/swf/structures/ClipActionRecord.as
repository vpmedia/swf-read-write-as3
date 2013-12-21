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
	import org.libspark.swfassist.swf.actions.ActionRecords;
	
	public class ClipActionRecord
	{
		private var _eventFlags:ClipEventFlags = new ClipEventFlags();
		private var _keyCode:uint = 0;
		private var _actions:ActionRecords = new ActionRecords();
		
		public function get eventFlags():ClipEventFlags
		{
			return _eventFlags;
		}
		
		public function set eventFlags(value:ClipEventFlags):void
		{
			_eventFlags = value;
		}
		
		public function get keyCode():uint
		{
			return _keyCode;
		}
		
		public function set keyCode(value:uint):void
		{
			_keyCode = value;
		}
		
		public function get actions():ActionRecords
		{
			return _actions;
		}
		
		public function set actions(value:ActionRecords):void
		{
			_actions = value;
		}
	}
}