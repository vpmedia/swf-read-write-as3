package com.codeazur.as3abc.data.traits
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.Metadata;
	import com.codeazur.as3abc.data.multinames.ABCQName;
	
	public class AbstractTrait implements ITrait
	{
		public var abc:ABC;
		
		public var name:ABCQName;
		
		public var kind:int;
		
		public var metadata:Vector.<Metadata>;
				
		public function parse(data:ABCData):void
		{
			throw new Error("AbstractTrait's parse method must be overridden.");
		}
		
		public function parseMetadata(data:ABCData):void
		{
			var i:int, metadataCount:int, index:int;
			metadata = new Vector.<Metadata>();
			metadataCount = data.readU32();
			for (i = 0; i < metadataCount; i++) {
				metadata[i] = abc.metadata[data.readU32()];
			}	
		}
		
		public function toString():String
		{
			return "[AbstractTrait]";
		}

	}
}