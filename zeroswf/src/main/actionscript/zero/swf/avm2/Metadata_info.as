/***
Metadata_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//metadata_info
//{
//	u30 name
//	u30 item_count
//	item_info items[item_count]
//}

//The name field is an index into the string array of the constant pool; it provides a name for the metadata
//entry. The value of the name field must not be zero. Zero or more items may be associated with the entry;
//item_count denotes the number of items that follow in the items array.
//name 是在 constant_pool.string_v 中的id
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	public class Metadata_info{
		public var name:int;							//u30
		public var item_infoV:Vector.<Array>;
		//
		
		public function Metadata_info(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{name=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{name=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{name=data[offset++];}
			//name
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				item_infoV=new Vector.<Array>(count);
				for(var i:int=0;i<count;i++){
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){item_infoV[i]=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28)];}else{item_infoV[i]=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21)];}}else{item_infoV[i]=[(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14)];}}else{item_infoV[i]=[(data[offset++]&0x7f)|(data[offset++]<<7)];}}else{item_infoV[i]=[data[offset++]];}
					//key
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){item_infoV[i][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{item_infoV[i][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{item_infoV[i][1]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{item_infoV[i][1]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{item_infoV[i][1]=data[offset++];}
					//value
					
				}
			}else{
				item_infoV=null;
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			if(name>>>7){if(name>>>14){if(name>>>21){if(name>>>28){data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=((name>>>21)&0x7f)|0x80;data[offset++]=name>>>28;}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=((name>>>14)&0x7f)|0x80;data[offset++]=name>>>21;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=((name>>>7)&0x7f)|0x80;data[offset++]=name>>>14;}}else{data[offset++]=(name&0x7f)|0x80;data[offset++]=name>>>7;}}else{data[offset++]=name;}
			//name
			
			if(item_infoV){
				var count:int=item_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var item_info:Array in item_infoV){
						
						if(item_info[0]>>>7){if(item_info[0]>>>14){if(item_info[0]>>>21){if(item_info[0]>>>28){data[offset++]=(item_info[0]&0x7f)|0x80;data[offset++]=((item_info[0]>>>7)&0x7f)|0x80;data[offset++]=((item_info[0]>>>14)&0x7f)|0x80;data[offset++]=((item_info[0]>>>21)&0x7f)|0x80;data[offset++]=item_info[0]>>>28;}else{data[offset++]=(item_info[0]&0x7f)|0x80;data[offset++]=((item_info[0]>>>7)&0x7f)|0x80;data[offset++]=((item_info[0]>>>14)&0x7f)|0x80;data[offset++]=item_info[0]>>>21;}}else{data[offset++]=(item_info[0]&0x7f)|0x80;data[offset++]=((item_info[0]>>>7)&0x7f)|0x80;data[offset++]=item_info[0]>>>14;}}else{data[offset++]=(item_info[0]&0x7f)|0x80;data[offset++]=item_info[0]>>>7;}}else{data[offset++]=item_info[0];}
						//key
						
						if(item_info[1]>>>7){if(item_info[1]>>>14){if(item_info[1]>>>21){if(item_info[1]>>>28){data[offset++]=(item_info[1]&0x7f)|0x80;data[offset++]=((item_info[1]>>>7)&0x7f)|0x80;data[offset++]=((item_info[1]>>>14)&0x7f)|0x80;data[offset++]=((item_info[1]>>>21)&0x7f)|0x80;data[offset++]=item_info[1]>>>28;}else{data[offset++]=(item_info[1]&0x7f)|0x80;data[offset++]=((item_info[1]>>>7)&0x7f)|0x80;data[offset++]=((item_info[1]>>>14)&0x7f)|0x80;data[offset++]=item_info[1]>>>21;}}else{data[offset++]=(item_info[1]&0x7f)|0x80;data[offset++]=((item_info[1]>>>7)&0x7f)|0x80;data[offset++]=item_info[1]>>>14;}}else{data[offset++]=(item_info[1]&0x7f)|0x80;data[offset++]=item_info[1]>>>7;}}else{data[offset++]=item_info[1];}
						//value
						
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
				name={name}
			/>;
			
			if(item_infoV){
				var count:int=item_infoV.length;
				if(count){
					var childXML:XML=<item_infoV count={count}/>;
					for each(var item_info:Array in item_infoV){
						childXML.appendChild(<item_info
							key={item_info[0]}
							value={item_info[1]}
						/>);
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			name=int(xml.@name.toString());
			
			var list:XMLList=xml.item_infoV.item_info;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				item_infoV=new Vector.<Array>(count);
				for each(var childXML:XML in list){
					item_infoV[++i]=[
						int(xml.@key.toString()),
						int(xml.@value.toString())
					];
				}
			}else{
				item_infoV=null;
			}
			
		}
		
	}
}
