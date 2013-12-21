/***
SWF
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年5月30日 21:43:15
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
import flash.utils.getTimer;

import zero.codec.LZMAUncompressSWF;
	import zero.output;
	import zero.outputError;
	
	public class SWF{
		
		public var type:String;
		public var Version:int;
		public var FileLength:int;
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		public var FrameRate:Number;
		public var FrameCount:int;
		public var tagsOffset:int;//20130206
		public var tagV:Vector.<Tag>;
		
		public function SWF(
			_type:String=null,
			_Version:int=0,
			_width:Number=-1,
			_height:Number=-1,
			_FrameRate:Number=0,
			_tagV:Vector.<Tag>=null
		){
			type=_type||"CWS";
			
			//跟播放器版本已经不是一回事了
			//Version=_Version>0?_Version:int(Capabilities.version.match(/\d+/)[0]);//例如 WIN 10,0,22,91 抽出 10;
			//trace("Capabilities.version="+Capabilities.version);
			if(_Version>0){
				Version=_Version;
			}else{
				Version=20;
			}
			
			x=0;
			y=0;
			width=_width>-1?_width:800;
			height=_height>-1?_height:600;
			
			FrameRate=_FrameRate>0?_FrameRate:30;
			if(_tagV){
				tagV=_tagV;
				FrameCount=Tags.getRealFrameCount(tagV);
			}else{
				tagV=new Vector.<Tag>();
				tagV[0]=new Tag(TagTypes.ShowFrame);
				tagV[1]=new Tag(TagTypes.End);
				FrameCount=1;
			}
		}
		
		public function swfData2Bytes(swfData:ByteArray):ByteArray{
			if(swfData.length>8){
			}else{
				throw new Error("不是有效的SWF文件："+swfData);
			}
			swfData.position=0;
			type=swfData.readUTFBytes(3);//压缩和非压缩标记
			
			switch(type){
				case "CWS":
					
					var uncompressedData:ByteArray=new ByteArray();
					uncompressedData.writeBytes(swfData,8);
					try{
						uncompressedData.uncompress();
					}catch(e:Error){
						throw new Error("CWS 解压缩数据时出错");
					}
					
					var bytes:ByteArray=new ByteArray();//类似于 stage.loaderInfo.bytes
					bytes.writeBytes(swfData,0,8);
					bytes[0]="F".charCodeAt(0);
					bytes.writeBytes(uncompressedData);
					
				break;
				case "ZWS"://20120517
					
					//0x5a, 0x57, 0x53 (“ZWS”).
					//A ZWS indicates that the entire file after the first 8 bytes (that is, after the FileLength field) was compressed by using the LZMA open standard: http://www.7-zip.org/sdk.html. ZWS file compression is permitted in SWF 13 or later only.
					
					//20130131
					try{
						var hasLZMA:Boolean=getDefinitionByName("flash.utils.CompressionAlgorithm").LZMA=="lzma";
					}catch(e:Error){
						hasLZMA=false;
					}
					
					if(hasLZMA){
						
						//20120824
						//|Z  W  S  |版本	|解压长度		|压缩数据长度?	|缺少解压长度（在 5,6,7,8 字节）和 00 00 00 00（在 9,10,11,12 字节）的 lzma 数据
						//|5a 57 53 |0f 	|c3 05 00 00	|99 02 00 00	|5d 00 00 00 01 00 37 ff fd e9 e3 ea 97 3f 20 7a 92 23 6d b5 fa 7f f3 94 fc 94 ... 52 c2 59 ea b0 ff 00 ed 7f 00
						//|								（解压长度-8）+ 00 00 00 00-----^ 插这
						
						
						//20130131
						///http://blog.kaourantin.net/?p=124
						
						//Format of SWF when LZMA is used:
						
						//| 4 bytes       | 4 bytes    | 4 bytes       | 5 bytes    | n bytes    | 6 bytes         |
						//| 'ZWS'+version | scriptLen  | compressedLen | LZMA props | LZMA data  | LZMA end marker |
						
						//scriptLen is the uncompressed length of the SWF data. Includes 4 bytes SWF header and
						//4 bytes for scriptLen itself.
						
						//compressedLen does not include header (4+4+4 bytes) or lzma props (5 bytes)
						//compressedLen does include LZMA end marker (6 bytes)
						///
						
						//LZMA compressed file format
						//---------------------------
						//Offset 	Size 	Description
						//0     	1   	Special LZMA properties (lc,lp, pb in encoded form)
						//1     	4   	Dictionary size (little endian)
						//5     	8   	Uncompressed size (little endian). -1 means unknown size
						//13         		Compressed data
						
						
						//20130131
						//http://helpx.adobe.com/flash-player/kb/exception-thrown-you-decompress-lzma-compressed.html
						
						//SWF file LZMA header
						//bytes 0-3: ZWS+version 
						//bytes 4-7: Uncompressed length (includes ZWS+version (4 bytes) and uncompressed length (4 bytes)) 
						//bytes 8-11: Compressed length 
						//bytes 12-16: LZMAproperties 
						//bytes 17-n: Compressed data
						
						//7z LZMA header
						//bytes 0-4: LZMA properties 
						//bytes 5-12: Uncompressed length (take the swf lzma length - 8 (don't include ZWS+version + uncompressed length)) 
						//bytes 13-n: Compressed data
						
						
						//import zero.BytesAndStr16;
						//trace(BytesAndStr16.bytes2str16(swfData,0,40)+" ...");
						uncompressedData=new ByteArray();
						uncompressedData.writeBytes(swfData,12,5);//貌似都是 5d 00 00 00 01
						
						if((swfData[8]|(swfData[9]<<8)|(swfData[10]<<16)|(swfData[11]<<24))==swfData.length-12-5){
						}else{
							output("compressed_size-5 不正确","brown");
						}
						
						//1
						var uncompressed_size:int=(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24));
						if(swfData[16]==0x01){//5d 00 00 00 01 //flash cs6 导出的 swf
							uncompressed_size-=8;
						}else{//5d 00 00 10 00 //用 ByteArray.compress("lzma") 生成的 swf
							uncompressed_size-=16;//经测试减16才可以解压
						}
						uncompressedData[5]=uncompressed_size;
						uncompressedData[6]=uncompressed_size>>8;
						uncompressedData[7]=uncompressed_size>>16;
						uncompressedData[8]=uncompressed_size>>24;
						//其实是 uncompressed_size 的高位，不过因为 uncompressed_size<FileLength，所以都为0：
						uncompressedData[9]=0x00;
						uncompressedData[10]=0x00;
						uncompressedData[11]=0x00;
						uncompressedData[12]=0x00;
						
						uncompressedData.position=13;
						uncompressedData.writeBytes(swfData,17);
						uncompressedData["uncompress"]("lzma");
						
						//import zero.BytesAndStr16;
						//trace(BytesAndStr16.bytes2str16(uncompressedData,0,20)+" ..."+BytesAndStr16.bytes2str16(uncompressedData,uncompressedData.length-20,20));
						
						//trace("使用 flash player 11.3 的 CompressionAlgorithm.LZMA 解压");
						
					}else{
						try{
							import flash.utils.getTimer;
							var t:int=getTimer();
							uncompressedData=LZMAUncompressSWF(swfData);
							output("LZMAUncompressSWF 耗时："+(getTimer()-t)+" 毫秒；swfData.length="+swfData.length,"brown");
						}catch(e:Error){
							throw new Error("ZWS 解压缩数据时出错");
						}
					}
					
					bytes=new ByteArray();
					bytes.writeBytes(swfData,0,8);
					bytes[0]="F".charCodeAt(0);
					bytes.writeBytes(uncompressedData);
					
				break;
				case "FWS":
					
					bytes=new ByteArray();
					bytes.writeBytes(swfData);
					
				break;
				default:
					
					//throw new Error("不是有效的SWF文件");
					var outputData:ByteArray=new ByteArray();
					var outputLen:int=100;
					outputData.writeBytes(swfData,0,Math.min(outputLen,swfData.length));
					throw new Error(
						"不是有效的SWF文件："+outputData+(
							outputLen<swfData.length
							?
							"..."
							:
							""
						)
					);
					
				break;
			}
			
			Version=swfData[3];//播放器版本
			
			FileLength=bytes.length;//SWF文件长度
			if(FileLength==(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))){
			}else{
				output(
					"文件长度不符 FileLength="+FileLength+
					"，ErrorFileLength="+(swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24))
					,"brown");
			}
			
			return bytes;
			
		}
		public function bytes2SWFData(bytes:ByteArray,_toDataOptions:Object):ByteArray{
			FileLength=bytes.length;
			
			if(type=="ZWS"){
				
				//20130131
				try{
					var hasLZMA:Boolean=getDefinitionByName("flash.utils.CompressionAlgorithm").LZMA=="lzma";
				}catch(e:Error){
					hasLZMA=false;
				}
				
				if(hasLZMA){//20120824
					FileLength+=8;//?
				}else{
					type="CWS";
					outputError("暂不支持 ZWS 压缩，type 自动改为 CWS");
				}
			}
			
			var swfData:ByteArray=new ByteArray();
			
			swfData.writeUTFBytes(type);
			
			swfData[3]=Version;
			
			swfData[4]=FileLength;
			swfData[5]=FileLength>>8;
			swfData[6]=FileLength>>16;
			swfData[7]=FileLength>>24;
			
			switch(type){
				case "CWS":
					
					var compressedData:ByteArray=new ByteArray();
					compressedData.writeBytes(bytes,8);
					compressedData.compress();
					
					swfData.position=8;
					swfData.writeBytes(compressedData);
					
				break;
				case "ZWS"://20120824
					
					compressedData=new ByteArray();
					compressedData.writeBytes(bytes,8);
					compressedData["compress"]("lzma");
					
					//import zero.BytesAndStr16;
					//trace(BytesAndStr16.bytes2str16(compressedData,0,40)+" ...");
					
					var compressed_size:int=compressedData.length-13;
					swfData[8]=compressed_size;
					swfData[9]=compressed_size>>8;
					swfData[10]=compressed_size>>16;
					swfData[11]=compressed_size>>24;
					swfData.position=12;
					swfData.writeBytes(compressedData,0,5);//貌似都是 5d 00 00 10 00
					//swfData[15]=0x00;
					//swfData[16]=0x01;//?
					swfData.writeBytes(compressedData,13);
					
				break;
				default:
					
					swfData.position=8;
					swfData.writeBytes(bytes,8);
					
				break;
			}
			
			return swfData;
		}
		
		public function initInfoByBytes(bytes:ByteArray):int{
			var bGroupValue:int=(bytes[8]<<24)|(bytes[9]<<16)|(bytes[10]<<8)|bytes[11];
			var offset:int=12;
			var Nbits:int=bGroupValue>>>27;							//11111000 00000000 00000000 00000000
			var bGroupBitsOffset:int=5;
			
			//import zero.BytesAndStr16;
			//import zero.BytesAndStr2;
			//trace(BytesAndStr16.bytes2str16(bytes,0,10));
			//trace(BytesAndStr2.bytes2str2(bytes,0,10));
			//trace("Nbits="+Nbits);
			
			if(Nbits){
				
				if(Nbits==31){//20130115 //FlasCC生成的一个swf
					//0        1        2        3        4        5        6        7        8        9        10       11       12       13       14       15       16
					//nnnnnaaa aaaaaaaa aaaaaaaa aaaaaaaa aaaabbbb bbbbbbbb bbbbbbbb bbbbbbbb bbbccccc cccccccc cccccccc cccccccc ccdddddd dddddddd dddddddd dddddddd d0000000
					
					Xmin=((bytes[8]&0x07)<<28)|(bytes[9]<<20)|(bytes[10]<<12)|(bytes[11]<<4)|(bytes[12]>>>4);
					Xmax=((bytes[12]&0x0f)<<27)|(bytes[13]<<19)|(bytes[14]<<11)|(bytes[15]<<3)|(bytes[16]>>>5);
					Ymin=((bytes[16]&0x1f)<<26)|(bytes[17]<<18)|(bytes[18]<<10)|(bytes[19]<<2)|(bytes[20]>>>6);
					Ymax=((bytes[20]&0x3f)<<25)|(bytes[21]<<17)|(bytes[22]<<9)|(bytes[23]<<1)|(bytes[24]>>>7);
					
					offset=25;
					bGroupBitsOffset=32;
					
				}else{
				
					var bGroupRshiftBitsOffset:int=32-Nbits;
					var bGroupNegMask:int=1<<(Nbits-1);
					var bGroupNeg:int=0xffffffff<<Nbits;
					
					var Xmin:int=(bGroupValue<<5)>>>bGroupRshiftBitsOffset;
					if(Xmin&bGroupNegMask){Xmin|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(bytes[offset++]<<16)|(bytes[offset++]<<8)|bytes[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(bytes[offset++]<<8)|bytes[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|bytes[offset++];}
					
					var Xmax:int=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(Xmax&bGroupNegMask){Xmax|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(bytes[offset++]<<16)|(bytes[offset++]<<8)|bytes[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(bytes[offset++]<<8)|bytes[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|bytes[offset++];}
					
					var Ymin:int=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(Ymin&bGroupNegMask){Ymin|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
					//从 data 读取足够多的位数以备下面使用:
					if(bGroupBitsOffset>=16){if(bGroupBitsOffset>=24){bGroupBitsOffset-=24;bGroupValue=(bGroupValue<<24)|(bytes[offset++]<<16)|(bytes[offset++]<<8)|bytes[offset++];}else{bGroupBitsOffset-=16;bGroupValue=(bGroupValue<<16)|(bytes[offset++]<<8)|bytes[offset++];}}else if(bGroupBitsOffset>=8){bGroupBitsOffset-=8;bGroupValue=(bGroupValue<<8)|bytes[offset++];}
					
					var Ymax:int=(bGroupValue<<bGroupBitsOffset)>>>bGroupRshiftBitsOffset;
					if(Ymax&bGroupNegMask){Ymax|=bGroupNeg;}//最高位为1,表示负数
					bGroupBitsOffset+=Nbits;
					
				}
			}
			
			//trace("Xmin="+Xmin,"Xmax="+Xmax,"Ymin="+Ymin,"Ymax="+Ymax);
			
			offset=offset-int(4-bGroupBitsOffset/8);
			
			x=Xmin/20;
			y=Ymin/20;
			width=(Xmax-Xmin)/20;
			height=(Ymax-Ymin)/20;
			
			FrameRate=bytes[offset++]/256+bytes[offset++];//帧频是一个Number, 在SWF里以 FIXED8(16-bit 8.8 fixed-point number, 16位8.8定点数) 的结构保存
			FrameCount=bytes[offset++]|(bytes[offset++]<<8);//仅用于参考
			
			tagsOffset=offset;//20130206
			
			return offset;
		}
		
		public function initBySWFData_start(swfData:ByteArray,_initByDataOptions:Object):Object{
			//~~~~~
			var bytes:ByteArray=swfData2Bytes(swfData);
			var offset:int=initInfoByBytes(bytes);
			
			//tagV
			tagV=new Vector.<Tag>();
			Tags.getTagsByData(tagV,bytes,offset,bytes.length,_initByDataOptions?_initByDataOptions.unknownTagV:null);
			
			//#####
			FrameCount=Tags.getRealFrameCount(tagV,FrameCount);
			
			///
			if(_initByDataOptions){
			}else{
				_initByDataOptions=new Object();
			}
			_initByDataOptions.swf_Version=Version;
			
			return _initByDataOptions;
		}
		public function initBySWFData(swfData:ByteArray,_initByDataOptions:Object):void{
			_initByDataOptions=initBySWFData_start(swfData,_initByDataOptions);
			
			//@@@@@
			var tagId:int=0;
			while(tagId<tagV.length){
				tagId=Tags.initByData_step(
					tagV,
					tagId,
					tagV.length,
					10000,
					_initByDataOptions
				);
			}
			
			//$$$$$
		}
		
		public function infoToBytes(_toDataOptions:Object):ByteArray{
			var bytes:ByteArray=new ByteArray();
			
			bytes.writeUTFBytes("FWS");
			bytes[3]=Version;
			bytes.length=8;//FileLength 未知
			
			var Xmin:int=x*20;
			var Ymin:int=y*20;
			var Xmax:int=(x+width)*20;
			var Ymax:int=(y+height)*20;
			var bGroupValue:int=0;
			var offset:int=8;
			
			//计算所需最小位数:
			var bGroupMixNum:int=((Xmin<0?-Xmin:Xmin)<<1)|((Xmax<0?-Xmax:Xmax)<<1)|((Ymin<0?-Ymin:Ymin)<<1)|((Ymax<0?-Ymax:Ymax)<<1);
			if(bGroupMixNum>>>16){if(bGroupMixNum>>>24){if(bGroupMixNum>>>28){if(bGroupMixNum>>>30){if(bGroupMixNum>>>31){var Nbits:int=32;}else{Nbits=31;}}else{if(bGroupMixNum>>>29){Nbits=30;}else{Nbits=29;}}}else{if(bGroupMixNum>>>26){if(bGroupMixNum>>>27){Nbits=28;}else{Nbits=27;}}else{if(bGroupMixNum>>>25){Nbits=26;}else{Nbits=25;}}}}else{if(bGroupMixNum>>>20){if(bGroupMixNum>>>22){if(bGroupMixNum>>>23){Nbits=24;}else{Nbits=23;}}else{if(bGroupMixNum>>>21){Nbits=22;}else{Nbits=21;}}}else{if(bGroupMixNum>>>18){if(bGroupMixNum>>>19){Nbits=20;}else{Nbits=19;}}else{if(bGroupMixNum>>>17){Nbits=18;}else{Nbits=17;}}}}}else{if(bGroupMixNum>>>8){if(bGroupMixNum>>>12){if(bGroupMixNum>>>14){if(bGroupMixNum>>>15){Nbits=16;}else{Nbits=15;}}else{if(bGroupMixNum>>>13){Nbits=14;}else{Nbits=13;}}}else{if(bGroupMixNum>>>10){if(bGroupMixNum>>>11){Nbits=12;}else{Nbits=11;}}else{if(bGroupMixNum>>>9){Nbits=10;}else{Nbits=9;}}}}else{if(bGroupMixNum>>>4){if(bGroupMixNum>>>6){if(bGroupMixNum>>>7){Nbits=8;}else{Nbits=7;}}else{if(bGroupMixNum>>>5){Nbits=6;}else{Nbits=5;}}}else{if(bGroupMixNum>>>2){if(bGroupMixNum>>>3){Nbits=4;}else{Nbits=3;}}else{if(bGroupMixNum>>>1){Nbits=2;}else{Nbits=bGroupMixNum;}}}}}
			
			bGroupValue|=Nbits<<27;							//11111000 00000000 00000000 00000000
			var bGroupBitsOffset:int=5;
			
			var bGroupRshiftBitsOffset:int=32-Nbits;
			bGroupValue|=(Xmin<<bGroupRshiftBitsOffset)>>>5;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bytes[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;bytes[offset++]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(Xmax<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bytes[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;bytes[offset++]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(Ymin<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入满8位(1字节)的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bGroupBitsOffset-=24;bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bytes[offset++]=bGroupValue>>8;bGroupValue<<=24;}else{bGroupBitsOffset-=16;bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bGroupValue<<=16;}}else if(bGroupBitsOffset>8){bGroupBitsOffset-=8;bytes[offset++]=bGroupValue>>24;bGroupValue<<=8;}
			
			bGroupValue|=(Ymax<<bGroupRshiftBitsOffset)>>>bGroupBitsOffset;
			bGroupBitsOffset+=Nbits;
			
			//向 data 写入有效的数据:
			if(bGroupBitsOffset>16){if(bGroupBitsOffset>24){bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bytes[offset++]=bGroupValue>>8;bytes[offset++]=bGroupValue;}else{bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;bytes[offset++]=bGroupValue>>8;}}else if(bGroupBitsOffset>8){bytes[offset++]=bGroupValue>>24;bytes[offset++]=bGroupValue>>16;}else{bytes[offset++]=bGroupValue>>24;}
			
			bytes[offset++]=FrameRate*256;
			bytes[offset++]=FrameRate;
			if(_toDataOptions&&_toDataOptions.FrameCount>0){//20111205
				FrameCount=_toDataOptions.FrameCount;
			}else{
				FrameCount=Tags.getRealFrameCount(tagV);
			}
			//trace("FrameCount="+FrameCount);
			bytes[offset++]=FrameCount;
			bytes[offset++]=FrameCount>>8;
			
			tagsOffset=offset;//20130206
			
			return bytes;
		}
		
		public function toSWFData_start(_toDataOptions:Object):Object{
			//#####
			if(_toDataOptions&&_toDataOptions.FrameCount>0){//20111205
				FrameCount=_toDataOptions.FrameCount;
			}else{
				FrameCount=Tags.getRealFrameCount(tagV);
			}
			//trace("FrameCount="+FrameCount);
			
			///
			if(_toDataOptions){
			}else{
				_toDataOptions=new Object();
			}
			_toDataOptions.swf_Version=Version;
			
			return _toDataOptions;
		}
		public function toSWFData(_toDataOptions:Object):ByteArray{
			_toDataOptions=toSWFData_start(_toDataOptions);
			
			//临时变量
			var tagsData:ByteArray=new ByteArray();
			
			//@@@@@
			var tagId:int=0;
			while(tagId<tagV.length){
				tagId=Tags.toData_step(
					tagV,
					tagsData,
					tagId,
					tagV.length,
					10000,
					_toDataOptions
				);
			}
			
			return toSWFData_end(tagsData,_toDataOptions);
		}
		public function toSWFData_end(tagsData:ByteArray,_toDataOptions:Object):ByteArray{
			//~~~~~
			var bytes:ByteArray=infoToBytes(_toDataOptions);
			
			//$$$$$
			bytes.position=bytes.length;
			bytes.writeBytes(tagsData);
			return bytes2SWFData(bytes,_toDataOptions);
		}
		
		CONFIG::USE_XML{
			public function infoToXML():XML{
				var infoXML:XML=<SWF
					type={type}
					Version={Version}
					FileLength={FileLength}
					x={x}
					y={y}
					width={width}
					height={height}
					FrameRate={FrameRate}
					FrameCount={FrameCount}
				/>;
				if(x==0){
					delete infoXML.@x;
				}
				if(y==0){
					delete infoXML.@y;
				}
				return infoXML;
			}
			
			public function toXML_start(_toXMLOptions:Object):Object{
				return _toXMLOptions;
			}
			public function toXML(_toXMLOptions:Object):XML{
				_toXMLOptions=toXML_start(_toXMLOptions);
				
				//!临时变量
				var tagsXML:XML=<tags count={tagV.length}/>;
				
				//@@@@@
				var tagId:int=0;
				while(tagId<tagV.length){
					tagId=Tags.toXML_step(
						tagV,
						tagsXML,
						tagId,
						tagV.length,
						10000,
						_toXMLOptions
					);
				}
				
				return toXML_end(tagsXML);
			}
			public function toXML_end(tagsXML:XML):XML{
				//#####
				FrameCount=Tags.getRealFrameCount(tagV);
				
				//~~~~~
				var xml:XML=infoToXML();
				
				//$$$$$
				xml.appendChild(tagsXML);
				return xml;
			}
			
			public function initInfoByXML(infoXML:XML):void{
				type=infoXML.@type.toString();
				Version=int(infoXML.@Version.toString());
				x=Number(infoXML.@x.toString());
				y=Number(infoXML.@y.toString());
				width=Number(infoXML.@width.toString());
				height=Number(infoXML.@height.toString());
				FrameRate=Number(infoXML.@FrameRate.toString());
				FrameCount=int(infoXML.@FrameCount.toString());//仅用于参考
			}
			
			public function initByXML_start(xml:XML,_initByXMLOptions:Object):Object{
				//~~~~~
				initInfoByXML(xml);
				
				//tagV
				tagV=new Vector.<Tag>();
				
				return _initByXMLOptions;
			}
			public function initByXML(xml:XML,_initByXMLOptions:Object):void{
				_initByXMLOptions=initByXML_start(xml,_initByXMLOptions);
				
				//临时变量
				var nodeXMLList:XMLList=xml.tags[0].children();
				
				//@@@@@
				var nodeId:int=0;
				var nodeCount:int=nodeXMLList.length();
				while(nodeId<nodeCount){
					nodeId=Tags.initByXML_step(
						tagV,
						nodeXMLList,
						nodeId,
						nodeCount,
						10000,
						_initByXMLOptions
					);
				}
				
				initByXML_end();
			}
			public function initByXML_end():void{
				//#####
				FrameCount=Tags.getRealFrameCount(tagV);
				
				//$$$$$
			}
		}//end of CONFIG::USE_XML
	}
}
		