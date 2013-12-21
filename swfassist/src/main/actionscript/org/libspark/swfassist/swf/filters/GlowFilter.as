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
	import flash.filters.GlowFilter;
	
	public class GlowFilter extends AbstractFilter
	{
		public function GlowFilter(filterId:uint = 0)
		{
			super(filterId =! 0 ? filterId : FilterConstants.ID_GLOW);
		}
		
		private var _glowColor:RGBA = new RGBA();
		private var _blurX:Number = 6.0;
		private var _blurY:Number = 6.0;
		private var _strength:Number = 2.0;
		private var _innerGlow:Boolean = false;
		private var _knockout:Boolean = false;
		private var _passes:uint = 1;
		
		public function get glowColor():RGBA
		{
			return _glowColor;
		}
		
		public function set glowColor(value:RGBA):void
		{
			_glowColor = value;
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
		
		public function get strength():Number
		{
			return _strength;
		}
		
		public function set strength(value:Number):void
		{
			_strength = value;
		}
		
		public function get innerGlow():Boolean
		{
			return _innerGlow;
		}
		
		public function set innerGlow(value:Boolean):void
		{
			_innerGlow = value;
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
		
		public function fromNativeFilter(filter:flash.filters.GlowFilter):void
		{
			glowColor.fromUint(filter.color);
			glowColor.alpha = uint(filter.alpha * 0xff) & 0xff;
			blurX = filter.blurX;
			blurY = filter.blurY;
			strength = filter.strength;
			innerGlow = filter.inner;
			knockout = filter.knockout;
			passes = filter.quality;
		}
		
		public function toNativeFilter():flash.filters.GlowFilter
		{
			var filter:flash.filters.GlowFilter = new flash.filters.GlowFilter();
			filter.color = glowColor.toUint() & 0xffffff;
			filter.alpha = glowColor.alpha / 0xff;
			filter.blurX = blurX;
			filter.blurY = blurY;
			filter.strength = strength;
			filter.inner = innerGlow;
			filter.knockout = knockout;
			filter.quality = passes;
			return filter;
		}
	}
}