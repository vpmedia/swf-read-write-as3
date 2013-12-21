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
	public class ScriptLimits extends AbstractTag
	{
		public function ScriptLimits(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_SCRIPT_LIMITS);
		}
		
		private var _maxRecursionDepth:uint = 256;
		private var _scriptTimeoutSeconds:uint = 15;
		
		public function get maxRecursionDepth():uint
		{
			return _maxRecursionDepth;
		}
		
		public function set maxRecursionDepth(value:uint):void
		{
			_maxRecursionDepth = value;
		}
		
		public function get scriptTimeoutSeconds():uint
		{
			return _scriptTimeoutSeconds;
		}
		
		public function set scriptTimeoutSeconds(value:uint):void
		{
			_scriptTimeoutSeconds = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitScriptLimits(this);
		}
	}
}