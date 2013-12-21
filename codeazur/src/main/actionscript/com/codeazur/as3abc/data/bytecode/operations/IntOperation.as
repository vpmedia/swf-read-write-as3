package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.bytecode.Opcodes;
	
	public class IntOperation extends AbstractOperation
	{
		public var value:int;
		
		public function IntOperation(code:int)
		{
			super(code);
		}
		
		override public function readOperands(bytes:ABCData):void
		{
			switch (code) {
				case Opcodes.GetScopeObject:
					value = bytes.readUnsignedByte();
					return;
				case Opcodes.PushByte:				
					// UNDOCUMENTED: The documentation states that PushByte
					// uses an unsigned byte which is incorrect.
					//
					// PushByte uses a signed byte value.
					// 
					value = bytes.readByte();
					break;
				case Opcodes.PushShort:
					// UNDOCUMENTED: The documentation forgets to mention
					// that the U30 which is unsigned has to be converted
					// to a signed value.
					//
					var i:int = bytes.readU30();
					if( 0 != ( i & 0x20000000 ) )
					{
						i &= 0x1fffffff;
						i -= 0x20000000;
					}
					value = i;
					break;
				default:
					value = bytes.readU30();
					break;
			}
		}
		
	}
}