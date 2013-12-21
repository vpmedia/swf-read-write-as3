package com.swfwire.decompiler.data.swf
{
	import com.swfwire.decompiler.data.swf.records.RectangleRecord;

	public class SWFHeader
	{
		public static const UNCOMPRESSED_SIGNATURE:String = 'FWS';
		public static const ZLIB_COMPRESSED_SIGNATURE:String = 'CWS';
		public static const LZMA_COMPRESSED_SIGNATURE:String = 'ZWS';
		
		public var signature:String;
		public var fileVersion:uint;
		public var uncompressedSize:uint;
		
		public var frameSize:RectangleRecord;
		public var frameRate:Number;
		public var frameCount:uint;

		public function SWFHeader(signature:String = null, fileVersion:uint = 0, uncompressedSize:uint = 0,
								  frameSize:RectangleRecord = null, frameRate:Number = NaN, frameCount:uint = 0)
		{
			if(!frameSize)
			{
				frameSize = new RectangleRecord();
			}
			
			this.signature = signature;
			this.fileVersion = fileVersion;
			this.uncompressedSize = uncompressedSize;
			this.frameSize = frameSize;
			this.frameRate = frameRate;
			this.frameCount = frameCount;
		}
	}
}