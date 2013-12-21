/***
ABCScript
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月26日 20:10:27
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/
//The script_info entry is used to define characteristics of an ActionScript 3.0 script.
//script_info
//{
//	u30 init
//	u30 trait_count
//	traits_info trait[trait_count]
//}

package zero.swf.avm2{
	public class ABCScript{
		
		public var init:ABCMethod;
		public var traitV:Vector.<ABCTrait>;
		
		public function ABCScript(){
		}
		
		public function toXML(xmlName:String,_toXMLOptions:Object):XML{
			
			var xml:XML=<{xmlName}/>;
			
			if(init){
				xml.appendChild(init.toXML("init",_toXMLOptions));
			}
			
			if(traitV){
				var count:int=traitV.length;
				if(count){
					var childXML:XML=<traitV count={count}/>;
					for each(var trait:ABCTrait in traitV){
						childXML.appendChild(trait.toXML("trait",_toXMLOptions));
					}
					xml.appendChild(childXML);
				}
			}
			
			return xml;
			
		}
		public function initByXML(xml:XML,_initByXMLOptions:Object):void{
			
			var initXML:XML=xml.init[0];
			if(initXML){
				init=new ABCMethod();
				init.initByXML(initXML,_initByXMLOptions);
			}else{
				init=null;
			}
			
			var list:XMLList=xml.traitV.trait;
			var count:int=list.length();
			if(count){
				var i:int=-1;
				traitV=new Vector.<ABCTrait>(count);
				for each(var childXML:XML in list){
					traitV[++i]=new ABCTrait();
					traitV[i].initByXML(childXML,_initByXMLOptions);
				}
			}else{
				traitV=null;
			}
			
		}
		
	}
}		