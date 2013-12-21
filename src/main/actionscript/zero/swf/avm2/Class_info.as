/***
Class_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The class_info entry is used to define characteristics of an ActionScript 3.0 class.
//class_info
//{
//	u30 cinit
//	u30 trait_count
//	traits_info traits[trait_count]
//}

//This is an index into the method array of the abcFile; it references the method that is invoked when the
//class is first created. This method is also known as the static initializer for the class.

//The value of trait_count is the number of entries in the trait array. The trait array holds the traits
//for the class (see above for information on traits).
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Class_info{
		
		public var cinit:int;
		public var ctraits_infoV:Vector.<Traits_info>;
		
		public function Class_info(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){cinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{cinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{cinit=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{cinit=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{cinit=data[offset++];}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				ctraits_infoV=new Vector.<Traits_info>(count);
				for(var i:int=0;i<count;i++){
					ctraits_infoV[i]=new Traits_info();
					offset=ctraits_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				ctraits_infoV=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			if(cinit>>>7){if(cinit>>>14){if(cinit>>>21){if(cinit>>>28){data[offset++]=(cinit&0x7f)|0x80;data[offset++]=((cinit>>>7)&0x7f)|0x80;data[offset++]=((cinit>>>14)&0x7f)|0x80;data[offset++]=((cinit>>>21)&0x7f)|0x80;data[offset++]=cinit>>>28;}else{data[offset++]=(cinit&0x7f)|0x80;data[offset++]=((cinit>>>7)&0x7f)|0x80;data[offset++]=((cinit>>>14)&0x7f)|0x80;data[offset++]=cinit>>>21;}}else{data[offset++]=(cinit&0x7f)|0x80;data[offset++]=((cinit>>>7)&0x7f)|0x80;data[offset++]=cinit>>>14;}}else{data[offset++]=(cinit&0x7f)|0x80;data[offset++]=cinit>>>7;}}else{data[offset++]=cinit;}
			
			if(ctraits_infoV){
				var count:int=ctraits_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var ctraits_info:Traits_info in ctraits_infoV){
						data.writeBytes(ctraits_info.toData(_toDataOptions));
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName}
				cinit={cinit}
			/>;
			
			if(ctraits_infoV){
				var count:int=ctraits_infoV.length;
				if(count){
					var childXML:XML=<ctraits_infoV count={count}/>;
					for each(var ctraits_info:Traits_info in ctraits_infoV){
						childXML.appendChild(ctraits_info.toXML("ctraits_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			cinit=int(xml.@cinit.toString());
			
			var list:XMLList=xml.ctraits_infoV.ctraits_info;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				ctraits_infoV=new Vector.<Traits_info>(count);
				for each(var childXML:XML in list){
					ctraits_infoV[++i]=new Traits_info();
					ctraits_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				ctraits_infoV=null;
			}
			
		}
		
	}
}
