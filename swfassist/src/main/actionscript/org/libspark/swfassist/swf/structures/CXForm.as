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
	import flash.geom.ColorTransform;
	
	public class CXForm
	{
		private var _hasAddition:Boolean = false;
		private var _hasMultiplication:Boolean = false;
		private var _redMul:int = 1.0;
		private var _greenMul:int = 1.0;
		private var _blueMul:int = 1.0;
		private var _redAdd:int = 0;
		private var _greenAdd:int = 0;
		private var _blueAdd:int = 0;
		
		public function get hasAddition():Boolean
		{
			return _hasAddition;
		}
		
		public function set hasAddition(value:Boolean):void
		{
			_hasAddition = value;
		}
		
		public function get hasMultiplication():Boolean
		{
			return _hasMultiplication;
		}
		
		public function set hasMultiplication(value:Boolean):void
		{
			_hasMultiplication = value;
		}
		
		// SB
		public function get redMultiplication():int
		{
			return _redMul;
		}
		
		public function set redMultiplication(value:int):void
		{
			_redMul = value;
		}
		
		// SB
		public function get greenMultiplication():int
		{
			return _greenMul;
		}
		
		public function set greenMultiplication(value:int):void
		{
			_greenMul = value;
		}
		
		// SB
		public function get blueMultiplication():int
		{
			return _blueMul;
		}
		
		public function set blueMultiplication(value:int):void
		{
			_blueMul = value;
		}
		
		// SB
		public function get redAddition():int
		{
			return _redAdd;
		}
		
		public function set redAddition(value:int):void
		{
			_redAdd = value;
		}
		
		// SB
		public function get greenAddition():int
		{
			return _greenAdd;
		}
		
		public function set greenAddition(value:int):void
		{
			_greenAdd = value;
		}
		
		// SB
		public function get blueAddition():int
		{
			return _blueAdd;
		}
		
		public function set blueAddition(value:int):void
		{
			_blueAdd = value;
		}
		
		public function toNativeColorTransform():ColorTransform
		{
			var tf:ColorTransform = new ColorTransform();
			
			tf.redMultiplier = redMultiplication;
			tf.greenMultiplier = greenMultiplication;
			tf.blueMultiplier = blueMultiplication;
			tf.alphaMultiplier = 1.0;
			tf.redOffset = redAddition;
			tf.greenOffset = greenAddition;
			tf.blueOffset = blueAddition;
			tf.alphaOffset = 0;
			
			return tf;
		}
	}
}