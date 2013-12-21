package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	
	public class IntStringIntIntOperation extends AbstractOperation
	{
		public var int1:int;
		public var int2:int;
		public var string:String;
		public var int3:int;
		
		public function IntStringIntIntOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{	
			int1 = bytes.readUnsignedByte();
			string = block.abc.constantPool.strings[bytes.readU30()];
			int2 = bytes.readUnsignedByte();
			int3 = bytes.readU30();
		}
		
	}
}