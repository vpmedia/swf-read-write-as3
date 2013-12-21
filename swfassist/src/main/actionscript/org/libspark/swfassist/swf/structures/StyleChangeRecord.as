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
	public class StyleChangeRecord extends AbstractShapeRecord
	{
		public function StyleChangeRecord()
		{
			super(ShapeRecordTypeConstants.STYLE_CHANGE, false);
		}
		
		private var _stateNewStyles:Boolean = false;
		private var _stateLineStyle:Boolean = false;
		private var _stateFillStyle0:Boolean = false;
		private var _stateFillStyle1:Boolean = false;
		private var _stateMoveTo:Boolean = false;
		private var _moveDeltaX:int = 0;
		private var _moveDeltaY:int = 0;
		private var _fillStyle0:uint = 0;
		private var _fillStyle1:uint = 0;
		private var _lineStyle:uint = 0;
		private var _fillStyles:FillStyleArray = new FillStyleArray();
		private var _lineStyles:LineStyleArray = new LineStyleArray();
		
		public function get stateNewStyles():Boolean
		{
			return _stateNewStyles;
		}
		
		public function set stateNewStyles(value:Boolean):void
		{
			_stateNewStyles = value;
		}
		
		public function get stateLineStyle():Boolean
		{
			return _stateLineStyle;
		}
		
		public function set stateLineStyle(value:Boolean):void
		{
			_stateLineStyle = value;
		}
		
		public function get stateFillStyle0():Boolean
		{
			return _stateFillStyle0;
		}
		
		public function set stateFillStyle0(value:Boolean):void
		{
			_stateFillStyle0 = value;
		}
		
		public function get stateFillStyle1():Boolean
		{
			return _stateFillStyle1;
		}
		
		public function set stateFillStyle1(value:Boolean):void
		{
			_stateFillStyle1 = value;
		}
		
		public function get stateMoveTo():Boolean
		{
			return _stateMoveTo;
		}
		
		public function set stateMoveTo(value:Boolean):void
		{
			_stateMoveTo = value;
		}
		
		public function get moveDeltaX():Number
		{
			return moveDeltaXTwips / twipsFactor;
		}
		
		public function set moveDeltaX(value:Number):void
		{
			moveDeltaXTwips = value * twipsFactor;
		}
		
		public function get moveDeltaXTwips():int
		{
			return _moveDeltaX;
		}
		
		public function set moveDeltaXTwips(value:int):void
		{
			_moveDeltaX = value;
		}
		
		public function get moveDeltaY():Number
		{
			return moveDeltaYTwips / twipsFactor;
		}
		
		public function set moveDeltaY(value:Number):void
		{
			moveDeltaYTwips = value * twipsFactor;
		}
		
		public function get moveDeltaYTwips():int
		{
			return _moveDeltaY;
		}
		
		public function set moveDeltaYTwips(value:int):void
		{
			_moveDeltaY = value;
		}
		
		public function get fillStyle0():uint
		{
			return _fillStyle0;
		}
		
		public function set fillStyle0(value:uint):void
		{
			_fillStyle0 = value;
		}
		
		public function get fillStyle1():uint
		{
			return _fillStyle1;
		}
		
		public function set fillStyle1(value:uint):void
		{
			_fillStyle1 = value;
		}
		
		public function get lineStyle():uint
		{
			return _lineStyle;
		}
		
		public function set lineStyle(value:uint):void
		{
			_lineStyle = value;
		}
		
		public function get fillStyles():FillStyleArray
		{
			return _fillStyles;
		}
		
		public function set fillStyles(value:FillStyleArray):void
		{
			_fillStyles = value;
		}
		
		public function get lineStyles():LineStyleArray
		{
			return _lineStyles;
		}
		
		public function set lineStyles(value:LineStyleArray):void
		{
			_lineStyles = value;
		}
	}
}