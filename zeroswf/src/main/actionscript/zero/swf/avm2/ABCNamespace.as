/***
ABCNamespace
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月17日 14:15:57（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//A namespace_info entry defines a namespace. Namespaces have string names, represented by indices into the
//string array, and kinds. User-defined namespaces have kind CONSTANT_Namespace or
//CONSTANT_ExplicitNamespace and a non-empty name. System namespaces have empty names and one of the
//other kinds, and provides a means for the loader to map references to these namespaces onto internal entities.

//A single byte defines the type of entry that follows, thus identifying how the name field should be interpreted by the loader. 
//The name field is an index into the string section of the constant pool.
//name是在 constant_pool.string_v 中的id
//A value of zero denotes an empty string.
//The table below lists the legal values for kind.
//Namespace Kind 				Value
//CONSTANT_Namespace 			0x08
//CONSTANT_PackageNamespace 	0x16
//CONSTANT_PackageInternalNs 	0x17
//CONSTANT_ProtectedNamespace 	0x18
//CONSTANT_ExplicitNamespace 	0x19
//CONSTANT_StaticProtectedNs 	0x1A
//CONSTANT_PrivateNs 			0x05

//			namespace_info
//			{
//				u8 kind
//				u30 name
//			}
package zero.swf.avm2{
	import flash.utils.Dictionary;
	
	import zero.swf.utils.nameComplexString;

	public class ABCNamespace{
		
		public var kind:int;
		public var name:String;
		
		public function ABCNamespace(str:String=null,_initByXMLOptions:Object=null){
			if(str||str===""){
				initByStr(str,_initByXMLOptions);
			}
		}
		
		public function toStr(_toXMLOptions:Object):String{
			
			if(kind==NamespaceKinds.PackageNamespace){
				var str:String="";
			}else{
				str="["+NamespaceKinds.kindV[kind]+"]";
			}
			
			if(name||name===""){
				str+=nameComplexString.escape(name);
			}else{
				str+="(name=undefined)";
				if(_toXMLOptions){//20130410
					if(_toXMLOptions.ns_name_undefined_mark){
					}else{
						_toXMLOptions.ns_name_undefined_mark=new Object();
					}
					if(_toXMLOptions.ns_name_undefined_mark["~"+str]){
						if(_toXMLOptions.ns_name_undefined_mark["~"+str]==this){
							//
						}else{
							var copyId:int=1;
							while(true){
								copyId++;
								if(_toXMLOptions.ns_name_undefined_mark["~"+str+"("+copyId+")"]){
									if(_toXMLOptions.ns_name_undefined_mark["~"+str+"("+copyId+")"]==this){
										str=str+"("+copyId+")";
										break;
									}
								}else{
									str=str+"("+copyId+")";
									_toXMLOptions.ns_name_undefined_mark["~"+str]=this;
									break;
								}
							}
						}
					}else{
						_toXMLOptions.ns_name_undefined_mark["~"+str]=this;
					}
				}
			}
			
			return str;
			
		}
		public function initByStr(str:String,_initByXMLOptions:Object):void{

			str=str.replace(/\(\d+\)$/,"");
			
			var execResult:Array=/^\[(\w+)\][\s\S]*$/.exec(str);
			
			if(execResult){
				kind=NamespaceKinds[execResult[1]];
				if(kind>0){
					str=str.substr(NamespaceKinds.kindV[kind].length+2);
				}else{
					kind=NamespaceKinds.PackageNamespace;
				}
			}else{
				kind=NamespaceKinds.PackageNamespace;
			}
			
			if(str=="(name=undefined)"){
				name=null;
			}else{
				name=nameComplexString.unescape(str);
			}
			
		}
		
		public static function test20130418():void{
			
			var str:String="";
			trace("str="+str);
			var ns:ABCNamespace=new ABCNamespace(str);
			trace("ns.toStr(null)="+ns.toStr(null));
			
			str="(2)";
			trace("str="+str);
			ns=new ABCNamespace(str);
			trace("ns.toStr(null)="+ns.toStr(null));
			
		}
		
	}
}
