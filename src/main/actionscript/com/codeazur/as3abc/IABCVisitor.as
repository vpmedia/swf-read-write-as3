package com.codeazur.as3abc
{
	import com.codeazur.as3abc.data.bytecode.operations.AbstractOperation;
	
	public interface IABCVisitor
	{
		function visitOperation(context:ABC, operation:AbstractOperation):void
	}
}