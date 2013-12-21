/***
DoABCWithoutFlagsAndName
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年08月29日 18:05:36（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater2/bin-debug/CodesGenerater2.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//DoABCWithoutFlagsAndName
//Field 		Type 					Comment
//Header 		RECORDHEADER 			Tag type = 72
//ABCData 		BYTE[] 					A block of .abc bytecode to be parsed by the ActionScript 3.0 virtual machine, up to the end of the tag.

package zero.swf.tagBodys{
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	
	import zero.swf.BytesData;
	
	public class DoABCWithoutFlagsAndName{
		
		public var ABCData:*;
		
		public function DoABCWithoutFlagsAndName(){
			//ABCData=null;
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
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
			
			return ABCData.toData(_toDataOptions);
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName} class="zero.swf.tagBodys.DoABCWithoutFlagsAndName"/>;
			
			xml.appendChild(ABCData.toXML("ABCData",_toXMLOptions));
			
			if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){//20130407
				_toXMLOptions.addToXMLInfos(this,xml);
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
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