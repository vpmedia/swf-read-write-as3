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

package org.libspark.swfassist.swf.io
{
	import org.libspark.swfassist.errors.DefaultErrorHandler;
	import org.libspark.swfassist.errors.ErrorHandler;
	
	public class WritingContext
	{
		private static var _defaultErrorHandler:ErrorHandler = new DefaultErrorHandler();
		
		private var _errorHandler:ErrorHandler = null;
		private var _version:uint = 9;
		private var _ignoreSWFVersion:Boolean = false;
		private var _fileLengthPosition:uint = 0;
		private var _tagType:uint = 0;
		private var _numFillStyles:uint = 0;
		private var _numLineStyles:uint = 0;
		private var _areWideCodes:Boolean = false;
		private var _glyphBits:uint = 0;
		private var _advanceBits:uint = 0;
		private var _offset:uint = 0;
		private var _length:uint = 0;
		
		public function get errorHandler():ErrorHandler
		{
			return _errorHandler || _defaultErrorHandler;
		}
		
		public function set errorHandler(value:ErrorHandler):void
		{
			_errorHandler = value;
		}
		
		public function get version():uint
		{
			return _version;
		}
		
		public function set version(value:uint):void
		{
			_version = value;
		}
		
		public function get ignoreSWFVersion():Boolean
		{
			return _ignoreSWFVersion;
		}
		
		public function set ignoreSWFVersion(value:Boolean):void
		{
			_ignoreSWFVersion = value;
		}
		
		public function get fileLengthPosition():uint
		{
			return _fileLengthPosition;
		}
		
		public function set fileLengthPosition(value:uint):void
		{
			_fileLengthPosition = value;
		}
		
		public function get tagType():uint
		{
			return _tagType;
		}
		
		public function set tagType(value:uint):void
		{
			_tagType = value;
		}
		
		public function get numFillStyles():uint
		{
			return _numFillStyles;
		}
		
		public function set numFillStyles(value:uint):void
		{
			_numFillStyles = value;
		}
		
		public function get numLineStyles():uint
		{
			return _numLineStyles;
		}
		
		public function set numLineStyles(value:uint):void
		{
			_numLineStyles = value;
		}
		
		public function get areWideCodes():Boolean
		{
			return _areWideCodes;
		}
		
		public function set areWideCodes(value:Boolean):void
		{
			_areWideCodes = value;
		}
		
		public function get glyphBits():uint
		{
			return _glyphBits;
		}
		
		public function set glyphBits(value:uint):void
		{
			_glyphBits = value;
		}
		
		public function get advanceBits():uint
		{
			return _advanceBits;
		}
		
		public function set advanceBits(value:uint):void
		{
			_advanceBits = value;
		}
		
		public function get offset():uint
		{
			return _offset;
		}
		
		public function set offset(value:uint):void
		{
			_offset = value;
		}
		
		public function get length():uint
		{
			return _length;
		}
		
		public function set length(value:uint):void
		{
			_length = value;
		}
	}
}