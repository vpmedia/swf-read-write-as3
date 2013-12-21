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
	public class CurvedEdgeRecord extends AbstractShapeRecord
	{
		public function CurvedEdgeRecord()
		{
			super(ShapeRecordTypeConstants.CURVED_EDGE, true);
		}
		
		private var _controlDeltaX:int = 0;
		private var _controlDeltaY:int = 0;
		private var _anchorDeltaX:int = 0;
		private var _anchorDeltaY:int = 0;
		
		public function get controlDeltaX():Number
		{
			return controlDeltaXTwips / twipsFactor;
		}
		
		public function set controlDeltaX(value:Number):void
		{
			controlDeltaXTwips = value * twipsFactor;
		}
		
		public function get controlDeltaXTwips():int
		{
			return _controlDeltaX;
		}
		
		public function set controlDeltaXTwips(value:int):void
		{
			_controlDeltaX = value;
		}
		
		public function get controlDeltaY():Number
		{
			return controlDeltaYTwips / twipsFactor;
		}
		
		public function set controlDeltaY(value:Number):void
		{
			controlDeltaYTwips = value * twipsFactor;
		}
		
		public function get controlDeltaYTwips():int
		{
			return _controlDeltaY;
		}
		
		public function set controlDeltaYTwips(value:int):void
		{
			_controlDeltaY = value;
		}
		
		public function get anchorDeltaX():Number
		{
			return anchorDeltaXTwips / twipsFactor;
		}
		
		public function set anchorDeltaX(value:Number):void
		{
			anchorDeltaXTwips = value * twipsFactor;
		}
		
		public function get anchorDeltaXTwips():int
		{
			return _anchorDeltaX;
		}
		
		public function set anchorDeltaXTwips(value:int):void
		{
			_anchorDeltaX = value;
		}
		
		public function get anchorDeltaY():Number
		{
			return anchorDeltaYTwips / twipsFactor;
		}
		
		public function set anchorDeltaY(value:Number):void
		{
			anchorDeltaYTwips = value * twipsFactor;
		}
		
		public function get anchorDeltaYTwips():int
		{
			return _anchorDeltaY;
		}
		
		public function set anchorDeltaYTwips(value:int):void
		{
			_anchorDeltaY = value;
		}
	}
}