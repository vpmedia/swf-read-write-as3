/***
Method_body_info
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月15日 13:32:49（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
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

//The max_stack field is maximum number of evaluation stack slots used at any point during the execution
//of this body.

//The local_count field is the index of the highest-numbered local register this method will use, plus one.

//The init_scope_depth field defines the minimum scope depth, relative to max_scope_depth, that may
//be accessed within the method.

//The max_scope_depth field defines the maximum scope depth that may be accessed within the method.
//The difference between max_scope_depth and init_scope_depth determines the size of the local scope
//stack.

//The value of code_length is the number of bytes in the code array. The code array holds AVM2
//instructions for this method body. The AVM2 instruction set is defined in Section 2.5.

//The value of exception_count is the number of elements in the exception array. The exception array
//associates exception handlers with ranges of instructions within the code array (see below).

//The value of trait_count is the number of elements in the trait array. The trait array contains all
//the traits for this method body (see above for more information on traits).
package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	import zero.swf.BytesData;
	
	public class Method_body_info{
		public var method:int;							//u30
		public var max_stack:int;						//u30
		public var local_count:int;						//u30
		public var init_scope_depth:int;				//u30
		public var max_scope_depth:int;					//u30
		
		public var codes:BytesData;
		public var exception_infoV:Vector.<Exception_info>;
		public var traits_infoV:Vector.<Traits_info>;
		//
		
		public function Method_body_info(){
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){method=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{method=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{method=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{method=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{method=data[offset++];}
			//method
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){max_stack=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{max_stack=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{max_stack=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{max_stack=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{max_stack=data[offset++];}
			//max_stack
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){local_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{local_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{local_count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{local_count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{local_count=data[offset++];}
			//local_count
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){init_scope_depth=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{init_scope_depth=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{init_scope_depth=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{init_scope_depth=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{init_scope_depth=data[offset++];}
			//init_scope_depth
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){max_scope_depth=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{max_scope_depth=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{max_scope_depth=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{max_scope_depth=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{max_scope_depth=data[offset++];}
			//max_scope_depth
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var codes_length:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{codes_length=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{codes_length=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{codes_length=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{codes_length=data[offset++];}
			//codes_length
			
			codes=new BytesData();
			offset=codes.initByData(data,offset,offset+codes_length,_initByDataOptions);
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				exception_infoV=new Vector.<Exception_info>(count);
				for(var i:int=0;i<count;i++){
					exception_infoV[i]=new Exception_info();
					offset=exception_infoV[i].initByData(data,offset,endOffset,_initByDataOptions);
				}
			}else{
				exception_infoV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				traits_infoV=new Vector.<Traits_info>(count);
				for(i=0;i<count;i++){
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
			
			if(method>>>7){if(method>>>14){if(method>>>21){if(method>>>28){data[offset++]=(method&0x7f)|0x80;data[offset++]=((method>>>7)&0x7f)|0x80;data[offset++]=((method>>>14)&0x7f)|0x80;data[offset++]=((method>>>21)&0x7f)|0x80;data[offset++]=method>>>28;}else{data[offset++]=(method&0x7f)|0x80;data[offset++]=((method>>>7)&0x7f)|0x80;data[offset++]=((method>>>14)&0x7f)|0x80;data[offset++]=method>>>21;}}else{data[offset++]=(method&0x7f)|0x80;data[offset++]=((method>>>7)&0x7f)|0x80;data[offset++]=method>>>14;}}else{data[offset++]=(method&0x7f)|0x80;data[offset++]=method>>>7;}}else{data[offset++]=method;}
			//method
			
			if(max_stack>>>7){if(max_stack>>>14){if(max_stack>>>21){if(max_stack>>>28){data[offset++]=(max_stack&0x7f)|0x80;data[offset++]=((max_stack>>>7)&0x7f)|0x80;data[offset++]=((max_stack>>>14)&0x7f)|0x80;data[offset++]=((max_stack>>>21)&0x7f)|0x80;data[offset++]=max_stack>>>28;}else{data[offset++]=(max_stack&0x7f)|0x80;data[offset++]=((max_stack>>>7)&0x7f)|0x80;data[offset++]=((max_stack>>>14)&0x7f)|0x80;data[offset++]=max_stack>>>21;}}else{data[offset++]=(max_stack&0x7f)|0x80;data[offset++]=((max_stack>>>7)&0x7f)|0x80;data[offset++]=max_stack>>>14;}}else{data[offset++]=(max_stack&0x7f)|0x80;data[offset++]=max_stack>>>7;}}else{data[offset++]=max_stack;}
			//max_stack
			
			if(local_count>>>7){if(local_count>>>14){if(local_count>>>21){if(local_count>>>28){data[offset++]=(local_count&0x7f)|0x80;data[offset++]=((local_count>>>7)&0x7f)|0x80;data[offset++]=((local_count>>>14)&0x7f)|0x80;data[offset++]=((local_count>>>21)&0x7f)|0x80;data[offset++]=local_count>>>28;}else{data[offset++]=(local_count&0x7f)|0x80;data[offset++]=((local_count>>>7)&0x7f)|0x80;data[offset++]=((local_count>>>14)&0x7f)|0x80;data[offset++]=local_count>>>21;}}else{data[offset++]=(local_count&0x7f)|0x80;data[offset++]=((local_count>>>7)&0x7f)|0x80;data[offset++]=local_count>>>14;}}else{data[offset++]=(local_count&0x7f)|0x80;data[offset++]=local_count>>>7;}}else{data[offset++]=local_count;}
			//local_count
			
			if(init_scope_depth>>>7){if(init_scope_depth>>>14){if(init_scope_depth>>>21){if(init_scope_depth>>>28){data[offset++]=(init_scope_depth&0x7f)|0x80;data[offset++]=((init_scope_depth>>>7)&0x7f)|0x80;data[offset++]=((init_scope_depth>>>14)&0x7f)|0x80;data[offset++]=((init_scope_depth>>>21)&0x7f)|0x80;data[offset++]=init_scope_depth>>>28;}else{data[offset++]=(init_scope_depth&0x7f)|0x80;data[offset++]=((init_scope_depth>>>7)&0x7f)|0x80;data[offset++]=((init_scope_depth>>>14)&0x7f)|0x80;data[offset++]=init_scope_depth>>>21;}}else{data[offset++]=(init_scope_depth&0x7f)|0x80;data[offset++]=((init_scope_depth>>>7)&0x7f)|0x80;data[offset++]=init_scope_depth>>>14;}}else{data[offset++]=(init_scope_depth&0x7f)|0x80;data[offset++]=init_scope_depth>>>7;}}else{data[offset++]=init_scope_depth;}
			//init_scope_depth
			
			if(max_scope_depth>>>7){if(max_scope_depth>>>14){if(max_scope_depth>>>21){if(max_scope_depth>>>28){data[offset++]=(max_scope_depth&0x7f)|0x80;data[offset++]=((max_scope_depth>>>7)&0x7f)|0x80;data[offset++]=((max_scope_depth>>>14)&0x7f)|0x80;data[offset++]=((max_scope_depth>>>21)&0x7f)|0x80;data[offset++]=max_scope_depth>>>28;}else{data[offset++]=(max_scope_depth&0x7f)|0x80;data[offset++]=((max_scope_depth>>>7)&0x7f)|0x80;data[offset++]=((max_scope_depth>>>14)&0x7f)|0x80;data[offset++]=max_scope_depth>>>21;}}else{data[offset++]=(max_scope_depth&0x7f)|0x80;data[offset++]=((max_scope_depth>>>7)&0x7f)|0x80;data[offset++]=max_scope_depth>>>14;}}else{data[offset++]=(max_scope_depth&0x7f)|0x80;data[offset++]=max_scope_depth>>>7;}}else{data[offset++]=max_scope_depth;}
			//max_scope_depth
			
			var codesData:ByteArray=codes.toData(_toDataOptions);
			var codes_length:int=codesData.length;
			if(codes_length>>>7){if(codes_length>>>14){if(codes_length>>>21){if(codes_length>>>28){data[offset++]=(codes_length&0x7f)|0x80;data[offset++]=((codes_length>>>7)&0x7f)|0x80;data[offset++]=((codes_length>>>14)&0x7f)|0x80;data[offset++]=((codes_length>>>21)&0x7f)|0x80;data[offset++]=codes_length>>>28;}else{data[offset++]=(codes_length&0x7f)|0x80;data[offset++]=((codes_length>>>7)&0x7f)|0x80;data[offset++]=((codes_length>>>14)&0x7f)|0x80;data[offset++]=codes_length>>>21;}}else{data[offset++]=(codes_length&0x7f)|0x80;data[offset++]=((codes_length>>>7)&0x7f)|0x80;data[offset++]=codes_length>>>14;}}else{data[offset++]=(codes_length&0x7f)|0x80;data[offset++]=codes_length>>>7;}}else{data[offset++]=codes_length;}
			//codes_length
			
			data.position=offset;
			data.writeBytes(codesData);
			offset=data.length;
			
			if(exception_infoV){
				var count:int=exception_infoV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					data.position=offset;
					for each(var exception_info:Exception_info in exception_infoV){
						data.writeBytes(exception_info.toData(_toDataOptions));
					}
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(traits_infoV){
				count=traits_infoV.length;
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
				method={method}
				max_stack={max_stack}
				local_count={local_count}
				init_scope_depth={init_scope_depth}
				max_scope_depth={max_scope_depth}
			/>;
			
			xml.appendChild(codes.toXML("codes",_toXMLOptions));
			
			if(exception_infoV){
				var count:int=exception_infoV.length;
				if(count){
					var childXML:XML=<exception_infoV count={count}/>;
					for each(var exception_info:Exception_info in exception_infoV){
						childXML.appendChild(exception_info.toXML("exception_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(traits_infoV){
				count=traits_infoV.length;
				if(count){
					childXML=<traits_infoV count={count}/>;
					for each(var traits_info:Traits_info in traits_infoV){
						childXML.appendChild(traits_info.toXML("traits_info",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			method=int(xml.@method.toString());
			max_stack=int(xml.@max_stack.toString());
			local_count=int(xml.@local_count.toString());
			init_scope_depth=int(xml.@init_scope_depth.toString());
			max_scope_depth=int(xml.@max_scope_depth.toString());
			
			codes=new BytesData();
			codes.initByXML(xml.codes[0],_initByXMLOptions);
			
			var list:XMLList=xml.exception_infoV.exception_info;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				exception_infoV=new Vector.<Exception_info>(count);
				for each(var childXML:XML in list){
					exception_infoV[++i]=new Exception_info();
					exception_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				exception_infoV=null;
			}
			
			list=xml.traits_infoV.traits_info;
			count=list.length();
			if(count){
				i=-1;
				traits_infoV=new Vector.<Traits_info>(count);
				for each(childXML in list){
					traits_infoV[++i]=new Traits_info();
					traits_infoV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				traits_infoV=null;
			}
			
		}
		
	}
}
