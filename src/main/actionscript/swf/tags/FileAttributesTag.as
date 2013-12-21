package swf.tags {
	import swf.SWFReader
	
	import flash.utils.ByteArray
	import flash.utils.Endian
	
	public class FileAttributesTag extends ControlTag {
		public var
			useDirectBlit	:Boolean,
			useGPU			:Boolean,
			hasMetaData		:Boolean,
			ActionScript3	:Boolean,
			useNetwork		:Boolean
		
		public function FileAttributesTag(useDirectBlit:Boolean = false, useGPU:Boolean = false, 
										  hasMetaData:Boolean = false, ActionScript3:Boolean  = false, 
										  useNetwork:Boolean = false)
		{
			super(Tag.FileAttributes)
			this.useDirectBlit = useDirectBlit
			this.useGPU = useGPU
			this.hasMetaData = hasMetaData
			this.ActionScript3 = ActionScript3
			this.useNetwork = useNetwork
		}
		
		override public function readFrom(reader:SWFReader, length:uint):void {
			reader.nextBitByte() // read file attributes in bits
			reader.readBits(1) // reserved
			useDirectBlit = Boolean(reader.readBits(1))
			useGPU = Boolean(reader.readBits(1))
			hasMetaData = Boolean(reader.readBits(1))
			ActionScript3 = Boolean(reader.readBits(1))
			reader.readBits(2) // reserved (2)
			useNetwork = Boolean(reader.readBits(1))
			
			// bunch of others reserved after this
			reader.readBits(24)
		}
		
		override public function toByteArray():ByteArray {
			var bytes:ByteArray = new ByteArray
			bytes.endian = Endian.LITTLE_ENDIAN
			var byte:uint = 0
			byte = (byte | uint(useDirectBlit)) << 1
			byte = (byte | uint(useGPU)) << 1
			byte = (byte | uint(hasMetaData)) << 1
			byte = (byte | uint(ActionScript3)) << 1
			byte = byte << 2
			byte = (byte | uint(useNetwork))
			bytes.writeByte(byte)
			bytes.writeByte(0) // 8
			bytes.writeShort(0) // + 16 = 24 reserved
			return bytes
		}
	}
}