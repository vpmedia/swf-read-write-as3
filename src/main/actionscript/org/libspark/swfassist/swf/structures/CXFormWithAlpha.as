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
	
	public class CXFormWithAlpha extends CXForm
	{
		private var _alphaMul:int = 1.0;
		private var _alphaAdd:int = 0.0;
		
		// SB
		public function get alphaMultiplication():int
		{
			return _alphaMul;
		}
		
		public function set alphaMultiplication(value:int):void
		{
			_alphaMul = value;
		}
		
		// SB
		public function get alphaAddition():int
		{
			return _alphaAdd;
		}
		
		public function set alphaAddition(value:int):void
		{
			_alphaAdd = value;
		}
		
		public override function toNativeColorTransform():ColorTransform
		{
			var tf:ColorTransform = super.toNativeColorTransform();
			
			tf.alphaMultiplier = alphaMultiplication;
			tf.alphaOffset = alphaAddition;
			
			return tf;
		}
	}
}