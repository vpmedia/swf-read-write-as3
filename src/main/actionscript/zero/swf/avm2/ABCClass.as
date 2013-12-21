/***
ABCClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 12:17:51
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

//The instance_info entry is used to define the characteristics of a run-time object (a class instance) within the
//AVM2. The corresponding(对应的) class_info entry is used in order to fully define an ActionScript 3.0 Class.
//instance_info
//{
//	u30 name
//	u30 super_name
//	u8 flags
//	u30 protectedNs
//	u30 intrf_count
//	u30 interface[intrf_count]
//	u30 iinit
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The class_info entry is used to define characteristics of an ActionScript 3.0 class.
//class_info
//{
//	u30 cinit
//	u30 trait_count
//	traits_info traits[trait_count]
//}

package zero.swf.avm2{
	public class ABCClass{
		
		public var name:ABCMultiname;
		public var super_name:ABCMultiname;
		public var ClassSealed:Boolean;
		public var ClassFinal:Boolean;
		public var ClassInterface:Boolean;
		public var protectedNs:ABCNamespace;
		public var intrfV:Vector.<ABCMultiname>;
		public var iinit:ABCMethod;
		public var itraitV:Vector.<ABCTrait>;
		public var cinit:ABCMethod;
		public var ctraitV:Vector.<ABCTrait>;
		
		public function ABCClass(){
			
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
			
			if(super_name){
				if(_toXMLOptions&&_toXMLOptions.toStrDict){
					multinameStr=_toXMLOptions.toStrDict[super_name];
					if(multinameStr||multinameStr===""){
					}else{
						_toXMLOptions.toStrDict[super_name]=multinameStr=super_name.toStr(_toXMLOptions);
					}
				}else{
					multinameStr=super_name.toStr(_toXMLOptions);
				}
				xml.appendChild(<super_name value={multinameStr}/>);
			}
			
			xml.@ClassSealed=ClassSealed;
			xml.@ClassFinal=ClassFinal;
			xml.@ClassInterface=ClassInterface;
			
			if(protectedNs){
				if(_toXMLOptions&&_toXMLOptions.toStrDict){
					var nsStr:String=_toXMLOptions.toStrDict[protectedNs];
					if(nsStr||nsStr===""){
					}else{
						_toXMLOptions.toStrDict[protectedNs]=nsStr=protectedNs.toStr(_toXMLOptions);
					}
				}else{
					nsStr=protectedNs.toStr(_toXMLOptions);
				}
				xml.appendChild(<protectedNs value={nsStr}/>);
			}
			
			if(intrfV){
				var count:int=intrfV.length;
				if(count){
					var childXML:XML=<intrfV count={count}/>;
					for each(var intrf:ABCMultiname in intrfV){
						if(intrf){
							if(_toXMLOptions&&_toXMLOptions.toStrDict){
								multinameStr=_toXMLOptions.toStrDict[intrf];
								if(multinameStr||multinameStr===""){
								}else{
									_toXMLOptions.toStrDict[intrf]=multinameStr=intrf.toStr(_toXMLOptions);
								}
							}else{
								multinameStr=intrf.toStr(_toXMLOptions);
							}
							childXML.appendChild(<intrf value={multinameStr}/>);
						}else{
							childXML.appendChild(<intrf/>);
						}
					}
					xml.appendChild(childXML);
				}
			}
			
			if(iinit){
				xml.appendChild(iinit.toXML("iinit",_toXMLOptions));
			}
			
			if(itraitV){
				count=itraitV.length;
				if(count){
					childXML=<itraitV count={count}/>;
					for each(var itrait:ABCTrait in itraitV){
						childXML.appendChild(itrait.toXML("itrait",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(cinit){
				xml.appendChild(cinit.toXML("cinit",_toXMLOptions));
			}
			
			if(ctraitV){
				count=ctraitV.length;
				if(count){
					childXML=<ctraitV count={count}/>;
					for each(var ctrait:ABCTrait in ctraitV){
						childXML.appendChild(ctrait.toXML("ctrait",_toXMLOptions));
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
			
			var super_nameXML:XML=xml.super_name[0];
			if(super_nameXML){
				multinameStr=super_nameXML.@value.toString();
				if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
					super_name=_initByXMLOptions.initByStrMark["~multiname~"+multinameStr];
					if(super_name){
					}else{
						_initByXMLOptions.initByStrMark["~multiname~"+multinameStr]=super_name=new ABCMultiname(multinameStr,_initByXMLOptions);
					}
				}else{
					super_name=new ABCMultiname(multinameStr,_initByXMLOptions);
				}
			}else{
				super_name=null;
			}
			
			ClassSealed=(xml.@ClassSealed.toString()=="true");
			ClassFinal=(xml.@ClassFinal.toString()=="true");
			ClassInterface=(xml.@ClassInterface.toString()=="true");
			
			var protectedNsXML:XML=xml.protectedNs[0];
			if(protectedNsXML){
				var nsStr:String=protectedNsXML.@value.toString();
				if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
					protectedNs=_initByXMLOptions.initByStrMark["~ns~"+nsStr];
					if(protectedNs){
					}else{
						_initByXMLOptions.initByStrMark["~ns~"+nsStr]=protectedNs=new ABCNamespace(nsStr,_initByXMLOptions);
					}
				}else{
					protectedNs=new ABCNamespace(nsStr,_initByXMLOptions);
				}
			}else{
				protectedNs=null;
			}
			
			var list:XMLList=xml.intrfV.intrf;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				intrfV=new Vector.<ABCMultiname>(count);
				for each(var childXML:XML in list){
					var valueXML:XML=childXML.@value[0];
					if(valueXML){
						multinameStr=valueXML.toString();
						if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
							var multiname:ABCMultiname=_initByXMLOptions.initByStrMark["~multiname~"+multinameStr];
							if(multiname){
							}else{
								_initByXMLOptions.initByStrMark["~multiname~"+multinameStr]=multiname=new ABCMultiname(multinameStr,_initByXMLOptions);
							}
						}else{
							multiname=new ABCMultiname(multinameStr,_initByXMLOptions);
						}
						intrfV[++i]=multiname;
					}else{
						i++;
					}
				}
			}else{
				intrfV=null;
			}
			
			var iinitXML:XML=xml.iinit[0];
			if(iinitXML){
				iinit=new ABCMethod();
				iinit.initByXML(iinitXML,_initByXMLOptions);
			}else{
				iinit=null;
			}
			
			list=xml.itraitV.itrait;
			count=list.length();
			if(count){
				i=-1;
				itraitV=new Vector.<ABCTrait>(count);
				for each(childXML in list){
					itraitV[++i]=new ABCTrait();
					itraitV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				itraitV=null;
			}
			
			var cinitXML:XML=xml.cinit[0];
			if(cinitXML){
				cinit=new ABCMethod();
				cinit.initByXML(cinitXML,_initByXMLOptions);
			}else{
				cinit=null;
			}
			
			list=xml.ctraitV.ctrait;
			count=list.length();
			if(count){
				i=-1;
				ctraitV=new Vector.<ABCTrait>(count);
				for each(childXML in list){
					ctraitV[++i]=new ABCTrait();
					ctraitV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				ctraitV=null;
			}
			
		}
		
	}
}