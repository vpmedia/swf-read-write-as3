/***
ABCMethod
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 13:38:25
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

//The method_body entry holds the AVM2 instructions that are associated with a particular method or
//function body. Some of the fields in this entry declare the maximum amount of resources the body will
//consume during execution. These declarations allow the AVM2 to anticipate the requirements of the method
//without analyzing the method body prior to execution. The declarations also serve as promises about the
//resource boundary within which the method has agreed to remain.3
//There can be fewer method bodies in the method_body table than than there are method signatures in the
//method table—some methods have no bodies. Therefore the method_body contains a reference to the method
//it belongs to, and other parts of the abcFile always reference the method table, not the method_body table.
//3 Any code loaded from an untrusted source will be examined in order to verify that the code stays within
//the declared limits.

//method_body
//{
//	u30 method
//	u30 max_stack
//	u30 local_count
//	u30 init_scope_depth
//	u30 max_scope_depth
//	u30 code_length
//	u8 code[code_length]
//	u30 exception_count
//	exception_info exception[exception_count]
//	u30 trait_count
//	traits_info trait[trait_count]
//}

//The method field is an index into the method array of the abcFile; it identifies the method signature with
//which this body is to be associated.

package zero.swf.avm2{
	public class ABCMethod{
		
		public var return_type:ABCMultiname;
		public var param_typeV:Vector.<ABCMultiname>;
		public var name:String;
		public var NeedArguments:Boolean;
		public var NeedActivation:Boolean;
		public var NeedRest:Boolean;
		public var SetDxns:Boolean;
		public var option_detailV:Vector.<ABCConstantItem>;
		public var param_nameV:Vector.<String>;
		
		public var max_stack:int;
		public var local_count:int;
		public var init_scope_depth:int;
		public var max_scope_depth:int;
		public var codes:AVM2Codes;
		public var traitV:Vector.<ABCTrait>;
		
		public function ABCMethod(){
		}
		
		public function toMarkStr(_toXMLOptions:Object):String{
			
			var markStr:String="function ";
			
			if(name||name===""){
				markStr+=name+"()";
			}else{
				markStr+="(name=undefined)()";
			}
			
			if(return_type){
				if(_toXMLOptions&&_toXMLOptions.toStrDict){
					var multinameStr:String=_toXMLOptions.toStrDict[return_type];
					if(multinameStr||multinameStr===""){
					}else{
						_toXMLOptions.toStrDict[return_type]=multinameStr=return_type.toStr(_toXMLOptions);
					}
				}else{
					multinameStr=return_type.toStr(_toXMLOptions);
				}
				markStr+=":"+multinameStr;
			}
			
			return markStr;
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName}
				NeedArguments={NeedArguments}
				NeedActivation={NeedActivation}
				NeedRest={NeedRest}
				SetDxns={SetDxns}
			/>;
			
			if(return_type){
				if(_toXMLOptions&&_toXMLOptions.toStrDict){
					var multinameStr:String=_toXMLOptions.toStrDict[return_type];
					if(multinameStr||multinameStr===""){
					}else{
						_toXMLOptions.toStrDict[return_type]=multinameStr=return_type.toStr(_toXMLOptions);
					}
				}else{
					multinameStr=return_type.toStr(_toXMLOptions);
				}
				xml.appendChild(<return_type value={multinameStr}/>);
			}
			
			if(param_typeV){
				var param_count:int=param_typeV.length;
				if(param_count){
					var childXML:XML=<param_typeV count={param_count}/>;
					for each(var param_type:ABCMultiname in param_typeV){
						if(param_type){
							if(_toXMLOptions&&_toXMLOptions.toStrDict){
								multinameStr=_toXMLOptions.toStrDict[param_type];
								if(multinameStr||multinameStr===""){
								}else{
									_toXMLOptions.toStrDict[param_type]=multinameStr=param_type.toStr(_toXMLOptions);
								}
							}else{
								multinameStr=param_type.toStr(_toXMLOptions);
							}
							childXML.appendChild(<param_type value={multinameStr}/>);
						}else{
							childXML.appendChild(<param_type/>);
						}
					}
					xml.appendChild(childXML);
				}
			}
			
			if(name||name===""){
				xml.@name=name;
			}
			
			if(option_detailV){
				var count:int=option_detailV.length;
				if(count){
					childXML=<option_detailV count={count}/>;
					for each(var option_detail:ABCConstantItem in option_detailV){
						childXML.appendChild(option_detail.toXML("option_detail",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(param_nameV){
				count=param_nameV.length;
				if(count){
					childXML=<param_nameV count={count}/>;
					for each(var param_name:String in param_nameV){
						if(param_name||param_name===""){
							childXML.appendChild(<param_name value={param_name}/>);
						}else{
							childXML.appendChild(<param_name/>);
						}
					}
					xml.appendChild(childXML);
				}
			}
			
			if(codes){
				
				xml.@max_stack=max_stack;
				xml.@local_count=local_count;
				xml.@init_scope_depth=init_scope_depth;
				xml.@max_scope_depth=max_scope_depth;
				
				xml.appendChild(codes.toXML("codes",_toXMLOptions));
				
				if(traitV){
					count=traitV.length;
					if(count){
						childXML=<traitV count={count}/>;
						for each(var trait:ABCTrait in traitV){
							childXML.appendChild(trait.toXML("trait",_toXMLOptions));
						}
						xml.appendChild(childXML);
					}
				}
				
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			var return_typeXML:XML=xml.return_type[0];
			if(return_typeXML){
				var multinameStr:String=return_typeXML.@value.toString();
				if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
					return_type=_initByXMLOptions.initByStrMark["~multiname~"+multinameStr];
					if(return_type){
					}else{
						_initByXMLOptions.initByStrMark["~multiname~"+multinameStr]=return_type=new ABCMultiname(multinameStr,_initByXMLOptions);
					}
				}else{
					return_type=new ABCMultiname(multinameStr,_initByXMLOptions);
				}
			}else{
				return_type=null;
			}
			
			var list:XMLList=xml.param_typeV.param_type;
			var param_count:int=list.length();
			if(param_count){
				var i:int=-1;
				param_typeV=new Vector.<ABCMultiname>(param_count);
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
						param_typeV[++i]=multiname;
					}else{
						i++;
					}
				}
			}else{
				param_typeV=null;
			}
			
			var nameXML:XML=xml.@name[0];
			if(nameXML){
				name=nameXML.toString();
			}else{
				name=null;
			}
			
			NeedArguments=(xml.@NeedArguments.toString()=="true");
			NeedActivation=(xml.@NeedActivation.toString()=="true");
			NeedRest=(xml.@NeedRest.toString()=="true");
			SetDxns=(xml.@SetDxns.toString()=="true");
			
			list=xml.option_detailV.option_detail;
			var count:int=list.length();
			if(count){
				i=-1;
				option_detailV=new Vector.<ABCConstantItem>(count);
				for each(childXML in list){
					option_detailV[++i]=new ABCConstantItem();
					option_detailV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				option_detailV=null;
			}
			
			list=xml.param_nameV.param_name;
			count=list.length();
			if(count){
				i=-1;
				param_nameV=new Vector.<String>(count);
				for each(childXML in list){
					valueXML=childXML.@value[0];
					if(valueXML){
						param_nameV[++i]=valueXML.toString();
					}else{
						i++;
					}
				}
			}else{
				param_nameV=null;
			}
			
			var codesXML:XML=xml.codes[0];
			if(codesXML){
				
				max_stack=int(xml.@max_stack.toString());
				local_count=int(xml.@local_count.toString());
				init_scope_depth=int(xml.@init_scope_depth.toString());
				max_scope_depth=int(xml.@max_scope_depth.toString());
				
				codes=new AVM2Codes();
				codes.initByXML(xml.codes[0],_initByXMLOptions);
				
				list=xml.traitV.trait;
				count=list.length();
				if(count){
					i=-1;
					traitV=new Vector.<ABCTrait>(count);
					for each(childXML in list){
						traitV[++i]=new ABCTrait();
						traitV[i].initByXML(childXML,_initByXMLOptions);
					}
				}else{
					traitV=null;
				}
				
			}else{
				
				codes=null;
				
			}
			
		}
		
	}
}