package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	
	public class UIntOperation extends AbstractOperation
	{
		public var value:uint;
		
		public function UIntOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			value = block.abc.constantPool.uints[bytes.readU30()];			
		}
		
	}
}