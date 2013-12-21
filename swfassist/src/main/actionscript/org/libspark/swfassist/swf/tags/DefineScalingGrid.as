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
	import org.libspark.swfassist.swf.structures.Rect;
	
	public class DefineScalingGrid extends AbstractTag
	{
		public function DefineScalingGrid(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_SCALING_GRID);
		}
		
		private var _characterId:uint = 0;
		private var _splitter:Rect = new Rect();
		
		public function get characterId():uint
		{
			return _characterId;
		}
		
		public function set characterId(value:uint):void
		{
			_characterId = value;
		}
		
		public function get splitter():Rect
		{
			return _splitter;
		}
		
		public function set splitter(value:Rect):void
		{
			_splitter = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineScalingGrid(this);
		}
	}
}