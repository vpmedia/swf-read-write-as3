package com.codeazur.as3abc.data.bytecode
{
	public class OpcodeInfo
	{
		public var name:String;
		public var mnemonic:String;
		public var operationClass:Class;
		public var isAlchemy:Boolean;
		public var isExperimental:Boolean;
		
		public function OpcodeInfo(
			name:String, mnemonic:String, operationClass:Class,
			isAlchemy:Boolean = false, isExperimental:Boolean = false
		)
		{
			this.name = name;
			this.mnemonic = mnemonic;
			this.operationClass = operationClass;
			this.isAlchemy = isAlchemy;
			this.isExperimental = isExperimental;
		}
	}
}