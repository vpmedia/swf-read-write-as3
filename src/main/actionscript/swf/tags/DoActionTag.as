package swf.tags {
	import swf.*
	import flash.utils.*
	
	/**
	 * Represents the DoABC2 tag in the SWF format.
	 */
	public class DoActionTag extends Tag {
		public var 
			flags	:uint,
			name	:String
		
		public function DoActionTag(){
			super(Tag.DoABC)
		}
		
		override public function readFrom(reader:SWFReader, length:uint):void {
			trace('readFrom', length)
			var startPos:int = reader.bytes.position
			var actionCode:uint = reader.bytes.readUnsignedByte()
			trace('actionCode', actionCode)
			if(actionCode >= 0x80){
				var length:uint = reader.bytes.readUnsignedShort()
			}
			
			switch(actionCode){
				case Action.GetURL:
					trace('found getURL')
					var url:String = reader.readString()
					var target:String = reader.readString()
					trace(url, target)
					break
				default:
					var waste:ByteArray = new ByteArray
					reader.bytes.readBytes(waste, 0, length)
					break
			}
		}
		
		override public function toByteArray():ByteArray {
			var bytes:ByteArray = new ByteArray
			bytes.endian = Endian.LITTLE_ENDIAN
			
			return bytes
		}
	}
}