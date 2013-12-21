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
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	public class FlashGraphics implements VectorGraphics
	{
		public function FlashGraphics(graphics:Graphics = null)
		{
			if (graphics) {
				this.graphics = graphics;
			}
		}
		
		private var _graphics:Graphics;
		
		public function get graphics():Graphics
		{
			return _graphics;
		}
		
		public function set graphics(value:Graphics):void
		{
			_graphics = value;
		}
		
		public function beginFill(color:uint, alpha:Number = 1.0):void
		{
			graphics.beginFill(color, alpha);
		}
		
		public function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			graphics.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void
		{
			graphics.curveTo(controlX, controlY, anchorX, anchorY);
		}
		
		public function endFill():void
		{
			graphics.endFill();
		}
		
		public function lineGradientStyle(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, sparedMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0):void
		{
			graphics.lineGradientStyle(type, colors, alphas, ratios, matrix, sparedMethod, interpolationMethod, focalPointRatio);
		}
		
		public function lineStyle(thickness:Number, color:uint=0, alpha:Number=1.0, pixelHinting:Boolean=false, scaleMode:String="normal", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
		}
		
		public function lineTo(x:Number, y:Number):void
		{
			graphics.lineTo(x, y);
		}
		
		public function moveTo(x:Number, y:Number):void
		{
			graphics.moveTo(x, y);
		}
	}
}