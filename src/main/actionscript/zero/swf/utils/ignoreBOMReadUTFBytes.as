/***
ignoreBOMReadUTFBytes
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年04月12日 21:31:02
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import flash.utils.ByteArray;

	public function ignoreBOMReadUTFBytes(data:ByteArray,length:int):String{
		if(length>=3){
			var offset:int=data.position;
			if(
				data[offset]==0xef&&data[offset+1]==0xbb&&data[offset+2]==0xbf//utf8 的 BOM
			){
				var str:String="";
				while(
					length>=3
					&&
					data[offset]==0xef&&data[offset+1]==0xbb&&data[offset+2]==0xbf//utf8 的 BOM
				){
					str+="\ufeff";
					length-=3;
					offset+=3;
				}
				data.position=offset;
				return str+data.readUTFBytes(length);
			}
		}
		return data.readUTFBytes(length);
	}
}