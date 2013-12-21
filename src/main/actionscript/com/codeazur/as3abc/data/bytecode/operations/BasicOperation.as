package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	
	public class BasicOperation extends AbstractOperation
	{
		public function BasicOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void { }

	}
}