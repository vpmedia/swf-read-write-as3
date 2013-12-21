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
	public class Tags implements TagVisitorAcceptor
	{
		private var _tags:Array = [];
		
		public function get numTags():uint
		{
			return tags.length;
		}
		
		public function get tags():Array
		{
			return _tags;
		}
		
		public function set tags(value:Array):void
		{
			_tags = value;
		}
		
		public function clearTags():void
		{
			if (tags.length > 0) {
				tags.splice(0, tags.length);
			}
		}
		
		public function addTag(tag:Tag):void
		{
			tags.push(tag);
		}
		
		public function visit(visitor:TagVisitor):void
		{
			for each (var tag:Tag in tags) {
				tag.visit(visitor);
			}
		}
	}
}