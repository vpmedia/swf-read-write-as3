package com.codeazur.as3abc.data.multinames
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	
	public interface IMultiname
	{
		function parse(data:ABCData, constantPool:ConstantPool):void;
		function toString():String;
	}
}