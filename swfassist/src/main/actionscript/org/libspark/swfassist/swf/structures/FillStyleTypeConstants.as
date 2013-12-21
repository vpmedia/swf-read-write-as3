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
	public class FillStyleTypeConstants
	{
		public static const SOLID_FILL:uint                    = 0x00;
		public static const LINEAR_GRADIENT_FILL:uint          = 0x10;
		public static const RADIAL_GRADIENT_FILL:uint          = 0x12;
		public static const FOCAL_RADIAL_GRADIENT_FILL:uint    = 0x13;
		public static const REPEATING_BITMAP_FILL:uint         = 0x40;
		public static const CLIPPED_BITMAP_FILL:uint           = 0x41;
		public static const NON_SMOOTHED_REPEATING_BITMAP:uint = 0x42;
		public static const NON_SMOOTHED_CLIPPED_BITMAP:uint   = 0x43;
	}
}