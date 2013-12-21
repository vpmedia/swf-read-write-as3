/***
ABCMultiname
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月19日 23:14:09（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//A multiname_info entry is a variable length item that is used to define multiname entities used by the
//bytecode. There are many kinds of multinames. The kind field acts as a tag: its value determines how the
//loader should see the variable-length data field. The layout of the contents of the data field under a particular
//kind is described below by the multiname_kind_ structures.
//multiname_info
//{
//u8 kind
//u8 data[]
//}
//
//Multiname Kind 		Value
//CONSTANT_QName 		0x07
//CONSTANT_QNameA 		0x0D
//CONSTANT_RTQName 		0x0F
//CONSTANT_RTQNameA 	0x10
//CONSTANT_RTQNameL 	0x11
//CONSTANT_RTQNameLA 	0x12
//CONSTANT_Multiname 	0x09
//CONSTANT_MultinameA 	0x0E
//CONSTANT_MultinameL 	0x1B
//CONSTANT_MultinameLA 	0x1C
//
//Those constants ending in "A" (such as CONSTANT_QNameA) represent the names of attributes.

//multiname_kind_QName
//{
//	u30 ns
//	u30 name
//}

//The ns and name fields are indexes into the namespace and string arrays of the constant_pool entry,
//respectively. A value of zero for the ns field indicates the any ("*") namespace, and a value of zero for the name
//field indicates the any ("*") name.
//ns是在 constant_pool.namespace_info_v 中的id
//name是在 constant_pool.string_v 中的id
//ns或name如果是 0 则表示 "*"

//multiname_kind_Multiname
//{
//	u30 name
//	u30 ns_set
//}

//The name field is an index into the string array, and the ns_set field is an index into the ns_set array. A
//value of zero for the name field indicates the any ("*") name. The value of ns_set cannot be zero.
//name是在 constant_pool.string_v 中的id
//ns_set是在 constant_pool.ns_set_info_v 中的id
//name如果是 0 则表示 "*"
//ns_set不能是 0

//multiname_kind_RTQName
//{
//	u30 name
//}

//The single field, name, is an index into the string array of the constant pool. A value of zero indicates the any ("*") name.
//name是在 constant_pool.string_v 中的id
//name如果是 0 则表示 "*"

//multiname_kind_RTQNameL
//{
//}

//This kind has no associated data.
//什么都没有...

//multiname_kind_MultinameL
//{
//	u30 ns_set
//}

//The ns_set field is an index into the ns_set array of the constant pool. The value of ns_set cannot be zero.
//ns_set是在 constant_pool.ns_set_info_v 中的id
//ns_set不能是 0

//0x1D can be considered a GenericName multiname, and is declared as such: 

//[Kind] [TypeDefinition] [ParamCount] [Param1] [Param2] [ParamN] 

//Where 
//[TypeDefinition] is a U30 into the multiname table 
//[ParamCount] is a U8 (U30?) of how many parameters there are 
//[ParamX] is a U30 into the multiname table. 
package zero.swf.avm2{
	import flash.utils.Dictionary;
	
	import zero.swf.utils.nameComplexString;
	import zero.swf.utils.nameGroupString;

	public class ABCMultiname{
		
		public var kind:int;							//direct_int
		public var ns:ABCNamespace;
		public var name:String;
		public var ns_set:ABCNs_set;
		public var TypeDefinition:ABCMultiname;
		public var ParamV:Vector.<ABCMultiname>;
		//
		public function ABCMultiname(str:String=null,_initByXMLOptions:Object=null){
			if(str||str===""){
				initByStr(str,_initByXMLOptions);
			}
		}
		
		public function toStr(_toXMLOptions:Object):String{
			
			if(kind==MultinameKinds.GenericName){
				return checkAndGetGenericNameStr(this,_toXMLOptions,true);
			}
			
			if(kind==MultinameKinds.QName){
				var str:String="";
			}else{
				str="["+MultinameKinds.kindV[kind]+"]";
			}
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
					if(ns){
						if(_toXMLOptions&&_toXMLOptions.toStrDict){
							var nsStr:String=_toXMLOptions.toStrDict[ns];
							if(nsStr||nsStr===""){
							}else{
								_toXMLOptions.toStrDict[ns]=nsStr=ns.toStr(_toXMLOptions);
							}
						}else{
							nsStr=ns.toStr(_toXMLOptions);
						}
						str+=nsStr;
						if(str){
							str+=".";
						}
					}else{
						str+="(ns=undefined).";
					}
					
					if(name||name===""){
						str+=nameComplexString.escape(name);
					}else{
						str+="(name=undefined)";
					}
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					if(ns_set){
						if(_toXMLOptions&&_toXMLOptions.toStrDict){
							var ns_setStr:String=_toXMLOptions.toStrDict[ns_set];
							if(ns_setStr||ns_setStr===""){
							}else{
								_toXMLOptions.toStrDict[ns_set]=ns_setStr=ns_set.toStr(_toXMLOptions);
							}
						}else{
							ns_setStr=ns_set.toStr(_toXMLOptions);
						}
						str+=ns_setStr+".";
					}else{
						str+="(ns_set=undefined).";
					}
					
					if(name||name===""){
						str+=nameComplexString.escape(name);
					}else{
						str+="(name=undefined)";
					}
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					if(name||name===""){
						str+=nameComplexString.escape(name);
					}else{
						str+="(name=undefined)";
					}
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					if(ns_set){
						if(_toXMLOptions&&_toXMLOptions.toStrDict){
							ns_setStr=_toXMLOptions.toStrDict[ns_set];
							if(ns_setStr||ns_setStr===""){
							}else{
								_toXMLOptions.toStrDict[ns_set]=ns_setStr=ns_set.toStr(_toXMLOptions);
							}
						}else{
							ns_setStr=ns_set.toStr(_toXMLOptions);
						}
						str+=ns_setStr+".";
					}else{
						str+="(ns_set=undefined).";
					}
				break;
			}
			
			return str;
			
		}
		public function initByStr(str:String,_initByXMLOptions:Object):void{
			
			str=nameGroupString.escape(str);
			
			if(str.indexOf("[")==0){
				//可能是 multinameKind，也可能是 QName 的  ns.kind
				var id:int=str.indexOf("]");
				kind=MultinameKinds[str.substr(1,id-1)];
				if(kind>0){
					str=str.substr(id+1);
				}else{
					kind=MultinameKinds.QName;
				}
			}else{
				kind=MultinameKinds.QName;
			}
			
			switch(kind){
				case MultinameKinds.QName:
				case MultinameKinds.QNameA:
					if(str.indexOf("(ns=undefined).")==0){
						ns=null;
						str=str.replace("(ns=undefined).","");
					}else{
						var dotId:int=str.lastIndexOf(".");
						if(dotId==-1){
							var nsStr:String="";
						}else{
							nsStr=str.substr(0,dotId);
							str=str.substr(dotId+1);
						}
						if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
							ns=_initByXMLOptions.initByStrMark["~ns~"+nsStr];
							if(ns){
							}else{
								_initByXMLOptions.initByStrMark["~ns~"+nsStr]=ns=new ABCNamespace(nsStr,_initByXMLOptions);
							}
						}else{
							ns=new ABCNamespace(nsStr,_initByXMLOptions);
						}
					}
					
					if(str=="(name=undefined)"){
						name=null;
					}else{
						name=nameComplexString.unescape(str);
					}
				break;
				case MultinameKinds.Multiname:
				case MultinameKinds.MultinameA:
					if(str.indexOf("(ns_set=undefined).")==0){
						ns_set=null;
						str=str.replace("(ns_set=undefined).","");
					}else{
						dotId=str.lastIndexOf("].")+1;
						var ns_setStr:String=str.substr(0,dotId);
						if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
							ns_set=_initByXMLOptions.initByStrMark["~ns_set~"+ns_setStr];
							if(ns_set){
							}else{
								_initByXMLOptions.initByStrMark["~ns_set~"+ns_setStr]=ns_set=new ABCNs_set(ns_setStr,_initByXMLOptions);
							}
						}else{
							ns_set=new ABCNs_set(ns_setStr,_initByXMLOptions);
						}
						str=str.substr(dotId+1);
					}
					
					if(str=="(name=undefined)"){
						name=null;
					}else{
						name=nameComplexString.unescape(str);
					}
				break;
				case MultinameKinds.RTQName:
				case MultinameKinds.RTQNameA:
					if(str=="(name=undefined)"){
						name=null;
					}else{
						name=nameComplexString.unescape(str);
					}
				break;
				case MultinameKinds.RTQNameL:
				case MultinameKinds.RTQNameLA:
					//
				break;
				case MultinameKinds.MultinameL:
				case MultinameKinds.MultinameLA:
					if(str=="(ns_set=undefined)."){
						ns_set=null;
					}else{
						ns_setStr=str.substr(0,str.length-1);
						if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
							ns_set=_initByXMLOptions.initByStrMark["~ns_set~"+ns_setStr];
							if(ns_set){
							}else{
								_initByXMLOptions.initByStrMark["~ns_set~"+ns_setStr]=ns_set=new ABCNs_set(ns_setStr,_initByXMLOptions);
							}
						}else{
							ns_set=new ABCNs_set(ns_setStr,_initByXMLOptions);
						}
					}
				break;
				case MultinameKinds.GenericName:
					
					if(str=="(recursiveGenericName)"){
						//循环指向的 GenericName
						TypeDefinition=null;
						ParamV=null;
					}
					
					//var execResult:Array=/^\(recursiveGenericNameId=(\d+)\)$/.exec(str);
					//if(execResult){
					//	//循环指向的 GenericName
					//	var recursiveGenericNameId:int=int(execResult[1]);
					//	if(_initByXMLOptions&&_initByXMLOptions.initByStrRecursiveGenericNames){
					//		this=_initByXMLOptions.initByStrRecursiveGenericNames.v[recursiveGenericNameId];
					//	}else{
					//		outputCodeError(str+"，缺少 _initByXMLOptions.initByStrRecursiveGenericNames.v");
					//	}
					//}
					
					dotId=str.indexOf(".<");
					var execResult:Array=[str.substr(0,dotId),str.substr(dotId+1)];
					if(execResult[0]=="(TypeDefinition=undefined)"){
						TypeDefinition=null;
					}else{
						if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
							TypeDefinition=_initByXMLOptions.initByStrMark["~multiname~"+execResult[0]];
							if(TypeDefinition){
							}else{
								_initByXMLOptions.initByStrMark["~multiname~"+execResult[0]]=TypeDefinition=new ABCMultiname(execResult[0],_initByXMLOptions);
							}
						}else{
							TypeDefinition=new ABCMultiname(execResult[0],_initByXMLOptions);
						}
					}
					if(execResult[1]=="<>(ParamV=undefined)"){
						ParamV=null;
					}else{
						execResult[1]=execResult[1].replace(/^<([\s\S]*)>$/,"$1");
						var i:int=-1;
						ParamV=new Vector.<ABCMultiname>();
						for each(var ParamsStr:String in nameGroupString.separate(execResult[1])){
							if(ParamsStr=="(Param=undefined)"){
								var Param:ABCMultiname=null;
							}else{
								if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
									Param=_initByXMLOptions.initByStrMark["~multiname~"+ParamsStr];
									if(Param){
									}else{
										_initByXMLOptions.initByStrMark["~multiname~"+ParamsStr]=Param=new ABCMultiname(ParamsStr,_initByXMLOptions);
									}
								}else{
									Param=new ABCMultiname(ParamsStr,_initByXMLOptions);
								}
							}
							ParamV[++i]=Param;
						}
					}
				break;
			}
			
		}
		
		internal static function checkAndGetGenericNameStr(genericName0:ABCMultiname,_toXMLOptions:Object,check:Boolean):String{//20130424
			
			var str:String="[GenericName]";
			
			if(check){
				
				var dict:Dictionary=new Dictionary();
				var seed:Array=[genericName0];
				while(seed.length){
					
					var newSeed:Array=new Array();
					
					for each(var genericName:ABCMultiname in seed){
						if(dict[genericName]){
							//循环指向的 GenericName
							
							if(_toXMLOptions&&_toXMLOptions.toStrRecursiveGenericNames){
								
								if(_toXMLOptions.toStrRecursiveGenericNames.idDict[genericName0]>-1){
								}else{
									_toXMLOptions.toStrRecursiveGenericNames.idDict[genericName0]=_toXMLOptions.toStrRecursiveGenericNames.v.length;
								}
								_toXMLOptions.toStrRecursiveGenericNames.v.push(genericName0);
								
								str+="(recursiveGenericNameId="+_toXMLOptions.toStrRecursiveGenericNames.idDict[genericName0]+")";
								
							}else{
								
								str+="(recursiveGenericName)";
								
							}
							
							return str;
							
						}
						dict[genericName]=true;
						if(genericName.TypeDefinition){
							if(genericName.TypeDefinition.kind==MultinameKinds.GenericName){
								newSeed.push(genericName.TypeDefinition);
							}
							for each(var Param:ABCMultiname in genericName.ParamV){
								if(Param){
									if(Param.kind==MultinameKinds.GenericName){
										newSeed.push(Param);
									}
								}
							}
						}
					}
					
					seed=newSeed;
					
				}
				
			}
			
			if(genericName0.TypeDefinition){
				if(_toXMLOptions&&_toXMLOptions.toStrDict){
					var multinameStr:String=_toXMLOptions.toStrDict[genericName0.TypeDefinition];
					if(multinameStr||multinameStr===""){
					}else{
						_toXMLOptions.toStrDict[genericName0.TypeDefinition]=multinameStr=genericName0.TypeDefinition.toStr(_toXMLOptions);
					}
				}else{
					multinameStr=genericName0.TypeDefinition.toStr(_toXMLOptions);
				}
				str+=multinameStr+".";
			}else{
				str+="(TypeDefinition=undefined).";
			}
			if(genericName0.ParamV){
				var count:int=genericName0.ParamV.length;
				if(count){
					var ParamsStr:String="";
					for each(Param in genericName0.ParamV){
						if(Param){
							if(_toXMLOptions&&_toXMLOptions.toStrDict){
								multinameStr=_toXMLOptions.toStrDict[Param];
								if(multinameStr||multinameStr===""){
								}else{
									_toXMLOptions.toStrDict[Param]=multinameStr=Param.toStr(_toXMLOptions);
								}
							}else{
								multinameStr=Param.toStr(_toXMLOptions);
							}
							ParamsStr+=","+multinameStr;
						}else{
							ParamsStr+=",(Param=undefined)";
						}
					}
					str+="<"+ParamsStr.substr(1)+">";
				}else{
					str+="<>(ParamV=undefined)";
				}
			}else{
				str+="<>(ParamV=undefined)";
			}
			
			return str;
		}
		
		private static function outputCodeError(msg:String):void{
			throw new Error(msg);
		}
		
		public static function test20130419():void{
			
			var str:String="[GenericName]__AS3__.vec.Vector.<>";
			trace("str="+str);
			var multiname:ABCMultiname=new ABCMultiname(str);
			trace("multiname.ParamV.length="+multiname.ParamV.length);
			trace("multiname.toStr(null)="+multiname.toStr(null));
			
			str="";
			trace("str="+str);
			multiname=new ABCMultiname(str);
			trace("multiname.toStr(null)="+multiname.toStr(null));
			
			str="(2)";
			trace("str="+str);
			multiname=new ABCMultiname(str);
			trace("multiname.toStr(null)="+multiname.toStr(null));
			
			multiname=new ABCMultiname();
			multiname.kind=MultinameKinds.MultinameL;
			str=multiname.toStr(null);
			trace("str="+str);
			multiname=new ABCMultiname(str);
			trace("multiname.toStr(null)="+multiname.toStr(null));
			
			multiname=new ABCMultiname();
			multiname.kind=MultinameKinds.GenericName;
			str=multiname.toStr(null);
			trace("str="+str);
			multiname=new ABCMultiname(str);
			trace("multiname.toStr(null)="+multiname.toStr(null));
			
			str="[GenericName]__AS3__.vec.Vector.<zero.swf.Tag>";
			trace("str="+str);
			multiname=new ABCMultiname(str);
			trace("multiname.toStr(null)="+multiname.toStr(null));
			
			str="[GenericName].<>";
			trace("str="+str);
			multiname=new ABCMultiname(str);
			trace("multiname.toStr(null)="+multiname.toStr(null));
			
		}
	}
}
