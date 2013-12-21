/***
getDocClassName
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年01月20日 12:05:53
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.Tag;
	import zero.swf.TagTypes;
	import zero.swf.tagBodys.SymbolClass;

	public function getDocClassName(swf:SWF):String{
		for each(var tag:Tag in swf.tagV){
			if(tag.type==TagTypes.SymbolClass){
				var symbolClass:SymbolClass=tag.getBody(SymbolClass,null);
				var id:int=symbolClass.TagV.indexOf(0);
				if(id>-1){
					return symbolClass.NameV[id].replace(/\:+/g,".");
				}
			}
		}
		return null;
	}
}