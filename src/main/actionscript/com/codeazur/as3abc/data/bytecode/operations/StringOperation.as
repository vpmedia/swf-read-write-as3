package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	
	public class StringOperation extends AbstractOperation
	{
		public var value:String;
		
		public function StringOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			value = block.abc.constantPool.strings[bytes.readU30()];			
		}
		
	}
}