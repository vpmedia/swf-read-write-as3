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
	import org.libspark.swfassist.swf.structures.StyleChangeRecord;
	import org.libspark.swfassist.swf.structures.StraightEdgeRecord;
	import org.libspark.swfassist.swf.structures.CurvedEdgeRecord;

	public class ShapeOutlineDrawer extends AbstractShapeDrawer
	{
		public function ShapeOutlineDrawer(graphics:VectorGraphics = null)
		{
			super(graphics);
		}
		
		private var _x:Number;
		private var _y:Number;
		
		public override function draw(shape:Shape):void
		{
			_x = 0;
			_y = 0;
			
			graphics.lineStyle(1, 0x000000);
			
			super.draw(shape);
			
			graphics.lineStyle(0);
		}
		
		protected override function drawStyleChange(record:StyleChangeRecord):void
		{
			if (record.stateMoveTo) {
				_x = record.moveDeltaX;
				_y = record.moveDeltaY;
				graphics.moveTo(_x, _y);
			}
		}
		
		protected override function drawStraightEdge(record:StraightEdgeRecord):void
		{
			if (record.generalLine || record.horizontalLine) {
				_x += record.deltaX;
			}
			if (record.generalLine || record.verticalLine) {
				_y += record.deltaY;
			}
			graphics.lineTo(_x, _y);
		}
		
		protected override function drawCurvedEdge(record:CurvedEdgeRecord):void
		{
			var controlX:Number = _x + record.controlDeltaX;
			var controlY:Number = _y + record.controlDeltaY;
			_x = controlX + record.anchorDeltaX;
			_y = controlY + record.anchorDeltaY;
			graphics.curveTo(controlX, controlY, _x, _y);
		}
	}
}