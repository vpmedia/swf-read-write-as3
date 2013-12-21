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
	public class DefineSprite extends AbstractTag
	{
		public function DefineSprite(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_SPRITE);
		}
		
		private var _spriteId:uint = 0;
		private var _numFrames:uint = 0;
		private var _tags:Tags = new Tags();
		
		public function get spriteId():uint
		{
			return _spriteId;
		}
		
		public function set spriteId(value:uint):void
		{
			_spriteId = value;
		}
		
		public function get numFrames():uint
		{
			return _numFrames;
		}
		
		public function set numFrames(value:uint):void
		{
			_numFrames = value;
		}
		
		public function get tags():Tags
		{
			return _tags;
		}
		
		public function set tags(value:Tags):void
		{
			_tags = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineSprite(this);
		}
	}
}