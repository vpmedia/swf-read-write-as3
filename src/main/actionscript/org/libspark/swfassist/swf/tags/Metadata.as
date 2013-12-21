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
	public class Metadata extends AbstractTag
	{
		public function Metadata(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_METADATA);
		}
		
		private var _metadata:String;
		
		public function get metadata():String
		{
			return _metadata;
		}
		
		public function set metadata(value:String):void
		{
			_metadata = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitMetadata(this);
		}
	}
}