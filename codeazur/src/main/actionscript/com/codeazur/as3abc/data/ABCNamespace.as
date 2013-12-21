package com.codeazur.as3abc.data
{
	public class ABCNamespace
	{
		public static const NAMESPACE:int = 0x08;
		public static const PACKAGE_NAMESPACE:int = 0x16;
		public static const PACKAGE_INTERNAL_NAMESPACE:int = 0x17;
		public static const PROTECTED_NAMESPACE:int = 0x18;
		public static const EXPLICIT_NAMESPACE:int = 0x19;
		public static const STATIC_PROTECTED_NAMESPACE:int = 0x1A;
		public static const PRIVATE_NAMESPACE:int = 0x05;
				
		public var kind:int;
		public var name:String;
		
		public function ABCNamespace(kind:int, name:String) 
		{
			this.kind = kind;
			this.name = name;
		}

		public function toString():String {
			return name;
		}
	}
}