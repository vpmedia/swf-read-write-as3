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
	import flash.filters.DropShadowFilter;
	
	public class DropShadowFilter extends AbstractFilter
	{
		public function DropShadowFilter(filterId:uint = 0)
		{
			super(filterId != 0 ? filterId : FilterConstants.ID_DROP_SHADOW);
		}
		
		private var _dropShadowColor:RGBA = new RGBA();
		private var _blurX:Number = 4.0;
		private var _blurY:Number = 4.0;
		private var _angle:Number = 45;
		private var _distance:Number = 4.0;
		private var _strength:Number = 1.0;
		private var _innerShadow:Boolean = false;
		private var _knockout:Boolean = false;
		private var _passes:uint = 1;
		
		public function get dropShadowColor():RGBA
		{
			return _dropShadowColor;
		}
		
		public function set dropShadowColor(value:RGBA):void
		{
			_dropShadowColor = value;
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
		
		public function get passes():uint
		{
			return _passes;
		}
		
		public function set passes(value:uint):void
		{
			_passes = value;
		}
		
		public function fromNativeFilter(filter:flash.filters.DropShadowFilter):void
		{
			dropShadowColor.fromUint(filter.color);
			dropShadowColor.alpha = uint(filter.alpha * 0xff) & 0xff;
			blurX = filter.blurX;
			blurY = filter.blurY;
			angle = filter.angle;
			distance = filter.distance;
			strength = filter.strength;
			innerShadow = filter.inner;
			knockout = filter.knockout;
			passes = filter.quality;
		}
		
		public function toNativeFilter():flash.filters.DropShadowFilter
		{
			var filter:flash.filters.DropShadowFilter = new flash.filters.DropShadowFilter();
			filter.color = dropShadowColor.toUint() & 0xffffff;
			filter.alpha = dropShadowColor.alpha / 0xff;
			filter.blurX = blurX;
			filter.blurY = blurY;
			filter.angle = angle;
			filter.distance = distance;
			filter.strength = strength;
			filter.inner = innerShadow;
			filter.knockout = knockout;
			filter.quality = passes;
			return filter;
		}
	}
}