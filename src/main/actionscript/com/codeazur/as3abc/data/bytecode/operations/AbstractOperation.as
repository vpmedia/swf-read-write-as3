package com.codeazur.as3abc.data.bytecode.operations
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.IABCVisitor;
	import com.codeazur.as3abc.data.bytecode.ActionBlock;
	import com.codeazur.as3abc.data.bytecode.Opcodes;
	
	public class AbstractOperation
	{
		public static const opNames:Vector.<String> = Opcodes.opNames;
		
		public var code:int;
		public var block:ActionBlock;
		
		// Debug
		public var position:int;

		public function AbstractOperation(code:int)
		{
			this.code = code;
		}
		
		public function accept(context:ABC, visitor:IABCVisitor):void
		{
			visitor.visitOperation(context, this);
		}
		
		public function readOperands(bytes:ABCData):void
		{
			throw new Error("Implementations override this method.");
		}

		public function toString():String
		{
			return "[Operation] " + opNames[code];
		}
	}
}