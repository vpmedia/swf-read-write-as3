package com.codeazur.as3abc.data.bytecode
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	import com.codeazur.as3abc.data.MethodBody;
	import com.codeazur.as3abc.data.bytecode.operations.AbstractOperation;
	import com.codeazur.as3abc.factories.OperationFactory;
	
	public class ActionBlock
	{
		
		public var abc:ABC;
		public var methodBody:MethodBody;
		public var operations:Vector.<AbstractOperation>;
		public var markers:MarkerManager;

		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			var operationFactory:OperationFactory;
			var operation:AbstractOperation;
			var position:int;
			var code:int;

			markers = new MarkerManager();
			operationFactory = new OperationFactory();			
			operations = new Vector.<AbstractOperation>();
			
			while (data.bytesAvailable) {
				
				position = data.position;
				code = data.readUnsignedByte();
				
				operation = operationFactory.create(code);
				
				if (!operation) { return; }
				
				operation.block = this;
				operation.position = position;
				operation.readOperands(data);
				
			}
		}

	}
}