package swf.tags {
	import abc.*
	import swf.*
	import flash.utils.*
	
	/**
	 * Represents the DoABC tag in the SWF format.
	 */
	public class DoABCTag extends Tag {
		public var
			name	:String
		protected var
			_abc	:ABC
		
		public function DoABCTag(abc:ABC = null){
			super(this is DoABC2Tag ? Tag.DoABC2 : Tag.DoABC)
			this.name = 'DoABC'
			_abc = abc
		}
		
		public function get abc():ABC {
			return _abc
		}
		
		public function set abc(abc:ABC):void {
			_abc = abc
		}
		
		override public function readFrom(reader:SWFReader, length:uint):void {			
			// make a new ByteArray with just the abcfile
			var abcBytes:ByteArray = new ByteArray
			abcBytes.endian = Endian.LITTLE_ENDIAN
			reader.bytes.readBytes(abcBytes, 0, length)
			abcBytes.position = 0
			_abc = new ABCReader(abcBytes, true).abc
			_abc.abcname = 'DoABC'
		}
		
		override public function toByteArray():ByteArray {
			var bytes:ByteArray = new ByteArray
			bytes.endian = Endian.LITTLE_ENDIAN
			bytes.writeBytes(ABCWriter.writeABC(_abc))
			return bytes
		}
	}
}