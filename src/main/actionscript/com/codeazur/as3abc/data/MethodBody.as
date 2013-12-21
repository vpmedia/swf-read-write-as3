package com.codeazur.as3abc.data
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.bytecode.ActionBlock;
	import com.codeazur.as3abc.data.traits.AbstractTraitOwner;
	
	public class MethodBody extends AbstractTraitOwner
	{
		public var methodIndex:int;
		public var method:Method;
		public var maxStack:int;
		public var localCount:int;
		public var initScopeDepth:int;
		public var maxScopeDepth:int;
		public var block:ActionBlock;
		public var code:ABCData;		// For now...
		public var exceptions:Vector.<ExceptionHandler>;
		
		public function parse(data:ABCData):void
		{			
			methodIndex = data.readU32();
			
			method = abc.methods[methodIndex];
			method.body = this;
			
			maxStack = data.readU32();
			localCount = data.readU32();
			initScopeDepth = data.readU32();
			maxScopeDepth = data.readU32();
			
			readOpCodes(data);
			readExceptions(data);
			readTraits(data);
		}
		
		public function readOpCodes(data:ABCData):void
		{
			var codeLength:int;
			codeLength = data.readU32();
					
			code = new ABCData();
			data.readBytes(code, 0, codeLength);
			code.position = 0;
			
			block = new ActionBlock();
			block.abc = abc;
			block.methodBody = this;
			block.parse(code, abc.constantPool);

		}
		
		public function readExceptions(data:ABCData):void
		{
			var i:int, exceptionCount:int;
			var exceptionHandler:ExceptionHandler;
			var it:int;
			
			exceptions = new Vector.<ExceptionHandler>();
			exceptionCount = data.readU30();
			for (i = 0; i < exceptionCount; i++) {
				exceptionHandler = new ExceptionHandler();
				exceptionHandler.from   = data.readU30();
				exceptionHandler.to     = data.readU30();
				exceptionHandler.target = data.readU30();
				exceptionHandler.exceptionType = abc.constantPool.multinames[data.readU30()];
				exceptionHandler.variableName = abc.constantPool.multinames[data.readU30()];
				exceptions[i] = exceptionHandler;
			}			
		}
	}
}