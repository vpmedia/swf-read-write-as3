package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	
	public class MultinameOperation extends AbstractOperation
	{
		public var value:IMultiname;
		
		public function MultinameOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			value = block.abc.constantPool.multinames[bytes.readU30()];
		}
	}
}