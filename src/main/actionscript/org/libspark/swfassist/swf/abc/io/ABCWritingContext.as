﻿/* * The Spark Project ( http://libspark.org ) * * Licensed under the Apache License, Version 2.0 (the "License"); * you may not use this file except in compliance with the License. * You may obtain a copy of the License at * *     http://www.apache.org/licenses/LICENSE-2.0 * * Unless required by applicable law or agreed to in writing, software * distributed under the License is distributed on an "AS IS" BASIS, * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,  * either express or implied. See the License for the specific language * governing permissions and limitations under the License. * * Contributor(s): * Daniel Riley	 ( http://scientificsciences.com ) */package org.libspark.swfassist.swf.abc.io{	import org.libspark.swfassist.errors.ErrorHandler;	import org.libspark.swfassist.errors.DefaultErrorHandler;		/**	 * Contains variables that complement the ABCWriter class, mainly for keeping track	 * of the read so it can be executed in chunks.	 *  	 * @author danriley	 * @version 0.1	 */		public class ABCWritingContext extends ABCContext	{		public var methodCount		:int = -1;				public var methodBodyLimit	:uint = 0;		public var methodBodyCount	:int = -1;		public var methodBodyCursor	:int = 0;					/**		 * This method is called after a section of the ABC file has been written.		 * It decides if the writer should move on to the next section or if it		 * should continue in the current section, based on the context.		 */		 		public override function updateCursor()		{			var nextStep:Boolean = true;						switch( cursor )			{				case CURSOR_METHODBODIES:					if( methodBodyCursor != methodCount )						nextStep = false;					break;			}						if( nextStep )				cursor++;		}	}}