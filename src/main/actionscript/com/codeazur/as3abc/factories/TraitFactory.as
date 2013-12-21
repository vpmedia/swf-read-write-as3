package com.codeazur.as3abc.factories
{
	import com.codeazur.as3abc.data.traits.*;
	
	public class TraitFactory
	{
		public static function create(kind:int):AbstractTrait
		{
			switch(kind & 0x0f) {
				case 0x00: return new TraitSlot();
				case 0x01: return new TraitMethod();
				case 0x02: return new TraitGetter();
				case 0x03: return new TraitSetter();
				case 0x04: return new TraitClass();
				case 0x05: return new TraitFunction();
				case 0x06: return new TraitConst();
				default:   throw new Error("Unknown trait kind: " + (kind & 0x0f) + ".");
			}
		}

	}
}