package com.codeazur.as3abc.data.traits
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.ConstantPool;
	import com.codeazur.as3abc.data.Method;
	
	public class AbstractTraitMethod extends AbstractTrait
	{
		public var dispIndex:int;
		public var methodIndex:int;
		public var method:Method;
		public var isFinal:Boolean;
		public var isOverride:Boolean;
	
		override public function parse(data:ABCData):void
		{
			var attributes:int = kind >> 4;
			
			dispIndex = data.readU32();
			methodIndex = data.readU32();
			method = abc.methods[methodIndex];
			
			isFinal    = Boolean(attributes & 0x01);
			isOverride = Boolean(attributes & 0x02);
		}

	}
	
}