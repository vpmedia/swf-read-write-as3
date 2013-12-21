package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public class RTQName extends AbstractMultiname
	{
		public var name:String;
		
		public function RTQName()
		{
			super();
		}

		override public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			// TODO: Trap errors dereferencing from bad constant pool indices
			name = constantPool.strings[data.readU32()];
		}
		
	}
}