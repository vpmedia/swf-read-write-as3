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

package org.libspark.swfassist.flash.display
{
	import org.libspark.swfassist.swf.structures.Shape;
	import org.libspark.swfassist.swf.structures.ShapeRecord;
	import org.libspark.swfassist.swf.structures.ShapeRecordTypeConstants;
	import org.libspark.swfassist.swf.structures.StyleChangeRecord;
	import org.libspark.swfassist.swf.structures.StraightEdgeRecord;
	import org.libspark.swfassist.swf.structures.CurvedEdgeRecord;

	public class AbstractShapeDrawer implements ShapeDrawer
	{
		public function AbstractShapeDrawer(graphics:VectorGraphics = null)
		{
			if (graphics) {
				this.graphics = graphics;
			}
		}
		
		private var _graphics:VectorGraphics;
		
		public function get graphics():VectorGraphics
		{
			return _graphics;
		}
		
		public function set graphics(value:VectorGraphics):void
		{
			_graphics = value;
		}
		
		public function draw(shape:Shape):void
		{
			for each (var record:ShapeRecord in shape.shapeRecords) {
				switch (record.type) {
					case ShapeRecordTypeConstants.STYLE_CHANGE:
						drawStyleChange(StyleChangeRecord(record));
						break;
					case ShapeRecordTypeConstants.STRAIGHT_EDGE:
						drawStraightEdge(StraightEdgeRecord(record));
						break;
					case ShapeRecordTypeConstants.CURVED_EDGE:
						drawCurvedEdge(CurvedEdgeRecord(record));
						break;
				}
			}
			drawEnd();
		}
		
		protected function drawStyleChange(record:StyleChangeRecord):void
		{
		}
		
		protected function drawStraightEdge(record:StraightEdgeRecord):void
		{
		}
		
		protected function drawCurvedEdge(record:CurvedEdgeRecord):void
		{
		}
		
		protected function drawEnd():void
		{
		}
	}
}