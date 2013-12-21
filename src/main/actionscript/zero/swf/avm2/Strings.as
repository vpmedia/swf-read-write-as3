/***
Strings
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年02月19日 20:49:44
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{
	import flash.utils.ByteArray;
	
	import zero.BytesAndStr16;

	public class Strings{
		
		/*public static function test():void{
			
			var data:ByteArray=new ByteArray();
			
			write(data,new <String>[
				null,
				"","a","bb","ccc","Hello World!","哈哈","嘿嘿ÿÿÿÿ\xff\xff\xff\xff","\b\b\b\b","\xff\xfe\xfd",
				"\r(啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊\r\n哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦哦)\n",
				"测试\x00测试"
			]);
			
			for each(var subArr:Array in [
				[0x61,0x61,0xC2,0xA6,0xC2,0xA6,0x61,0x61,0x18,0xC3,0x82,0xC2,0xA6,0xC3,0x82,0xC2],
				[0xA6,0xE6,0x88,0x91,0xE4,0xBA,0x86,0xC3,0x82,0xE4,0xB8,0xAA,0xE5,0x8E,0xBB,0xC2],
				[0xA6,0x03,0x7C,0xC3,0xBF,0x03,0x7C,0xC3,0xB0,0x03,0x7C,0xC3,0x80,0x03,0x7C,0xC2],
				[0x80,0x02,0x5B,0x00,0x02,0x2D,0x2D]
			]){
				if(data[0]<0x7f){
					data[0]++;//不严格
					if(subArr.length<0x80){
						data.writeByte(subArr.length);//不严格
						for each(var byte:int in subArr){
							data.writeByte(byte);
						}
					}else{
						throw new Error("不支持："+subArr.length);
					}
				}else{
					throw new Error("不支持："+data[0]);
				}
			}
			
			data.position=0;
			var stringV:Vector.<String>=read(data,null);
			trace("data.length="+data.length,"data.position="+data.position);
			
			var output:String="";
			for each(var string:String in stringV){
				if(string||string===""){
					output+=',"'+string+'"';
				}else{
					output+=","+string;
				}
			}
			output="stringV=["+output.substr(1)+"];";
			trace(output);
			
		}*/
		
		private static const str_data:ByteArray=new ByteArray();
		private static const f0ff_reg:RegExp=/[\xf0-\xff]/;
		private static const f0ffs:Object=new Object();
		f0ffs["\xf0"]=0xf0;f0ffs["\xf1"]=0xf1;f0ffs["\xf2"]=0xf2;f0ffs["\xf3"]=0xf3;
		f0ffs["\xf4"]=0xf4;f0ffs["\xf5"]=0xf5;f0ffs["\xf6"]=0xf6;f0ffs["\xf7"]=0xf7;
		f0ffs["\xf8"]=0xf8;f0ffs["\xf9"]=0xf9;f0ffs["\xfa"]=0xfa;f0ffs["\xfb"]=0xfb;
		f0ffs["\xfc"]=0xfc;f0ffs["\xfd"]=0xfd;f0ffs["\xfe"]=0xfe;f0ffs["\xff"]=0xff;
		
		public static function read(data:ByteArray,stringHexV:Vector.<String>):Vector.<String>{
			
			var offset:int=data.position;
			
			if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var count:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{count=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{count=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{count=data[offset++];}
			//count
			//trace("count="+count);
			
			if(count>1){
				
				var stringV:Vector.<String>=new Vector.<String>(count);
				if(stringHexV){
					stringHexV.length=count;
				}
				
				for(var i:int=1;i<count;i++){
					
					var pos:int=offset;
					
					if(data[offset]>>>7){if(data[offset+1]>>>7){if(data[offset+2]>>>7){if(data[offset+3]>>>7){var get_str_size:int=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|((data[offset++]&0x7f)<<21)|(data[offset++]<<28);}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|((data[offset++]&0x7f)<<14)|(data[offset++]<<21);}}else{get_str_size=(data[offset++]&0x7f)|((data[offset++]&0x7f)<<7)|(data[offset++]<<14);}}else{get_str_size=(data[offset++]&0x7f)|(data[offset++]<<7);}}else{get_str_size=data[offset++];}
					//get_str_size
					
					if(get_str_size){
						
						data.position=offset;
						var get_str_str:String=data.readUTFBytes(get_str_size);
						
						//import zero.BytesAndStr16;
						//trace('\nget_str_str="'+get_str_str+'"');
						//trace("data片断："+BytesAndStr16.bytes2str16(data,offset,get_str_size));
						
						if(get_str_str.length==get_str_size){
							
							//每个字符占一个字节
							
						}else{
							
							//trace(
							//	"0x"+(0x100+data[offset]).toString(16).substr(1),
							//	"get_str_str.length="+get_str_str.length,
							//	"get_str_size="+get_str_size
							//);
							
							str_data.position=0;
							str_data.writeUTFBytes(get_str_str);
							
							//trace("str_data："+BytesAndStr16.bytes2str16(str_data,0,str_data.position));
							
							if(str_data.position==get_str_size){
								
								var get_str_bytePos:int=get_str_size;
								while(--get_str_bytePos>=0){
									if(str_data[get_str_bytePos]==data[offset+get_str_bytePos]){
									}else{
										break;
									}
								}
								
								if(get_str_bytePos==-1){
									
									//带多字节字符的标准的 utf8 编码的数据
									
								}else{
									
									//trace("长度一致："+get_str_str.substr(0,10));
									get_str_str=utf8_get(data,offset,get_str_size);
									
								}
								
							}else{
								
								//trace("长度不一致："+get_str_str.substr(0,10));
								get_str_str=utf8_get(data,offset,get_str_size);
								
							}
							
						}
						
						stringV[i]=get_str_str;
						offset+=get_str_size;
						
					}else{
						
						stringV[i]="";
						
					}
					
					if(stringHexV){
						stringHexV[i]=zero.BytesAndStr16.bytes2str16(data,pos,offset-pos);
					}
					
				}
				
				data.position=offset;
				return stringV;
				
			}
			
			data.position=offset;
			return null;
			
		}
		
		public static function write(data:ByteArray,stringV:Vector.<String>):void{
			
			var offset:int=data.position;
			
			if(stringV){
				
				var count:int=stringV.length;
				
				if(count>1){
					
					if(count>>>7){if(count>>>14){if(count>>>21){if(count>>>28){data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=((count>>>21)&0x7f)|0x80;data[offset++]=count>>>28;}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=((count>>>14)&0x7f)|0x80;data[offset++]=count>>>21;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=((count>>>7)&0x7f)|0x80;data[offset++]=count>>>14;}}else{data[offset++]=(count&0x7f)|0x80;data[offset++]=count>>>7;}}else{data[offset++]=count;}
					//count
					
					for(var i:int=1;i<count;i++){
						
						var string:String=stringV[i];
						
						if(string){
							
							str_data.position=0;
							//20120413
							if(string.search(f0ff_reg)>-1){
								for each(var c:String in string.split("")){
									if(f0ffs[c]){
										str_data.writeByte(f0ffs[c]);//这么写，个别字符能使 asv2010 显示不出来
									}else{
										str_data.writeUTFBytes(c);
									}
								}
							}else{
								str_data.writeUTFBytes(string);
							}
							var set_str_size:int=str_data.position;
							
							if(set_str_size>>>7){if(set_str_size>>>14){if(set_str_size>>>21){if(set_str_size>>>28){data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=((set_str_size>>>21)&0x7f)|0x80;data[offset++]=set_str_size>>>28;}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=((set_str_size>>>14)&0x7f)|0x80;data[offset++]=set_str_size>>>21;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=((set_str_size>>>7)&0x7f)|0x80;data[offset++]=set_str_size>>>14;}}else{data[offset++]=(set_str_size&0x7f)|0x80;data[offset++]=set_str_size>>>7;}}else{data[offset++]=set_str_size;}
							//set_str_size
							
							data.position=offset;
							data.writeBytes(str_data,0,set_str_size);
							offset+=set_str_size;
						
						}else{
							
							data[offset++]=0x00;
							
						}
						
					}
				}else{
					
					data[offset++]=0;
					
				}
			}else{
				
				data[offset++]=0;
				
			}
			
			data.position=offset;
			
		}
		
		private static function utf8_get(data:ByteArray,offset:int,get_str_size:int):String{
			
			var get_str_str:String="";
			var get_str_end_offset:int=offset+get_str_size;
			
			while(offset<get_str_end_offset){
				
				var get_str_byte:int=data[offset];
				
				if(get_str_byte&0x80){
					
					if((get_str_byte&0xf8)==0xf0){//0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx
						
						if(//20130412
							offset+4<=get_str_end_offset
							&&
							(data[offset+1]&0xc0)==0x80
							&&
							(data[offset+2]&0xc0)==0x80
							&&
							(data[offset+3]&0xc0)==0x80
						){
							
							data.position=offset;
							get_str_str+=data.readUTFBytes(4);
							offset+=4;
							continue;
							
						}
						
					}else if((get_str_byte&0xf0)==0xe0){//0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
						
						if(
							offset+3<=get_str_end_offset
							&&
							(data[offset+1]&0xc0)==0x80
							&&
							(data[offset+2]&0xc0)==0x80
						){
							
							if(
								data[offset]==0xef&&data[offset+1]==0xbb&&data[offset+2]==0xbf//utf8 的 BOM
							){
								get_str_str+="\ufeff";
							}else{
								data.position=offset;
								get_str_str+=data.readUTFBytes(3);
							}
							offset+=3;
							continue;
							
						}
						
					}else if((get_str_byte&0xe0)==0xc0){//0000 0080-0000 07FF | 110xxxxx 10xxxxxx
						
						if(
							offset+2<=get_str_end_offset
							&&
							(data[offset+1]&0xc0)==0x80
						){
							
							data.position=offset;
							get_str_str+=data.readUTFBytes(2);
							offset+=2;
							continue;
							
						}
					}
					
				}
				
				//0000 0000-0000 007F | 0xxxxxxx
				//0x00~0x7f
				get_str_str+=String.fromCharCode(get_str_byte);
				offset++;
				
			}
			
			return get_str_str;
			
		}
	}
}