package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.NominalType;
	
	public class NewClassOperation extends IntOperation
	{
		// ABC Binding
		public var type:NominalType;

		public function NewClassOperation(code:int)
		{
			super(code);
		}
		
		/*
		override public function readOperands(bytes:ABCData):void
		{
			super.readOperands(bytes);
		//	type = block.abc.types[value];
		}
		*/
	}
}