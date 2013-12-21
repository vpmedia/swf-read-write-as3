package com.codeazur.as3abc.factories
{
	import com.codeazur.as3abc.data.multinames.*;
	
	public class ABCMultinameFactory
	{
		public static function create(kind:int):IMultiname
		{
			switch(kind) {
				case 0x07: return new ABCQName();
				case 0x0D: return new QNameA();
				case 0x0F: return new RTQName();
				case 0x10: return new RTQNameA();
				case 0x11: return new RTQNameL();
				case 0x12: return new RTQNameLA();
				case 0x09: return new Multiname();
				case 0x0E: return new MultinameA();
				case 0x1B: return new MultinameL();
				case 0x1C: return new MultinameLA();
				
				// Poorly documented.  See TypeName.as for more information.
				case 0x1D: return new TypeName();
				
				default:   throw new Error("Unknown Multiname kind: " + kind);
			}
		}
	}
}