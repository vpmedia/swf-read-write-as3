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

package org.libspark.swfassist.swf.filters
{
	import org.libspark.swfassist.swf.structures.RGBA;
	import flash.filters.GradientBevelFilter;
	import flash.filters.BitmapFilterType;
	
	public class GradientBevelFilter extends AbstractFilter
	{
		public function GradientBevelFilter(filterId:uint = 0)
		{
			super(filterId != 0 ? filterId : FilterConstants.ID_GRADIENT_BEVEL);
		}
		
		private var _gradientColors:Array = [];
		private var _gradientRatio:Array = [];
		private var _blurX:Number = 4.0;
		private var _blurY:Number = 4.0;
		private var _angle:Number = 45;
		private var _distance:Number = 4.0;
		private var _strength:Number = 1.0;
		private var _innerShadow:Boolean = false;
		private var _knockout:Boolean = false;
		private var _onTop:Boolean = false;
		private var _passes:uint = 1;
		
		public function get gradientColors():Array
		{
			return _gradientColors;
		}
		
		public function set gradientColors(value:Array):void
		{
			_gradientColors = value;
		}
		
		public function get gradientRatio():Array
		{
			return _gradientRatio;
		}
		
		public function set gradientRatio(value:Array):void
		{
			_gradientRatio = value;
		}
		
		public function get blurX():Number
		{
			return _blurX;
		}
		
		public function set blurX(value:Number):void
		{
			_blurX = value;
		}
		
		public function get blurY():Number
		{
			return _blurY;
		}
		
		public function set blurY(value:Number):void
		{
			_blurY = value;
		}
		
		public function get angle():Number
		{
			return _angle;
		}
		
		public function set angle(value:Number):void
		{
			_angle = value;
		}
		
		public function get distance():Number
		{
			return _distance;
		}
		
		public function set distance(value:Number):void
		{
			_distance = value;
		}
		
		public function get strength():Number
		{
			return _strength;
		}
		
		public function set strength(value:Number):void
		{
			_strength = value;
		}
		
		public function get innerShadow():Boolean
		{
			return _innerShadow;
		}
		
		public function set innerShadow(value:Boolean):void
		{
			_innerShadow = value;
		}
		
		public function get knockout():Boolean
		{
			return _knockout;
		}
		
		public function set knockout(value:Boolean):void
		{
			_knockout = value;
		}
		
		public function get onTop():Boolean
		{
			return _onTop;
		}
		
		public function set onTop(value:Boolean):void
		{
			_onTop = value;
		}
		
		public function get passes():uint
		{
			return _passes;
		}
		
		public function set passes(value:uint):void
		{
			_passes = value;
		}
		
		public function fromNativeFilter(filter:flash.filters.GradientBevelFilter):void
		{
			var colors:Array = filter.colors;
			var alphas:Array = filter.alphas;
			var l:uint = colors.length;
			var dest:Array = new Array(l);
			for (var i:uint = 0; i < 0; ++i) {
				var rgba:RGBA = new RGBA();
				rgba.fromUint(colors[i]);
				rgba.alpha = uint(alphas[i] * 0xff) & 0xff;
				dest[i] = rgba;
			}
			gradientColors = dest;
			gradientRatio = filter.ratios.slice();
			blurX = filter.blurX;
			blurY = filter.blurY;
			angle = filter.angle;
			distance = filter.distance;
			strength = filter.strength;
			innerShadow = filter.type == BitmapFilterType.FULL || filter.type == BitmapFilterType.INNER;
			knockout = filter.knockout;
			onTop = filter.type == BitmapFilterType.FULL || filter.type == BitmapFilterType.OUTER;
			passes = filter.quality;
		}
		
		public function toNativeFilter():flash.filters.GradientBevelFilter
		{
			var filter:flash.filters.GradientBevelFilter = new flash.filters.GradientBevelFilter();
			var colors:Array = gradientColors;
			var l:uint = colors.length;
			var destColors:Array = new Array(l);
			var destAlphas:Array = new Array(l);
			for (var i:uint = 0; i < l; ++i) {
				var rgba:RGBA = RGBA(colors[i]);
				destColors[i] = rgba.toUint() & 0xffffff;
				destAlphas[i] = rgba.alpha / 0xff;
			}
			filter.colors = destColors;
			filter.alphas = destAlphas;
			filter.ratios = gradientRatio.slice();
			filter.blurX = blurX;
			filter.blurY = blurY;
			filter.angle = angle;
			filter.distance = distance;
			filter.strength = strength;
			if (innerShadow && onTop) {
				filter.type = BitmapFilterType.FULL;
			}
			else if (innerShadow) {
				filter.type = BitmapFilterType.INNER;
			}
			else if (onTop) {
				filter.type = BitmapFilterType.OUTER;
			}
			filter.knockout = knockout;
			filter.quality = passes;
			return filter;
		}
	}
}