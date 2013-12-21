package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	
	public class MultinameIntOperation extends AbstractOperation
	{
		public var multiname:IMultiname;		
		public var int1:int;

		public function MultinameIntOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			multiname = block.abc.constantPool.multinames[bytes.readU30()];
			int1 = bytes.readU30();			
		}
		
	}
}