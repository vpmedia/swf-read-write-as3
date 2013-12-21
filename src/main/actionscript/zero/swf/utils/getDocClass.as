/***
getDocClass
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年01月20日 12:15:58
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.swf.SWF;
	import zero.swf.avm2.ABCClass;
	import zero.swf.avm2.ABCClasses;
	import zero.swf.avm2.ABCTrait;
	import zero.swf.utils.getABCClasseses;

	public function getDocClass(swf:SWF):ABCClass{
		var docClassName:String=getDocClassName(swf);
		if(docClassName){
			for each(var ABCData:ABCClasses in getABCClasseses(swf,null)){
				for each(var clazz:ABCClass in ABCData.classV){
					if(clazz.name){
						if(docClassName==clazz.name.toStr(null).replace(/\:+/g,".")){
							return clazz;
						}
					}
				}
			}
		}
		return null;
	}
}