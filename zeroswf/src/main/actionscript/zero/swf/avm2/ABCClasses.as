/***
ABCClasses
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月16日 10:15:45（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The constant pool is a block of array-based entries(entry 条目) that reflect the constants used by all methods.
//Each of the count entries (for example, int_count) must be one more than the number of entries in the corresponding
//array, 
//每个条目数组的 count 都是比数组长度多1(1表示0,2表示1,...因为0表示了特别的意义，下面有提及)
//and the first entry in the array is element "1". 
//For all constant pools, the index "0" has a special meaning,
//typically a sensible default value. For example, the "0" entry is used to represent the empty sting (""), the any
//namespace, or the any type (*) depending on the context it is used in. When "0" has a special meaning it is
//described in the text below.

//cpool_info
//{
//	u30 			int_count
//	s32 			integer[int_count]
//	u30 			uint_count
//	u32 			uinteger[uint_count]
//	u30 			double_count
//	d64 			double[double_count]
//	u30 			string_count
//	string_info 	string[string_count]
//	u30 			namespace_count
//	namespace_info 	namespace[namespace_count]
//	u30 			ns_set_count
//	ns_set_info 	ns_set[ns_set_count]
//	u30 			multiname_count
//	multiname_info 	multiname[multiname_count]
//}

//The value of int_count is the number of entries in the integer array, plus one. The integer array
//holds integer constants referenced by the bytecode. The "0" entry of the integer array is not present in
//the abcFile; it represents the zero value for the purposes of providing values for optional parameters and
//field initialization.

//The value of uint_count is the number of entries in the uinteger array, plus one. The uinteger array
//holds unsigned integer constants referenced by the bytecode. The "0" entry of the uinteger array is not
//present in the abcFile; it represents the zero value for the purposes of providing values for optional
//parameters and field initialization.

//The value of double_count is the number of entries in the double array, plus one. The double array
//holds IEEE double-precision floating point constants referenced by the bytecode. 
//The "0" entry of the double array is not present in the abcFile; it represents the NaN (Not-a-Number) value for the purposes of providing values for optional parameters and field initialization.
//0 代表 NaN	

//The value of string_count is the number of entries in the string array, plus one. The string array
//holds UTF-8 encoded strings referenced by the compiled code and by many other parts of the abcFile.
//In addition to describing string constants in programs, string data in the constant pool are used in the
//description of names of many kinds. Entry "0" of the string array is not present in the abcFile; it
//represents the empty string in most contexts but is also used to represent the "any" name in others
//(known as "*" in ActionScript).

//The value of namespace_count is the number of entries in the namespace array, plus one. The
//namespace array describes the namespaces used by the bytecode and also for names of many kinds. Entry
//"0" of the namespace array is not present in the abcFile; it represents the "any" namespace (known as
//"*" in ActionScript).

//The value of ns_set_count is the number of entries in the ns_set array, plus one. The ns_set array
//describes namespace sets used in the descriptions of multinames. The "0" entry of the ns_set array is not
//present in the abcFile.

//The value of multiname_count is the number of entries in the multiname array, plus one. The
//multiname array describes names used by the bytecode. The "0" entry of the multiname array is not
//present in the abcFile.

//abcFile
//{
//	u16 				minor_version

//	u16 				major_version
//	cpool_info 			constant_pool
//	u30 				method_count
//	method_info 		method[method_count]
//	u30 				metadata_count
//	metadata_info 		metadata[metadata_count]
//	u30 				class_count
//	instance_info 		instance[class_count]
//	class_info 			class[class_count]
//	u30 				script_count
//	script_info 		script[script_count]
//	u30 				method_body_count
//	method_body_info	method_body[method_body_count]
//}

//The values of major_version and minor_version are the major and minor version numbers of the
//abcFile format. A change in the minor version number signifies a change in the file format that is
//backward compatible, in the sense that an implementation of the AVM2 can still make use of a file of an
//older version. A change in the major version number denotes an incompatible adjustment to the file
//format.
//As of the publication of this overview, the major version is 46 and the minor version is 16.
//minor_version一般就是16
//major_version一般就是46

//The constant_pool is a variable length structure composed of integers, doubles, strings, namespaces,
//namespace sets, and multinames. These constants are referenced from other parts of the abcFile
//structure.
//常量池

//The value of method_count is the number of entries in the method array. Each entry in the method array
//is a variable length method_info structure. The array holds information about every method defined in
//this abcFile. The code for method bodies is held separately in the method_body array (see below).
//Some entries in method may have no body—this is the case for native methods, for example.

//The value of metadata_count is the number of entries in the metadata array. Each metadata entry is a
//metadata_info structure that maps a name to a set of string values.

//The value of class_count is the number of entries in the instance and class arrays.

//Each instance entry is a variable length instance_info structure which specifies the characteristics of
//object instances created by a particular class.

//Each class entry defines the characteristics of a class. It is used in conjunction with the instance field to
//derive a full description of an AS Class.

//The value of script_count is the number of entries in the script array.

//Each script entry is a script_info structure that defines the characteristics of a single script in this file. As explained in the
//previous chapter, the last entry in this array is the entry point for execution in the abcFile.

//The value of method_body_count is the number of entries in the method_body array. Each method_body

//entry consists of a variable length method_body_info structure which contains the instructions for an
//individual method or function.
package zero.swf.avm2{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	import zero.BytesAndStr16;
	import zero.output;
	import zero.outputError;
	import zero.swf.BytesData;
	import zero.swf.utils.getAllTraitsAndMethods;
	
	public class ABCClasses{
		
		public var minor_version:int;
		public var major_version:int;
		
		public var classV:Vector.<ABCClass>;
		public var scriptV:Vector.<ABCScript>;
		
		//仅用于 initByData 后立即使用，一般以 classV 和 sciprtV 内的为准
		public var allNsV:Vector.<ABCNamespace>;//20130213
		public var allNs_setV:Vector.<ABCNs_set>;//20130213
		public var allMultinameV:Vector.<ABCMultiname>;//20120222
		public var allMethodV:Vector.<ABCMethod>;//20130205
		
		public function ABCClasses(){
			
		}
		
		public function initByData(data:ByteArray,offset:int,endOffset:int,_initByDataOptions:Object):int{
			
			minor_version=data[offset++]|(data[offset++]<<8);
			
			major_version=data[offset++]|(data[offset++]<<8);
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				var integerV:Vector.<int>=new Vector.<int>(count);
				integerV.fixed=true;
				for(var i:int=1;i<count;i++){
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{integerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{integerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{integerV[i]=data[offset++];}
				}
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				var uintegerV:Vector.<int>=new Vector.<int>(count);
				uintegerV.fixed=true;
				for(i=1;i<count;i++){
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{uintegerV[i]=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{uintegerV[i]=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{uintegerV[i]=data[offset++];}
				}
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				var doubleV:Vector.<Number>=new Vector.<Number>(count);
				doubleV.fixed=true;
				data.endian=Endian.LITTLE_ENDIAN;
				data.position=offset;
				for(i=1;i<count;i++){
					doubleV[i]=data.readDouble();
				}
				offset=data.position;
			}
			
			data.position=offset;
			var stringV:Vector.<String>=Strings.read(data,null);
			//for each(var string:String in stringV){
			//	trace("string="+string);
			//	if(string==null){
			//	}else{
			//		trace("string.length="+string.length);
			//	}
			//}
			offset=data.position;
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				allNsV=new Vector.<ABCNamespace>(count);
				allNsV.fixed=true;
				for(i=1;i<count;i++){
					var ns:ABCNamespace=allNsV[i]=new ABCNamespace();
					ns.kind=data[offset++];
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var u30:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
					if(stringV){
						if(u30>0&&u30<stringV.length){
							ns.name=stringV[u30];
						}
					}
					//trace("ns："+ns.toStr(null));
				}
			}else{
				allNsV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				allNs_setV=new Vector.<ABCNs_set>(count);
				allNs_setV.fixed=true;
				for(i=1;i<count;i++){
					var ns_set:ABCNs_set=allNs_setV[i]=new ABCNs_set();
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count2:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count2=data[offset++];}
					if(count2){
						ns_set.nsV=new Vector.<ABCNamespace>(count2);
						for(var j:int=0;j<count2;j++){
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(allNsV){
								if(u30>0&&u30<allNsV.length){
									ns_set.nsV[j]=allNsV[u30];
								}
							}
						}
					}else{
						ns_set.nsV=null;
					}
					//trace("ns_set："+ns_set.toStr(null));
				}
			}else{
				allNs_setV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count>1){
				allMultinameV=new Vector.<ABCMultiname>(count);
				allMultinameV.fixed=true;
				for(i=1;i<count;i++){
					allMultinameV[i]=new ABCMultiname();
				}
				for(i=1;i<count;i++){
					var multiname:ABCMultiname=allMultinameV[i];
					multiname.kind=data[offset++];
					switch(multiname.kind){
						case MultinameKinds.QName:
						case MultinameKinds.QNameA:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(allNsV){
								if(u30>0&&u30<allNsV.length){
									multiname.ns=allNsV[u30];
								}
							}
							
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(stringV){
								if(u30>0&&u30<stringV.length){
									multiname.name=stringV[u30];
								}
							}
						break;
						case MultinameKinds.Multiname:
						case MultinameKinds.MultinameA:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(stringV){
								if(u30>0&&u30<stringV.length){
									multiname.name=stringV[u30];
								}
							}
							
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(allNs_setV){
								if(u30>0&&u30<allNs_setV.length){
									multiname.ns_set=allNs_setV[u30];
								}
							}
						break;
						case MultinameKinds.RTQName:
						case MultinameKinds.RTQNameA:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(stringV){
								if(u30>0&&u30<stringV.length){
									multiname.name=stringV[u30];
								}
							}
						break;
						case MultinameKinds.RTQNameL:
						case MultinameKinds.RTQNameLA:
							//
						break;
						case MultinameKinds.MultinameL:
						case MultinameKinds.MultinameLA:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(allNs_setV){
								if(u30>0&&u30<allNs_setV.length){
									multiname.ns_set=allNs_setV[u30];
								}
							}
						break;
						case MultinameKinds.GenericName:
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
							if(allMultinameV){
								if(u30>0&&u30<allMultinameV.length){
									multiname.TypeDefinition=allMultinameV[u30];
								}
							}
							
							if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count2=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count2=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count2=data[offset++];}
							if(count2){
								multiname.ParamV=new Vector.<ABCMultiname>(count2);
								for(j=0;j<count2;j++){
									if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{u30=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{u30=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{u30=data[offset++];}
									if(allMultinameV){
										if(u30>0&&u30<allMultinameV.length){
											multiname.ParamV[j]=allMultinameV[u30];
										}
									}
								}
							}else{
								multiname.ParamV=null;
							}
						break;
					}
					//trace("multiname："+multiname.toStr(null));
				}
			}else{
				allMultinameV=null;
			}
			
			var constantItemArr:Array=new Array();
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				allMethodV=new Vector.<ABCMethod>(count);
				allMethodV.fixed=true;
				var method_info:Method_info=new Method_info();
				for(i=0;i<count;i++){
					offset=method_info.initByData(data,offset,endOffset,_initByDataOptions);
					
					var method:ABCMethod=allMethodV[i]=new ABCMethod();
					
					if(allMultinameV){
						if(method_info.return_type>0&&method_info.return_type<allMultinameV.length){
							method.return_type=allMultinameV[method_info.return_type];
						}
					}
					
					if(method_info.param_typeV){
						count2=method_info.param_typeV.length;
						if(count2){
							j=-1;
							method.param_typeV=new Vector.<ABCMultiname>(count2);
							for each(var param_type:int in method_info.param_typeV){
								if(allMultinameV){
									if(param_type>0&&param_type<allMultinameV.length){
										method.param_typeV[++j]=allMultinameV[param_type];
									}else{
										j++;
									}
								}else{
									j++;
								}
							}
						}
					}
					
					if(stringV){
						if(method_info.name>0&&method_info.name<stringV.length){
							method.name=stringV[method_info.name];
						}
					}
					
					method.NeedArguments=method_info.NeedArguments;
					method.NeedActivation=method_info.NeedActivation;
					method.NeedRest=method_info.NeedRest;
					method.SetDxns=method_info.SetDxns;
					
					if(method_info.option_detailV){
						count2=method_info.option_detailV.length;
						if(count2){
							j=-1;
							method.option_detailV=new Vector.<ABCConstantItem>(count2);
							for each(var option_detail:Option_detail in method_info.option_detailV){
								constantItemArr.push([
									method.option_detailV[++j]=new ABCConstantItem(),
									option_detail.kind,option_detail.val
								]);
							}
						}
					}
					
					if(method_info.param_nameV){
						count2=method_info.param_nameV.length;
						if(count2){
							j=-1;
							method.param_nameV=new Vector.<String>(count2);
							for each(var param_name:int in method_info.param_nameV){
								if(stringV){
									if(param_name>0&&param_name<stringV.length){
										method.param_nameV[++j]=stringV[param_name];
									}else{
										j++;
									}
								}else{
									j++;
								}
								
							}
						}
					}
					
				}
			}//else{
			//	allMethodV=null;
			//}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				var allMetadataV:Vector.<ABCMetadata>=new Vector.<ABCMetadata>(count);
				allMetadataV.fixed=true;
				var metadata_info:Metadata_info=new Metadata_info();
				for(i=0;i<count;i++){
					offset=metadata_info.initByData(data,offset,endOffset,_initByDataOptions);
					
					var metadata:ABCMetadata=allMetadataV[i]=new ABCMetadata();
					if(stringV){
						if(metadata_info.name>0&&metadata_info.name<stringV.length){
							metadata.name=stringV[metadata_info.name];
						}
					}
					if(metadata_info.item_infoV){
						count2=metadata_info.item_infoV.length;
						if(count2){
							j=-1;
							metadata.itemV=new Vector.<Array>(count2);
							for each(var item_info:Array in metadata_info.item_infoV){
								if(stringV){
									if(item_info[0]>0&&item_info[0]<stringV.length){
										metadata.itemV[++j]=[stringV[item_info[0]]];
									}else{
										metadata.itemV[++j]=[null];
									}
									if(item_info[1]>0&&item_info[1]<stringV.length){
										metadata.itemV[j][1]=stringV[item_info[1]];
									}else{
										metadata.itemV[j][1]=null;
									}
								}else{
									metadata.itemV[++j]=[null,null];
								}
							}
						}
					}
					
				}
			}//else{
			//	allMetadataV=null;
			//}
			
			var traitArr:Array=new Array();
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				classV=new Vector.<ABCClass>(count);
				
				var instance_info:Instance_info=new Instance_info();
				for(i=0;i<count;i++){
					offset=instance_info.initByData(data,offset,endOffset,_initByDataOptions);
					
					var clazz:ABCClass=classV[i]=new ABCClass();
					if(allMultinameV){
						if(instance_info.name>0&&instance_info.name<allMultinameV.length){
							clazz.name=allMultinameV[instance_info.name];
						}
					}
					if(allMultinameV){
						if(instance_info.super_name>0&&instance_info.super_name<allMultinameV.length){
							clazz.super_name=allMultinameV[instance_info.super_name];
						}
					}
					clazz.ClassSealed=instance_info.ClassSealed;
					clazz.ClassFinal=instance_info.ClassFinal;
					clazz.ClassInterface=instance_info.ClassInterface;
					if(allNsV){
						if(instance_info.protectedNs>0&&instance_info.protectedNs<allNsV.length){
							clazz.protectedNs=allNsV[instance_info.protectedNs];
						}
					}
					if(instance_info.intrfV){
						count2=instance_info.intrfV.length;
						if(count2){
							j=-1;
							clazz.intrfV=new Vector.<ABCMultiname>(count2);
							for each(var intrf:int in instance_info.intrfV){
								if(allMultinameV){
									if(intrf>0&&intrf<allMultinameV.length){
										clazz.intrfV[++j]=allMultinameV[intrf];
									}else{
										j++;
									}
								}else{
									j++;
								}
							}
						}
					}
					if(allMethodV){
						if(instance_info.iinit>-1&&instance_info.iinit<allMethodV.length){
							clazz.iinit=allMethodV[instance_info.iinit];
						}
					}
					if(instance_info.itraits_infoV){
						count2=instance_info.itraits_infoV.length;
						if(count2){
							j=-1;
							clazz.itraitV=new Vector.<ABCTrait>(count2);
							for each(var traits_info:Traits_info in instance_info.itraits_infoV){
								traitArr.push([
									clazz.itraitV[++j]=new ABCTrait(),
									traits_info
								]);
							}
						}
					}
					
				}
				
				var class_info:Class_info=new Class_info();
				for each(clazz in classV){
					offset=class_info.initByData(data,offset,endOffset,_initByDataOptions);
					
					if(allMethodV){
						if(class_info.cinit>-1&&class_info.cinit<allMethodV.length){
							clazz.cinit=allMethodV[class_info.cinit];
						}
					}
					if(class_info.ctraits_infoV){
						count2=class_info.ctraits_infoV.length;
						if(count2){
							j=-1;
							clazz.ctraitV=new Vector.<ABCTrait>(count2);
							for each(traits_info in class_info.ctraits_infoV){
								traitArr.push([
									clazz.ctraitV[++j]=new ABCTrait(),
									traits_info
								]);
							}
						}
					}
					
				}
				
			}else{
				classV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				scriptV=new Vector.<ABCScript>(count);
				
				var script_info:Script_info=new Script_info();
				for(i=0;i<count;i++){
					offset=script_info.initByData(data,offset,endOffset,_initByDataOptions);
					var script:ABCScript=scriptV[i]=new ABCScript();
					if(allMethodV){
						if(script_info.init>-1&&script_info.init<allMethodV.length){
							script.init=allMethodV[script_info.init];
						}
					}
					if(script_info.traits_infoV){
						count2=script_info.traits_infoV.length;
						if(count2){
							j=-1;
							script.traitV=new Vector.<ABCTrait>(count2);
							for each(traits_info in script_info.traits_infoV){
								traitArr.push([
									script.traitV[++j]=new ABCTrait(),
									traits_info]
								);
							}
						}
					}
				}
			}else{
				scriptV=null;
			}
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			if(count){
				var method_body_info:Method_body_info=new Method_body_info();
				for(i=0;i<count;i++){
					offset=method_body_info.initByData(data,offset,endOffset,_initByDataOptions);
					
					if(allMethodV){
						if(method_body_info.method>-1&&method_body_info.method<allMethodV.length){
							method=allMethodV[method_body_info.method];
							//trace("method.name="+method.name);
							
							method.max_stack=method_body_info.max_stack;
							method.local_count=method_body_info.local_count;
							method.init_scope_depth=method_body_info.init_scope_depth;
							method.max_scope_depth=method_body_info.max_scope_depth;
							
							var codesData:ByteArray=method_body_info.codes.ownData;
							
							var codeOffset:int=method_body_info.codes.dataOffset;
							var codeEndOffset:int=method_body_info.codes.dataOffset+method_body_info.codes.dataLength;
							
							if(codeOffset<codeEndOffset){
								
								var startPos:int=codeOffset;
								
								var labelByPosArr:Array=new Array();
								var codeByPosArr:Array=new Array();
								
								while(codeOffset<codeEndOffset){
									
									var code:Object=codeByPosArr[codeOffset]={
										ownData:codesData,
										pos:codeOffset,
										op:codesData[codeOffset],
										info:""
									};
									
									if(AVM2Ops.nameV[code.op]){
										codeOffset++;
										switch(AVM2Ops.dataTypeV[code.op]){
											case "":
												//
											break;
											case "u30":
												if(codesData[codeOffset]>>>7){if(codesData[codeOffset+1]>>>7){if(codesData[codeOffset+2]>>>7){if(codesData[codeOffset+3]>>>7){var value1:int=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|((codesData[codeOffset++]&0x7f)<<21)|(codesData[codeOffset++]<<28);}else{value1=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|(codesData[codeOffset++]<<21);}}else{value1=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|(codesData[codeOffset++]<<14);}}else{value1=(codesData[codeOffset++]&0x7f)|(codesData[codeOffset++]<<7);}}else{value1=codesData[codeOffset++];}
												//value1
											break;
											case "u30,u30":
												if(codesData[codeOffset]>>>7){if(codesData[codeOffset+1]>>>7){if(codesData[codeOffset+2]>>>7){if(codesData[codeOffset+3]>>>7){value1=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|((codesData[codeOffset++]&0x7f)<<21)|(codesData[codeOffset++]<<28);}else{value1=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|(codesData[codeOffset++]<<21);}}else{value1=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|(codesData[codeOffset++]<<14);}}else{value1=(codesData[codeOffset++]&0x7f)|(codesData[codeOffset++]<<7);}}else{value1=codesData[codeOffset++];}
												//value1
												if(codesData[codeOffset]>>>7){if(codesData[codeOffset+1]>>>7){if(codesData[codeOffset+2]>>>7){if(codesData[codeOffset+3]>>>7){var value2:int=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|((codesData[codeOffset++]&0x7f)<<21)|(codesData[codeOffset++]<<28);}else{value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|(codesData[codeOffset++]<<21);}}else{value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|(codesData[codeOffset++]<<14);}}else{value2=(codesData[codeOffset++]&0x7f)|(codesData[codeOffset++]<<7);}}else{value2=codesData[codeOffset++];}
												//value2
											break;
											case "s24":
												value1=codesData[codeOffset++]|(codesData[codeOffset++]<<8)|(codesData[codeOffset++]<<16);
												if(value1&0x00800000){value1|=0xff000000}//最高位为1,表示负数
												var offsetPos:int=codeOffset+value1;
												if(offsetPos<startPos){
													code.info+="不合法的偏移量："+(offsetPos-startPos)+"\n";
													offsetPos=codeEndOffset;
												}else if(offsetPos>codeEndOffset){
													code.info+=AVM2Ops.nameV[code.op]+"，offsetPos="+offsetPos+" 超出范围，修正为："+codeEndOffset+"\n";
													offsetPos=codeEndOffset;
												}
												code.label=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
											break
											case "u8":
												value1=codesData[codeOffset++];
											break;
											case "u8,u30,u8,u30":
												//
											break;
											case "s24,u30,s24[count+1]":
												//
											break;
											default:
												outputCodeError("未知 dataType："+AVM2Ops.dataTypeV[code.op]);
											break;
										}//end of switch(AVM2Ops.dataTypeV[code.op])...
										switch(AVM2Ops.valueTypeV[code.op]){
											case "":
												//
											break;
											case "registerid":
												code.registerid=value1;
											break;
											case "slotid":
												code.slotid=value1;
											break;
											case "scopeid":
												code.scopeid=value1;
											break;
											case "linenum":
												code.linenum=value1;
											break;
											
											case "integerid":
												if(integerV){
													if(value1>0&&value1<integerV.length){
														code.integer=integerV[value1];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "uintegerid":
												if(uintegerV){
													if(value1>0&&value1<uintegerV.length){
														code.uinteger=uintegerV[value1];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "doubleid":
												if(doubleV){
													if(value1>0&&value1<doubleV.length){
														code.double=doubleV[value1];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "stringid":
												if(stringV){
													if(value1>0&&value1<stringV.length){
														code.string=stringV[value1];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "namespaceid":
												if(allNsV){
													if(value1>0&&value1<allNsV.length){
														code.namespace=allNsV[value1];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "multinameid":
												if(allMultinameV){
													if(value1>0&&value1<allMultinameV.length){
														code.multiname=allMultinameV[value1];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											
											case "methodid":
												if(allMethodV){
													if(value1>-1&&value1<allMethodV.length){
														code.method=allMethodV[value1];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "exceptionid":
												if(method_body_info.exception_infoV){
													if(value1>-1&&value1<method_body_info.exception_infoV.length){
														var exception_info:Exception_info=method_body_info.exception_infoV[value1];
														offsetPos=startPos+exception_info.from;
														code.from=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
														offsetPos=startPos+exception_info.to;
														code.to=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
														offsetPos=startPos+exception_info.target;
														code.target=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
														if(exception_info.exc_type>0&&exception_info.exc_type<allMultinameV.length){
															code.exc_type=allMultinameV[exception_info.exc_type];
														}
														if(exception_info.var_name>0&&exception_info.var_name<allMultinameV.length){
															code.var_name=allMultinameV[exception_info.var_name];
														}
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "classid":
												if(classV){
													if(value1>-1&&value1<classV.length){
														code["class"]=classV[value1].name;
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											
											case "arg_count":
												code.arg_count=value1;
											break;
											
											case "offset":
												//
											break;
											
											case "registerid,registerid":
												code.registerid1=value1;
												code.registerid2=value2;
											break;
											case "multinameid,arg_count":
												if(allMultinameV){
													if(value1>0&&value1<allMultinameV.length){
														code.multiname=allMultinameV[value1];
														code.arg_count=value2;
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "dispid,arg_count":
												code.dispid=value1;
												code.arg_count=value2;
											break;
											case "methodid,arg_count":
												if(allMethodV){
													if(value1>-1&&value1<allMethodV.length){
														code.method=allMethodV[value1];
														code.arg_count=value2;
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
											break;
											case "sbyte":
												if(value1&0x80){value1|=0xffffff00}//最高位为1,表示负数
												code.byte=value1;
											break;
											case "sshort":
												if(value1&0x8000){value1|=0xffff0000}//最高位为1,表示负数
												code.short=value1;
											break;
											case "debug_type,index,reg,extra":
												value1=codesData[codeOffset++];
												if(codesData[codeOffset]>>>7){if(codesData[codeOffset+1]>>>7){if(codesData[codeOffset+2]>>>7){if(codesData[codeOffset+3]>>>7){value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|((codesData[codeOffset++]&0x7f)<<21)|(codesData[codeOffset++]<<28);}else{value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|(codesData[codeOffset++]<<21);}}else{value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|(codesData[codeOffset++]<<14);}}else{value2=(codesData[codeOffset++]&0x7f)|(codesData[codeOffset++]<<7);}}else{value2=codesData[codeOffset++];}
												//value2
												var value3:int=codesData[codeOffset++];
												if(codesData[codeOffset]>>>7){if(codesData[codeOffset+1]>>>7){if(codesData[codeOffset+2]>>>7){if(codesData[codeOffset+3]>>>7){var value4:int=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|((codesData[codeOffset++]&0x7f)<<21)|(codesData[codeOffset++]<<28);}else{value4=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|(codesData[codeOffset++]<<21);}}else{value4=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|(codesData[codeOffset++]<<14);}}else{value4=(codesData[codeOffset++]&0x7f)|(codesData[codeOffset++]<<7);}}else{value4=codesData[codeOffset++];}
												//value4
												code.debug_type=value1;
												if(stringV){
													if(value2>0&&value2<stringV.length){
														code.index=stringV[value2];
													}else{
														code.op=AVM2Ops.nop;
													}
												}else{
													code.op=AVM2Ops.nop;
												}
												code.reg=value3;
												code.extra=value4;
											break;
											case "default_offset,case_count,case_offsets...":
												value1=codesData[codeOffset++]|(codesData[codeOffset++]<<8)|(codesData[codeOffset++]<<16);
												if(value1&0x00800000){value1|=0xff000000}//最高位为1,表示负数
												offsetPos=code.pos+value1;
												if(offsetPos<startPos){
													code.info+="不合法的偏移量："+(offsetPos-startPos)+"\n";
													offsetPos=codeEndOffset;
												}
												code.default_offset=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
												if(codesData[codeOffset]>>>7){if(codesData[codeOffset+1]>>>7){if(codesData[codeOffset+2]>>>7){if(codesData[codeOffset+3]>>>7){value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|((codesData[codeOffset++]&0x7f)<<21)|(codesData[codeOffset++]<<28);}else{value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|((codesData[codeOffset++]&0x7f)<<14)|(codesData[codeOffset++]<<21);}}else{value2=(codesData[codeOffset++]&0x7f)|((codesData[codeOffset++]&0x7f)<<7)|(codesData[codeOffset++]<<14);}}else{value2=(codesData[codeOffset++]&0x7f)|(codesData[codeOffset++]<<7);}}else{value2=codesData[codeOffset++];}
												//value2
												code.case_offsetArr=new Array(value2+1);
												for(j=0;j<=value2;j++){
													value3=codesData[codeOffset++]|(codesData[codeOffset++]<<8)|(codesData[codeOffset++]<<16);
													if(value3&0x00800000){value3|=0xff000000}//最高位为1,表示负数
													offsetPos=code.pos+value3;
													if(offsetPos<startPos){
														code.info+="不合法的偏移量："+(offsetPos-startPos)+"\n";
														offsetPos=codeEndOffset;
													}
													code.case_offsetArr[j]=labelByPosArr[offsetPos]||(labelByPosArr[offsetPos]={pos:offsetPos});
												}
											break;
											default:
												outputCodeError("未知 valueType："+AVM2Ops.valueTypeV[code.op]);
											break;
										}//end of switch(AVM2Ops.valueTypeV[op])...
										
										code.length=codeOffset-code.pos;
										
									}else{
										code.dataLen=1;
										codeOffset+=code.dataLen;
										output("未知 op 0x"+BytesAndStr16._16V[code.op]+"（"+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.dataLen)+"）","brown");
									}//end of if(AVM2Ops.nameV[code.op])...else...
									
								}//end of while(codeOffset<codeEndOffset)...
								
								//labelByPosArr 的最后一个索引最大的合法值是 codeEndOffset
								if((labelByPosArr.length-1)>codeEndOffset){
									outputCodeError("不合法的偏移量："+(labelByPosArr.length-1));
								}
								
								var codeArr:Array=new Array();
								var codeId:int=-1;
								
								for(codeOffset=startPos;codeOffset<codeEndOffset;codeOffset++){
									if(labelByPosArr[codeOffset]){
										if(codeByPosArr[codeOffset]){
											codeArr[++codeId]=labelByPosArr[codeOffset];
											codeArr[++codeId]=codeByPosArr[codeOffset];
										}else{
											
											//outputCodeError("不合法的偏移量："+(codeOffset-startPos));
											
											//20130522
											//发现于某个 returnvalue 后 jump labelx
											labelByPosArr[codeOffset].info="不合法的偏移量："+(codeOffset-startPos)+"\n";
											codeArr[++codeId]=labelByPosArr[codeOffset];
											
										}
									}else if(codeByPosArr[codeOffset]){
										codeArr[++codeId]=codeByPosArr[codeOffset];
									}
								}
								if(labelByPosArr[codeEndOffset]){//可能有的最后一个 label
									codeArr[++codeId]=labelByPosArr[codeEndOffset];
								}
								
								var infos:String="";
								for each(code in codeArr){
									if(code.info){
										infos+=code.info;
									}
								}
								if(infos){
									output(infos,"brown");
								}
								
							}else{
								codeArr=null;
							}
							
							if(codeArr&&codeArr.length){
								if(_initByDataOptions){
									if(_initByDataOptions.optimizeAVM2Codes){
										codeArr=_initByDataOptions.optimizeAVM2Codes(codeArr,_initByDataOptions);
									}
								}
							}
							
							method.codes=new AVM2Codes();
							method.codes.codeArr=codeArr;
							
							if(method_body_info.traits_infoV){
								count2=method_body_info.traits_infoV.length;
								if(count2){
									j=-1;
									method.traitV=new Vector.<ABCTrait>(count2);
									for each(traits_info in method_body_info.traits_infoV){
										traitArr.push([
											method.traitV[++j]=new ABCTrait(),
											traits_info
										]);
									}
								}
							}
							
						}
					}
					
				}
			}
			
			for each(var subArr:Array in traitArr){
				
				var trait:ABCTrait=subArr[0];
				traits_info=subArr[1];
				
				if(allMultinameV){
					if(traits_info.name>0&&traits_info.name<allMultinameV.length){
						trait.name=allMultinameV[traits_info.name];
					}
				}
				
				trait.ATTR_Final=traits_info.ATTR_Final;
				trait.ATTR_Override=traits_info.ATTR_Override;
				
				trait.kind_trait_type=traits_info.kind_trait_type;
				
				switch(trait.kind_trait_type){
					case TraitTypeAndAttributes.Slot:
					case TraitTypeAndAttributes.Const:
						
						trait.slot_id=traits_info.value[0];
						
						if(allMultinameV){
							if(traits_info.value[1]>0&&traits_info.value[1]<allMultinameV.length){
								trait.type_name=allMultinameV[traits_info.value[1]];
							}
						}
						
						if(traits_info.value[2]>0){
							constantItemArr.push([
								trait.vkindAndVIndex=new ABCConstantItem(),
								traits_info.value[3],traits_info.value[2]
							]);
						}
						
					break;
					case TraitTypeAndAttributes.Method:
					case TraitTypeAndAttributes.Getter:
					case TraitTypeAndAttributes.Setter:
						
						trait.disp_id=traits_info.value[0];
						
						if(allMethodV){
							if(traits_info.value[1]>-1&&traits_info.value[1]<allMethodV.length){
								trait.method=allMethodV[traits_info.value[1]];
							}
						}
						
					break;
					case TraitTypeAndAttributes.Function_:
						
						trait.slot_id=traits_info.value[0];
						
						if(allMethodV){
							if(traits_info.value[1]>-1&&traits_info.value[1]<allMethodV.length){
								trait.function_=allMethodV[traits_info.value[1]];
							}
						}
						
					break;
					case TraitTypeAndAttributes.Class_:
						
						trait.slot_id=traits_info.value[0];
						
						if(classV){
							if(traits_info.value[1]>-1&&traits_info.value[1]<classV.length){
								trait.classi=classV[traits_info.value[1]].name;
							}
						}
						
					break;
				}
				
				if(traits_info.metadataV){
					count=traits_info.metadataV.length;
					if(count){
						i=-1;
						trait.metadataV=new Vector.<ABCMetadata>(count);
						for each(var metadataId:int in traits_info.metadataV){
							if(allMetadataV){
								if(metadataId>-1&&metadataId<allMetadataV.length){
									trait.metadataV[++i]=allMetadataV[metadataId];
								}else{
									i++;
								}
							}else{
								i++;
							}
						}
					}
				}
			}
			
			for each(subArr in constantItemArr){
				
				var constantItem:ABCConstantItem=subArr[0];
				constantItem.kind=subArr[1];
				
				switch(constantItem.kind){
					case ConstantKinds.Int:
						if(integerV){
							if(subArr[2]>0&&subArr[2]<integerV.length){
								constantItem.value=integerV[subArr[2]];
							}else{
								constantItem.kind=ConstantKinds.Undefined;
							}
						}else{
							constantItem.kind=ConstantKinds.Undefined;
						}
					break;
					case ConstantKinds.UInt:
						if(uintegerV){
							if(subArr[2]>0&&subArr[2]<uintegerV.length){
								constantItem.value=uintegerV[subArr[2]];
							}else{
								constantItem.kind=ConstantKinds.Undefined;
							}
						}else{
							constantItem.kind=ConstantKinds.Undefined;
						}
					break;
					case ConstantKinds.Double:
						if(doubleV){
							if(subArr[2]>0&&subArr[2]<doubleV.length){
								constantItem.value=doubleV[subArr[2]];
							}else{
								constantItem.kind=ConstantKinds.Undefined;
							}
						}else{
							constantItem.kind=ConstantKinds.Undefined;
						}
					break;
					case ConstantKinds.Utf8:
						if(stringV){
							if(subArr[2]>0&&subArr[2]<stringV.length){
								constantItem.value=stringV[subArr[2]];
							}else{
								constantItem.kind=ConstantKinds.Undefined;
							}
						}else{
							constantItem.kind=ConstantKinds.Undefined;
						}
					break;
					case ConstantKinds.True:
					case ConstantKinds.False:
					case ConstantKinds.Null:
					case ConstantKinds.Undefined:
						//value 无意义
					break;
					//case ConstantKinds.Namespace:
					//case ConstantKinds.PackageNamespace:
					//case ConstantKinds.PackageInternalNs:
					//case ConstantKinds.ProtectedNamespace:
					//case ConstantKinds.ExplicitNamespace:
					//case ConstantKinds.StaticProtectedNs:
					//case ConstantKinds.PrivateNs:
					default:
						if(allNsV){
							if(subArr[2]>0&&subArr[2]<allNsV.length){
								constantItem.value=allNsV[subArr[2]];
							}else{
								constantItem.kind=ConstantKinds.Undefined;
							}
						}else{
							constantItem.kind=ConstantKinds.Undefined;
						}
					break;
				}
			}
			
			return offset;
			
		}
		public function toData(_toDataOptions:Object):ByteArray{
			
			var integerV:Vector.<int>=new Vector.<int>();
			var uintegerV:Vector.<int>=new Vector.<int>();
			var doubleV:Vector.<Number>=new Vector.<Number>();
			var stringV:Vector.<String>=new Vector.<String>();
			var allNsV:Vector.<ABCNamespace>=new Vector.<ABCNamespace>();
			var allNs_setV:Vector.<ABCNs_set>=new Vector.<ABCNs_set>();
			var allMultinameV:Vector.<ABCMultiname>=new Vector.<ABCMultiname>();
			var allMethodV:Vector.<ABCMethod>=new Vector.<ABCMethod>();
			var allMetadataV:Vector.<ABCMetadata>=new Vector.<ABCMetadata>();
			var allTraitV:Vector.<ABCTrait>=new Vector.<ABCTrait>();
			var allConstantItemV:Vector.<ABCConstantItem>=new Vector.<ABCConstantItem>();
			
			if(_toDataOptions){
			}else{
				_toDataOptions=new Object();
			}
			if(_toDataOptions.toStrDict){
			}else{
				_toDataOptions.toStrDict=new Dictionary();//20130409
			}
			if(_toDataOptions.toStrRecursiveGenericNames){
			}else{
				_toDataOptions.toStrRecursiveGenericNames={//20130425
					idDict:new Dictionary(),
					v:new Vector.<ABCMultiname>()
				}
			}
			
			getAllTraitsAndMethods(this,allTraitV,allMethodV);
			
			//获取所有 string，namespace，multiname 等 -------------------------------------------------------------------
			for each(var clazz:ABCClass in classV){
				allMultinameV.push(clazz.name);
				allMultinameV.push(clazz.super_name);
				allNsV.push(clazz.protectedNs);
				for each(var intrf:ABCMultiname in clazz.intrfV){
					allMultinameV.push(intrf);
				}
			}
			
			for each(var trait:ABCTrait in allTraitV){
				allMultinameV.push(trait.name);
				switch(trait.kind_trait_type){
					case TraitTypeAndAttributes.Slot:
					case TraitTypeAndAttributes.Const:
						allMultinameV.push(trait.type_name);
						if(trait.vkindAndVIndex){
							allConstantItemV.push(trait.vkindAndVIndex);
						}
					break;
					case TraitTypeAndAttributes.Class_:
						//上面已经 allMultinameV.push(clazz.name)，所以是统计了两次
						allMultinameV.push(trait.classi);
					break;
				}
				
				for each(var metadata:ABCMetadata in trait.metadataV){
					if(metadata){
						allMetadataV.push(metadata);
					}
				}
			}
			
			//统计，合并，排序 metadata 们
			var metadataMark:Object=new Object();//统计次数用；记录id用
			var ss:Object=new Object();
			for each(metadata in allMetadataV){
				stringV.push(metadata.name);
				for each(var item:Array in metadata.itemV){
					stringV.push(item[0],item[1]);
				}
				var metadataStr:String=_toDataOptions.toStrDict[metadata];
				if(metadataStr||metadataStr===""){
				}else{
					_toDataOptions.toStrDict[metadata]=metadataStr=metadata.toStr(_toDataOptions);
				}
				var _str:String="~"+metadataStr;
				if(metadataMark[_str]){
					metadataMark[_str]++;
				}else{
					metadataMark[_str]=1;
					ss[_str]=metadata;
				}
			}
			allMetadataV.length=0;
			var id:int=-1;
			for each(_str in sortMarkByTimes(metadataMark)){
				allMetadataV[++id]=ss[_str];
				metadataMark[_str]=id;
			}
			allMetadataV.fixed=true;
			
			var methodDict:Dictionary=new Dictionary();
			id=-1;
			for each(var method:ABCMethod in allMethodV){
				methodDict[method]=++id;
				allMultinameV.push(method.return_type);
				for each(var param_type:ABCMultiname in method.param_typeV){
					allMultinameV.push(param_type);
				}
				stringV.push(method.name);
				for each(var option_detail:ABCConstantItem in method.option_detailV){
					allConstantItemV.push(option_detail);
				}
				for each(var param_name:String in method.param_nameV){
					stringV.push(param_name);
				}
				if(method.codes){
					for each(var code:Object in method.codes.codeArr){
						if(code.op>-1){
							switch(AVM2Ops.valueTypeV[code.op]){
								case "integerid":
									integerV.push(code.integer);
								break;
								case "uintegerid":
									uintegerV.push(code.uinteger);
								break;
								case "doubleid":
									doubleV.push(code.double);
								break;
								case "stringid":
									stringV.push(code.string);
								break;
								case "namespaceid":
									allNsV.push(code.namespace);
								break;
								case "multinameid":
								case "multinameid,arg_count":
									allMultinameV.push(code.multiname);
								break;
								
								case "exceptionid":
									allMultinameV.push(code.exc_type);
									allMultinameV.push(code.var_name);
								break;
								case "classid":
									//上面已经 allMultinameV.push(clazz.name)，所以是统计了两次
									allMultinameV.push(code["class"]);
								break;
								case "debug_type,index,reg,extra":
									stringV.push(code.index);
								break;
								//case "default_offset,case_count,case_offsets...":
								//	//
								//break;
								//default:
								//	//
								//break;
							}
						}
					}
				}
			}
			
			for each(var constantItem:ABCConstantItem in allConstantItemV){
				switch(constantItem.kind){
					case ConstantKinds.Int:
						integerV.push(constantItem.value);
					break;
					case ConstantKinds.UInt:
						uintegerV.push(constantItem.value);
					break;
					case ConstantKinds.Double:
						doubleV.push(constantItem.value);
					break;
					case ConstantKinds.Utf8:
						stringV.push(constantItem.value);
					break;
					case ConstantKinds.True:
					case ConstantKinds.False:
					case ConstantKinds.Null:
					case ConstantKinds.Undefined:
						//value 无意义
					break;
					//case ConstantKinds.Namespace:
					//case ConstantKinds.PackageNamespace:
					//case ConstantKinds.PackageInternalNs:
					//case ConstantKinds.ProtectedNamespace:
					//case ConstantKinds.ExplicitNamespace:
					//case ConstantKinds.StaticProtectedNs:
					//case ConstantKinds.PrivateNs:
					default:
						allNsV.push(constantItem.value);
					break;
				}
			}
			
			//处理嵌套的 multiname 们（GenericName）
			var seed:Array=new Array();
			var dict:Dictionary=new Dictionary();
			for each(var multiname:ABCMultiname in allMultinameV){
				if(multiname){
					dict[multiname]=true;
					if(multiname.kind==MultinameKinds.GenericName){
						seed.push(multiname);
					}
				}
			}
			do{
				var newSeed:Array=new Array();
				for each(multiname in seed){
					if(multiname.TypeDefinition){
						if(multiname.TypeDefinition.kind==MultinameKinds.GenericName){
							if(dict[multiname.TypeDefinition]){
							}else{
								dict[multiname.TypeDefinition]=true;
								seed.push(multiname.TypeDefinition);
							}
						}
						allMultinameV.push(multiname.TypeDefinition);
					}
					for each(var Param:ABCMultiname in multiname.ParamV){
						if(Param){
							if(Param.kind==MultinameKinds.GenericName){
								if(dict[Param]){
								}else{
									dict[Param]=true;
									seed.push(Param);
								}
							}
							allMultinameV.push(Param);
						}
					}
				}
				seed=newSeed;
			}while(seed.length);
			seed=null;
			dict=null;
			
			//统计，合并，排序 multiname 们
			var multinameMark:Object=new Object();//统计次数用；记录id用
			ss=new Object();
			for each(multiname in allMultinameV){
				if(multiname){
					switch(multiname.kind){
						case MultinameKinds.QName:
						case MultinameKinds.QNameA:
							allNsV.push(multiname.ns);
							stringV.push(multiname.name);
						break;
						case MultinameKinds.Multiname:
						case MultinameKinds.MultinameA:
							stringV.push(multiname.name);
							allNs_setV.push(multiname.ns_set);
						break;
						case MultinameKinds.RTQName:
						case MultinameKinds.RTQNameA:
							stringV.push(multiname.name);
						break;
						case MultinameKinds.RTQNameL:
						case MultinameKinds.RTQNameLA:
							//
						break;
						case MultinameKinds.MultinameL:
						case MultinameKinds.MultinameLA:
							allNs_setV.push(multiname.ns_set);
						break;
						//case MultinameKinds.GenericName:
						//	//
						//break;
					}
					var multinameStr:String=_toDataOptions.toStrDict[multiname];
					if(multinameStr||multinameStr===""){
					}else{
						_toDataOptions.toStrDict[multiname]=multinameStr=multiname.toStr(_toDataOptions);
					}
					_str="~"+multinameStr;
					if(multinameMark[_str]){
						multinameMark[_str]++;
					}else{
						multinameMark[_str]=1;
						ss[_str]=multiname;
					}
				}
			}
			allMultinameV.length=0;
			id=-1;
			for each(_str in sortMarkByTimes(multinameMark)){
				allMultinameV[++id]=ss[_str];
			}
			allMultinameV.fixed=true;
			
			//统计，合并，排序 ns_set 们
			var ns_setMark:Object=new Object();//统计次数用；记录id用
			ss=new Object();
			for each(var ns_set:ABCNs_set in allNs_setV){
				if(ns_set){
					for each(var ns:ABCNamespace in ns_set.nsV){
						allNsV.push(ns);
					}
					var ns_setStr:String=_toDataOptions.toStrDict[ns_set];
					if(ns_setStr||ns_setStr===""){
					}else{
						_toDataOptions.toStrDict[ns_set]=ns_setStr=ns_set.toStr(_toDataOptions);
					}
					_str="~"+ns_setStr;
					if(ns_setMark[_str]){
						ns_setMark[_str]++;
					}else{
						ns_setMark[_str]=1;
						ss[_str]=ns_set;
					}
				}
			}
			allNs_setV.length=0;
			id=-1;
			for each(_str in sortMarkByTimes(ns_setMark)){
				allNs_setV[++id]=ss[_str];
			}
			allNs_setV.fixed=true;
			
			//统计，合并，排序 namespace 们
			var nsMark:Object=new Object();//统计次数用；记录id用
			ss=new Object();
			for each(ns in allNsV){
				if(ns){
					stringV.push(ns.name);
					var nsStr:String=_toDataOptions.toStrDict[ns];
					if(nsStr||nsStr===""){
					}else{
						_toDataOptions.toStrDict[ns]=nsStr=ns.toStr(_toDataOptions);
					}
					_str="~"+nsStr;
					if(nsMark[_str]){
						nsMark[_str]++;
					}else{
						nsMark[_str]=1;
						ss[_str]=ns;
					}
				}
			}
			allNsV.length=0;
			id=-1;
			for each(_str in sortMarkByTimes(nsMark)){
				allNsV[++id]=ss[_str];
			}
			allNsV.fixed=true;
			
			//统计，合并，排序 string 们
			var stringMark:Object=new Object();//统计次数用；记录id用
			for each(var string:String in stringV){
				if(string||string===""){
					_str="~"+string;
					if(stringMark[_str]){
						stringMark[_str]++;
					}else{
						stringMark[_str]=1;
					}
				}
			}
			stringV.length=0;
			stringV[0]=null;
			id=0;
			for each(_str in sortMarkByTimes(stringMark)){
				stringV[++id]=_str.substr(1);
			}
			stringV.fixed=true;
			
			//统计，合并，排序 double 们
			var doubleMark:Object=new Object();//统计次数用；记录id用
			for each(var double:Number in doubleV){
				_str="~"+double;
				if(doubleMark[_str]){
					doubleMark[_str]++;
				}else{
					doubleMark[_str]=1;
				}
			}
			doubleV.length=0;
			id=-1;
			for each(_str in sortMarkByTimes(doubleMark)){
				doubleV[++id]=Number(_str.substr(1));
			}
			doubleV.fixed=true;
			
			//统计，合并，排序 uinteger 们
			var uintegerMark:Object=new Object();//统计次数用；记录id用
			for each(var uinteger:int in uintegerV){
				_str="~"+uinteger;
				if(uintegerMark[_str]){
					uintegerMark[_str]++;
				}else{
					uintegerMark[_str]=1;
				}
			}
			uintegerV.length=0;
			id=-1;
			for each(_str in sortMarkByTimes(uintegerMark)){
				uintegerV[++id]=int(_str.substr(1));
			}
			uintegerV.fixed=true;
			
			//统计，合并，排序 integer 们
			var integerMark:Object=new Object();//统计次数用；记录id用
			for each(var integer:int in integerV){
				_str="~"+integer;
				if(integerMark[_str]){
					integerMark[_str]++;
				}else{
					integerMark[_str]=1;
				}
			}
			integerV.length=0;
			id=-1;
			for each(_str in sortMarkByTimes(integerMark)){
				integerV[++id]=int(_str.substr(1));
			}
			integerV.fixed=true;
			// -------------------------------------------------------------------
			
			//写入数据 -------------------------------------------------------------------
			var data:ByteArray=new ByteArray();
			var offset:int=0;
			
			data[offset++]=minor_version;
			data[offset++]=minor_version>>8;
			
			data[offset++]=major_version;
			data[offset++]=major_version>>8;
			
			var count:int=integerV.length;
			if(count){
				count++;
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				for each(integer in integerV){
					if(integer>>>7){if(integer>>>14){if(integer>>>21){if(integer>>>28){data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=((integer>>>21)&0x7f)|0x80;data[offset++]=integer>>>28;}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=((integer>>>14)&0x7f)|0x80;data[offset++]=integer>>>21;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=((integer>>>7)&0x7f)|0x80;data[offset++]=integer>>>14;}}else{data[offset++]=(integer&0x7f)|0x80;data[offset++]=integer>>>7;}}else{data[offset++]=integer;}
				}
			}else{
				data[offset++]=0;
			}
			
			count=uintegerV.length;
			if(count){
				count++;
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				for each(uinteger in uintegerV){
					if(uinteger>>>7){if(uinteger>>>14){if(uinteger>>>21){if(uinteger>>>28){data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=((uinteger>>>21)&0x7f)|0x80;data[offset++]=uinteger>>>28;}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=((uinteger>>>14)&0x7f)|0x80;data[offset++]=uinteger>>>21;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=((uinteger>>>7)&0x7f)|0x80;data[offset++]=uinteger>>>14;}}else{data[offset++]=(uinteger&0x7f)|0x80;data[offset++]=uinteger>>>7;}}else{data[offset++]=uinteger;}
				}
			}else{
				data[offset++]=0;
			}
			
			count=doubleV.length;
			if(count){
				count++;
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				data.endian=Endian.LITTLE_ENDIAN;
				data.position=offset;
				for each(double in doubleV){
					data.writeDouble(double);
				}
				offset=data.length;
			}else{
				data[offset++]=0;
			}
			
			data.position=offset;
			Strings.write(data,stringV);
			offset=data.position;
			
			count=allNsV.length;
			if(count){
				count++;
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				for each(ns in allNsV){
					data[offset++]=ns.kind;
					if(ns.name||ns.name===""){
						id=stringMark["~"+ns.name];
						if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
					}else{
						data[offset++]=0;
					}
				}
			}else{
				data[offset++]=0;
			}
			
			count=allNs_setV.length;
			if(count){
				count++;
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				for each(ns_set in allNs_setV){
					if(ns_set.nsV){
						var count2:int=ns_set.nsV.length;
						if(count2){
							if(count2>>>7){if(count2>>>14){if(count2>>>21){if(count2>>>28){data[offset++]=(count2&0x7f)|0x80;data[offset++]=((count2>>>7)&0x7f)|0x80;data[offset++]=((count2>>>14)&0x7f)|0x80;data[offset++]=((count2>>>21)&0x7f)|0x80;data[offset++]=count2>>>28;}else{data[offset++]=(count2&0x7f)|0x80;data[offset++]=((count2>>>7)&0x7f)|0x80;data[offset++]=((count2>>>14)&0x7f)|0x80;data[offset++]=count2>>>21;}}else{data[offset++]=(count2&0x7f)|0x80;data[offset++]=((count2>>>7)&0x7f)|0x80;data[offset++]=count2>>>14;}}else{data[offset++]=(count2&0x7f)|0x80;data[offset++]=count2>>>7;}}else{data[offset++]=count2;}
							for each(ns in ns_set.nsV){
								id=nsMark["~"+_toDataOptions.toStrDict[ns]];
								if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
							}
						}else{
							data[offset++]=0;
						}
					}else{
						data[offset++]=0;
					}
				}
			}else{
				data[offset++]=0;
			}
			
			count=allMultinameV.length;
			if(count){
				count++
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				for each(multiname in allMultinameV){
					data[offset++]=multiname.kind;
					switch(multiname.kind){
						case MultinameKinds.QName:
						case MultinameKinds.QNameA:
							id=nsMark["~"+_toDataOptions.toStrDict[multiname.ns]];
							if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
							
							if(multiname.name||multiname.name===""){
								id=stringMark["~"+multiname.name];
								if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
							}else{
								data[offset++]=0;
							}
						break;
						case MultinameKinds.Multiname:
						case MultinameKinds.MultinameA:
							if(multiname.name||multiname.name===""){
								id=stringMark["~"+multiname.name];
								if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
							}else{
								data[offset++]=0;
							}
							
							id=ns_setMark["~"+_toDataOptions.toStrDict[multiname.ns_set]];
							if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
						break;
						case MultinameKinds.RTQName:
						case MultinameKinds.RTQNameA:
							if(multiname.name||multiname.name===""){
								id=stringMark["~"+multiname.name];
								if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
							}else{
								data[offset++]=0;
							}
						break;
						case MultinameKinds.RTQNameL:
						case MultinameKinds.RTQNameLA:
							//
						break;
						case MultinameKinds.MultinameL:
						case MultinameKinds.MultinameLA:
							id=ns_setMark["~"+_toDataOptions.toStrDict[multiname.ns_set]];
							if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
						break;
						case MultinameKinds.GenericName:
							id=multinameMark["~"+_toDataOptions.toStrDict[multiname.TypeDefinition]];
							if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
							
							if(multiname.ParamV){
								count2=multiname.ParamV.length;
								if(count2){
									if(count2>>>7){if(count2>>>14){if(count2>>>21){if(count2>>>28){data[offset++]=(count2&0x7f)|0x80;data[offset++]=((count2>>>7)&0x7f)|0x80;data[offset++]=((count2>>>14)&0x7f)|0x80;data[offset++]=((count2>>>21)&0x7f)|0x80;data[offset++]=count2>>>28;}else{data[offset++]=(count2&0x7f)|0x80;data[offset++]=((count2>>>7)&0x7f)|0x80;data[offset++]=((count2>>>14)&0x7f)|0x80;data[offset++]=count2>>>21;}}else{data[offset++]=(count2&0x7f)|0x80;data[offset++]=((count2>>>7)&0x7f)|0x80;data[offset++]=count2>>>14;}}else{data[offset++]=(count2&0x7f)|0x80;data[offset++]=count2>>>7;}}else{data[offset++]=count2;}
									for each(Param in multiname.ParamV){
										id=multinameMark["~"+_toDataOptions.toStrDict[Param]];
										if(id>>>7){if(id>>>14){if(id>>>21){if(id>>>28){data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=((id>>>21)&0x7f)|0x80;data[offset++]=id>>>28;}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=((id>>>14)&0x7f)|0x80;data[offset++]=id>>>21;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=((id>>>7)&0x7f)|0x80;data[offset++]=id>>>14;}}else{data[offset++]=(id&0x7f)|0x80;data[offset++]=id>>>7;}}else{data[offset++]=id;}
									}
								}
							}
						break;
					}
				}
			}else{
				data[offset++]=0;
			}
			
			if(classV){
				count=classV.length;
				if(count){
					var i:int=-1;
					var classIdByNameMark:Object=new Object();//用于俩地方：trait 的 classi；newclass 的 class
					for each(clazz in classV){
						if(clazz.name){
							classIdByNameMark["~"+_toDataOptions.toStrDict[clazz.name]]=++i;
						}else{
							outputCodeError("clazz.name="+clazz.name);
						}
					}
				}
			}
			
			var constantItemValueDict:Dictionary=new Dictionary();//记录 constantItem 的 value 的 id
			for each(constantItem in allConstantItemV){
				switch(constantItem.kind){
					case ConstantKinds.Int:
						constantItemValueDict[constantItem]=integerMark["~"+constantItem.value];
					break;
					case ConstantKinds.UInt:
						constantItemValueDict[constantItem]=uintegerMark["~"+constantItem.value];
					break;
					case ConstantKinds.Double:
						constantItemValueDict[constantItem]=doubleMark["~"+constantItem.value];
					break;
					case ConstantKinds.Utf8:
						constantItemValueDict[constantItem]=stringMark["~"+constantItem.value];
					break;
					case ConstantKinds.True:
					case ConstantKinds.False:
					case ConstantKinds.Null:
					case ConstantKinds.Undefined:
						constantItemValueDict[constantItem]=constantItem.kind;
						//value=kind
					break;
					//case ConstantKinds.Namespace:
					//case ConstantKinds.PackageNamespace:
					//case ConstantKinds.PackageInternalNs:
					//case ConstantKinds.ProtectedNamespace:
					//case ConstantKinds.ExplicitNamespace:
					//case ConstantKinds.StaticProtectedNs:
					//case ConstantKinds.PrivateNs:
					default:
						constantItemValueDict[constantItem]=nsMark["~"+_toDataOptions.toStrDict[constantItem.value]];
					break;
				}
			}
			
			var traitDict:Dictionary=new Dictionary();//记录 trait 对应的 traits_info
			for each(trait in allTraitV){
				var traits_info:Traits_info=traitDict[trait]=new Traits_info();
				
				if(trait.name){
					traits_info.name=multinameMark["~"+_toDataOptions.toStrDict[trait.name]];
				}else{
					traits_info.name=0;
				}
				
				traits_info.ATTR_Final=trait.ATTR_Final;
				traits_info.ATTR_Override=trait.ATTR_Override;
				
				traits_info.kind_trait_type=trait.kind_trait_type;
				
				switch(traits_info.kind_trait_type){
					case TraitTypeAndAttributes.Slot:
					case TraitTypeAndAttributes.Const:
						
						traits_info.value=[trait.slot_id];
						
						if(trait.type_name){
							traits_info.value[1]=multinameMark["~"+_toDataOptions.toStrDict[trait.type_name]];
						}else{
							traits_info.value[1]=0;
						}
						
						if(trait.vkindAndVIndex){
							traits_info.value[2]=constantItemValueDict[trait.vkindAndVIndex];
							traits_info.value[3]=trait.vkindAndVIndex.kind;
						}else{
							traits_info.value[2]=0;
							traits_info.value[3]=0;
						}
						
					break;
					case TraitTypeAndAttributes.Method:
					case TraitTypeAndAttributes.Getter:
					case TraitTypeAndAttributes.Setter:
						
						traits_info.value=[trait.disp_id];
						
						if(trait.method){
							traits_info.value[1]=methodDict[trait.method];
						}else{
							traits_info.value[1]=-1;
						}
						
					break;
					case TraitTypeAndAttributes.Function_:
						
						traits_info.value=[trait.slot_id];
						
						if(trait.function_){
							traits_info.value[1]=methodDict[trait.function_];
						}else{
							traits_info.value[1]=-1;
						}
						
					break;
					case TraitTypeAndAttributes.Class_:
						
						traits_info.value=[trait.slot_id];
						
						if(trait.classi){
							var className:String=_toDataOptions.toStrDict[trait.classi];
							if(classIdByNameMark["~"+className]>-1){
								traits_info.value[1]=classIdByNameMark["~"+className];
							}else{
								traits_info.value[1]=-1;
							}
						}else{
							traits_info.value[1]=-1;
						}
						
					break;
				}
				
				if(trait.metadataV){
					count2=trait.metadataV.length;
					if(count2){
						var j:int=-1;
						traits_info.metadataV=new Vector.<int>(count2);
						for each(metadata in trait.metadataV){
							if(metadata){
								traits_info.metadataV[++j]=metadataMark["~"+_toDataOptions.toStrDict[metadata]];
							}else{
								traits_info.metadataV[++j]=-1;
							}
						}
					}
				}
			}
			
			count=allMethodV.length;
			if(count){
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				
				var method_info:Method_info=new Method_info();
				
				var method_body_count:int=0;
				var method_bodys_data:ByteArray=new ByteArray();
				var method_body_info:Method_body_info=new Method_body_info();
				
				data.position=offset;
				var methodId:int=-1;
				for each(method in allMethodV){
					
					methodId++;
					
					if(method.return_type){
						method_info.return_type=multinameMark["~"+_toDataOptions.toStrDict[method.return_type]];
					}else{
						method_info.return_type=0;
					}
					
					if(method.param_typeV){
						count2=method.param_typeV.length;
						if(count2){
							j=-1;
							method_info.param_typeV=new Vector.<int>(count2);
							for each(param_type in method.param_typeV){
								if(param_type){
									method_info.param_typeV[++j]=multinameMark["~"+_toDataOptions.toStrDict[param_type]];
								}else{
									method_info.param_typeV[++j]=0;
								}
							}
						}else{
							method_info.param_typeV=null;
						}
					}else{
						method_info.param_typeV=null;
					}
					
					if(method.name||method.name===""){
						method_info.name=stringMark["~"+method.name];
					}else{
						method_info.name=0;
					}
					
					method_info.NeedArguments=method.NeedArguments;
					method_info.NeedActivation=method.NeedActivation;
					method_info.NeedRest=method.NeedRest;
					method_info.SetDxns=method.SetDxns;
					
					if(method.option_detailV){
						count2=method.option_detailV.length;
						if(count2){
							j=-1;
							method_info.option_detailV=new Vector.<Option_detail>(count2);
							for each(option_detail in method.option_detailV){
								method_info.option_detailV[++j]=new Option_detail();
								method_info.option_detailV[j].kind=option_detail.kind;
								method_info.option_detailV[j].val=constantItemValueDict[option_detail];
							}
						}else{
							method_info.option_detailV=null;
						}
					}else{
						method_info.option_detailV=null;
					}
					
					if(method.param_nameV){
						count2=method.param_nameV.length;
						if(count2){
							j=-1;
							method_info.param_nameV=new Vector.<int>(count2);
							for each(param_name in method.param_nameV){
								if(param_name||param_name===""){
									method_info.param_nameV[++j]=stringMark["~"+param_name];
								}else{
									method_info.param_nameV[++j]=0;
								}
							}
						}else{
							method_info.param_nameV=null;
						}
					}else{
						method_info.param_nameV=null;
					}
					
					data.writeBytes(method_info.toData(_toDataOptions));
					
					if(method.codes){
						
						method_body_info.method=methodId;
						
						method_body_info.max_stack=method.max_stack;
						method_body_info.local_count=method.local_count;
						method_body_info.init_scope_depth=method.init_scope_depth;
						method_body_info.max_scope_depth=method.max_scope_depth;
						
						var exceptionCodeV:Vector.<Object>=new Vector.<Object>();
						var codesData:ByteArray=new ByteArray();
						var codeOffset:int=0;
						var labelObjArr:Array=new Array();
						var labelDict:Dictionary=new Dictionary();
						for each(code in method.codes.codeArr){
							if(code.ownData&&code.pos>-1&&code.dataLen>0){
								//output("直接写入的字节码："+BytesAndStr16.bytes2str16(code.ownData,code.pos,code.dataLen),"brown");
								codesData.position=codeOffset;
								codesData.writeBytes(code.ownData,code.pos,code.dataLen);
								codeOffset=codesData.length;
							}else if(code.op>-1){
								if(AVM2Ops.nameV[code.op]){
									codesData[codeOffset++]=code.op;
									switch(AVM2Ops.valueTypeV[code.op]){
										case "":
											//
										break;
										case "registerid":
											if(code.registerid>>>7){if(code.registerid>>>14){if(code.registerid>>>21){if(code.registerid>>>28){codesData[codeOffset++]=(code.registerid&0x7f)|0x80;codesData[codeOffset++]=((code.registerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.registerid>>>28;}else{codesData[codeOffset++]=(code.registerid&0x7f)|0x80;codesData[codeOffset++]=((code.registerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.registerid>>>21;}}else{codesData[codeOffset++]=(code.registerid&0x7f)|0x80;codesData[codeOffset++]=((code.registerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.registerid>>>14;}}else{codesData[codeOffset++]=(code.registerid&0x7f)|0x80;codesData[codeOffset++]=code.registerid>>>7;}}else{codesData[codeOffset++]=code.registerid;}
										break;
										case "slotid":
											if(code.slotid>>>7){if(code.slotid>>>14){if(code.slotid>>>21){if(code.slotid>>>28){codesData[codeOffset++]=(code.slotid&0x7f)|0x80;codesData[codeOffset++]=((code.slotid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.slotid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.slotid>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.slotid>>>28;}else{codesData[codeOffset++]=(code.slotid&0x7f)|0x80;codesData[codeOffset++]=((code.slotid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.slotid>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.slotid>>>21;}}else{codesData[codeOffset++]=(code.slotid&0x7f)|0x80;codesData[codeOffset++]=((code.slotid>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.slotid>>>14;}}else{codesData[codeOffset++]=(code.slotid&0x7f)|0x80;codesData[codeOffset++]=code.slotid>>>7;}}else{codesData[codeOffset++]=code.slotid;}
										break;
										case "scopeid":
											codesData[codeOffset++]=code.scopeid;
										break;
										case "linenum":
											if(code.linenum>>>7){if(code.linenum>>>14){if(code.linenum>>>21){if(code.linenum>>>28){codesData[codeOffset++]=(code.linenum&0x7f)|0x80;codesData[codeOffset++]=((code.linenum>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.linenum>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.linenum>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.linenum>>>28;}else{codesData[codeOffset++]=(code.linenum&0x7f)|0x80;codesData[codeOffset++]=((code.linenum>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.linenum>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.linenum>>>21;}}else{codesData[codeOffset++]=(code.linenum&0x7f)|0x80;codesData[codeOffset++]=((code.linenum>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.linenum>>>14;}}else{codesData[codeOffset++]=(code.linenum&0x7f)|0x80;codesData[codeOffset++]=code.linenum>>>7;}}else{codesData[codeOffset++]=code.linenum;}
										break;
										
										case "integerid":
											var integerid:int=integerMark["~"+code.integer];
											if(integerid>>>7){if(integerid>>>14){if(integerid>>>21){if(integerid>>>28){codesData[codeOffset++]=(integerid&0x7f)|0x80;codesData[codeOffset++]=((integerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((integerid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((integerid>>>21)&0x7f)|0x80;codesData[codeOffset++]=integerid>>>28;}else{codesData[codeOffset++]=(integerid&0x7f)|0x80;codesData[codeOffset++]=((integerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((integerid>>>14)&0x7f)|0x80;codesData[codeOffset++]=integerid>>>21;}}else{codesData[codeOffset++]=(integerid&0x7f)|0x80;codesData[codeOffset++]=((integerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=integerid>>>14;}}else{codesData[codeOffset++]=(integerid&0x7f)|0x80;codesData[codeOffset++]=integerid>>>7;}}else{codesData[codeOffset++]=integerid;}
										break;
										case "uintegerid":
											var uintegerid:int=uintegerMark["~"+code.uinteger];
											if(uintegerid>>>7){if(uintegerid>>>14){if(uintegerid>>>21){if(uintegerid>>>28){codesData[codeOffset++]=(uintegerid&0x7f)|0x80;codesData[codeOffset++]=((uintegerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((uintegerid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((uintegerid>>>21)&0x7f)|0x80;codesData[codeOffset++]=uintegerid>>>28;}else{codesData[codeOffset++]=(uintegerid&0x7f)|0x80;codesData[codeOffset++]=((uintegerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((uintegerid>>>14)&0x7f)|0x80;codesData[codeOffset++]=uintegerid>>>21;}}else{codesData[codeOffset++]=(uintegerid&0x7f)|0x80;codesData[codeOffset++]=((uintegerid>>>7)&0x7f)|0x80;codesData[codeOffset++]=uintegerid>>>14;}}else{codesData[codeOffset++]=(uintegerid&0x7f)|0x80;codesData[codeOffset++]=uintegerid>>>7;}}else{codesData[codeOffset++]=uintegerid;}
										break;
										case "doubleid":
											var doubleid:int=doubleMark["~"+code.double];
											if(doubleid>>>7){if(doubleid>>>14){if(doubleid>>>21){if(doubleid>>>28){codesData[codeOffset++]=(doubleid&0x7f)|0x80;codesData[codeOffset++]=((doubleid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((doubleid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((doubleid>>>21)&0x7f)|0x80;codesData[codeOffset++]=doubleid>>>28;}else{codesData[codeOffset++]=(doubleid&0x7f)|0x80;codesData[codeOffset++]=((doubleid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((doubleid>>>14)&0x7f)|0x80;codesData[codeOffset++]=doubleid>>>21;}}else{codesData[codeOffset++]=(doubleid&0x7f)|0x80;codesData[codeOffset++]=((doubleid>>>7)&0x7f)|0x80;codesData[codeOffset++]=doubleid>>>14;}}else{codesData[codeOffset++]=(doubleid&0x7f)|0x80;codesData[codeOffset++]=doubleid>>>7;}}else{codesData[codeOffset++]=doubleid;}
										break;
										case "stringid":
											if(code.string||code.string===""){
												var stringid:int=stringMark["~"+code.string];
												if(stringid>>>7){if(stringid>>>14){if(stringid>>>21){if(stringid>>>28){codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>21)&0x7f)|0x80;codesData[codeOffset++]=stringid>>>28;}else{codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>14)&0x7f)|0x80;codesData[codeOffset++]=stringid>>>21;}}else{codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>7)&0x7f)|0x80;codesData[codeOffset++]=stringid>>>14;}}else{codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=stringid>>>7;}}else{codesData[codeOffset++]=stringid;}
											}else{
												codesData[codeOffset++]=0;
											}
										break;
										case "namespaceid":
											if(code.namespace){
												var namespaceid:int=nsMark["~"+_toDataOptions.toStrDict[code.namespace]];
												if(namespaceid>>>7){if(namespaceid>>>14){if(namespaceid>>>21){if(namespaceid>>>28){codesData[codeOffset++]=(namespaceid&0x7f)|0x80;codesData[codeOffset++]=((namespaceid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((namespaceid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((namespaceid>>>21)&0x7f)|0x80;codesData[codeOffset++]=namespaceid>>>28;}else{codesData[codeOffset++]=(namespaceid&0x7f)|0x80;codesData[codeOffset++]=((namespaceid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((namespaceid>>>14)&0x7f)|0x80;codesData[codeOffset++]=namespaceid>>>21;}}else{codesData[codeOffset++]=(namespaceid&0x7f)|0x80;codesData[codeOffset++]=((namespaceid>>>7)&0x7f)|0x80;codesData[codeOffset++]=namespaceid>>>14;}}else{codesData[codeOffset++]=(namespaceid&0x7f)|0x80;codesData[codeOffset++]=namespaceid>>>7;}}else{codesData[codeOffset++]=namespaceid;}
											}else{
												codesData[codeOffset++]=0;
											}
										break;
										case "multinameid":
											if(code.multiname){
												var multinameid:int=multinameMark["~"+_toDataOptions.toStrDict[code.multiname]];
												if(multinameid>>>7){if(multinameid>>>14){if(multinameid>>>21){if(multinameid>>>28){codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>21)&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>28;}else{codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>14)&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>21;}}else{codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>7)&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>14;}}else{codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>7;}}else{codesData[codeOffset++]=multinameid;}
											}else{
												codesData[codeOffset++]=0;
											}
										break;
										
										case "methodid":
											if(code.method){
												var methodid:int=methodDict[code.method];
											}else{
												methodid=-1;
											}
											if(methodid>>>7){if(methodid>>>14){if(methodid>>>21){if(methodid>>>28){codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>21)&0x7f)|0x80;codesData[codeOffset++]=methodid>>>28;}else{codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>14)&0x7f)|0x80;codesData[codeOffset++]=methodid>>>21;}}else{codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>7)&0x7f)|0x80;codesData[codeOffset++]=methodid>>>14;}}else{codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=methodid>>>7;}}else{codesData[codeOffset++]=methodid;}
										break;
										case "exceptionid":
											var exceptionid:int=exceptionCodeV.length;
											if(exceptionid>>>7){if(exceptionid>>>14){if(exceptionid>>>21){if(exceptionid>>>28){codesData[codeOffset++]=(exceptionid&0x7f)|0x80;codesData[codeOffset++]=((exceptionid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((exceptionid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((exceptionid>>>21)&0x7f)|0x80;codesData[codeOffset++]=exceptionid>>>28;}else{codesData[codeOffset++]=(exceptionid&0x7f)|0x80;codesData[codeOffset++]=((exceptionid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((exceptionid>>>14)&0x7f)|0x80;codesData[codeOffset++]=exceptionid>>>21;}}else{codesData[codeOffset++]=(exceptionid&0x7f)|0x80;codesData[codeOffset++]=((exceptionid>>>7)&0x7f)|0x80;codesData[codeOffset++]=exceptionid>>>14;}}else{codesData[codeOffset++]=(exceptionid&0x7f)|0x80;codesData[codeOffset++]=exceptionid>>>7;}}else{codesData[codeOffset++]=exceptionid;}
											exceptionCodeV[exceptionid]=code;
										break;
										case "classid":
											if(code["class"]){
												className=_toDataOptions.toStrDict[code["class"]];
												if(classIdByNameMark["~"+className]>-1){
													var classid:int=classIdByNameMark["~"+className];
												}else{
													classid=-1;
												}
											}else{
												classid=-1;
											}
											if(classid>>>7){if(classid>>>14){if(classid>>>21){if(classid>>>28){codesData[codeOffset++]=(classid&0x7f)|0x80;codesData[codeOffset++]=((classid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((classid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((classid>>>21)&0x7f)|0x80;codesData[codeOffset++]=classid>>>28;}else{codesData[codeOffset++]=(classid&0x7f)|0x80;codesData[codeOffset++]=((classid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((classid>>>14)&0x7f)|0x80;codesData[codeOffset++]=classid>>>21;}}else{codesData[codeOffset++]=(classid&0x7f)|0x80;codesData[codeOffset++]=((classid>>>7)&0x7f)|0x80;codesData[codeOffset++]=classid>>>14;}}else{codesData[codeOffset++]=(classid&0x7f)|0x80;codesData[codeOffset++]=classid>>>7;}}else{codesData[codeOffset++]=classid;}
										break;
										
										case "arg_count":
											if(code.arg_count>>>7){if(code.arg_count>>>14){if(code.arg_count>>>21){if(code.arg_count>>>28){codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>28;}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>21;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>14;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>7;}}else{codesData[codeOffset++]=code.arg_count;}
										break;
										
										case "offset":
											labelObjArr.push({code:code,label:code.label,startPos:codeOffset+3,offsetCodePos:codeOffset});
											codesData[codeOffset++]=0x00;
											codesData[codeOffset++]=0x00;
											codesData[codeOffset++]=0x00;
										break;
										
										case "registerid,registerid":
											if(code.registerid1>>>7){if(code.registerid1>>>14){if(code.registerid1>>>21){if(code.registerid1>>>28){codesData[codeOffset++]=(code.registerid1&0x7f)|0x80;codesData[codeOffset++]=((code.registerid1>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid1>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid1>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.registerid1>>>28;}else{codesData[codeOffset++]=(code.registerid1&0x7f)|0x80;codesData[codeOffset++]=((code.registerid1>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid1>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.registerid1>>>21;}}else{codesData[codeOffset++]=(code.registerid1&0x7f)|0x80;codesData[codeOffset++]=((code.registerid1>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.registerid1>>>14;}}else{codesData[codeOffset++]=(code.registerid1&0x7f)|0x80;codesData[codeOffset++]=code.registerid1>>>7;}}else{codesData[codeOffset++]=code.registerid1;}
											if(code.registerid2>>>7){if(code.registerid2>>>14){if(code.registerid2>>>21){if(code.registerid2>>>28){codesData[codeOffset++]=(code.registerid2&0x7f)|0x80;codesData[codeOffset++]=((code.registerid2>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid2>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid2>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.registerid2>>>28;}else{codesData[codeOffset++]=(code.registerid2&0x7f)|0x80;codesData[codeOffset++]=((code.registerid2>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.registerid2>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.registerid2>>>21;}}else{codesData[codeOffset++]=(code.registerid2&0x7f)|0x80;codesData[codeOffset++]=((code.registerid2>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.registerid2>>>14;}}else{codesData[codeOffset++]=(code.registerid2&0x7f)|0x80;codesData[codeOffset++]=code.registerid2>>>7;}}else{codesData[codeOffset++]=code.registerid2;}
										break;
										case "multinameid,arg_count":
											if(code.multiname){
												multinameid=multinameMark["~"+_toDataOptions.toStrDict[code.multiname]];
												if(multinameid>>>7){if(multinameid>>>14){if(multinameid>>>21){if(multinameid>>>28){codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>21)&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>28;}else{codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>14)&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>21;}}else{codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=((multinameid>>>7)&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>14;}}else{codesData[codeOffset++]=(multinameid&0x7f)|0x80;codesData[codeOffset++]=multinameid>>>7;}}else{codesData[codeOffset++]=multinameid;}
											}else{
												codesData[codeOffset++]=0;
											}
											if(code.arg_count>>>7){if(code.arg_count>>>14){if(code.arg_count>>>21){if(code.arg_count>>>28){codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>28;}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>21;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>14;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>7;}}else{codesData[codeOffset++]=code.arg_count;}
										break;
										case "dispid,arg_count":
											if(code.dispid>>>7){if(code.dispid>>>14){if(code.dispid>>>21){if(code.dispid>>>28){codesData[codeOffset++]=(code.dispid&0x7f)|0x80;codesData[codeOffset++]=((code.dispid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.dispid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.dispid>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.dispid>>>28;}else{codesData[codeOffset++]=(code.dispid&0x7f)|0x80;codesData[codeOffset++]=((code.dispid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.dispid>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.dispid>>>21;}}else{codesData[codeOffset++]=(code.dispid&0x7f)|0x80;codesData[codeOffset++]=((code.dispid>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.dispid>>>14;}}else{codesData[codeOffset++]=(code.dispid&0x7f)|0x80;codesData[codeOffset++]=code.dispid>>>7;}}else{codesData[codeOffset++]=code.dispid;}
											if(code.arg_count>>>7){if(code.arg_count>>>14){if(code.arg_count>>>21){if(code.arg_count>>>28){codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>28;}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>21;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>14;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>7;}}else{codesData[codeOffset++]=code.arg_count;}
										break;
										case "methodid,arg_count":
											if(code.method){
												methodid=methodDict[code.method];
											}else{
												methodid=-1;
											}
											if(methodid>>>7){if(methodid>>>14){if(methodid>>>21){if(methodid>>>28){codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>21)&0x7f)|0x80;codesData[codeOffset++]=methodid>>>28;}else{codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>14)&0x7f)|0x80;codesData[codeOffset++]=methodid>>>21;}}else{codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=((methodid>>>7)&0x7f)|0x80;codesData[codeOffset++]=methodid>>>14;}}else{codesData[codeOffset++]=(methodid&0x7f)|0x80;codesData[codeOffset++]=methodid>>>7;}}else{codesData[codeOffset++]=methodid;}
											if(code.arg_count>>>7){if(code.arg_count>>>14){if(code.arg_count>>>21){if(code.arg_count>>>28){codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>28;}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>21;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=((code.arg_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>14;}}else{codesData[codeOffset++]=(code.arg_count&0x7f)|0x80;codesData[codeOffset++]=code.arg_count>>>7;}}else{codesData[codeOffset++]=code.arg_count;}
										break;
										case "sbyte":
											codesData[codeOffset++]=code.byte;
										break;
										case "sshort":
											//if(code.short>>>7){if(code.short>>>14){if(code.short>>>21){if(code.short>>>28){codesData[codeOffset++]=(code.short&0x7f)|0x80;codesData[codeOffset++]=((code.short>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.short>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.short>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.short>>>28;}else{codesData[codeOffset++]=(code.short&0x7f)|0x80;codesData[codeOffset++]=((code.short>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.short>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.short>>>21;}}else{codesData[codeOffset++]=(code.short&0x7f)|0x80;codesData[codeOffset++]=((code.short>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.short>>>14;}}else{codesData[codeOffset++]=(code.short&0x7f)|0x80;codesData[codeOffset++]=code.short>>>7;}}else{codesData[codeOffset++]=code.short;}
											if(code.short>>>7){
												if(code.short>>>14){
													codesData[codeOffset++]=(code.short&0x7f)|0x80;
													codesData[codeOffset++]=((code.short>>>7)&0x7f)|0x80;
													codesData[codeOffset++]=(code.short>>>14)&0x03;
												}else{
													codesData[codeOffset++]=(code.short&0x7f)|0x80;
													codesData[codeOffset++]=code.short>>>7;
												}
											}else{
												codesData[codeOffset++]=code.short;
											}
										break;
										case "debug_type,index,reg,extra":
											codesData[codeOffset++]=code.debug_type;
											if(code.index||code.index===""){
												stringid=stringMark["~"+code.index];
												if(stringid>>>7){if(stringid>>>14){if(stringid>>>21){if(stringid>>>28){codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>14)&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>21)&0x7f)|0x80;codesData[codeOffset++]=stringid>>>28;}else{codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>7)&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>14)&0x7f)|0x80;codesData[codeOffset++]=stringid>>>21;}}else{codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=((stringid>>>7)&0x7f)|0x80;codesData[codeOffset++]=stringid>>>14;}}else{codesData[codeOffset++]=(stringid&0x7f)|0x80;codesData[codeOffset++]=stringid>>>7;}}else{codesData[codeOffset++]=stringid;}
											}else{
												codesData[codeOffset++]=0;
											}
											codesData[codeOffset++]=code.reg;
											if(code.extra>>>7){if(code.extra>>>14){if(code.extra>>>21){if(code.extra>>>28){codesData[codeOffset++]=(code.extra&0x7f)|0x80;codesData[codeOffset++]=((code.extra>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.extra>>>14)&0x7f)|0x80;codesData[codeOffset++]=((code.extra>>>21)&0x7f)|0x80;codesData[codeOffset++]=code.extra>>>28;}else{codesData[codeOffset++]=(code.extra&0x7f)|0x80;codesData[codeOffset++]=((code.extra>>>7)&0x7f)|0x80;codesData[codeOffset++]=((code.extra>>>14)&0x7f)|0x80;codesData[codeOffset++]=code.extra>>>21;}}else{codesData[codeOffset++]=(code.extra&0x7f)|0x80;codesData[codeOffset++]=((code.extra>>>7)&0x7f)|0x80;codesData[codeOffset++]=code.extra>>>14;}}else{codesData[codeOffset++]=(code.extra&0x7f)|0x80;codesData[codeOffset++]=code.extra>>>7;}}else{codesData[codeOffset++]=code.extra;}
										break;
										case "default_offset,case_count,case_offsets...":
											var lookupswitch_pos:int=codeOffset-1;
											labelObjArr.push({code:code,label:code.default_offset,startPos:lookupswitch_pos,offsetCodePos:codeOffset});
											codesData[codeOffset++]=0x00;
											codesData[codeOffset++]=0x00;
											codesData[codeOffset++]=0x00;
											var case_count:int=code.case_offsetArr.length-1;//考虑 code.case_offsetArr.length==0 的情况？
											if(case_count>>>7){if(case_count>>>14){if(case_count>>>21){if(case_count>>>28){codesData[codeOffset++]=(case_count&0x7f)|0x80;codesData[codeOffset++]=((case_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((case_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=((case_count>>>21)&0x7f)|0x80;codesData[codeOffset++]=case_count>>>28;}else{codesData[codeOffset++]=(case_count&0x7f)|0x80;codesData[codeOffset++]=((case_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=((case_count>>>14)&0x7f)|0x80;codesData[codeOffset++]=case_count>>>21;}}else{codesData[codeOffset++]=(case_count&0x7f)|0x80;codesData[codeOffset++]=((case_count>>>7)&0x7f)|0x80;codesData[codeOffset++]=case_count>>>14;}}else{codesData[codeOffset++]=(case_count&0x7f)|0x80;codesData[codeOffset++]=case_count>>>7;}}else{codesData[codeOffset++]=case_count;}
											for each(var case_offset:Object in code.case_offsetArr){
												labelObjArr.push({code:code,label:case_offset,startPos:lookupswitch_pos,offsetCodePos:codeOffset});
												codesData[codeOffset++]=0x00;
												codesData[codeOffset++]=0x00;
												codesData[codeOffset++]=0x00;
											}
										break;
										default:
											outputCodeError("未知 valueType："+AVM2Ops.valueTypeV[code.op]);
										break;
									}//end of switch(AVM2Ops.valueTypeV[code.op])...
									
								}else{
									outputCodeError("未知 op 0x"+BytesAndStr16._16V[code.op]);
								}//end of if(AVM2Ops.nameV[code.op])...else...
								
							}else{
								//label
								labelDict[code]=true;
								code.pos=codeOffset;
							}//end of if(code.ownData&&code.pos>-1&&code.dataLen>0)...else if(code.op>-1)...else...
							
						}//end of for each(code in method.codes.codeArr)...
						
						for each(var labelObj:Object in labelObjArr){
							if(labelDict[labelObj.label]){
								var posOffset:int=labelObj.label.pos-labelObj.startPos;
								if(posOffset>=-0x800000&&posOffset<0x800000){
								}else{
									outputCodeError("posOffset="+posOffset+"，超出范围");
								}
								codesData[labelObj.offsetCodePos]=posOffset;
								codesData[labelObj.offsetCodePos+1]=posOffset>>8;
								codesData[labelObj.offsetCodePos+2]=posOffset>>16;
							}else{
								outputCodeError("找不到对应的 label：code.op="+AVM2Ops.nameV[labelObj.code.op]+"，labelObj.startPos"+labelObj.startPos+"，labelObj.offsetCodePos"+labelObj.offsetCodePos);
							}
						}
						
						count2=exceptionCodeV.length;
						if(count2){
							method_body_info.exception_infoV=new Vector.<Exception_info>(count2);
							j=-1;
							for each(code in exceptionCodeV){
								var exception_info:Exception_info=method_body_info.exception_infoV[++j]=new Exception_info();
								if(labelDict[code.from]){
									exception_info.from=code.from.pos;
								}else{
									outputCodeError("找不到对应的 label：code.op="+AVM2Ops.nameV[labelObj.code.op]+"，code.from="+code.from);
								}
								if(labelDict[code.to]){
									exception_info.to=code.to.pos;
								}else{
									outputCodeError("找不到对应的 label：code.op="+AVM2Ops.nameV[labelObj.code.op]+"，code.to="+code.to);
								}
								if(labelDict[code.target]){
									exception_info.target=code.target.pos;
								}else{
									outputCodeError("找不到对应的 label：code.op="+AVM2Ops.nameV[labelObj.code.op]+"，code.target="+code.target);
								}
								if(code.exc_type){
									exception_info.exc_type=multinameMark["~"+_toDataOptions.toStrDict[code.exc_type]];
								}else{
									exception_info.exc_type=0;
								}
								if(code.var_name){
									exception_info.var_name=multinameMark["~"+_toDataOptions.toStrDict[code.var_name]];
								}else{
									exception_info.var_name=0;
								}
							}
						}else{
							method_body_info.exception_infoV=null;
						}
						
						method_body_info.codes=new BytesData();
						method_body_info.codes.initByData(codesData,0,codesData.length,null);
						
						if(method.traitV){
							count2=method.traitV.length;
							if(count2){
								method_body_info.traits_infoV=new Vector.<Traits_info>(count2);
								j=-1;
								for each(trait in method.traitV){
									method_body_info.traits_infoV[++j]=traitDict[trait];
								}
							}else{
								method_body_info.traits_infoV=null;
							}
						}else{
							method_body_info.traits_infoV=null;
						}
						
						method_body_count++;
						method_bodys_data.writeBytes(method_body_info.toData(_toDataOptions));
						
					}
					
				}
				offset=data.length;
			}else{
				data[offset++]=0;
			}
			
			count=allMetadataV.length;
			if(count){
				if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
				
				var metadata_info:Metadata_info=new Metadata_info();
				
				data.position=offset;
				for each(metadata in allMetadataV){
					if(metadata.name||metadata.name===""){
						metadata_info.name=stringMark["~"+metadata.name];
					}else{
						metadata_info.name=0;
					}
					if(metadata.itemV){
						count2=metadata.itemV.length;
						if(count2){
							j=-1;
							metadata_info.item_infoV=new Vector.<Array>(count2);
							for each(item in metadata.itemV){
								if(item[0]||item[0]===""){
									metadata_info.item_infoV[++j]=[stringMark["~"+item[0]]];
								}else{
									metadata_info.item_infoV[++j]=[0];
								}
								if(item[1]||item[1]===""){
									metadata_info.item_infoV[j][1]=stringMark["~"+item[1]];
								}else{
									metadata_info.item_infoV[j][1]=0;
								}
							}
						}else{
							metadata_info.item_infoV=null;
						}
					}else{
						metadata_info.item_infoV=null;
					}
					
					data.writeBytes(metadata_info.toData(_toDataOptions));
					
				}
				
				offset=data.length;
			}else{
				data[offset++]=0;
			}
			
			if(classV){
				count=classV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					
					var instance_info:Instance_info=new Instance_info();
					var class_info:Class_info=new Class_info();
					
					data.position=offset;
					
					for each(clazz in classV){
						
						if(clazz.name){
							instance_info.name=multinameMark["~"+_toDataOptions.toStrDict[clazz.name]];
						}else{
							instance_info.name=0;
						}
						if(clazz.super_name){
							instance_info.super_name=multinameMark["~"+_toDataOptions.toStrDict[clazz.super_name]];
						}else{
							instance_info.super_name=0;
						}
						
						instance_info.ClassSealed=clazz.ClassSealed;
						instance_info.ClassFinal=clazz.ClassFinal;
						instance_info.ClassInterface=clazz.ClassInterface;
						
						if(clazz.protectedNs){
							instance_info.protectedNs=nsMark["~"+_toDataOptions.toStrDict[clazz.protectedNs]];
						}else{
							instance_info.protectedNs=0;
						}
						
						if(clazz.intrfV){
							count2=clazz.intrfV.length;
							if(count2){
								j=-1;
								instance_info.intrfV=new Vector.<int>(count2);
								for each(intrf in clazz.intrfV){
									if(intrf){
										instance_info.intrfV[++j]=multinameMark["~"+_toDataOptions.toStrDict[intrf]];
									}else{
										instance_info.intrfV[++j]=0;
									}
								}
							}else{
								instance_info.intrfV=null;
							}
						}else{
							instance_info.intrfV=null;
						}
						
						if(clazz.iinit){
							instance_info.iinit=methodDict[clazz.iinit];
						}else{
							instance_info.iinit=-1;
						}
						
						if(clazz.itraitV){
							count2=clazz.itraitV.length;
							if(count2){
								instance_info.itraits_infoV=new Vector.<Traits_info>(count2);
								j=-1;
								for each(trait in clazz.itraitV){
									instance_info.itraits_infoV[++j]=traitDict[trait];
								}
							}else{
								instance_info.itraits_infoV=null;
							}
						}else{
							instance_info.itraits_infoV=null;
						}
						
						data.writeBytes(instance_info.toData(_toDataOptions));
						
					}
					
					for each(clazz in classV){
						
						if(clazz.cinit){
							class_info.cinit=methodDict[clazz.cinit];
						}else{
							class_info.cinit=-1;
						}
						
						if(clazz.ctraitV){
							count2=clazz.ctraitV.length;
							if(count2){
								class_info.ctraits_infoV=new Vector.<Traits_info>(count2);
								j=-1;
								for each(trait in clazz.ctraitV){
									class_info.ctraits_infoV[++j]=traitDict[trait];
								}
							}else{
								class_info.ctraits_infoV=null;
							}
						}else{
							class_info.ctraits_infoV=null;
						}
						
						data.writeBytes(class_info.toData(_toDataOptions));
						
					}
					
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(scriptV){
				count=scriptV.length;
				if(count){
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					
					var script_info:Script_info=new Script_info();
					
					data.position=offset;
					
					for each(var script:ABCScript in scriptV){
						
						if(script.init){
							script_info.init=methodDict[script.init];
						}else{
							script_info.init=-1;
						}
						
						if(script.traitV){
							count2=script.traitV.length;
							if(count2){
								script_info.traits_infoV=new Vector.<Traits_info>(count2);
								j=-1;
								for each(trait in script.traitV){
									script_info.traits_infoV[++j]=traitDict[trait];
								}
							}else{
								script_info.traits_infoV=null;
							}
						}else{
							script_info.traits_infoV=null;
						}
						
						data.writeBytes(script_info.toData(_toDataOptions));
						
					}
					
					offset=data.length;
				}else{
					data[offset++]=0;
				}
			}else{
				data[offset++]=0;
			}
			
			if(method_body_count){
				if(method_body_count>>>7){if(method_body_count>>>14){if(method_body_count>>>21){if(method_body_count>>>28){data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=((method_body_count>>>7)&0x7f)|0x80;data[offset++]=((method_body_count>>>14)&0x7f)|0x80;data[offset++]=((method_body_count>>>21)&0x7f)|0x80;data[offset++]=method_body_count>>>28;}else{data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=((method_body_count>>>7)&0x7f)|0x80;data[offset++]=((method_body_count>>>14)&0x7f)|0x80;data[offset++]=method_body_count>>>21;}}else{data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=((method_body_count>>>7)&0x7f)|0x80;data[offset++]=method_body_count>>>14;}}else{data[offset++]=(method_body_count&0x7f)|0x80;data[offset++]=method_body_count>>>7;}}else{data[offset++]=method_body_count;}
				data.position=offset;
				data.writeBytes(method_bodys_data);
				offset=data.length;
			}else{
				data[offset++]=0;
			}
			
			return data;
			
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			if(_toXMLOptions){
			}else{
				_toXMLOptions=new Object();
			}
			if(_toXMLOptions.toStrDict){
			}else{
				_toXMLOptions.toStrDict=new Dictionary();//20130409
			}
			if(_toXMLOptions.toStrRecursiveGenericNames){
			}else{
				_toXMLOptions.toStrRecursiveGenericNames={//20130425
					idDict:new Dictionary(),
					v:new Vector.<ABCMultiname>()
				}
			}
			
			_toXMLOptions.abcclassesValues={//20130224
				v:new Vector.<ABCMethod>(),
				dict:new Dictionary(),
				mark:new Object()
			}
			
			var xml:XML=<{xmlName} class="zero.swf.avm2.ABCClasses"
				minor_version={minor_version}
				major_version={major_version}
			/>;
			
			if(classV){
				var count:int=classV.length;
				if(count){
					var childXML:XML=<classV count={count}/>;
					for each(var clazz:ABCClass in classV){
						childXML.appendChild(clazz.toXML("class",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(scriptV){
				count=scriptV.length;
				if(count){
					childXML=<scriptV count={count}/>;
					for each(var script:ABCScript in scriptV){
						childXML.appendChild(script.toXML("script",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			if(_toXMLOptions.abcclassesValues.v.length){
				
				var methodXMLDict:Dictionary=new Dictionary();
				do{
					
					var seed:Array=new Array();
					for each(var method:ABCMethod in _toXMLOptions.abcclassesValues.v){
						if(methodXMLDict[method]){
						}else{
							seed.push(method);
						}
					}
					
					for each(method in seed){
						methodXMLDict[method]=method.toXML("function",_toXMLOptions);
					}
					
				}while(seed.length);
				
				childXML=<functionV count={_toXMLOptions.abcclassesValues.v.length}/>;
				for each(method in _toXMLOptions.abcclassesValues.v){
					var methodXML:XML=methodXMLDict[method];
					methodXML.@markStr=_toXMLOptions.abcclassesValues.dict[method];
					childXML.appendChild(methodXML);
				}
				xml.appendChild(childXML);
			}
			
			if(_toXMLOptions.toStrRecursiveGenericNames.v.length){
				childXML=<recursiveGenericNameV count={_toXMLOptions.toStrRecursiveGenericNames.v.length}/>;
				var recursiveGenericNameId:int=-1;
				for each(var genericName:ABCMultiname in _toXMLOptions.toStrRecursiveGenericNames.v){
					recursiveGenericNameId++;
					var recursiveGenericNameXML:XML=<recursiveGenericName id={recursiveGenericNameId} value={ABCMultiname.checkAndGetGenericNameStr(genericName,_toXMLOptions,false)}/>;
					childXML.appendChild(recursiveGenericNameXML);
				}
				xml.appendChild(childXML);
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			if(_initByXMLOptions){
			}else{
				_initByXMLOptions=new Object();
			}
			if(_initByXMLOptions.initByStrMark){
			}else{
				_initByXMLOptions.initByStrMark=new Object();//20130409
			}
			
			//_initByXMLOptions.initByStrRecursiveGenericNames={//20130425
			//}
			
			var list:XMLList=xml.recursiveGenericNameV.recursiveGenericName;
			var count:int=list.length();
			if(count){
				var recursiveGenericNameV:Vector.<ABCMultiname>=new Vector.<ABCMultiname>(count);
				for each(var childXML:XML in list){
					var recursiveGenericNameId:int=int(childXML.@id.toString());
					_initByXMLOptions.initByStrMark["~multiname~"+"[GenericName](recursiveGenericNameId="+recursiveGenericNameId+")"]=recursiveGenericNameV[recursiveGenericNameId]=new ABCMultiname();
				}
				recursiveGenericNameId=-1;
				for each(childXML in list){
					recursiveGenericNameId++;
					(recursiveGenericNameV[recursiveGenericNameId] as ABCMultiname).initByStr(childXML.@value.toString(),_initByXMLOptions);
				}
			}
			
			_initByXMLOptions.abcclassesValues={//20130228
			}
			
			list=xml.functionV["function"];
			count=list.length();
			if(count){
				_initByXMLOptions.abcclassesValues.functions=new Object();
				for each(childXML in list){
					_initByXMLOptions.abcclassesValues.functions[childXML.@markStr.toString()]=new ABCMethod();
				}
				for each(childXML in list){
					(_initByXMLOptions.abcclassesValues.functions[childXML.@markStr.toString()] as ABCMethod).initByXML(childXML,_initByXMLOptions);
				}
			}
			
			minor_version=int(xml.@minor_version.toString());
			
			major_version=int(xml.@major_version.toString());
			
			list=xml.classV["class"];
			count=list.length();
			if(count){
				var i:int=-1;
				classV=new Vector.<ABCClass>(count);
				for each(childXML in list){
					classV[++i]=new ABCClass();
					classV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				classV=null;
			}
			
			list=xml.scriptV.script;
			count=list.length();
			if(count){
				i=-1;
				scriptV=new Vector.<ABCScript>(count);
				for each(childXML in list){
					scriptV[++i]=new ABCScript();
					scriptV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				scriptV=null;
			}
			
		}
		
		private static function sortMarkByTimes(mark:Object):Array{
			//次数越多排的越靠前
			//总个数不能多于 1000000000
			var _strArr:Array=new Array();
			for(var _str:String in mark){
				_strArr.push((2000000000-mark[_str])+_str);
			}
			_strArr.sort(Array.CASEINSENSITIVE);
			var id:int=_strArr.length;
			while(id--){
				_strArr[id]=_strArr[id].substr(10);
				mark[_strArr[id]]=id+1;
			}
			return _strArr;
		}
		
		private static function outputCodeError(msg:String):void{
			throw msg;
		}
		
	}
}
