/***
ABCNs_set
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月18日 17:19:59（代码生成器 V1.1.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//An ns_set_info entry defines a set of namespaces, allowing the set to be used as a unit in the definition of multinames.

//			ns_set_info
//			{
//				u30 count
//				u30 ns[count]
//			}

//The count field defines how many ns's are identified for the entry, while each ns is an integer that indexes into
//the namespace array of the constant pool.
//ns是在 constant_pool.ns_v 中的id
//No entry in the ns array may be zero.
package zero.swf.avm2{
	import flash.utils.Dictionary;
	
	import zero.swf.utils.nameGroupString;

	public class ABCNs_set{
		
		public var nsV:Vector.<ABCNamespace>;
		
		public function ABCNs_set(str:String=null,_initByXMLOptions:Object=null){
			if(str||str===""){
				initByStr(str,_initByXMLOptions);
			}
		}
		
		public function toStr(_toXMLOptions:Object):String{
			
			if(nsV){
				if(nsV.length){
					var str:String="";
					for each(var ns:ABCNamespace in nsV){
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
						str+=","+nsStr;
					}
					str="["+str.substr(1)+"]";
				}else{
					str="[](nsV=undefined)";
				}
			}else{
				str="[](nsV=undefined)";
			}
			
			return str;
			
		}
		public function initByStr(str:String,_initByXMLOptions:Object):void{
			
			if(str=="[](nsV=undefined)"){
				nsV=null;
			}else{
				
				str=str.replace(/^\[([\s\S]*)\]$/,"$1");
				
				str=nameGroupString.escape(str);
				
				nsV=new Vector.<ABCNamespace>();
				var i:int=-1;
				for each(var nsStr:String in nameGroupString.separate(str)){
					if(nsStr=="(undefined)"){
						var ns:ABCNamespace=null;
					}else{
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
					nsV[++i]=ns;
				}
				
			}
			
		}
		
		public static function test20130419():void{
			
			var str:String="[]";
			trace("str="+str);
			var ns_set:ABCNs_set=new ABCNs_set(str);
			//trace("ns_set.nsV.length="+ns_set.nsV.length);
			trace("ns_set.toStr(null)="+ns_set.toStr(null));
			
			str="";
			trace("str="+str);
			ns_set=new ABCNs_set(str);
			trace("ns_set.toStr(null)="+ns_set.toStr(null));
			
			str="(2)";
			trace("str="+str);
			ns_set=new ABCNs_set(str);
			trace("ns_set.toStr(null)="+ns_set.toStr(null));
			
		}
		
	}
}
