package com.codeazur.as3abc.data.bytecode.operations
{
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.bytecode.Marker;
	
	public class JumpOperation extends AbstractOperation
	{
		public var marker:Marker;
		
		public function JumpOperation(code:int)
		{
			super(code);
		}

		override public function readOperands(bytes:ABCData):void
		{
			//
			// The position advanced 4 bytes.
			//
			// The opcode is 1 byte, the S24 is 3 bytes.
			// Therefore we have to add 4 to the current position in
			// order to get the correct marker AFTER those bytes have
			// been consumed.
			//
			marker = block.markers.putMarkerAt(position + 0x04 + bytes.readS24());
		}
	}
}