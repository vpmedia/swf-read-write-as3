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
	import org.libspark.swfassist.swf.structures.ShapeWithStyle;
	import org.libspark.swfassist.swf.structures.LineStyle;
	import org.libspark.swfassist.swf.structures.LineStyle2;
	import org.libspark.swfassist.swf.structures.RGBA;
	import org.libspark.swfassist.swf.structures.JoinStyleConstants;
	import flash.display.JointStyle;
	import org.libspark.swfassist.swf.structures.CapStyleConstants;
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import org.libspark.swfassist.swf.structures.FillStyle;
	import org.libspark.swfassist.swf.structures.FillStyleTypeConstants;
	import flash.display.GradientType;
	import org.libspark.swfassist.swf.structures.Gradient;
	import org.libspark.swfassist.swf.structures.GradientRecord;
	import org.libspark.swfassist.swf.structures.SpreadModeConstants;
	import flash.display.SpreadMethod;
	import org.libspark.swfassist.swf.structures.InterpolationModeConstants;
	import flash.display.InterpolationMethod;
	import org.libspark.swfassist.swf.structures.FocalGradient;

	/**
	 * Incomplete
	 */
	public class ShapeWithStyleDrawer extends AbstractShapeDrawer
	{
		public function ShapeWithStyleDrawer(graphics:VectorGraphics = null)
		{
			super(graphics);
		}
		
		private var _x:Number;
		private var _y:Number;
		private var _fillStyles:Array;
		private var _lineStyles:Array;
		private var _fillStyle:FillStyle;
		private var _lineStyle:LineStyle2;
		
		public override function draw(shape:Shape):void
		{
			_x = 0;
			_y = 0;
			
			_fillStyle = null;
			_lineStyle = null;
			
			if (shape is ShapeWithStyle) {
				_fillStyles = ShapeWithStyle(shape).fillStyles.fillStyles;
				_lineStyles = ShapeWithStyle(shape).lineStyles.lineStyles;
			}
			else {
				_fillStyles = null;
				_lineStyles = null;
			}
			
			graphics.endFill();
			graphics.lineStyle(0);
			
			super.draw(shape);
			
			graphics.endFill();
			graphics.lineStyle(0);
		}
		
		private function setFillStyle(id:uint):void
		{
			_fillStyle = null;
			
			if (id == 0) {
				graphics.endFill();
				return;
			}
			if (_fillStyles) {
				applyFillStyle(_fillStyle = FillStyle(_fillStyles[id - 1]));
			}
		}
		
		private function applyFillStyle(style:FillStyle):void
		{
			if (style.fillStyleType == FillStyleTypeConstants.SOLID_FILL) {
				graphics.beginFill(style.color.toUint() & 0xffffff, style.color.alpha / 0xff);
				return;
			}
			if (style.fillStyleType == FillStyleTypeConstants.LINEAR_GRADIENT_FILL ||
			    style.fillStyleType == FillStyleTypeConstants.RADIAL_GRADIENT_FILL ||
			    style.fillStyleType == FillStyleTypeConstants.FOCAL_RADIAL_GRADIENT_FILL) {
			
			var isLinear:Boolean = style.fillStyleType == FillStyleTypeConstants.LINEAR_GRADIENT_FILL;
			var isFocal:Boolean = style.fillStyleType == FillStyleTypeConstants.FOCAL_RADIAL_GRADIENT_FILL;
			var gradient:FocalGradient = style.gradient;
			var colors:Array = [];
			var alphas:Array = [];
			var ratios:Array = [];
			for each (var record:GradientRecord in gradient.gradientRecords) {
				var gc:RGBA = record.color;
				colors.push(gc.toUint() & 0xffffff);
				alphas.push(gc.alpha / 0xff);
				ratios.push(record.ratio);
			}
			
			graphics.beginGradientFill(isLinear ? GradientType.LINEAR : GradientType.RADIAL,
			                           colors,
			                           alphas,
			                           ratios,
			                           style.matrix.toNativeMatrix(),
			                           getSparedMethod(gradient.spreadMode),
			                           getInterpolationMethod(gradient.interpolationMode),
			                           isFocal ? gradient.focalPoint : 0);
			}
		}
		
		private function setLineStyle(id:uint):void
		{
			_lineStyle = null;
			
			if (id == 0) {
				graphics.lineStyle(0);
				return;
			}
			if (_lineStyles) {
				var style:LineStyle = LineStyle(_lineStyles[id - 1]);
				if (style is LineStyle2) {
					applyLineStyle2(_lineStyle = LineStyle2(style));
				}
				else {
					applyLineStyle(style);
				}
			}
		}
		
		private function applyLineStyle(style:LineStyle):void
		{
			var color:RGBA = style.color;
			graphics.lineStyle(style.width, color.toUint() & 0xffffff, color.alpha / 0xff);
		}
		
		private function applyLineStyle2(style:LineStyle2):void
		{
			var color:RGBA = style.color;
			graphics.lineStyle(style.width, color.toUint() & 0xffffff, color.alpha / 0xff,
			                   style.pixelHinting,
			                   getScaleMode(style.noHorizontalScale, style.noVerticalScale),
			                   getCapsStyle(style.startCapStyle),
			                   getJoinStyle(style.joinStyle),
			                   style.miterLimitFactor);
			if (style.hasFill) {
				var fill:FillStyle = style.fillType;
				if (fill.fillStyleType == FillStyleTypeConstants.LINEAR_GRADIENT_FILL ||
				    fill.fillStyleType == FillStyleTypeConstants.RADIAL_GRADIENT_FILL ||
				    fill.fillStyleType == FillStyleTypeConstants.FOCAL_RADIAL_GRADIENT_FILL) {
				
				var isLinear:Boolean = fill.fillStyleType == FillStyleTypeConstants.LINEAR_GRADIENT_FILL;
				var isFocal:Boolean = fill.fillStyleType == FillStyleTypeConstants.FOCAL_RADIAL_GRADIENT_FILL;
				var gradient:FocalGradient = fill.gradient;
				var colors:Array = [];
				var alphas:Array = [];
				var ratios:Array = [];
				for each (var record:GradientRecord in gradient.gradientRecords) {
					var gc:RGBA = record.color;
					colors.push(gc.toUint() & 0xffffff);
					alphas.push(gc.alpha / 0xff);
					ratios.push(record.ratio);
				}
				
				graphics.lineGradientStyle(isLinear ? GradientType.LINEAR : GradientType.RADIAL,
				                           colors,
				                           alphas,
				                           ratios,
				                           fill.matrix.toNativeMatrix(),
				                           getSparedMethod(gradient.spreadMode),
				                           getInterpolationMethod(gradient.interpolationMode),
				                           isFocal ? gradient.focalPoint : 0);
				}
			}
		}
		
		private function getJoinStyle(style:uint):String
		{
			switch (style) {
				case JoinStyleConstants.BEVEL_JOIN:
					return JointStyle.BEVEL;
				case JoinStyleConstants.MITER_JOIN:
					return JointStyle.MITER;
				case JoinStyleConstants.ROUND_JOIN:
					return JointStyle.ROUND;
			}
			return null;
		}
		
		private function getCapsStyle(style:uint):String
		{
			switch (style) {
				case CapStyleConstants.NO_CAP:
					return CapsStyle.NONE;
				case CapStyleConstants.ROUND_CAP:
					return CapsStyle.ROUND;
				case CapStyleConstants.SQUARE_CAP:
					return CapsStyle.SQUARE;
			}
			return null;
		}
		
		private function getScaleMode(noHScale:Boolean, noVScale:Boolean):String
		{
			if (noHScale && noVScale) {
				return LineScaleMode.NONE;
			}
			if (noHScale) {
				return LineScaleMode.VERTICAL;
			}
			if (noVScale) {
				return LineScaleMode.HORIZONTAL;
			}
			return LineScaleMode.NORMAL;
		}
		
		private function getSparedMethod(method:uint):String
		{
			switch (method) {
				case SpreadModeConstants.PAD_MODE:
					return SpreadMethod.PAD;
				case SpreadModeConstants.REFLECT_MODE:
					return SpreadMethod.REFLECT;
				case SpreadModeConstants.REPEAT_MODE:
					return SpreadMethod.REPEAT;
			}
			return null;
		}
		
		private function getInterpolationMethod(method:uint):String
		{
			switch (method) {
				case InterpolationModeConstants.LINEAR_RGB_MODE:
					return InterpolationMethod.LINEAR_RGB;
				case InterpolationModeConstants.NORMAL_RGB_MODE:
					return InterpolationMethod.RGB;
			}
			return null;
		}
		
		protected override function drawStyleChange(record:StyleChangeRecord):void
		{
			if (record.stateMoveTo) {
				_x = record.moveDeltaX;
				_y = record.moveDeltaY;
				graphics.moveTo(_x, _y);
			}
			if (record.stateNewStyles) {
				_fillStyles = record.fillStyles.fillStyles;
				_lineStyles = record.lineStyles.lineStyles;
			}
			if (record.stateFillStyle0) {
				graphics.moveTo(_x, _y);
				// setFillStyle(record.fillStyle0);
				c = record.fillStyle0 != 0 ? c | 0xff0000 : c & 0x00ffff;
			}
			/**/
			if (record.stateFillStyle1) {
				graphics.moveTo(_x, _y);
				// setFillStyle(record.fillStyle1);
				c = record.fillStyle1 != 0 ? c | 0x0000ff : c & 0xffff00;
			}
			graphics.lineStyle(1, c);
			/**
			if (record.stateLineStyle) {
				setLineStyle(record.lineStyle);
			}
			*/
		}
		private var c:uint = 0;
		
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