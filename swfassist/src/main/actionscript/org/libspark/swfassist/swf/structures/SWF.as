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
	import org.libspark.swfassist.swf.tags.FileAttributes;
	import org.libspark.swfassist.swf.tags.Tags;
	import org.libspark.swfassist.swf.tags.TagVisitorAcceptor;
	import org.libspark.swfassist.swf.tags.TagVisitor;
	
	public class SWF implements TagVisitorAcceptor
	{
		private var _header:Header = new Header();
		private var _fileAttributes:FileAttributes = new FileAttributes();
		private var _tags:Tags = new Tags();
		
		public function get header():Header
		{
			return _header;
		}
		
		public function set header(value:Header):void
		{
			_header = value;
		}
		
		public function get fileAttributes():FileAttributes
		{
			return _fileAttributes;
		}
		
		public function set fileAttributes(value:FileAttributes):void
		{
			_fileAttributes = value;
		}
		
		public function get tags():Tags
		{
			return _tags;
		}
		
		public function set tags(value:Tags):void
		{
			_tags = value;
		}
		
		public function visit(visitor:TagVisitor):void
		{
			tags.visit(visitor);
		}
	}
}