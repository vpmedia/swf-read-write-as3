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
	import flash.geom.Matrix;
	
	public class Matrix
	{
		private var _hasScale:Boolean = false;
		private var _scaleX:Number = 1.0;
		private var _scaleY:Number = 1.0;
		private var _hasRotate:Boolean = false;
		private var _rotateSkew0:Number = 0.0;
		private var _rotateSkew1:Number = 0.0;
		private var _translateX:int = 0;
		private var _translateY:int = 0;
		
		public function get hasScale():Boolean
		{
			return _hasScale;
		}
		
		public function set hasScale(value:Boolean):void
		{
			_hasScale = value;
		}
		
		// FB
		public function get scaleX():Number
		{
			return _scaleX;
		}
		
		public function set scaleX(value:Number):void
		{
			_scaleX = value;
		}
		
		// FB
		public function get scaleY():Number
		{
			return _scaleY;
		}
		
		public function set scaleY(value:Number):void
		{
			_scaleY = value;
		}
		
		public function get hasRotate():Boolean
		{
			return _hasRotate;
		}
		
		public function set hasRotate(value:Boolean):void
		{
			_hasRotate = value;
		}
		
		// FB
		public function get rotateSkew0():Number
		{
			return _rotateSkew0;
		}
		
		public function set rotateSkew0(value:Number):void
		{
			_rotateSkew0 = value;
		}
		
		// FB
		public function get rotateSkew1():Number
		{
			return _rotateSkew1;
		}
		
		public function set rotateSkew1(value:Number):void
		{
			_rotateSkew1 = value;
		}
		
		// SB
		public function get translateX():Number
		{
			return translateXTwips / 20;
		}
		
		public function set translateX(value:Number):void
		{
			translateXTwips = value * 20;
		}
		
		public function get translateXTwips():int
		{
			return _translateX;
		}
		
		public function set translateXTwips(value:int):void
		{
			_translateX = value;
		}
		
		// SB
		public function get translateY():Number
		{
			return translateYTwips / 20;
		}
		
		public function set translateY(value:Number):void
		{
			translateYTwips = value * 20;
		}
		
		public function get translateYTwips():int
		{
			return _translateY;
		}
		
		public function set translateYTwips(value:int):void
		{
			_translateY = value;
		}
		
		public function toNativeMatrix():flash.geom.Matrix
		{
			var mat:flash.geom.Matrix = new flash.geom.Matrix();
			
			mat.a = scaleX;
			mat.d = scaleY;
			mat.b = rotateSkew0;
			mat.c = rotateSkew1;
			mat.tx = translateX;
			mat.ty = translateY;
			
			return mat;
		}
	}
}