/***
nameComplexString
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年04月07日 21:48:40
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import zero.ComplexString;
	
	public const nameComplexString:ComplexString=new ComplexString(["(",")","[","]","{","}","<",">",",","="," ","　","\u200b","\u2060","\ufeff"]);
	nameComplexString.escapeV[0x20]="\\x20";		//空格（半角空格，英文空格）
	nameComplexString.escapeV[0x3000]="\\u3000";	//全角空格（中文空格）
	nameComplexString.escapeV[0x200b]="\\u200b";	//不详，但是会被 \s 匹配
	nameComplexString.escapeV[0x2060]="\\u2060";	//不详，但是会被 \s 匹配
	nameComplexString.escapeV[0xfeff]="\\ufeff";	//不详，但是会被 \s 匹配
}