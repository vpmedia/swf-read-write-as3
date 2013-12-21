package swf.tags {
	import swf.SWFReader
	import flash.utils.*

	public class MetadataTag extends ControlTag {
		public var metadata:XML
		public function MetadataTag(metadata:XML = null){
			super(Tag.Metadata)
			this.metadata = metadata
		}
		
		override public function readFrom(reader:SWFReader, length:uint):void {
			try {
				metadata = new XML(reader.readString())
			} catch(err:Error) {
				// error reading string or parsing as XML
			}
		}
		
		override public function toByteArray():ByteArray {
			var bytes:ByteArray = new ByteArray
			if(metadata) bytes.writeUTFBytes(metadata.toXMLString())
			return bytes
		}
	}
}