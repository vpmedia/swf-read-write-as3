package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.Method;
	
	public class NewFunctionOperation extends IntOperation
	{
		// ABC Binding
		public var method:Method;
		
		public function NewFunctionOperation(code:int)
		{
			super(code);
		}
		
		/*
		override public function readOperands(bytes:ABCData):void
		{
			super.readOperands(bytes);
			//	method = block.abc.methods[value];
		}
		*/
	}
}