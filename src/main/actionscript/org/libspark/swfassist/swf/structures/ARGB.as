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
	public class ARGB extends RGBA
	{
		public override function fromUint(color:uint):void
		{
			alpha = (color >> 24) & 0xff;
			red = (color >> 16) & 0xff;
			green = (color >> 8) & 0xff;
			blue = color & 0xff;
		}
		
		public override function toUint():uint
		{
			return ((alpha & 0xff) << 24) | ((red & 0xff) << 16) | ((green << 8) & 0xff) | (alpha & 0xff);
		}
	}
}