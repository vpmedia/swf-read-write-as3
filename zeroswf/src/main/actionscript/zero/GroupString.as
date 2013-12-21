/***
GroupString
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年6月24日 14:31:17
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero{
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.*;
	import flash.text.*;
	import flash.utils.*;
	
	public class GroupString{
		//str="\t\\[\\]\\(\\)";
		//trace(str);//	\[\]\(\)
		//str=GroupString.escape(str);
		//trace(str);//	\x5b\x5d\x28\x29
		//str=GroupString.escape(str);
		//trace(str);//	\x5b\x5d\x28\x29	//反复 escape() 不会继续引起变化
		//str=GroupString.unescape(str);
		//trace(str);//	\[\]\(\)
		//str=GroupString.unescape(str);
		//trace(str);//	\[\]\(\)			//反复 unescape() 不会继续引起变化
		
		//public static const ext:GroupString=new GroupString(ComplexString.ext.extendsCArr);
		
		private var escape_mark:Object;
		private var unescape_mark:Object;
		public var extendsCArr:Array;
		public function GroupString(_extendsCArr:Array=null){
			extendsCArr=_extendsCArr;
			
			escape_mark=new Object();
			unescape_mark=new Object();
			for each(var extendsC:String in extendsCArr){
				var cCodeStr:String=extendsC.charCodeAt(0).toString(16);
				if(cCodeStr.length<0){
					cCodeStr="0"+cCodeStr;
				}
				escape_mark[extendsC]="\\x"+cCodeStr;
				unescape_mark[cCodeStr]=
				unescape_mark[cCodeStr.charAt(0).toUpperCase()+cCodeStr.charAt(1)]=
				unescape_mark[cCodeStr.charAt(0)+cCodeStr.charAt(1).toUpperCase()]=
				unescape_mark[cCodeStr.toUpperCase()]=
				"\\"+extendsC;
			}
		};
		
		public function escape(str:String):String{
			if(str){
				var cArr:Array=str.split("");
				str="";
				var L:int=cArr.length;
				var i:int=-1;
				while(++i<L){
					var c:String=cArr[i];
					if(c=="\\"){
						c=cArr[i+1];
						if(c=="\\"){
							str+="\\\\";
							i++;
						}else if(escape_mark[c]){
							str+=escape_mark[c];
							i++;
						}else{
							str+="\\";
						}
					}else{
						str+=c;
					}
				}
			}
			return str;
		}
		
		public function unescape(str:String):String{
			if(str){
				var cArr:Array=str.split("");
				str="";
				var L:int=cArr.length;
				var i:int=-1;
				while(++i<L){
					var c:String=cArr[i];
					if(c=="\\"){
						c=cArr[i+1];
						if(c=="\\"){
							str+="\\\\";
							i++;
						}else if(c=="x"){
							c=cArr[i+2]+cArr[i+3];
							if(unescape_mark[c]){
								str+=unescape_mark[c];
								i+=3;
							}else{
								str+="\\";
							}
						}else{
							str+="\\";
						}
					}else{
						str+=c;
					}
				}
			}
			return str;
		}
		
		public function separate(escapeStr:String):Array{
			//"param0:[Multiname][xxx,yyy,zzz].DisplayObject,param1:flash.display.DisplayObject" ==> ["param0:[Multiname][xxx,yyy,zzz].DisplayObject","param1:flash.display.DisplayObject"]
			if(escapeStr){
				var cArr:Array=escapeStr.split("");
				cArr.push(",");//作为结束条件
				var arr:Array=new Array();
				var stack:Array=new Array();
				var str:String="";
				var L:int=cArr.length;
				var i:int=-1;
				while(++i<L){
					var c:String=cArr[i];
					switch(c){
						case "[":
						case "<":
						case "(":
						case "{":
							str+=c;
							stack.push(c);
						break;
						case "]":
							if(stack.pop()=="["){
								str+=c;
							}else{
								throw new Error("配对失败");
							}
						break;
						case ">":
							if(stack.pop()=="<"){
								str+=c;
							}else{
								throw new Error("配对失败");
							}
						break;
						case ")":
							if(stack.pop()=="("){
								str+=c;
							}else{
								throw new Error("配对失败");
							}
						break;
						case "}":
							if(stack.pop()=="{"){
								str+=c;
							}else{
								throw new Error("配对失败");
							}
						break;
						case ",":
							if(stack.length){
								str+=c;
							}else{
								arr.push(str);
								str="";
							}
						break;
						default:
							str+=c;
						break;
					}
				}
				return arr;
			}
			if(escapeStr===""){
				return [""];
			}
			return null;
		}
	}
}
		