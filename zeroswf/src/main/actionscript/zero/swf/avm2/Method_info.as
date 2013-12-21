/***
Method_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//method_info
//{
//	u30 param_count
//	u30 return_type
//	u30 param_type[param_count]
//	u30 name
//	u8 flags
//	option_info options
//	param_info param_names
//}

//The param_count field is the number of formal parameters that the method supports; it also represents
//the length of the param_type array.
//param_count 是 参数名 array 的长度, 也是 参数类型 array 的长度

//The return_type field is an index into the multiname array of the constant pool; the name at that entry
//provides the name of the return type of this method. A zero value denotes the any ("*") type.
//return_type 是在 constant_pool.multiname_info_v 中的id

//Each entry in the param_type array is an index into the multiname
//array of the constant pool; the name at that entry provides the name of the type of the corresponding
//formal parameter. A zero value denotes the any ("*") type.
//param_type 是在 constant_pool.multiname_info_v 中的id
//0 表示 任意类型 "*"

//The name field is an index into the string array of the constant pool; the string at that entry provides the
//name of this method. If the index is zero, this method has no name.
//name 是在 constant_pool.string_v 中的id
//0 表示 method没有名字(不是函数名而是类似DoABC的Name的一个没有什么意义的东西)

//The flag field is a bit vector that provides additional information about the method. The bits are
//described by the following table. (Bits not described in the table should all be set to zero.)
//Name 				Value 	Meaning
//NEED_ARGUMENTS 	0x01 	Suggests to the run-time that an "arguments" object (as specified by the ActionScript 3.0 Language Reference) be created. Must not be used together with NEED_REST. See Chapter 3.
//NEED_ACTIVATION 	0x02 	Must be set if this method uses the newactivation opcode.
//NEED_REST 		0x04 	This flag creates an ActionScript 3.0 rest arguments array. Must not be used with NEED_ARGUMENTS. See Chapter 3.
//HAS_OPTIONAL 		0x08 	Must be set if this method has optional parameters and the options field is present in this method_info structure.
//SET_DXNS 			0x40 	Must be set if this method uses the dxns or dxnslate opcodes.
//HAS_PARAM_NAMES 	0x80 	Must be set when the param_names field is present in this method_info structure.

//This entry may be present only if the HAS_OPTIONAL flag is set in flags.


//The param_names entry is available only when the HAS_PARAM_NAMES bit is set in the flags. Each param_info
//element of the array is an index into the constant pool's string array. The parameter name entry exists solely
//for external tool use and is not used by the AVM2.

//The option_info entry is used to define the default values for the optional parameters of the method. The
//number of optional parameters is given by option_count, which must not be zero nor greater than the
//parameter_count field of the enclosing method_info structure.
//默认参数信息
//option_count 不能是0, 也不能大于 parameter_count

//option_info
//{
//	u30 option_count
//	option_detail option[option_count]
//}
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Method_info{
		
		public var return_type:int;
		public var param_typeV:Vector.<int>;
		public var name:int;
		public var NeedArguments:Boolean;
		public var NeedActivation:Boolean;
		public var NeedRest:Boolean;
		public var SetDxns:Boolean;
		public var option_detailV:Vector.<Option_detail>;
		public var param_nameV:Vector.<int>;
		
		public function Method_info(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var param_count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{param_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{param_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{param_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{param_count=data[offset++];}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{return_type=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{return_type=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{return_type=data[offset++];}
			
			if(param_count){
				param_typeV=new Vector.<int>(param_count);
				for(var i:int=0;i<param_count;i++){
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{param_typeV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{param_typeV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{param_typeV[i]=data[offset++];}
				}
			}else{
				param_typeV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
			
			var flags:int=data[offset++];
			NeedArguments=((flags&MethodFlags.NEED_ARGUMENTS)?true:false);			//00000001
			NeedActivation=((flags&MethodFlags.NEED_ACTIVATION)?true:false);		//00000010
			NeedRest=((flags&MethodFlags.NEED_REST)?true:false);					//00000100
			SetDxns=((flags&MethodFlags.SET_DXNS)?true:false);						//01000000
			
			if(flags&MethodFlags.HAS_OPTIONAL){										//00001000
				if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
				if(count){
					option_detailV=new Vector.<Option_detail>(count);
					for(i=0;i<count;i++){
						option_detailV[i]=new Option_detail();
						offset=option_detailV[i].initByData(data,offset,endOffset,_initByDataOptions);
					}
				}else{
					option_detailV=null;
				}
			}else{
				option_detailV=null;
			}
			
			if(flags&MethodFlags.HAS_PARAM_NAMES){									//10000000
				if(param_count){
					param_nameV=new Vector.<int>(param_count);
					for(i=0;i<param_count;i++){
						if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{param_nameV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{param_nameV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{param_nameV[i]=data[offset++];}
					}
				}else{
					param_nameV=null;
				}
			}else{
				param_nameV=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			if(param_typeV){
				var param_count:int=param_typeV.length;
				if(param_count){
					if(param_count>>>7){if(param_count>>>14){if(param_count>>>21){if(param_count>>>28){data[offset++]=(param_count&0x7f)|0x80;data[offset++]=((param_count>>>7)&0x7f)|0x80;data[offset++]=((param_count>>>14)&0x7f)|0x80;data[offset++]=((param_count>>>21)&0x7f)|0x80;data[offset++]=param_count>>>28;}else{data[offset++]=(param_count&0x7f)|0x80;data[offset++]=((param_count>>>7)&0x7f)|0x80;data[offset++]=((param_count>>>14)&0x7f)|0x80;data[offset++]=param_count>>>21;}}else{data[offset++]=(param_count&0x7f)|0x80;data[offset++]=((param_count>>>7)&0x7f)|0x80;data[offset++]=param_count>>>14;}}else{data[offset++]=(param_count&0x7f)|0x80;data[offset++]=param_count>>>7;}}else{data[offset++]=param_count;}
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(return_type>>>7){if(return_type>>>14){if(return_type>>>21){if(return_type>>>28){data[offset++]=(return_type&0x7f)|0x80;data[offset++]=((return_type>>>7)&0x7f)|0x80;data[offset++]=((return_type>>>14)&0x7f)|0x80;data[offset++]=((return_type>>>21)&0x7f)|0x80;data[offset++]=return_type>>>28;}else{data[offset++]=(return_type&0x7f)|0x80;data[offset++]=((return_type>>>7)&0x7f)|0x80;data[offset++]=((return_type>>>14)&0x7f)|0x80;data[offset++]=return_type>>>21;}}else{data[offset++]=(return_type&0x7f)|0x80;data[offset++]=((return_type>>>7)&0x7f)|0x80;data[offset++]=return_type>>>14;}}else{data[offset++]=(return_type&0x7f)|0x80;data[offset++]=return_type>>>7;}}else{data[offset++]=return_type;}
			
			if(param_count){
				for each(var param_type:int in param_typeV){
					if(param_type>>>7){if(param_type>>>14){if(param_type>>>21){if(param_type>>>28){data[offset++]=(param_type&0x7f)|0x80;data[offset++]=((param_type>>>7)&0x7f)|0x80;data[offset++]=((param_type>>>14)&0x7f)|0x80;data[offset++]=((param_type>>>21)&0x7f)|0x80;data[offset++]=param_type>>>28;}else{data[offset++]=(param_type&0x7f)|0x80;data[offset++]=((param_type>>>7)&0x7f)|0x80;data[offset++]=((param_type>>>14)&0x7f)|0x80;data[offset++]=param_type>>>21;}}else{data[offset++]=(param_type&0x7f)|0x80;data[offset++]=((param_type>>>7)&0x7f)|0x80;data[offset++]=param_type>>>14;}}else{data[offset++]=(param_type&0x7f)|0x80;data[offset++]=param_type>>>7;}}else{data[offset++]=param_type;}
				}
			}
			
			if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
			
			var flags:int=0;
			if(NeedArguments){
				flags|=MethodFlags.NEED_ARGUMENTS;
			}
			if(NeedActivation){
				flags|=MethodFlags.NEED_ACTIVATION;
			}
			if(NeedRest){
				flags|=MethodFlags.NEED_REST;
			}
			if(SetDxns){
				flags|=MethodFlags.SET_DXNS;
			}
			var flagsOffset:int=offset;
			offset++;
			
			if(option_detailV){
				var count:int=option_detailV.length;
				if(count){
					flags|=MethodFlags.HAS_OPTIONAL;
					
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var option_detail:Option_detail in option_detailV){
						data.writeBytes(option_detail.toData(_toDataOptions));
					}
					offset=data.length;
				}
			}
			
			if(param_nameV){
				count=param_nameV.length;
				if(count){
					flags|=MethodFlags.HAS_PARAM_NAMES;
					
					for each(var param_name:int in param_nameV){
						if(param_name>>>7){if(param_name>>>14){if(param_name>>>21){if(param_name>>>28){data[offset++]=(param_name&0x7f)|0x80;data[offset++]=((param_name>>>7)&0x7f)|0x80;data[offset++]=((param_name>>>14)&0x7f)|0x80;data[offset++]=((param_name>>>21)&0x7f)|0x80;data[offset++]=param_name>>>28;}else{data[offset++]=(param_name&0x7f)|0x80;data[offset++]=((param_name>>>7)&0x7f)|0x80;data[offset++]=((param_name>>>14)&0x7f)|0x80;data[offset++]=param_name>>>21;}}else{data[offset++]=(param_name&0x7f)|0x80;data[offset++]=((param_name>>>7)&0x7f)|0x80;data[offset++]=param_name>>>14;}}else{data[offset++]=(param_name&0x7f)|0x80;data[offset++]=param_name>>>7;}}else{data[offset++]=param_name;}
					}
				}
			}
			
			data[flagsOffset]=flags;
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName}
				return_type={return_type}
				name={name}
				NeedArguments={NeedArguments}
				NeedActivation={NeedActivation}
				NeedRest={NeedRest}
				SetDxns={SetDxns}
			/>;
			
			if(param_typeV){
				var param_count:int=param_typeV.length;
				if(param_count){
					var childXML:XML=<param_typeV count={param_count}/>;
					for each(var param_type:int in param_typeV){
						childXML.appendChild(<param_type value={param_type}/>);
					}
					xml.appendChild(childXML);
				}
			}
			
			if(option_detailV){
				var count:int=option_detailV.length;
				if(count){
					childXML=<option_detailV count={count}/>;
					for each(var option_detail:Option_detail in option_detailV){
						childXML.appendChild(option_detail.toXML("option_detail",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(param_nameV){
				count=param_nameV.length;
				if(count){
					childXML=<param_nameV count={count}/>;
					for each(var param_name:int in param_nameV){
						childXML.appendChild(<param_name value={param_name}/>);
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			return_type=int(xml.@return_type.toString());
			
			var list:XMLList=xml.param_typeV.param_type;
			var param_count:int=list.length();
			if(param_count){
				var i:int=-1;
				param_typeV=new Vector.<int>(param_count);
				for each(var childXML:XML in list){
					param_typeV[++i]=int(childXML.@value.toString());
				}
			}else{
				param_typeV=null;
			}
			
			name=int(xml.@name.toString());
			
			NeedArguments=(xml.@NeedArguments.toString()=="true");
			NeedActivation=(xml.@NeedActivation.toString()=="true");
			NeedRest=(xml.@NeedRest.toString()=="true");
			SetDxns=(xml.@SetDxns.toString()=="true");
			
			list=xml.option_detailV.option_detail;
			var count:int=list.length();
			if(count){
				i=-1;
				option_detailV=new Vector.<Option_detail>(count);
				for each(childXML in list){
					option_detailV[++i]=new Option_detail();
					option_detailV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				option_detailV=null;
			}
			
			list=xml.param_nameV.param_name;
			count=list.length();
			if(count){
				i=-1;
				param_nameV=new Vector.<int>(count);
				for each(childXML in list){
					param_nameV[++i]=int(childXML.@value.toString());
				}
			}else{
				param_nameV=null;
			}
			
		}
		
	}
}
