/***
Tags
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月9日 09:18:42
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	import zero.output;
	import zero.outputError;
	
	public class Tags{
		public static function getRealFrameCount(
			tagV:Vector.<Tag>,
			FrameCount:int=-1//如果传入，表示需要检测是否正确
		):int{
			var realFrameCount:int=0;
			for each(var tag:Tag in tagV){
				if(tag.type==TagTypes.ShowFrame){
					realFrameCount++;
				}
			}
			
			if(FrameCount>-1){
				if(FrameCount==realFrameCount){
				}else{
					//realFrameCount==0 多见于 连接了 AS2 类的 DefineSprite
					if(realFrameCount){
						output("FrameCount="+FrameCount+" 不正确\n修正为："+realFrameCount,"brown");
					}
				}
			}
			
			return realFrameCount;
		}
		public static function getTagsByData(tagV:Vector.<Tag>,data:ByteArray,offset:int,endOffset:int,unknownTagV:Vector.<Tag>):void{
			while(offset<endOffset){
				var tag:Tag=new Tag();
				tagV[tagV.length]=tag;
				tag.initByData(data,offset);
				offset=tag.bodyOffset+tag.bodyLength;
				
				if(TagTypes.typeNameV[tag.type]){
				}else{
					if(unknownTagV){
						unknownTagV.push(tag);
					}else{
						outputError("未知 type："+tag.type+"，typeName="+TagTypes.typeNameV[tag.type]);
					}
				}
				
				if(tag.type==TagTypes.End){
					break;
				}
			}
			
			if(offset==endOffset){
			}else{
				output("getTagsByData offset="+offset+"，endOffset="+endOffset+"，offset!=endOffset","brown");
				if(offset>endOffset){
					tag.bodyLength+=endOffset-offset;
					output("修正最后一个 tag：tag.bodyLength="+tag.bodyLength,"brown");
				}else{
					outputError("offset="+offset+"，endOffset="+endOffset+"，offset!=endOffset");
				}
			}
		}
		
		public static function initByData_step(
			tagV:Vector.<Tag>,
			tagId:int,
			tagCount:int,
			timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 initByData_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
			_initByDataOptions:Object
		):int{
			if(_initByDataOptions&&_initByDataOptions.optionV){
			}else{
				return tagCount;
			}
			var t:int=getTimer();
			while(getTimer()-t<timeLimit){
				if(tagId<tagCount){
					var tag:Tag=tagV[tagId];
					if(tag.type<256){
						var _option:String=_initByDataOptions.optionV[tag.type]
					}else{
						_option="字节码";
					}
					switch(_option){
						case "数据块（仅位置）":
						case "数据块（字节码）":
						case "仅位置":
						case "字节码":
							//trace("忽略");
						break;
						case "结构":
							var TagBodyClassName:String="zero.swf.tagBodys."+TagTypes.typeNameV[tag.type];
							tag.getBody((_initByDataOptions.classes&&_initByDataOptions.classes[TagBodyClassName]||getDefinitionByName(TagBodyClassName)) as Class,_initByDataOptions);
						break;
						default:
							throw new Error("未知 option："+_initByDataOptions.optionV[tag.type]);
						break;
					}
					tagId++;
				}else{
					return tagCount;
				}
			}
			
			//trace("tagId="+tagId);
			
			return tagId;
		}
		
		public static function toData_step(
			tagV:Vector.<Tag>,
			tagsData:ByteArray,
			tagId:int,
			tagCount:int,
			timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 initByData_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
			_toDataOptions:Object
		):int{
			var t:int=getTimer();
			while(getTimer()-t<timeLimit){
				if(tagId<tagCount){
					var tag:Tag=tagV[tagId];
					tagsData.writeBytes(tag.toData(_toDataOptions));
					tagId++;
				}else{
					return tagCount;
				}
			}
			
			return tagId;
		}
		
		CONFIG::USE_XML{
				
			import zero.BytesAndStr16;
			
			public static function toXML_step(
				tagV:Vector.<Tag>,
				tagsXML:XML,
				tagId:int,
				tagCount:int,
				timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 toXML_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
				_toXMLOptions:Object
			):int{
				var t:int=getTimer();
				while(getTimer()-t<timeLimit){
					if(tagId<tagCount){
						var tag:Tag=tagV[tagId];
							
						if(tag.type<256){
							if(_toXMLOptions&&_toXMLOptions.optionV){
								
								var option:String=_toXMLOptions.optionV[tag.type];
								//trace(TagTypes.typeNameV[tag.type],option);
								if(_toXMLOptions.checkNeedStructure){//20130308
									if(option=="结构"){
										if(_toXMLOptions.checkNeedStructure(tag)){
										}else{
											option=_toXMLOptions.noNeedStructureOption||"字节码";
											tag.setBody(null);
										}
									}
								}
								
							}else{
								option="字节码";
							}
						}else{
							option="字节码";
						}
						
						switch(option){
							case "数据块（仅位置）":
								var lastTag:Tag=tag;
								var currBlockOption:String=option;
								if(_toXMLOptions.swfSrc){
									while(++tagId<tagCount){
										if(tagV[tagId].type<256){
											
											option=_toXMLOptions.optionV[tagV[tagId].type];
											
											if(_toXMLOptions.checkNeedStructure){//20130308
												if(option=="结构"){
													if(_toXMLOptions.checkNeedStructure(tagV[tagId])){
													}else{
														option=_toXMLOptions.noNeedStructureOption||"字节码";
														tagV[tagId].setBody(null);
													}
												}
											}
											
											if(currBlockOption==option){
											}else{
												break;
											}
										}else{
											break;
										}
										lastTag=tagV[tagId];
									}
									var blockSize:int=lastTag.bodyOffset+lastTag.bodyLength-tag.headOffset;
									tagsXML.appendChild(
										<block
											swfSrc={_toXMLOptions.swfSrc}
											offset={tag.headOffset}
											length={blockSize}
										/>
									);
								}else{
									var currSrc:String=_toXMLOptions.getSWFSrcFun(tag.getBodyData());
									while(++tagId<tagCount){
										if(tagV[tagId].type<256){
											
											option=_toXMLOptions.optionV[tagV[tagId].type];
											
											if(_toXMLOptions.checkNeedStructure){//20130308
												if(option=="结构"){
													if(_toXMLOptions.checkNeedStructure(tagV[tagId])){
													}else{
														option=_toXMLOptions.noNeedStructureOption||"字节码";
														tagV[tagId].setBody(null);
													}
												}
											}
											
											if(currBlockOption==option){
												if(currSrc==_toXMLOptions.getSWFSrcFun(tag.getBodyData())){
												}else{
													break;
												}
											}else{
												break;
											}
										}else{
											break;
										}
										lastTag=tagV[tagId];
									}
									blockSize=lastTag.bodyOffset+lastTag.bodyLength-tag.headOffset;
									tagsXML.appendChild(
										<block
											swfSrc={currSrc}
											offset={tag.headOffset}
											length={blockSize}
										/>
									);
								}
							break;
							case "数据块（字节码）":
								lastTag=tag;
								currBlockOption=option;
								var blockData:ByteArray=tag.getBodyData();
								while(++tagId<tagCount){
									if(tagV[tagId].type<256){
										
										option=_toXMLOptions.optionV[tagV[tagId].type];
										
										if(_toXMLOptions.checkNeedStructure){//20130308
											if(option=="结构"){
												if(_toXMLOptions.checkNeedStructure(tagV[tagId])){
												}else{
													option=_toXMLOptions.noNeedStructureOption||"字节码";
													tagV[tagId].setBody(null);
												}
											}
										}
										
										if(currBlockOption==option){
											if(blockData==tag.getBodyData()){
											}else{
												break;
											}
										}
									}else{
										break;
									}
									lastTag=tagV[tagId];
								}
								blockSize=lastTag.bodyOffset+lastTag.bodyLength-tag.headOffset;
								tagsXML.appendChild(
									<block
										length={blockSize}//此处 length 只用于查看，真正的 length 以 value 的长度为准
										value={
											BytesAndStr16.bytes2str16(
												blockData,
												tag.headOffset,
												blockSize
											)
										}
									/>
								);
							break;
							case "仅位置":
							case "字节码":
							case "结构":
								//if(option=="结构"){
								//	trace("忽略");
								//}
								var tagXML:XML=tag.toXML(_toXMLOptions);
								if(_toXMLOptions&&_toXMLOptions.addToXMLInfos){
									if(tag.type==TagTypes.ShowFrame){
										_toXMLOptions.addToXMLInfos(tag,tagXML);
									}
								}
								tagsXML.appendChild(tagXML);
								
								tagId++;
							break;
							default:
								throw new Error("未知 option："+option);
							break;
						}
					}else{
						return tagCount;
					}
				}
				
				return tagId;
			}
			////
			
			////
			public static function initByXML_step(
				tagV:Vector.<Tag>,
				nodeXMLList:XMLList,
				nodeId:int,
				nodeCount:int,
				timeLimit:int,//20110606 主要用于 DefineSprite 和 SWF 中减少瞬时调用 initByXML_step 的次数，以提高运行速度，对 SWFProgresser 基本不影响
				_initByXMLOptions:Object
			):int{
				var t:int=getTimer();
				while(getTimer()-t<timeLimit){
					if(nodeId<nodeCount){
						var nodeXML:XML=nodeXMLList[nodeId];
						switch(nodeXML.name().toString()){
							case "block":
								var block_data_value:String=nodeXML.@value.toString();
								if(block_data_value){
									var block_data:ByteArray=BytesAndStr16.str162bytes(block_data_value);
									var block_data_offset:int=0;
									var block_data_endOffset:int=block_data.length;
								}else{
									var swfSrc:String=nodeXML.@swfSrc.toString();
									if(swfSrc){
										if(_initByXMLOptions){
										}else{
											throw new Error("需要提供 _initByXMLOptions");
										}
										block_data=_initByXMLOptions.swfResData||_initByXMLOptions.getSWFResDataFun(swfSrc);
									}else{
										var src:String=nodeXML.@src.toString();
										if(src){
											if(_initByXMLOptions){
											}else{
												throw new Error("需要提供 _initByXMLOptions");
											}
											block_data=_initByXMLOptions.resData||_initByXMLOptions.getResDataFun(src);
										}else{
											block_data=null;
										}
									}
									if(block_data){
										var offsetXML:XML=nodeXML.@offset[0];
										if(offsetXML){
											block_data_offset=int(offsetXML.toString());
										}else{
											block_data_offset=0;//20110928
										}
										var lengthXML:XML=nodeXML.@length[0];
										if(lengthXML){
											block_data_endOffset=block_data_offset+int(lengthXML.toString());
										}else{
											block_data_endOffset=block_data.length;//20110928
										}
									}else{
										block_data=new ByteArray();
										block_data_offset=0;
										block_data_endOffset=0;
									}
								}
								
								getTagsByData(tagV,block_data,block_data_offset,block_data_endOffset,null);
							break;
							default:
								var tag:Tag=new Tag();
								tag.initByXML(nodeXML,_initByXMLOptions);
								tagV[tagV.length]=tag;
							break;
						}
						nodeId++;
					}else{
						return nodeCount;
					}
				}
				return nodeId;
			}
			////
			
		}//end of CONFIG::USE_XML
	}
}
		