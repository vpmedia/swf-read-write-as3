/***
DoABC
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月29日 18:05:36（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DoABC
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 82
//Flags 		UI32 					A 32-bit flags value, which may contain the following bits set:kDoAbcLazyInitializeFlag = 1: Indicates that the ABC block should not be executed immediately, but only parsed. A later finddef may cause its scripts to execute.
//Name 			STRING 					The name assigned to the bytecode.
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.

package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.BytesData;
	import zero.swf.utils.ignoreBOMReadUTFBytes;
	
	public class DoABC{
		
		public var Flags:uint;//UI32
		public var Name:String;//STRING
		public var ABCData:*;
		
		public function DoABC(){
			//Flags=0;
			//Name=null;
			//ABCData=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			Flags=data[offset++]|(data[offset++]<<8)|(data[offset++]<<16)|(data[offset++]<<24);
			
			var get_str_size:int=0;
			while(data[offset+(get_str_size++)]){}
			data.position=offset;
			Name=ignoreBOMReadUTFBytes(data,get_str_size);
			offset+=get_str_size;
			
			if(_initByDataOptions){
				if(_initByDataOptions.classes){
					var ABCDataClass:Class=_initByDataOptions.classes["zero.swf.avm2.ABCFile"];
				}
				if(ABCDataClass){
				}else{
					ABCDataClass=_initByDataOptions.ABCDataClass;
				}
			}
			ABCData=new (ABCDataClass||BytesData)();
			return ABCData.initByData(data,offset,endOffset,_initByDataOptions);
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			
			data[0]=Flags;
			data[1]=Flags>>8;
			data[2]=Flags>>16;
			data[3]=Flags>>24;
			
			data.position=4;
			data.writeUTFBytes(Name+"\x00");
			
			data.writeBytes(ABCData.toData(_toDataOptions));
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DoABC"
				Flags={Flags}
				Name={Name}
			/>;
			
			xml.appendChild(ABCData.toXML("ABCData",_toXMLOptions));
			
			if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){//20130407
				_toXMLOptions.addToXMLInfos(this,xml);
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			Flags=uint(xml.@Flags.toString());
			
			Name=xml.@Name.toString();
			
			var ABCDataXML:XML=xml.ABCData[0];
			var classStr:String=ABCDataXML["@class"].toString();
			var ABCDataClass:Class=null;
			if(_initByXMLOptions&&_initByXMLOptions.customClasses){
				ABCDataClass=_initByXMLOptions.customClasses[classStr];
			}
			if(ABCDataClass){
			}else{
				try{
					ABCDataClass=getDefinitionByName(classStr) as Class;
				}catch(e:Error){
					ABCDataClass=null;
				}
			}
			ABCData=new (ABCDataClass||BytesData)();
			ABCData.initByXML(ABCDataXML,_initByXMLOptions);
			
		}
		
	}
}