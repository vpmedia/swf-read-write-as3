/***
stringComplexString
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年03月07日 17:17:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.ComplexString;

	public const stringComplexString:ComplexString=new ComplexString(["\"","'","\ufeff"]);
	stringComplexString.escapeV[0xfeff]="\\ufeff";	//不详，但是会被 \s 匹配
}