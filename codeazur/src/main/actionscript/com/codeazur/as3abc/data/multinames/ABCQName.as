package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ABCNamespace;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class ABCQName extends AbstractMultiname
	{
		public var abcNamespace:ABCNamespace;
		public var name:String;
		
		public function ABCQName()
		{
			super();
		}

		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			// TODO: Trap errors dereferencing from bad constant pool indices
			abcNamespace = constantPool.namespaces[data.readU32()];
			name = constantPool.strings[data.readU32()];
		}
		
		override public function toString():String
		{
			if (abcNamespace) {
				var namespaceStr:String = abcNamespace.toString();
				if (namespaceStr) {
					return abcNamespace + '::' + name;
				}
				else {
					return name;
				}
			}
			else {
				return "";
			}
		}		
	}
}