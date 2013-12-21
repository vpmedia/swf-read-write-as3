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
	public class DefineSceneAndFrameLabelData extends AbstractTag
	{
		public function DefineSceneAndFrameLabelData(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_SCENE_AND_FRAME_LABEL_DATA);
		}
		
		private var _scenes:Array = [];
		private var _frameLabels:Array = [];
		
		public function get numScenes():uint
		{
			return scenes.length;
		}
		
		public function get scenes():Array
		{
			return _scenes;
		}
		
		public function set scenes(value:Array):void
		{
			_scenes = value;
		}
		
		public function get numFrameLabels():uint
		{
			return frameLabels.length;
		}
		
		public function get frameLabels():Array
		{
			return _frameLabels;
		}
		
		public function set frameLabels(value:Array):void
		{
			_frameLabels = value;
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineSceneAndFrameLabelData(this);
		}
	}
}