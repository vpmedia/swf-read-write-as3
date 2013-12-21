package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.bytecode.Opcodes;
	
	public class IntIntOperation extends AbstractOperation
	{
		public var value1:int;
		public var value2:int;
		
		public function IntIntOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			if (code == Opcodes.HasNext2) {
				value1 = bytes.readU32();
				value2 = bytes.readU32();
			}
			else
			{
				value1 = bytes.readU30();
				value2 = bytes.readU30();	
			}
		}
		
	}
}