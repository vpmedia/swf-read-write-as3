package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;

	public class AbstractMultiname implements IMultiname
	{
		public function AbstractMultiname()
		{
		
		}

		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			throw new Error("AbstractMultiname's parse method must be overridden.");
		}

		public function toString():String {
			return "[AbstractMultiname]";
		}
	}
}