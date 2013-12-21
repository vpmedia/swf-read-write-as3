package com.codeazur.as3abc.data
{
	import com.codeazur.as3abc.data.multinames.IMultiname;
	
	public class Parameter
	{
		public var type:IMultiname;
		public var name:String;				// What does this do?  Not completely sure it is correct.
		public var isOptional:Boolean;	
		
		// Only set if isOptional is true
		public var optionalType:int;
		
		// Only set if isOptional is true	
		public var optionalValue:Object;	
	
		public function Parameter()
		{
		}
		
		public function toString():String {
			var str:String = type.toString();
			if (isOptional) {
				str += " = ";
				if (optionalType == 0x01 && optionalValue == "") {
					str += "\"\"";
				}
				else {
					str += optionalValue;
				}
			}
			return str;
		}

	}
}