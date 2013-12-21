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

package org.libspark.swfassist.swf.tags
{
	import org.libspark.swfassist.swf.structures.Matrix;
	import org.libspark.swfassist.swf.structures.CXForm;
	
	public class PlaceObject extends AbstractTag
	{
		public function PlaceObject(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_PLACE_OBJECT);
		}
		
		private var _characterId:uint = 0;
		private var _depth:uint = 0;
		private var _matrix:Matrix = new Matrix();
		private var _hasColorTransform:Boolean = false;
		private var _colorTransform:CXForm = new CXForm();
		
		// UI16
		public function get characterId():uint
		{
			return _characterId;
		}
		
		public function set characterId(value:uint):void
		{
			_characterId = value;
		}
		
		// UI16
		public function get depth():uint
		{
			return _depth;
		}
		
		public function set depth(value:uint):void
		{
			_depth = value;
		}
		
		public function get matrix():Matrix
		{
			return _matrix;
		}
		
		public function set matrix(value:Matrix):void
		{
			_matrix = value;
		}
		
		public function get hasColorTransform():Boolean
		{
			return _hasColorTransform;
		}
		
		public function set hasColorTransform(value:Boolean):void
		{
			_hasColorTransform = value;
		}
		
		public function get colorTransform():CXForm
		{
			return _colorTransform;
		}
		
		public function set colorTransform(value:CXForm):void
		{
			_colorTransform = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitPlaceObject(this);
		}
	}
}