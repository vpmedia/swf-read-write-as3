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
	import org.libspark.swfassist.swf.structures.ZoneRecord;
	
	public class DefineFontAlignZones extends AbstractTag
	{
		public function DefineFontAlignZones(code:uint = 0)
		{
			super(code != 0 ? code : TagCodeConstants.TAG_DEFINE_FONT_ALIGN_ZONES);
		}
		
		private var _fontId:uint = 0;
		private var _csmTableHint:uint = CSMTableHintConstants.THIN;
		private var _zoneTable:Array = [];
		
		public function get fontId():uint
		{
			return _fontId;
		}
		
		public function set fontId(value:uint):void
		{
			_fontId = value;
		}
		
		public function get csmTableHint():uint
		{
			return _csmTableHint;
		}
		
		public function set csmTableHint(value:uint):void
		{
			_csmTableHint = value;
		}
		
		public function get numZones():uint
		{
			return zoneTable.length;
		}
		
		public function get zoneTable():Array
		{
			return _zoneTable;
		}
		
		public function set zoneTable(value:Array):void
		{
			_zoneTable = value;
		}
		
		public function clearZoneTable():void
		{
			if (numZones > 0) {
				zoneTable.splice(0, numZones);
			}
		}
		
		public function addZoneRecord(zone:ZoneRecord):void
		{
			zoneTable.push(zone);
		}
		
		public override function visit(visitor:TagVisitor):void
		{
			visitor.visitDefineFontAlignZones(this);
		}
	}
}