/***
Script_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The script_info entry is used to define characteristics of an ActionScript 3.0 script.
//script_info
//{
//	u30 init
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The init field is an index into the method array of the abcFile. It identifies a function that is to be
//invoked prior to any other code in this script.
//它确定一个函数，要
//调用任何其他代码之前在此脚本

//The value of trait_count is the number of entries in the trait array. The trait array is the set of traits
//defined by the script.
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Script_info{
		
		public var init:int;
		public var traits_infoV:Vector.<Traits_info>;
		
		public function Script_info(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){init=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{init=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{init=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{init=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{init=data[offset++];}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				traits_infoV=new Vector.<Traits_info>(count);
				for(var i:int=0;i<count;i++){
					traits_infoV[i]=new Traits_info();
					offset=traits_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				traits_infoV=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			if(init>>>7){if(init>>>14){if(init>>>21){if(init>>>28){data[offset++]=(init&0x7f)|0x80;data[offset++]=((init>>>7)&0x7f)|0x80;data[offset++]=((init>>>14)&0x7f)|0x80;data[offset++]=((init>>>21)&0x7f)|0x80;data[offset++]=init>>>28;}else{data[offset++]=(init&0x7f)|0x80;data[offset++]=((init>>>7)&0x7f)|0x80;data[offset++]=((init>>>14)&0x7f)|0x80;data[offset++]=init>>>21;}}else{data[offset++]=(init&0x7f)|0x80;data[offset++]=((init>>>7)&0x7f)|0x80;data[offset++]=init>>>14;}}else{data[offset++]=(init&0x7f)|0x80;data[offset++]=init>>>7;}}else{data[offset++]=init;}
			
			if(traits_infoV){
				var count:int=traits_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var traits_info:Traits_info in traits_infoV){
						data.writeBytes(traits_info.toData(_toDataOptions));
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
				init={init}
			/>;
			
			if(traits_infoV){
				var count:int=traits_infoV.length;
				if(count){
					var childXML:XML=<traits_infoV count={count}/>;
					for each(var traits_info:Traits_info in traits_infoV){
						childXML.appendChild(traits_info.toXML("traits_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			init=int(xml.@init.toString());
			
			var list:XMLList=xml.traits_infoV.traits_info;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				traits_infoV=new Vector.<Traits_info>(count);
				for each(var childXML:XML in list){
					traits_infoV[++i]=new Traits_info();
					traits_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				traits_infoV=null;
			}
			
		}
		
	}
}
