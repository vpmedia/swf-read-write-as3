package swf {
	
	import flash.geom.*
	import flash.utils.ByteArray
	
	import swf.tags.*
	import abc.ABC

	public class SWF {
		public var 
			compressed	:Boolean,
			version		:uint,
			frameSize	:Rectangle,
			frameRate	:uint,
			frameCount	:uint,
			tags		:Vector.<Tag>
		
		public function SWF(){
			_initDefaults()
		}
		
		public static function readFrom(bytes:ByteArray):SWF {
			var reader:SWFReader = new SWFReader(bytes)
			return reader.swf
		}
		
		/**
		 * Convenience accessor that simply finds all of the AVM2 bytecode in the file.
		 * Since it's for convenience only, changing the entries in the Vector returned 
		 * won't influence the SWF if it's re-serialized, and a new Vector is returned 
		 * on each call.  
		 */
		public function get abcs():Vector.<ABC> {
			var vec:Vector.<ABC> = new <ABC>[]
			for each(var t:Tag in tags){
				if(t is DoABCTag) vec.push((t as DoABCTag).abc)
			}
			return vec
		}
		
		public function toByteArray():ByteArray {
			return new SWFWriter(this).toByteArray()
		}
		
		public function toString():String {
			return (['[SWF' + version, (compressed ? '' : 'un') + 'compressed', frameSize.width + 'x' + frameSize.height, frameRate + 'fps]']).join(', ')
		}
		
		private function _initDefaults():void {
			// header
			compressed = false
			version = 1
			frameSize = new Rectangle
			frameRate = 12
			
			tags = new Vector.<Tag>()
		}
	}
}