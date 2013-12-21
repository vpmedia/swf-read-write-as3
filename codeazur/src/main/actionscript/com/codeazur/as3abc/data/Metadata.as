package com.codeazur.as3abc.data
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.utils.StringUtils;
	
	public class Metadata
	{
		public var name:String;
		public var keys:Vector.<String>;
		public var values:Vector.<String>;
		
		public function Metadata()
		{
			keys = new Vector.<String>;
			values = new Vector.<String>;
		}
		
		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			var i:int, len:int;
			
			name = constantPool.strings[data.readU32()];
			
			len = data.readU32();
			for (i = 0; i < len; i++) {
				keys[i]   = constantPool.strings[data.readU32()];
				values[i] = constantPool.strings[data.readU32()];
			}
		}
		
		public function toString(indent:uint = 0):String
		{
			var parts:Vector.<String> = new Vector.<String>();
			var i:int, len:int = keys.length;
			var str:String = StringUtils.repeat(indent) + "[Metadata] " + name + "(";
			for (i = 0; i < len; i++) {
				if (keys[i]) {
					parts[i] = keys[i] + "=\"" + values[i] + "\""
				}
				else {
					parts[i] = "\"" + values[i] + "\"";
				}
			}
			str += parts.join(", ") + ")";
			return str;
		}

	}
}