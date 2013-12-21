package com.codeazur.as3abc.data.traits
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	import com.codeazur.as3abc.data.Method;
	
	public class TraitFunction extends AbstractTrait
	{
		public var slotIndex:int;
		public var functionIndex:int;
		public var funktion:Method;
		
		override public function parse(data:ABCData):void
		{
			slotIndex = data.readU32();
			functionIndex = data.readU32();
			funktion = abc.methods[functionIndex];
		}
	}
}