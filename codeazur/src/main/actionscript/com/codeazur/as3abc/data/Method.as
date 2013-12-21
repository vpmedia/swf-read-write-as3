package com.codeazur.as3abc.data
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	import com.codeazur.utils.StringUtils;
	
	public class Method
	{
		public var abc:ABC;
		public var parameters:Vector.<Parameter>;
		public var returnType:IMultiname;
		public var name:String;
		public var needsArguments:Boolean;
		public var needsActivation:Boolean;
		public var needsRest:Boolean;
		public var hasOptionalParameters:Boolean;
		public var setsDXNS:Boolean;
		public var hasParameterNames:Boolean;
		public var body:MethodBody;
				
		public function parse(data:ABCData, constantPool:ConstantPool):void
		{
			var i:int;
			var paramCount:int = data.readU32();
			var optionalCount:int;
			var parameter:Parameter;
			var flags:int;
			var valueIndex:int;
			
			returnType = constantPool.multinames[data.readU32()];
			
			parameters = new Vector.<Parameter>();
			
			for (i = 0; i < paramCount; i++) {
				parameter = new Parameter();
				parameter.type = constantPool.multinames[data.readU32()];
				parameters[i] = parameter;	
			}
			
			name = constantPool.strings[data.readU32()];
			
			flags = data.readUnsignedByte();
			needsArguments =        Boolean(flags & 0x01);
			needsActivation =       Boolean(flags & 0x02);
			needsRest =             Boolean(flags & 0x04);
			hasOptionalParameters = Boolean(flags & 0x08);
			setsDXNS =              Boolean(flags & 0x40);
			hasParameterNames =     Boolean(flags & 0x80);
			
			if (hasOptionalParameters) {

				optionalCount = data.readU32();
				
				if (optionalCount > paramCount) {
					throw new Error("Optional parameter count is greater than formal parameter count.");
				}
				
				for (i = paramCount - optionalCount; i < paramCount; ++i) {				
					parameter = parameters[i];
					parameter.isOptional = true;
					
					valueIndex = data.readU32();

					parameter.optionalType = data.readByte();					
					parameter.optionalValue = constantPool.getConstantValue(
						parameter.optionalType,
						valueIndex
					);
				}	
			}
			
			if (hasParameterNames) {
				for (i = 0; i < paramCount; ++i) {
					parameters[i].name = constantPool.strings[data.readU32()];
				}
			}
		}
		
		public function toString(indent:uint = 0):String {
			var str:String;
			var returnTypeStr:String = returnType.toString();
			str = StringUtils.repeat(indent) + (name ? name : "(anonymous)") +
				"(" + parameters.join(", ") + ")";
			if (returnTypeStr) {
				str += ":" + returnTypeStr;
			}				
				/*
				StringUtils.repeat(indent + 4) +				
				"NeedsArguments: " + needsArguments + ", " +
				"NeedsActivation: " + needsActivation + ", " +
				"NeedsRest: " + needsRest + ", " +
				"HasOptionalParameters: " + hasOptionalParameters + ", " +
				"SetsDXNS: " + setsDXNS + ", " +
				"HasParameterNames: " + hasParameterNames
				*/
			return str;
		}

	}
}