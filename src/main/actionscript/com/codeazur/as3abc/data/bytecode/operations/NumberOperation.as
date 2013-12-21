package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	
	public class NumberOperation extends AbstractOperation
	{
		public var value:Number;
		
		public function NumberOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			value = block.abc.constantPool.doubles[bytes.readU30()];
		}
	}
}