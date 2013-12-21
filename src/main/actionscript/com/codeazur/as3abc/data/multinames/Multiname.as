package com.codeazur.as3abc.data.multinames
{
	import __AS3__.vec.Vector;

	import com.codeazur.as3abc.ABCData;	
	import com.codeazur.as3abc.data.ABCNamespace;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class Multiname extends AbstractMultiname
	{		
		public var name:String;
		public var namespaceSet:Vector.<ABCNamespace>;
		
		public function Multiname()
		{
			super();
		}
		
		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			// TODO: Trap errors dereferencing from bad constant pool indices
			name = constantPool.strings[data.readU32()];
			namespaceSet = constantPool.namespaceSets[data.readU32()];
		}		
		
	}
}