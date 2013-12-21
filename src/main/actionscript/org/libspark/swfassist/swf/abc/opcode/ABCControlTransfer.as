﻿/* * Copyright(c) 2007 the Spark project. * * Licensed under the Apache License, Version 2.0 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at * *     http://www.apache.org/licenses/LICENSE-2.0 * * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,  * either express or implied. See the License for the specific language * governing permissions and limitations under the License. */package org.libspark.swfassist.swf.abc.opcode{	public class ABCControlTransfer	{		private var _base:int = 0;		private var _location:int = 0;		private var _offset:int = 0;		private var _updated:Boolean = false;				/**		 * ABCControlTransfer holds information about an if/switch control change		 * type statement, which causes the code to jump around. In a patching		 * situation, a patch can potentially mess up the code by altering the		 * length and disrupting offsets within a control change.		 */		 		public function ABCControlTransfer( loc:int = 0, offset:int = 0 ):void		{			_location = loc;			_offset = offset;		}				/**		 * Checks if an instruction is between the control transfer base		 * and its offset		 */		public function inside( loc:int ):Boolean		{			return (loc > _base && loc < _base + _offset) || (loc < _base && loc > _base + _offset );		}				/**		 * Modifies the offset by a given size change. If a patch increased		 * the area in between the transfer by 10 bytes, then the offset		 * needs to be increased 10 bytes in whichever direction it is.		 */		public function expand( size:int ):void		{			_offset += (_offset)/Math.abs(_offset) * size;		}				/**		 * Just a flag that this has been updated		 */		public function set updated(u:Boolean):void		{			_updated = u;		}				public function get updated():Boolean		{			return _updated;		}				/**		 * Returns whether this control transfer object is part of		 * a switch by comparing its base to its instruction location		 */		public function get isSwitch():Boolean		{			return _base != _location;		}				/**		 * The base is the point in the code that should be counted		 * from to reach the offset point		 */		public function set base( i:int ):void		{			_base = i;		}				public function get base():int		{			return _base;		}				/**		 * The location is the byte address of the offset variable in the		 * original byteArray, so we can overwrite it later		 */		public function set location( l:int ):void		{			_location = l;		}				public function get location():int		{			return _location;		}				/**		 * The number of bytes to jump from the base to the target		 */		public function get offset():int		{			return _offset;		}				public function set offset( o:int ):void		{			_offset = o;		}	}}