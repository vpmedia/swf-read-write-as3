package com.codeazur.as3abc.data
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.traits.AbstractTraitOwner;
	
	public class Script extends AbstractTraitOwner
	{
		public var initializerIndex:int;

		public var initializer:Method;

		public var type:NominalType;

		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			initializerIndex = data.readU32();	
			initializer = abc.methods[initializerIndex];	
			readTraits(data);
		}
			

	}
}