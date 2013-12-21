﻿/* * The Spark Project ( http://libspark.org ) * * Licensed under the Apache License, Version 2.0 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at * *     http://www.apache.org/licenses/LICENSE-2.0 * * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,  * either express or implied. See the License for the specific language * governing permissions and limitations under the License. * * Contributor(s): * Daniel Riley	 ( http://scientificsciences.com ) */package org.libspark.swfassist.swf.abc.io{	import org.libspark.swfassist.errors.ErrorHandler;	import org.libspark.swfassist.errors.DefaultErrorHandler;		/**	 * Contains variables that complement the ABCReader class, mainly for keeping track	 * of the read so it can be executed in a thread-based style.	 *  	 * @author danriley	 * @version 0.1	 */		public class ABCContext	{		public static const CURSOR_HEADER		:uint = 0;		public static const CURSOR_CPOOL		:uint = 1;		public static const CURSOR_METHODS		:uint = 2;		public static const CURSOR_METADATA		:uint = 3;		public static const CURSOR_INSTANCES	:uint = 4;		public static const CURSOR_CLASSES		:uint = 5;		public static const CURSOR_SCRIPTS		:uint = 6;		public static const CURSOR_METHODBODIES	:uint = 7;		public static const CURSOR_COMPLETE		:uint = 8;						public var cursor:uint = 0;				private static var _defaultErrorHandler:ErrorHandler = new DefaultErrorHandler();		protected var _errorHandler:ErrorHandler;				public function get errorHandler():ErrorHandler		{			return _errorHandler || _defaultErrorHandler;		}				public function set errorHandler(value:ErrorHandler):void		{			_errorHandler = value;		}				/**		 * This method is called after a section of the ABC file has been read.		 * it decides if the reader should move on to the next section or if it		 * should continue in the current section, based on the context.		 */		 		public function updateCursor()		{			cursor++;		}	}}