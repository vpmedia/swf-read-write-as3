package com.codeazur.as3abc.data.traits
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.NominalType;
	
	public class TraitClass extends AbstractTrait
	{
		public var slotIndex:int;
		public var classIndex:int;
		public var type:NominalType
		
		override public function parse(data:ABCData):void
		{
			slotIndex = data.readU32();
			classIndex = data.readU32();
		}
	}
}