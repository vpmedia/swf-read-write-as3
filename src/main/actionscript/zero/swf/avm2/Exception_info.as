/***
Exception_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The exception_info entry is used to define the range of ActionScript 3.0 instructions over which a particular
//exception handler is engaged.
//exception_info
//{
//	u30 from
//	u30 to
//	u30 target
//	u30 exc_type
//	u30 var_name
//}

//The starting position in the code field from which the exception is enabled.

//The ending position in the code field after which the exception is disabled.

//The position in the code field to which control should jump if an exception of type exc_type is
//encountered while executing instructions that lie within the region [from, to] of the code field.

//An index into the string array of the constant pool that identifies the name of the type of exception that
//is to be monitored during the reign of this handler. A value of zero means the any type ("*") and implies
//that this exception handler will catch any type of exception thrown.
//文档里是错的...不是 string_v 而是 multiname_info_v

//This index into the string array of the constant pool defines the name of the variable that is to receive
//the exception object when the exception is thrown and control is transferred to target location. If the
//value is zero then there is no name associated with the exception object.
//文档里是错的...不是 string_v 而是 multiname_info_v
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Exception_info{
		public var from:int;							//u30
		public var to:int;								//u30
		public var target:int;							//u30
		public var exc_type:int;						//u30
		public var var_name:int;						//u30
		//
		
		public function Exception_info(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){from=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{from=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{from=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{from=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{from=data[offset++];}
			//from
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){to=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{to=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{to=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{to=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{to=data[offset++];}
			//to
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){target=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{target=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{target=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{target=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{target=data[offset++];}
			//target
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){exc_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{exc_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{exc_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{exc_type=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{exc_type=data[offset++];}
			//exc_type
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{var_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{var_name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{var_name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{var_name=data[offset++];}
			//var_name
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			if(from>>>7){if(from>>>14){if(from>>>21){if(from>>>28){data[offset++]=(from&0x7f)|0x80;data[offset++]=((from>>>7)&0x7f)|0x80;data[offset++]=((from>>>14)&0x7f)|0x80;data[offset++]=((from>>>21)&0x7f)|0x80;data[offset++]=from>>>28;}else{data[offset++]=(from&0x7f)|0x80;data[offset++]=((from>>>7)&0x7f)|0x80;data[offset++]=((from>>>14)&0x7f)|0x80;data[offset++]=from>>>21;}}else{data[offset++]=(from&0x7f)|0x80;data[offset++]=((from>>>7)&0x7f)|0x80;data[offset++]=from>>>14;}}else{data[offset++]=(from&0x7f)|0x80;data[offset++]=from>>>7;}}else{data[offset++]=from;}
			//from
			
			if(to>>>7){if(to>>>14){if(to>>>21){if(to>>>28){data[offset++]=(to&0x7f)|0x80;data[offset++]=((to>>>7)&0x7f)|0x80;data[offset++]=((to>>>14)&0x7f)|0x80;data[offset++]=((to>>>21)&0x7f)|0x80;data[offset++]=to>>>28;}else{data[offset++]=(to&0x7f)|0x80;data[offset++]=((to>>>7)&0x7f)|0x80;data[offset++]=((to>>>14)&0x7f)|0x80;data[offset++]=to>>>21;}}else{data[offset++]=(to&0x7f)|0x80;data[offset++]=((to>>>7)&0x7f)|0x80;data[offset++]=to>>>14;}}else{data[offset++]=(to&0x7f)|0x80;data[offset++]=to>>>7;}}else{data[offset++]=to;}
			//to
			
			if(target>>>7){if(target>>>14){if(target>>>21){if(target>>>28){data[offset++]=(target&0x7f)|0x80;data[offset++]=((target>>>7)&0x7f)|0x80;data[offset++]=((target>>>14)&0x7f)|0x80;data[offset++]=((target>>>21)&0x7f)|0x80;data[offset++]=target>>>28;}else{data[offset++]=(target&0x7f)|0x80;data[offset++]=((target>>>7)&0x7f)|0x80;data[offset++]=((target>>>14)&0x7f)|0x80;data[offset++]=target>>>21;}}else{data[offset++]=(target&0x7f)|0x80;data[offset++]=((target>>>7)&0x7f)|0x80;data[offset++]=target>>>14;}}else{data[offset++]=(target&0x7f)|0x80;data[offset++]=target>>>7;}}else{data[offset++]=target;}
			//target
			
			if(exc_type>>>7){if(exc_type>>>14){if(exc_type>>>21){if(exc_type>>>28){data[offset++]=(exc_type&0x7f)|0x80;data[offset++]=((exc_type>>>7)&0x7f)|0x80;data[offset++]=((exc_type>>>14)&0x7f)|0x80;data[offset++]=((exc_type>>>21)&0x7f)|0x80;data[offset++]=exc_type>>>28;}else{data[offset++]=(exc_type&0x7f)|0x80;data[offset++]=((exc_type>>>7)&0x7f)|0x80;data[offset++]=((exc_type>>>14)&0x7f)|0x80;data[offset++]=exc_type>>>21;}}else{data[offset++]=(exc_type&0x7f)|0x80;data[offset++]=((exc_type>>>7)&0x7f)|0x80;data[offset++]=exc_type>>>14;}}else{data[offset++]=(exc_type&0x7f)|0x80;data[offset++]=exc_type>>>7;}}else{data[offset++]=exc_type;}
			//exc_type
			
			if(var_name>>>7){if(var_name>>>14){if(var_name>>>21){if(var_name>>>28){data[offset++]=(var_name&0x7f)|0x80;data[offset++]=((var_name>>>7)&0x7f)|0x80;data[offset++]=((var_name>>>14)&0x7f)|0x80;data[offset++]=((var_name>>>21)&0x7f)|0x80;data[offset++]=var_name>>>28;}else{data[offset++]=(var_name&0x7f)|0x80;data[offset++]=((var_name>>>7)&0x7f)|0x80;data[offset++]=((var_name>>>14)&0x7f)|0x80;data[offset++]=var_name>>>21;}}else{data[offset++]=(var_name&0x7f)|0x80;data[offset++]=((var_name>>>7)&0x7f)|0x80;data[offset++]=var_name>>>14;}}else{data[offset++]=(var_name&0x7f)|0x80;data[offset++]=var_name>>>7;}}else{data[offset++]=var_name;}
			//var_name
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			return <{xmlName}
				from={from}
				to={to}
				target={target}
				exc_type={exc_type}
				var_name={var_name}
			/>;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			from=int(xml.@from.toString());
			
			to=int(xml.@to.toString());
			
			target=int(xml.@target.toString());
			
			exc_type=int(xml.@exc_type.toString());
			
			var_name=int(xml.@var_name.toString());
			
		}
		
	}
}
