package com.codeazur.as3abc.data.traits
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	
	public class AbstractTraitSlot extends AbstractTrait
	{
		public var slotIndex:int;
		public var type:IMultiname;
		public var valueKind:int;
		public var value:Object;
		
		override public function parse(data:ABCData):void
		{
			var valueIndex:int;
			var constantPool:ConstantPool = abc.constantPool;
			
			slotIndex = data.readU32();
			type = constantPool.multinames[data.readU32()];
			valueIndex = data.readU32();
			if (valueIndex != 0) {
				valueKind = data.readByte();
				value = constantPool.getConstantValue(valueKind, valueIndex);
			}
		}
	}
}