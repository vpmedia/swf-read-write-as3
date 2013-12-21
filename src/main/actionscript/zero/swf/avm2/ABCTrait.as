/***
ABCTrait
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 13:38:30
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//A trait is a fixed property of an object or class; it has a name, a type, and some associated data. The
//traits_info structure bundles these data.

//traits_info
//{
//	u30 name
//	u8 kind
//	u8 data[]
//	u30 metadata_count
//	u30 metadata[metadata_count]
//}
package zero.swf.avm2{
	public class ABCTrait{
		
		public var name:ABCMultiname;
		public var ATTR_Final:Boolean;
		public var ATTR_Override:Boolean;
		public var kind_trait_type:int;
		public var slot_id:int;
		public var type_name:ABCMultiname;
		public var vkindAndVIndex:ABCConstantItem;
		public var disp_id:int;
		public var method:ABCMethod;
		public var function_:ABCMethod;
		public var classi:ABCMultiname;
		public var metadataV:Vector.<ABCMetadata>;
		
		public function ABCTrait(){
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName}/>;
			
			if(name){
				if(_toXMLOptions&&_toXMLOptions.toStrDict){
					var multinameStr:String=_toXMLOptions.toStrDict[name];
					if(multinameStr||multinameStr===""){
					}else{
						_toXMLOptions.toStrDict[name]=multinameStr=name.toStr(_toXMLOptions);
					}
				}else{
					multinameStr=name.toStr(_toXMLOptions);
				}
				xml.appendChild(<name value={multinameStr}/>);
			}
			
			xml.@ATTR_Final=ATTR_Final;
			xml.@ATTR_Override=ATTR_Override;
			
			xml.@kind_trait_type=TraitTypeAndAttributes.typeV[kind_trait_type];
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					
					xml.@slot_id=slot_id;
					
					if(type_name){
						if(_toXMLOptions&&_toXMLOptions.toStrDict){
							multinameStr=_toXMLOptions.toStrDict[type_name];
							if(multinameStr||multinameStr===""){
							}else{
								_toXMLOptions.toStrDict[type_name]=multinameStr=type_name.toStr(_toXMLOptions);
							}
						}else{
							multinameStr=type_name.toStr(_toXMLOptions);
						}
						xml.appendChild(<type_name value={multinameStr}/>);
					}
					
					if(vkindAndVIndex){
						xml.appendChild(vkindAndVIndex.toXML("vkindAndVIndex",_toXMLOptions));
					}
					
				break;
				case TraitTypeAndAttributes.Method:
				case TraitTypeAndAttributes.Getter:
				case TraitTypeAndAttributes.Setter:
					
					xml.@disp_id=disp_id;
					
					if(method){
						xml.appendChild(method.toXML("method",_toXMLOptions));
					}
					
				break;
				case TraitTypeAndAttributes.Function_:
					
					xml.@slot_id=slot_id;
					
					if(function_){
						xml.appendChild(function_.toXML("function_",_toXMLOptions));
					}
					
				break;
				case TraitTypeAndAttributes.Class_:
					
					xml.@slot_id=slot_id;
					
					if(classi){
						if(_toXMLOptions&&_toXMLOptions.toStrDict){
							multinameStr=_toXMLOptions.toStrDict[classi];
							if(multinameStr||multinameStr===""){
							}else{
								_toXMLOptions.toStrDict[classi]=multinameStr=classi.toStr(_toXMLOptions);
							}
						}else{
							multinameStr=classi.toStr(_toXMLOptions);
						}
						xml.appendChild(<classi value={multinameStr}/>);
					}
					
				break;
			}
			
			if(metadataV){
				var count:int=metadataV.length;
				if(count){
					var childXML:XML=<metadataV count={count}/>;
					for each(var metadata:ABCMetadata in metadataV){
						if(metadata){
							if(_toXMLOptions&&_toXMLOptions.toStrDict){
								var metadataStr:String=_toXMLOptions.toStrDict[metadata];
								if(metadataStr||metadataStr===""){
								}else{
									_toXMLOptions.toStrDict[metadata]=metadataStr=metadata.toStr(_toXMLOptions);
								}
							}else{
								metadataStr=metadata.toStr(_toXMLOptions);
							}
							childXML.appendChild(<metadata value={metadataStr}/>);
						}else{
							childXML.appendChild(<metadata/>);
						}
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			var nameXML:XML=xml.name[0];
			if(nameXML){
				var multinameStr:String=nameXML.@value.toString();
				if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
					name=_initByXMLOptions.initByStrMark["~multiname~"+multinameStr];
					if(name){
					}else{
						_initByXMLOptions.initByStrMark["~multiname~"+multinameStr]=name=new ABCMultiname(multinameStr,_initByXMLOptions);
					}
				}else{
					name=new ABCMultiname(multinameStr,_initByXMLOptions);
				}
			}else{
				name=null;
			}
			
			ATTR_Final=(xml.@ATTR_Final.toString()=="true");
			ATTR_Override=(xml.@ATTR_Override.toString()=="true");
			
			kind_trait_type=TraitTypeAndAttributes[xml.@kind_trait_type.toString()];
			
			switch(kind_trait_type){
				case TraitTypeAndAttributes.Slot:
				case TraitTypeAndAttributes.Const:
					
					slot_id=int(xml.@slot_id.toString());
					
					var type_nameXML:XML=xml.type_name[0];
					if(type_nameXML){
						multinameStr=type_nameXML.@value.toString();
						if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
							type_name=_initByXMLOptions.initByStrMark["~multiname~"+multinameStr];
							if(type_name){
							}else{
								_initByXMLOptions.initByStrMark["~multiname~"+multinameStr]=type_name=new ABCMultiname(multinameStr,_initByXMLOptions);
							}
						}else{
							type_name=new ABCMultiname(multinameStr,_initByXMLOptions);
						}
					}else{
						type_name=null;
					}
					
					var vkindAndVIndexXML:XML=xml.vkindAndVIndex[0];
					if(vkindAndVIndexXML){
						vkindAndVIndex=new ABCConstantItem();
						vkindAndVIndex.initByXML(vkindAndVIndexXML,_initByXMLOptions);
					}else{
						vkindAndVIndex=null;
					}
					
				break;
				case TraitTypeAndAttributes.Method:
				case TraitTypeAndAttributes.Getter:
				case TraitTypeAndAttributes.Setter:
					
					disp_id=int(xml.@disp_id.toString());
					
					var methodXML:XML=xml.method[0];
					if(methodXML){
						method=new ABCMethod();
						method.initByXML(methodXML,_initByXMLOptions);
					}else{
						method=null;
					}
				
				break;
				case TraitTypeAndAttributes.Function_:
					
					slot_id=int(xml.@slot_id.toString());
					
					var function_XML:XML=xml.function_[0];
					if(function_XML){
						function_=new ABCMethod();
						function_.initByXML(function_XML,_initByXMLOptions);
					}else{
						function_=null;
					}
					
				break;
				case TraitTypeAndAttributes.Class_:
					
					slot_id=int(xml.@slot_id.toString());
					
					var classiXML:XML=xml.classi[0];
					if(classiXML){
						multinameStr=classiXML.@value.toString();
						if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
							classi=_initByXMLOptions.initByStrMark["~multiname~"+multinameStr];
							if(classi){
							}else{
								_initByXMLOptions.initByStrMark["~multiname~"+multinameStr]=classi=new ABCMultiname(multinameStr,_initByXMLOptions);
							}
						}else{
							classi=new ABCMultiname(multinameStr,_initByXMLOptions);
						}
					}else{
						classi=null;
					}
					
				break;
			}
			
			var list:XMLList=xml.metadataV.metadata;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				metadataV=new Vector.<ABCMetadata>(count);
				for each(var childXML:XML in list){
					var valueXML:XML=childXML.@value[0];
					if(valueXML){
						metadataV[++i]=new ABCMetadata(valueXML.toString(),_initByXMLOptions);
					}else{
						i++;
					}
				}
			}else{
				metadataV=null;
			}
		}
		
	}
}	