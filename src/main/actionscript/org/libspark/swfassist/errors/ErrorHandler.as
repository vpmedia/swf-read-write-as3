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

package org.libspark.swfassist.errors
{
	public interface ErrorHandler
	{
		/**
		 * エラーを処理します。
		 * 
		 * @param error 処理すべきエラー
		 * @return 発生元の処理を続行するのであればtrue, そうでなければfalse
		 */
		function handleError(error:Error):Boolean;
		
		/**
		 * 警告を処理します。
		 * 
		 * @param warning 処理すべきエラー
		 * @return 発生元の処理を続行するのであればtrue, そうでなければfalse
		 */
		function handleWarning(warning:Warning):Boolean;
	}
}