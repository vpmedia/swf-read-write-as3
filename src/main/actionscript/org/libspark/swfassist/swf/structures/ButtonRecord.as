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
	import org.libspark.swfassist.swf.filters.FilterList;
	import org.libspark.swfassist.swf.filters.BlendModeConstants;
	
	public class ButtonRecord
	{
		private var _hasBlendMode:Boolean = false;
		private var _hasFilterList:Boolean = false;
		private var _stateHitTest:Boolean = false;
		private var _stateDown:Boolean = false;
		private var _stateOver:Boolean = false;
		private var _stateUp:Boolean = false;
		private var _characterId:uint = 0;
		private var _placeDepth:uint = 0;
		private var _placeMatrix:Matrix = new Matrix();
		private var _colorTransform:CXFormWithAlpha = new CXFormWithAlpha();
		private var _filterList:FilterList = new FilterList();
		private var _blendMode:uint = BlendModeConstants.NORMAL;
		
		public function get hasBlendMode():Boolean
		{
			return _hasBlendMode;
		}
		
		public function set hasBlendMode(value:Boolean):void
		{
			_hasBlendMode = value;
		}
		
		public function get hasFilterList():Boolean
		{
			return _hasFilterList;
		}
		
		public function set hasFilterList(value:Boolean):void
		{
			_hasFilterList = value;
		}
		
		public function get stateHitTest():Boolean
		{
			return _stateHitTest;
		}
		
		public function set stateHitTest(value:Boolean):void
		{
			_stateHitTest = value;
		}
		
		public function get stateDown():Boolean
		{
			return _stateDown;
		}
		
		public function set stateDown(value:Boolean):void
		{
			_stateDown = value;
		}
		
		public function get stateOver():Boolean
		{
			return _stateOver;
		}
		
		public function set stateOver(value:Boolean):void
		{
			_stateOver = value;
		}
		
		public function get stateUp():Boolean
		{
			return _stateUp;
		}
		
		public function set stateUp(value:Boolean):void
		{
			_stateUp = value;
		}
		
		public function get characterId():uint
		{
			return _characterId;
		}
		
		public function set characterId(value:uint):void
		{
			_characterId = value;
		}
		
		public function get placeDepth():uint
		{
			return _placeDepth;
		}
		
		public function set placeDepth(value:uint):void
		{
			_placeDepth = value;
		}
		
		public function get placeMatrix():Matrix
		{
			return _placeMatrix;
		}
		
		public function set placeMatrix(value:Matrix):void
		{
			_placeMatrix = value;
		}
		
		/**
		 * DefineButton2 only.
		 */
		public function get colorTransform():CXFormWithAlpha
		{
			return _colorTransform;
		}
		
		public function set colorTransform(value:CXFormWithAlpha):void
		{
			_colorTransform = value;
		}
		
		/**
		 * DefineButton2 only.
		 */
		public function get filterList():FilterList
		{
			return _filterList;
		}
		
		public function set filterList(value:FilterList):void
		{
			_filterList = value;
		}
		
		/**
		 * DefineButton2 only.
		 */
		public function get blendMode():uint
		{
			return _blendMode;
		}
		
		public function set blendMode(value:uint):void
		{
			_blendMode = value;
		}
	}
}