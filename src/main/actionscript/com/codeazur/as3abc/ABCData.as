package com.codeazur.as3abc
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;

	public class ABCData extends ByteArray
	{
		public function ABCData()
		{
			super();
			endian = Endian.LITTLE_ENDIAN;
		}
		
		public function readS24():int
		{
			var b:int = readUnsignedByte();
			b |= readUnsignedByte() << 8;
			b |= readByte() << 16;
			return b;
		}
		
		public function writeS24(value:int):void {
			throw new Error("writeS24() not yet implemented.");
		}
		
		public function readU30():int
		{
			return int( readU32() & 0x3fffffff );
		}
		
		public function readU32():int
		{
			var result:int = readUnsignedByte();
			if (!(result & 0x00000080))
				return result;
			result = result & 0x0000007f | readUnsignedByte() << 7;
			if (!(result & 0x00004000))
				return result;
			result = result & 0x00003fff | readUnsignedByte() << 14;
			if (!(result & 0x00200000))
				return result;
			result = result & 0x001fffff | readUnsignedByte() << 21;
			if (!(result & 0x10000000))
				return result;
			return   result & 0x0fffffff | readUnsignedByte() << 28;
		}
		
		public function writeU32(value:int):void {
			var byte:uint;
			do {
				byte = value & 0x7f;
				value >>>= 7;
				if (value) { byte |= 0x80 };
				writeByte(byte);
			} while(value);
		}
	}
}