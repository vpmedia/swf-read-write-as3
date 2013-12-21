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
	import org.libspark.swfassist.swf.actions.ActionRecord;
	
	public class ButtonCondAction
	{
		private var _condIdleToOverDown:Boolean = false;
		private var _condOutDownToIdle:Boolean = false;
		private var _condOutDownToOverDown:Boolean = false;
		private var _condOverDownToOutDown:Boolean = false;
		private var _condOverDownToOverUp:Boolean = false;
		private var _condOverUpToOverDown:Boolean = false;
		private var _condOverUpToIdle:Boolean = false;
		private var _condIdleToOverUp:Boolean = false;
		private var _condKeyPress:uint = 0;
		private var _condOverDownToIdle:Boolean = false;
		private var _actions:ActionRecords = new ActionRecords();
		
		public function get condIdleToOverDown():Boolean
		{
			return _condIdleToOverDown;
		}
		
		public function set condIdleToOverDown(value:Boolean):void
		{
			_condIdleToOverDown = value;
		}
		
		public function get condOutDownToIdle():Boolean
		{
			return _condOutDownToIdle;
		}
		
		public function set condOutDownToIdle(value:Boolean):void
		{
			_condOutDownToIdle = value;
		}
		
		public function get condOutDownToOverDown():Boolean
		{
			return _condOutDownToOverDown;
		}
		
		public function set condOutDownToOverDown(value:Boolean):void
		{
			_condOutDownToOverDown = value;
		}
		
		public function get condOverDownToOutDown():Boolean
		{
			return _condOverDownToOutDown;
		}
		
		public function set condOverDownToOutDown(value:Boolean):void
		{
			_condOverDownToOutDown = value;
		}
		
		public function get condOverDownToOverUp():Boolean
		{
			return _condOverDownToOverUp;
		}
		
		public function set condOverDownToOverUp(value:Boolean):void
		{
			_condOverDownToOverUp = value;
		}
		
		public function get condOverUpToOverDown():Boolean
		{
			return _condOverUpToOverDown;
		}
		
		public function set condOverUpToOverDown(value:Boolean):void
		{
			_condOverUpToOverDown = value;
		}
		
		public function get condOverUpToIdle():Boolean
		{
			return _condOverUpToIdle;
		}
		
		public function set condOverUpToIdle(value:Boolean):void
		{
			_condOverUpToIdle = value;
		}
		
		public function get condIdleToOverUp():Boolean
		{
			return _condIdleToOverUp;
		}
		
		public function set condIdleToOverUp(value:Boolean):void
		{
			_condIdleToOverUp = value;
		}
		
		public function get condKeyPress():uint
		{
			return _condKeyPress;
		}
		
		public function set condKeyPress(value:uint):void
		{
			_condKeyPress = value;
		}
		
		public function get condOverDownToIdle():Boolean
		{
			return _condOverDownToIdle;
		}
		
		public function set condOverDownToIdle(value:Boolean):void
		{
			_condOverDownToIdle = value;
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