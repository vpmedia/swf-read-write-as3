package com.codeazur.as3abc.data.traits
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.ABCQName;
	import com.codeazur.as3abc.factories.TraitFactory;
	
	public class AbstractTraitOwner
	{
		public var abc:ABC;
		
		public var traits:Vector.<ITrait>;
		
		public function readTraits(data:ABCData):Vector.<ITrait>
		{
			var i:int, traitCount:int;
			var name:ABCQName;
			var nameIndex:int;
			var kind:uint;
			var trait:AbstractTrait;
			var hasMetadata:Boolean;
			
			traitCount = data.readU32();
			traits = new Vector.<ITrait>();
			for (i = 0; i < traitCount; i++) {
				
				nameIndex = data.readU32();
				if (nameIndex == 0) {
					throw new Error("Trait name index cannot be zero.");
				}
				name = ABCQName(abc.constantPool.multinames[nameIndex]);
				kind = data.readUnsignedByte();
				
				hasMetadata = Boolean((kind >> 4) & 0x04);

				trait = TraitFactory.create(kind);
				trait.abc = abc;
				trait.name = name;
				trait.kind = kind;
				
				trait.parse(data);
				
				if (hasMetadata) {
					trait.parseMetadata(data);
				}
			}
			
			return traits;
		}
	}
}