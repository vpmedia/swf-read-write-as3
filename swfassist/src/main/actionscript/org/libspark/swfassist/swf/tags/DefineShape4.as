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
	
	public class DefineShape4 extends DefineShape3
	{
		public function DefineShape4(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_SHAPE4);
		}
		
		private var _edgeBounds:Rect = new Rect();
		private var _useNonScalingStrokes:Boolean = false;
		private var _useScalingStrokes:Boolean = false;
		
		public function get edgeBounds():Rect
		{
			return _edgeBounds;
		}
		
		public function set edgeBounds(value:Rect):void
		{
			_edgeBounds = value;
		}
		
		public function get useNonScalingStrokes():Boolean
		{
			return _useNonScalingStrokes;
		}
		
		public function set useNonScalingStrokes(value:Boolean):void
		{
			_useNonScalingStrokes = value;
		}
		
		public function get useScalingStrokes():Boolean
		{
			return _useScalingStrokes;
		}
		
		public function set useScalingStrokes(value:Boolean):void
		{
			_useScalingStrokes = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineShape4(this);
		}
	}
}