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
	import org.libspark.swfassist.swf.structures.CXFormWithAlpha;
	import org.libspark.swfassist.swf.structures.ClipActions;
	import org.libspark.swfassist.swf.structures.ClipEventFlags;
	
	public class PlaceObject2 extends AbstractTag
	{
		public function PlaceObject2(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_PLACE_OBJECT2);
		}
		
		private var _hasClipActions:Boolean = false;
		private var _hasClipDepth:Boolean = false;
		private var _hasName:Boolean = false;
		private var _hasRatio:Boolean = false;
		private var _hasColorTransform:Boolean = false;
		private var _hasMatrix:Boolean = false;
		private var _hasCharacter:Boolean = false;
		private var _isMove:Boolean = false;
		private var _depth:uint = 0;
		private var _characterId:uint = 0;
		private var _matrix:Matrix = new Matrix();
		private var _colorTransform:CXFormWithAlpha = new CXFormWithAlpha();
		private var _ratio:uint = 0;
		private var _name:String = null;
		private var _clipDepth:uint = 0;
		private var _clipActions:ClipActions = new ClipActions();
		
		public function get hasClipActions():Boolean
		{
			return _hasClipActions;
		}
		
		public function set hasClipActions(value:Boolean):void
		{
			_hasClipActions = value;
		}
		
		public function get hasClipDepth():Boolean
		{
			return _hasClipDepth;
		}
		
		public function set hasClipDepth(value:Boolean):void
		{
			_hasClipDepth = value;
		}
		
		public function get hasName():Boolean
		{
			return _hasName;
		}
		
		public function set hasName(value:Boolean):void
		{
			_hasName = value;
		}
		
		public function get hasRatio():Boolean
		{
			return _hasRatio;
		}
		
		public function set hasRatio(value:Boolean):void
		{
			_hasRatio = value;
		}
		
		public function get hasColorTransform():Boolean
		{
			return _hasColorTransform;
		}
		
		public function set hasColorTransform(value:Boolean):void
		{
			_hasColorTransform = value;
		}
		
		public function get hasMatrix():Boolean
		{
			return _hasMatrix;
		}
		
		public function set hasMatrix(value:Boolean):void
		{
			_hasMatrix = value;
		}
		
		public function get hasCharacter():Boolean
		{
			return _hasCharacter;
		}
		
		public function set hasCharacter(value:Boolean):void
		{
			_hasCharacter = value;
		}
		
		public function get isMove():Boolean
		{
			return _isMove;
		}
		
		public function set isMove(value:Boolean):void
		{
			_isMove = value;
		}
		
		public function get depth():uint
		{
			return _depth;
		}
		
		public function set depth(value:uint):void
		{
			_depth = value;
		}
		
		public function get characterId():uint
		{
			return _characterId;
		}
		
		public function set characterId(value:uint):void
		{
			_characterId = value;
		}
		
		public function get matrix():Matrix
		{
			return _matrix;
		}
		
		public function set matrix(value:Matrix):void
		{
			_matrix = value;
		}
		
		public function get colorTransform():CXFormWithAlpha
		{
			return _colorTransform;
		}
		
		public function set colorTransform(value:CXFormWithAlpha):void
		{
			_colorTransform = value;
		}
		
		public function get ratio():uint
		{
			return _ratio;
		}
		
		public function set ratio(value:uint):void
		{
			_ratio = value;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{
			_name = value;
		}
		
		public function get clipDepth():uint
		{
			return _clipDepth;
		}
		
		public function set clipDepth(value:uint):void
		{
			_clipDepth = value;
		}
		
		public function get clipActions():ClipActions
		{
			return _clipActions;
		}
		
		public function set clipActions(value:ClipActions):void
		{
			_clipActions = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitPlaceObject2(this);
		}
	}
}