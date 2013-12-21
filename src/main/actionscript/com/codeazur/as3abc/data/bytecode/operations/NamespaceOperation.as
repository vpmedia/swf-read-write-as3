package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ABCNamespace;
	
	public class NamespaceOperation extends AbstractOperation
	{
		public var value:ABCNamespace;
		
		public function NamespaceOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			value = block.abc.constantPool.namespaces[bytes.readU30()];
		}
	}
}