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
	import org.libspark.swfassist.swf.structures.ShapeWithStyle;
	
	public class DefineShape extends AbstractTag
	{
		public function DefineShape(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_SHAPE);
		}
		
		private var _shapeId:uint = 0;
		private var _shapeBounds:Rect = new Rect();
		private var _shapes:ShapeWithStyle = new ShapeWithStyle();
		
		public function get shapeId():uint
		{
			return _shapeId;
		}
		
		public function set shapeId(value:uint):void
		{
			_shapeId = value;
		}
		
		public function get shapeBounds():Rect
		{
			return _shapeBounds;
		}
		
		public function set shapeBounds(value:Rect):void
		{
			_shapeBounds = value;
		}
		
		public function get shapes():ShapeWithStyle
		{
			return _shapes;
		}
		
		public function set shapes(value:ShapeWithStyle):void
		{
			_shapes = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineShape(this);
		}
	}
}