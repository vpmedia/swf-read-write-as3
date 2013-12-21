/***
ABCConstantItem
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 15:17:23
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{
	public class ABCConstantItem{
		
		public var kind:int;
		public var value:*;
		
		public function ABCConstantItem(){
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			switch(kind){
				case ConstantKinds.Int:
				case ConstantKinds.UInt:
				case ConstantKinds.Double:
				case ConstantKinds.Utf8:
					return <{xmlName} kind={ConstantKinds.kindV[kind]} value={value}/>;
				break;
				case ConstantKinds.True:
				case ConstantKinds.False:
				case ConstantKinds.Null:
				case ConstantKinds.Undefined:
					//value 无意义
					return <{xmlName} kind={ConstantKinds.kindV[kind]}/>;
				break;
				//case ConstantKinds.Namespace:
				//case ConstantKinds.PackageNamespace:
				//case ConstantKinds.PackageInternalNs:
				//case ConstantKinds.ProtectedNamespace:
				//case ConstantKinds.ExplicitNamespace:
				//case ConstantKinds.StaticProtectedNs:
				//case ConstantKinds.PrivateNs:
				default:
					var ns:ABCNamespace=value;
					if(_toXMLOptions&&_toXMLOptions.toStrDict){
						var nsStr:String=_toXMLOptions.toStrDict[ns];
						if(nsStr||nsStr===""){
						}else{
							_toXMLOptions.toStrDict[ns]=nsStr=ns.toStr(_toXMLOptions);
						}
					}else{
						nsStr=ns.toStr(_toXMLOptions);
					}
					return <{xmlName} kind={ConstantKinds.kindV[kind]} value={nsStr}/>;
				break;
			}
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			kind=ConstantKinds[xml.@kind.toString()];
			
			switch(kind){
				case ConstantKinds.Int:
					value=int(xml.@value.toString());
				break;
				case ConstantKinds.UInt:
					value=uint(xml.@value.toString());
				break;
				case ConstantKinds.Double:
					value=Number(xml.@value.toString());
				break;
				case ConstantKinds.Utf8:
					value=xml.@value.toString();
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
					var nsStr:String=xml.@value.toString();
					if(_initByXMLOptions&&_initByXMLOptions.initByStrMark){
						value=_initByXMLOptions.initByStrMark["~ns~"+nsStr];
						if(value){
						}else{
							_initByXMLOptions.initByStrMark["~ns~"+nsStr]=value=new ABCNamespace(nsStr,_initByXMLOptions);
						}
					}else{
						value=new ABCNamespace(nsStr,_initByXMLOptions);
					}
				break;
			}
			
		}
	}
}
		