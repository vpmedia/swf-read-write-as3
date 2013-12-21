package com.codeazur.as3abc
{
	import com.codeazur.as3abc.data.*;
	import com.codeazur.utils.StringUtils;
	
	import flash.utils.ByteArray;
	
	public class ABC 
	{
		public static const SUPPORTED_MAJOR_VERSION:int = 46;
		public static const SUPPORTED_MINOR_VERSION:int = 16;
		
		public var majorVersion:uint;
		public var minorVersion:uint;
		
		public var constantPool:ConstantPool;
		
		public var methods:Vector.<Method>;
		public var metadata:Vector.<Metadata>;
		public var types:Vector.<NominalType>;		
		public var scripts:Vector.<Script>;
				
		public function ABC(data:ByteArray)
		{
			constantPool = new ConstantPool();
			constantPool.abc = this;
			
			methods   = new Vector.<Method>();
			metadata  = new Vector.<Metadata>();
			types     = new Vector.<NominalType>();
			scripts   = new Vector.<Script>();
			
			if (data != null) {
				loadBytes(data);
			} 
		}
	
		public function loadBytes(data:ByteArray):void
		{
			var abcData:ABCData = new ABCData();
			data.position = 0;
			data.readBytes(abcData, 0, data.length);
			parse(abcData);
		}
		
		public function parse(data:ABCData):void
		{
			minorVersion = data.readUnsignedShort();
			majorVersion = data.readUnsignedShort();
			
			if (majorVersion != SUPPORTED_MAJOR_VERSION)
			{
				throw new Error("Not a ABC (or unsupported version).  Major version is "+
					majorVersion + " (expected " + SUPPORTED_MAJOR_VERSION + ").");
			}
			
			if (minorVersion != SUPPORTED_MINOR_VERSION)
			{
				throw new Error("Not a ABC (or unsupported version).  Minor version is "+
					minorVersion + " (expected " + SUPPORTED_MINOR_VERSION + ").");		
			}
			
			constantPool.parse(data);	
			
			readMethods(data);
			readMetadata(data);
			readInstances(data);
			readClasses(data);
			readScripts(data);
			readMethodBodies(data);
		}
			
		public function readMethods(data:ABCData):void
		{
			var i:int, len:int;
			var method:Method;
					
			len = data.readU32();
			
			for (i = 0; i < len; i++) {
				method = new Method();
				method.abc = this;
				method.parse(data, constantPool);
				methods[i] = method;
			}
		}
		
		public function readMetadata(data:ABCData):void
		{
			var i:int, len:int;
			var item:Metadata;
					
			len = data.readU32();
			
			for (i = 0; i < len; i++) {
				item = new Metadata();
				item.parse(data, constantPool);
				this.metadata[i] = item;
			}
		}
		
		public function readInstances(data:ABCData):void
		{
			var i:int, len:int;
			var type:NominalType;
			
			len = data.readU32();	
			
			for (i = 0; i < len; i++) {
				type = new NominalType();
				type.abc = this;
				type.parseInstance(data, constantPool);
				types[i] = type;
			}
		}
		
		public function readClasses(data:ABCData):void
		{
			var i:int, len:int;
			var type:NominalType;
			
			len = types.length;	
			
			for (i = 0; i < len; i++) {
				type = types[i];
				type.parseClass(data, constantPool);
			}
		}
		
		public function readScripts(data:ABCData):void
		{
			var i:int, len:int;
			var script:Script;
			
			len = data.readU32();
			
			for (i = 0; i < len; i++) {
				script = new Script();
				script.abc = this;
				script.parse(data, constantPool);
				scripts[i] = script;
			}
		}
		
		public function readMethodBodies(data:ABCData):void
		{
			var i:int, len:int;
			var methodBody:MethodBody;

			len = data.readU32();
			for (i = 0; i < len; i++) {
				methodBody = new MethodBody();
				methodBody.abc = this;
				methodBody.parse(data);
			}
		}
		
		public function dumpMethods(indent:uint = 0):String {
			var str:String;
			var i:int, len:int;
			len = methods.length;
	
			str = StringUtils.repeat(indent) + "Methods:\n";
			
			for (i = 0; i < len; i++) {
				str += methods[i].toString(indent + 4) + "\n";
			}
			
			return str;
		}
		
		public function dumpMetadata(indent:uint = 0):String {
			var str:String;
			var i:int, len:int;
			len = metadata.length;
	
			str = StringUtils.repeat(indent) + "Metadata:\n";
			
			for (i = 0; i < len; i++) {
				str += metadata[i].toString(indent + 4) + "\n";
			}
			
			return str;
		}
		
		public function toString(indent:uint = 0):String {
			var str:String = StringUtils.repeat(indent) + "[ABC] " +
				"MajorVersion: " + majorVersion + ", MinorVersion: " + minorVersion + "\n" +
				constantPool.toString(indent + 4) + "\n" +				
				StringUtils.repeat(indent + 4) + "Methods (" + methods.length + ")\n" +
				StringUtils.repeat(indent + 4) + "Metadata (" + metadata.length + ")\n" +
				StringUtils.repeat(indent + 4) + "Types (" + types.length + ")\n" +
				StringUtils.repeat(indent + 4) + "Scripts (" + scripts.length + ")\n"
			return str;
		}
	}
}