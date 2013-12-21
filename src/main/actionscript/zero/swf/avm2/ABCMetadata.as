/***
ABCMetadata
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 17:49:10
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//metadata_info
//{
//	u30 name
//	u30 item_count
//	item_info items[item_count]
//}
package zero.swf.avm2{
	import flash.utils.Dictionary;
	
	import zero.swf.utils.nameComplexString;
	import zero.swf.utils.nameGroupString;

	public class ABCMetadata{
		
		public var name:String;
		public var itemV:Vector.<Array>;
		
		public function ABCMetadata(str:String=null,_initByXMLOptions:Object=null){
			if(str||str===""){
				initByStr(str,_initByXMLOptions);
			}
		}
		
		public function toStr(_toXMLOptions:Object):String{
			
			if(itemV){
				if(itemV.length){
					var str:String="";
					for each(var item:Array in itemV){
						if(item[0]||item[0]===""){//key
							var itemStr:String=nameComplexString.escape(item[0])+",";
						}else{
							itemStr="(key=undefined),";
						}
						
						if(item[1]||item[1]===""){//value
							itemStr="["+itemStr+nameComplexString.escape(item[1])+"]";
						}else{
							itemStr="["+itemStr+"(value=undefined)"+"]";
						}
						str+=","+itemStr;
					}
					str="["+str.substr(1)+"]";
				}else{
					str="[](itemV=undefined)";
				}
			}else{
				str="[](itemV=undefined)";
			}
			
			if(name||name===""){
				str=nameComplexString.escape(name)+str;
			}else{
				str="(name=undefined)"+str;
			}
			
			return str;
			
		}
		public function initByStr(str:String,_initByXMLOptions:Object):void{
			
			str=nameGroupString.escape(str);
			
			var dotId:int=str.indexOf("[");
			var execResult:Array=[str.substr(0,dotId),str.substr(dotId)];
			
			if(execResult[0]=="(name=undefined)"){
				name=null;
			}else{
				name=nameComplexString.unescape(execResult[0]);
			}
			if(execResult[1]=="[](itemV=undefined)"){
				itemV=null;
			}else{
				execResult[1]=execResult[1].replace(/^\[([\s\S]*)\]$/,"$1");
				if(execResult[1]){
					itemV=new Vector.<Array>();
					var i:int=-1;
					for each(var itemStr:String in nameGroupString.separate(execResult[1])){
						
						var itemExecResult:Array=/^\[([^,]*),([^,]*)\]$/.exec(nameGroupString.escape(itemStr));
						
						if(itemExecResult[1]=="(key=undefined)"){
							var item:Array=[null];
						}else{
							item=[nameComplexString.unescape(itemExecResult[1])];
						}
						
						if(itemExecResult[2]=="(value=undefined)"){
							item[1]=null;
						}else{
							item[1]=nameComplexString.unescape(itemExecResult[2]);
						}
						
						itemV[++i]=item;
						
					}
				}else{
					itemV=null;
				}
			}
			
		}
		
		public static function test20130419():void{
			
			var str:String="[]";
			trace("str="+str);
			var metadata:ABCMetadata=new ABCMetadata(str);
			trace("metadata.toStr(null)="+metadata.toStr(null));
			
			str="[[,],[,]]";
			trace("str="+str);
			metadata=new ABCMetadata(str);
			trace("metadata.toStr(null)="+metadata.toStr(null));
			
			metadata=new ABCMetadata();
			str=metadata.toStr(null);
			trace("str="+str);
			metadata=new ABCMetadata(str);
			trace("metadata.toStr(null)="+metadata.toStr(null));
			
		}
		
	}
}	