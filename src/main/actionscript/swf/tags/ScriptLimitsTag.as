package swf.tags {
	import swf.SWFReader
	
	import flash.utils.ByteArray

	public class ScriptLimitsTag extends ControlTag {
		public var
			maxRecursionDepth		:uint,
			scriptTimeoutSeconds	:uint
		
		public function ScriptLimitsTag(maxRecursionDepth:uint = 256, scriptTimeoutSeconds:uint = 15){
			super(Tag.ScriptLimits)
			this.maxRecursionDepth = maxRecursionDepth
			this.scriptTimeoutSeconds = scriptTimeoutSeconds
		}
		
		override public function readFrom(reader:SWFReader, length:uint):void {
			maxRecursionDepth		= reader.bytes.readUnsignedShort()
			scriptTimeoutSeconds	= reader.bytes.readUnsignedShort()
		}
		
		override public function toByteArray():ByteArray {
			var bytes:ByteArray = new ByteArray()
			bytes.writeShort(maxRecursionDepth)
			bytes.writeShort(scriptTimeoutSeconds)
			return bytes
		}
	}
}