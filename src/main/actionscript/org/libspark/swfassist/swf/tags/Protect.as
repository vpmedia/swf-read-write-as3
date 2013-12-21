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
	public class Protect extends AbstractTag
	{
		public function Protect(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_PROTECT);
		}
		
		private var _hasPassword:Boolean = false;
		private var _password:String;
		
		public function get hasPassword():Boolean
		{
			return _hasPassword;
		}
		
		public function set hasPassword(value:Boolean):void
		{
			_hasPassword = value;
		}
		
		public function get password():String
		{
			return _password;
		}
		
		public function set password(value:String):void
		{
			_password = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitProtect(this);
		}
	}
}