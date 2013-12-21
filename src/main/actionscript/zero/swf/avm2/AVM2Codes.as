/***
AVM2Codes 版本:v1.0
简要说明:这家伙很懒什么都没写
创建人:ZЁЯ¤  身高:168cm+;体重:57kg+;未婚(已有女友);最爱的运动:睡觉;格言:路见不平,拔腿就跑;QQ:358315553
创建时间:2010年11月8日 14:28:59
历次修改:未有修改
用法举例:这家伙很懒什么都没写
*/

package zero.swf.avm2{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import zero.BytesAndStr16;
	import zero.output;
	import zero.swf.utils.stringComplexString;
	
	public class AVM2Codes{
		
		public var codeArr:Array;
		
		public function AVM2Codes(){
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			var str:String=toStr(_toXMLOptions);
			if(str){
				return new XML("<"+xmlName+" class=\"zero.swf.avm2.AVM2Codes\"><![CDATA[\n"+
					str.replace(/\]\]\>/g,"\\]\\]\\>")
					+"\t\t\t\t]]></"+xmlName+">");
			}
			return <{xmlName}/>;
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			initByStr(xml.toString(),_initByXMLOptions);
		}
		
		public function toStr(_toXMLOptions:Object):String{
			
			if(codeArr&&codeArr.length){
				
				var labelId:int=-1;
				var labelIdDict:Dictionary=new Dictionary();
				for each(var code:Object in codeArr){
					if(code.op>-1){
					}else{
						//label
						labelIdDict[code]=++labelId;
					}
				}
				
				var str:String="";
				
				for each(code in codeArr){
					if(code.ownData&&code.pos>-1&&code.dataLen>0){
						if(_toXMLOptions&&_toXMLOptions.ActionsOutputPos){
							str+="\t\t\t\t\t//pos="+code.pos+"\n";
						}
						if(code.info){
							str+=code.info.replace(/(.+)/g,"\t\t\t\t\t//$1");
						}
						//str+="\t\t\t\t\t"+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.dataLen)+"\n";//个别很长的数据会引起代码块过大
					}else if(code.op>-1){
						if(AVM2Ops.nameV[code.op]){
							if(_toXMLOptions&&_toXMLOptions.ActionsOutputPos){
								if(code.pos>-1){
									str+="\t\t\t\t\t//pos="+code.pos+"\n";
								}else{
									str+="\t\t\t\t\t//（无 pos）\n";
								}
							}
							if(code.info){
								str+=code.info.replace(/(.+)/g,"\t\t\t\t\t//$1");
							}
							if(_toXMLOptions&&_toXMLOptions.ActionsGetHexArr){
								if(code.ownData&&code.pos>-1){
									str+="\t\t\t\t\t//"+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.length)+"\n";
								}else{
									str+="\t\t\t\t\t//（无 hex）\n";
								}
							}
							/*if(code.stackTop===undefined){
							}else{
								str+="\t\t\t\t\t//stackTop="+code.stackTop+"\n";
								//str+="\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t//stackTop="+code.stackTop;
							}*/
							
							str+="\t\t\t\t\t"+AVM2Ops.nameV[code.op];
							switch(AVM2Ops.valueTypeV[code.op]){
								case "":
									//
								break;
								case "registerid":
									str+=" registerid="+code.registerid;
								break;
								case "slotid":
									str+=" slotid="+code.slotid;
								break;
								case "scopeid":
									str+=" scopeid="+code.scopeid;
								break;
								case "linenum":
									str+=" linenum="+code.linenum;
								break;
								
								case "integerid":
									str+=" "+code.integer;
								break;
								case "uintegerid":
									str+=" "+code.uinteger;
								break;
								case "doubleid":
									str+=" "+code.double;
								break;
								case "stringid":
									str+=" \""+stringComplexString.escape(code.string)+"\"";
								break;
								case "namespaceid":
									var ns:ABCNamespace=code.namespace;
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
									}else{
										nsStr="(undefined)";
									}
									str+=" "+nsStr;
								break;
								case "multinameid":
									var multiname:ABCMultiname=code.multiname;
									if(multiname){
										if(_toXMLOptions&&_toXMLOptions.toStrDict){
											var multinameStr:String=_toXMLOptions.toStrDict[multiname];
											if(multinameStr||multinameStr===""){
											}else{
												_toXMLOptions.toStrDict[multiname]=multinameStr=multiname.toStr(_toXMLOptions);
											}
										}else{
											multinameStr=multiname.toStr(_toXMLOptions);
										}
									}else{
										multinameStr="(undefined)";
									}
									str+=" "+multinameStr;
								break;
								
								case "methodid":
									if(code.method){
										if(_toXMLOptions&&_toXMLOptions.abcclassesValues){
											var functionStr:String=_toXMLOptions.abcclassesValues.dict[code.method];
											if(functionStr){
											}else{
												functionStr=code.method.toMarkStr(_toXMLOptions);
												//计算 copyId
												if(_toXMLOptions.abcclassesValues.mark[functionStr]){
													var copyId:int=1;
													while(_toXMLOptions.abcclassesValues.mark[functionStr+"("+(++copyId)+")"]){};
													functionStr+="("+copyId+")";
												}
												//
												_toXMLOptions.abcclassesValues.dict[code.method]=functionStr;
												_toXMLOptions.abcclassesValues.mark[functionStr]=code.method;
												_toXMLOptions.abcclassesValues.v.push(code.method);
											}
										}else{
											functionStr=code.method.toMarkStr(_toXMLOptions);
										}
									}else{
										functionStr="(undefined)";
									}
									str+=" "+functionStr;
								break;
								case "exceptionid":
									if(labelIdDict[code.from]>-1){
									}else{
										outputCodeError("找不到 code.from 对应的位置");
									}
									if(labelIdDict[code.to]>-1){
									}else{
										outputCodeError("找不到 code.to 对应的位置");
									}
									if(labelIdDict[code.target]>-1){
									}else{
										outputCodeError("找不到 code.target 对应的位置");
									}
									str+=" from=label"+labelIdDict[code.from]+
										" to=label"+labelIdDict[code.to]+
										" target=label"+labelIdDict[code.target];
									
									multiname=code.exc_type;
									if(multiname){
										if(_toXMLOptions&&_toXMLOptions.toStrDict){
											multinameStr=_toXMLOptions.toStrDict[multiname];
											if(multinameStr||multinameStr===""){
											}else{
												_toXMLOptions.toStrDict[multiname]=multinameStr=multiname.toStr(_toXMLOptions);
											}
										}else{
											multinameStr=multiname.toStr(_toXMLOptions);
										}
									}else{
										multinameStr="(undefined)";
									}
									
									str+=" exc_type="+multinameStr;
									
									multiname=code.var_name;
									if(multiname){
										if(_toXMLOptions&&_toXMLOptions.toStrDict){
											multinameStr=_toXMLOptions.toStrDict[multiname];
											if(multinameStr||multinameStr===""){
											}else{
												_toXMLOptions.toStrDict[multiname]=multinameStr=multiname.toStr(_toXMLOptions);
											}
										}else{
											multinameStr=multiname.toStr(_toXMLOptions);
										}
									}else{
										multinameStr="(undefined)";
									}
									
									str+=" var_name="+multinameStr;
								break;
								case "classid":
									
									multiname=code["class"];
									if(multiname){
										if(_toXMLOptions&&_toXMLOptions.toStrDict){
											multinameStr=_toXMLOptions.toStrDict[multiname];
											if(multinameStr||multinameStr===""){
											}else{
												_toXMLOptions.toStrDict[multiname]=multinameStr=multiname.toStr(_toXMLOptions);
											}
										}else{
											multinameStr=multiname.toStr(_toXMLOptions);
										}
									}else{
										multinameStr="(undefined)";
									}
									
									str+=" "+multinameStr;
								break;
								
								case "arg_count":
									str+=" "+code.arg_count;
								break;
								
								case "offset":
									if(labelIdDict[code.label]>-1){
									}else{
										///*//临时分析时可以直接注掉，将会输出：jump/if_ labelundefined
										outputCodeError("找不到 code.label 对应的位置");
										//*/output("找不到 code.label 对应的位置","brown");
									}
									str+=" label"+labelIdDict[code.label];
								break;
								
								case "registerid,registerid":
									str+=" registerid1="+code.registerid1+" registerid2="+code.registerid2;
								break;
								case "multinameid,arg_count":
									
									multiname=code.multiname;
									if(multiname){
										if(_toXMLOptions&&_toXMLOptions.toStrDict){
											multinameStr=_toXMLOptions.toStrDict[multiname];
											if(multinameStr||multinameStr===""){
											}else{
												_toXMLOptions.toStrDict[multiname]=multinameStr=multiname.toStr(_toXMLOptions);
											}
										}else{
											multinameStr=multiname.toStr(_toXMLOptions);
										}
									}else{
										multinameStr="(undefined)";
									}
									
									str+=" "+multinameStr+" "+code.arg_count;
								break;
								case "dispid,arg_count":
									str+=" dispid="+code.dispid+" "+code.arg_count;
								break;
								case "methodid,arg_count":
									if(code.method){
										if(_toXMLOptions&&_toXMLOptions.abcclassesValues){
											functionStr=_toXMLOptions.abcclassesValues.dict[code.method];
											if(functionStr){
											}else{
												functionStr=code.method.toMarkStr(_toXMLOptions);
												//计算 copyId
												if(_toXMLOptions.abcclassesValues.mark[functionStr]){
													copyId=1;
													while(_toXMLOptions.abcclassesValues.mark[functionStr+"("+(++copyId)+")"]){};
													functionStr+="("+copyId+")";
												}
												//
												_toXMLOptions.abcclassesValues.dict[code.method]=functionStr;
												_toXMLOptions.abcclassesValues.mark[functionStr]=code.method;
												_toXMLOptions.abcclassesValues.v.push(code.method);
											}
										}else{
											functionStr=code.method.toMarkStr(_toXMLOptions);
										}
									}else{
										functionStr="(undefined)";
									}
									str+=" "+functionStr+" "+code.arg_count;
								break;
								case "sbyte":
									str+=" "+code.byte;
								break;
								case "sshort":
									str+=" "+code.short;
								break;
								case "debug_type,index,reg,extra":
									str+=" debug_type="+code.debug_type+" index=\""+stringComplexString.escape(code.index)+"\" reg="+code.reg+" extra="+code.extra;
								break;
								case "default_offset,case_count,case_offsets...":
									var case_offsetsStr:String="";
									for each(var case_offset:Object in code.case_offsetArr){
										case_offsetsStr+=",label"+labelIdDict[case_offset];
									}
									str+=
										" default_offset=label"+labelIdDict[code.default_offset]+
										" case_offsets="+case_offsetsStr.substr(1);
								break;
								default:
									outputCodeError("未知 valueType："+AVM2Ops.valueTypeV[code.op]);
								break;
							}//end of switch(AVM2Ops.valueTypeV[code.op])...
							str+="\n";
							
						}else{
							outputCodeError("未知 op 0x"+BytesAndStr16._16V[code.op]);
						}//end of if(AVM2Ops.nameV[code.op])...else...
						
					}else{
						//label
						if(code.info){
							str+=code.info.replace(/(.+)/g,"\t\t\t\t//$1");
						}
						/*if(code.stackTop===undefined){
						}else{
							str+="\t\t\t\t\t//stackTop="+code.stackTop+"\n";
							//str+="\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t//stackTop="+code.stackTop;
						}*/
						str+="\t\t\t\tlabel"+labelIdDict[code]+":\n";
					}//end of if(code.ownData&&code.pos>-1&&code.dataLen>0)...else if(code.op>-1)...else...
					
				}//end of for each(code in codeArr)...
				
				return str;
			}
			
			return "";
			
		}
		public function initByStr(str:String,_initByXMLOptions:Object):void{
			
			str=("\n"+str)
				.replace(/\s*\n\s*\/\/.*/g,"")
				.replace(/^\s*|\s*$/g,"");
			
			if(str){
				
				var codeStrArr:Array=str.split(/\s*\n\s*/);
				
				var labels:Object=new Object();
				for each(var codeStr:String in codeStrArr){
					execResult=/^(label\d+)\:/.exec(codeStr);
					if(execResult){
						if(labels[execResult[1]]){
							outputCodeError(codeStr+"，重复的 label");
						}else{
							labels[execResult[1]]={};
						}
					}
				}
				
				var codeId:int=-1;
				codeArr=new Array();
				for each(codeStr in codeStrArr){
					var execResult:Array=/^(\w+)([\s\S]*)$/.exec(codeStr);
					if(execResult){
						codeId++;
						
						var code:Object={op:AVM2Ops[execResult[1]]};
						if(code.op>-1){
							var codeStr2:String=execResult[2].replace(/^\s*|\s*$/g,"");
							switch(AVM2Ops.valueTypeV[code.op]){
								case "":
									if(codeStr2){
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，"+AVM2Ops.nameV[code.op]+" 不需要参数");
									}
								break;
								case "registerid":
									execResult=/^(registerid=)?(\w+)$/.exec(codeStr2);
									if(execResult){
										code.registerid=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" registerid=1”）");
									}
								break;
								case "slotid":
									execResult=/^(slotid=)?(\w+)$/.exec(codeStr2);
									if(execResult){
										code.slotid=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" slotid=1”）");
									}
								break;
								case "scopeid":
									execResult=/^(scopeid=)?(\w+)$/.exec(codeStr2);
									if(execResult){
										code.scopeid=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" scopeid=1”）");
									}
								break;
								case "linenum":
									execResult=/^(linenum=)?(\w+)$/.exec(codeStr2);
									if(execResult){
										code.linenum=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" linenum=1”）");
									}
								break;
								case "integerid":
									code.integer=int(codeStr2);
								break;
								case "uintegerid":
									code.uinteger=int(codeStr2);
								break;
								case "doubleid":
									code.double=Number(codeStr2);
								break;
								case "stringid":
									execResult=/("|')([\s\S]*)\1$/.exec(codeStr2);
									if(execResult){
										code.string=stringComplexString.unescape(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" \"mc\"”）");
									}
								break;
								case "namespaceid":
									
									if(codeStr2=="(undefined)"){
										var ns:ABCNamespace=null;
									}else{
										if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
											ns=_initByXMLOptions.initByStrMark["~ns~"+codeStr2];
											if(ns){
											}else{
												_initByXMLOptions.initByStrMark["~ns~"+codeStr2]=ns=new ABCNamespace(codeStr2,_initByXMLOptions);
											}
										}else{
											ns=new ABCNamespace(codeStr2,_initByXMLOptions);
										}
									}
									code.namespace=ns;
									
								break;
								case "multinameid":
									
									if(codeStr2=="(undefined)"){
										var multiname:ABCMultiname=null;
									}else{
										if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
											multiname=_initByXMLOptions.initByStrMark["~multiname~"+codeStr2];
											if(multiname){
											}else{
												_initByXMLOptions.initByStrMark["~multiname~"+codeStr2]=multiname=new ABCMultiname(codeStr2,_initByXMLOptions);
											}
										}else{
											multiname=new ABCMultiname(codeStr2,_initByXMLOptions);
										}
									}
									code.multiname=multiname;
									
								break;
								
								case "methodid":
									if(codeStr2=="(undefined)"){
									}else{
										if(_initByXMLOptions&&_initByXMLOptions.abcclassesValues){
											code.method=_initByXMLOptions.abcclassesValues.functions[codeStr2];
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，缺少 _initByXMLOptions.abcclassesValues.functions");
										}
									}
								break;
								case "exceptionid":
									execResult=/^from=(label\d+)\s+to=(label\d+)\s+target=(label\d+)\s+exc_type=([\s\S]*)\s+var_name=([\s\S]*)$/.exec(codeStr2);
									if(execResult){
										if(labels[execResult[1]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[1]+" 对应的位置");
										}
										code.from=labels[execResult[1]];
										if(labels[execResult[2]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[2]+" 对应的位置");
										}
										code.to=labels[execResult[2]];
										if(labels[execResult[3]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[3]+" 对应的位置");
										}
										code.target=labels[execResult[3]];
										
										if(execResult[4]=="(undefined)"){
											multiname=null;
										}else{
											if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
												multiname=_initByXMLOptions.initByStrMark["~multiname~"+execResult[4]];
												if(multiname){
												}else{
													_initByXMLOptions.initByStrMark["~multiname~"+execResult[4]]=multiname=new ABCMultiname(execResult[4],_initByXMLOptions);
												}
											}else{
												multiname=new ABCMultiname(execResult[4],_initByXMLOptions);
											}
										}
										code.exc_type=multiname;
										
										if(execResult[5]=="(undefined)"){
											multiname=null;
										}else{
											if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
												multiname=_initByXMLOptions.initByStrMark["~multiname~"+execResult[5]];
												if(multiname){
												}else{
													_initByXMLOptions.initByStrMark["~multiname~"+execResult[5]]=multiname=new ABCMultiname(execResult[5],_initByXMLOptions);
												}
											}else{
												multiname=new ABCMultiname(execResult[5],_initByXMLOptions);
											}
										}
										code.var_name=multiname;
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" from=label5 to=label6 target=label7 exc_type=Error var_name=e”）");
									}
								break;
								case "classid":
									
									if(codeStr2=="(undefined)"){
										multiname=null;
									}else{
										if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
											multiname=_initByXMLOptions.initByStrMark["~multiname~"+codeStr2];
											if(multiname){
											}else{
												_initByXMLOptions.initByStrMark["~multiname~"+codeStr2]=multiname=new ABCMultiname(codeStr2,_initByXMLOptions);
											}
										}else{
											multiname=new ABCMultiname(codeStr2,_initByXMLOptions);
										}
									}
									code["class"]=multiname;
									
								break;
								
								case "arg_count":
									code.arg_count=int(codeStr2);
								break;
								
								case "offset":
									if(/^label\d+$/.test(codeStr2)){
										if(labels[codeStr2]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+codeStr2+" 对应的位置");
										}
										code.label=labels[codeStr2];
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" label0”）");
									}
								break;
								
								case "registerid,registerid":
									execResult=/^(registerid1=)?(\w+)\s+(registerid2=)?(\w+)$/.exec(codeStr2);
									if(execResult){
										code.registerid1=int(execResult[2]);
										code.registerid2=int(execResult[4]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" registerid1=1 registerid2=2”）");
									}
								break;
								case "multinameid,arg_count":
									execResult=/^([\s\S]*)\s+(\w+)$/.exec(codeStr2);
									if(execResult){
										
										if(execResult[1]=="(undefined)"){
											multiname=null;
										}else{
											if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
												multiname=_initByXMLOptions.initByStrMark["~multiname~"+execResult[1]];
												if(multiname){
												}else{
													_initByXMLOptions.initByStrMark["~multiname~"+execResult[1]]=multiname=new ABCMultiname(execResult[1],_initByXMLOptions);
												}
											}else{
												multiname=new ABCMultiname(execResult[1],_initByXMLOptions);
											}
										}
										code.multiname=multiname;
										
										code.arg_count=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" fun 0”）");
									}
								break;
								case "dispid,arg_count":
									execResult=/^(dispid=)?(\w+)\s+(\w+)$/.exec(codeStr2);
									if(execResult){
										code.dispid=int(execResult[2]);
										code.arg_count=int(execResult[3]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" disp=1 0”）");
									}
								break;
								case "methodid,arg_count":
									execResult=/^([\s\S]*)\s+(\w+)$/.exec(codeStr2);
									if(execResult){
										if(codeStr2=="(undefined)"){
										}else{
											if(_initByXMLOptions&&_initByXMLOptions.abcclassesValues){
												code.method=_initByXMLOptions.abcclassesValues.functions[execResult[1]];
											}else{
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，缺少 _initByXMLOptions.abcclassesValues.functions");
											}
										}
										code.arg_count=int(execResult[2]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" function fun():void 0”）");
									}
								break;
								case "sbyte":
									code.byte=int(codeStr2);
								break;
								case "sshort":
									code.short=int(codeStr2);
								break;
								case "debug_type,index,reg,extra":
									execResult=/^debug_type=(\w+)\s+index=("|')([\s\S]*)\2\s+reg=(\w+)\s+extra=(\w+)$/.exec(codeStr2);
									if(execResult){
										code.debug_type=int(execResult[1]);
										code.index=stringComplexString.unescape(execResult[3]);
										code.reg=int(execResult[4]);
										code.extra=int(execResult[5]);
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" debug_type=1 index=\"output\" reg=0 extra=478”）");
									}
								break;
								case "default_offset,case_count,case_offsets...":
									execResult=/^default_offset=(label\d+)\s+case_offsets=([\s\S]*)$/.exec(codeStr2);
									if(execResult){
										if(labels[execResult[1]]){
										}else{
											outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+execResult[1]+" 对应的位置");
										}
										code.default_offset=labels[execResult[1]];
										code.case_offsetArr=execResult[2].match(/label\d+/g);
										var i:int=code.case_offsetArr.length;
										while(--i>=0){
											if(labels[code.case_offsetArr[i]]){
											}else{
												outputCodeError("codeArr["+codeId+"] "+codeStr+"，找不到 "+code.case_offsetArr[i]+" 对应的位置");
											}
											code.case_offsetArr[i]=labels[code.case_offsetArr[i]];
										}
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，格式不正确（例子：“"+AVM2Ops.nameV[code.op]+" default_offset=label3 case_offsets=label0,label1,label2”）");
									}
								break;
								default:
									outputCodeError("codeArr["+codeId+"] "+codeStr+"，未知 valueType："+AVM2Ops.valueTypeV[code.op]);
								break;
							}//end of switch(AVM2Ops.valueTypeV[code.op])...
							
						}else{
							execResult=/^(label\d+)\:/.exec(codeStr);
							if(execResult){
								code=labels[execResult[1]];
							}else{
								if(/^([0-9a-fA-F]{2}\s+)+$/.test(codeStr+" ")){
									output("使用 ByteArray 进行记录的未知代码："+codeStr,"brown");
									code={ownData:BytesAndStr16.str162bytes(codeStr),pos:0};
									code.op=code.ownData[0];
									code.dataLen=code.ownData.length;
								}else{
									if(/^(label\d+)$/.test(codeStr)){
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，貌似缺少“:”（应该为：“"+codeStr+":”）");
									}else{
										outputCodeError("codeArr["+codeId+"] "+codeStr+"，未知 op");
									}
								}
							}
						}//end of if(code.op>-1)...else...
						
						codeArr[codeId]=code;
					}else{
						codeId++;
						outputCodeError("codeArr["+codeId+"] "+codeStr+"，未知  code");
					}//end of if(execResult)...else...
					
				}//end of for each(codeStr in codeStrArr)...
			}else{
				codeArr=null;
			}
		}
		
		private static function outputCodeError(msg:String):void{
			throw new Error(msg);
		}
		
		public static function test20130419():void{
			
			var codeStr:String="getlex  ";
			trace("codeStr="+codeStr);
			var execResult:Array=/^(\w+)([\s\S]*)$/.exec(codeStr);
			trace("execResult="+execResult);
			
			var codeStr2:String="  0";
			trace("codeStr2="+codeStr2);
			execResult=/^([\s\S]*)\s+(\w+)$/.exec(codeStr2);
			trace("execResult="+execResult);
			
		}
		
	}
}
