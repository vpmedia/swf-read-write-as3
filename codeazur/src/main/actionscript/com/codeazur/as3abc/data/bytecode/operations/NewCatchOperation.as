package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ExceptionHandler;
	
	public class NewCatchOperation extends IntOperation
	{
		// ABC Binding
		public var exceptionHandler:ExceptionHandler;
		
		public function NewCatchOperation(code:int)
		{
			super(code);
		}
		
		/*
		override public function readOperands(bytes:ABCData):void
		{
			super.readOperands(bytes);
		//	exceptionHandler = block.methodBody.exceptions[value];
		}
		*/
	}
}