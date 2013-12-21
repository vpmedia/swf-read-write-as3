
//原代码来自：http://bbs.9ria.com/thread-103658-1-1.html
//20120518修改

package zero.codec{
	
	import flash.utils.ByteArray;
	
	public function LZMAUncompressSWF(swfData:ByteArray):ByteArray{
		
		var props:int=swfData[12];//93（0x5d）
		var posStates:int=1<<(props/9/5);//4
		var numPosBits:int=props/9%5;//0
		var numPrevBits:int=props%9;//3
		var posMask:int=(1<<numPosBits)-1;//0
		var numStates:int=1<<(numPrevBits+numPosBits);//8
		
		var i:int;
		
		var posDecoders:Vector.<int>=decoder_114.slice();
		posDecoders.fixed=true;
		
		var isRepDecoders:Vector.<int>=decoder_12.slice();
		isRepDecoders.fixed=true;
		
		var isRepG0Decoders:Vector.<int>=decoder_12.slice();
		isRepG0Decoders.fixed=true;
		
		var isRepG1Decoders:Vector.<int>=decoder_12.slice();
		isRepG1Decoders.fixed=true;
		
		var isRepG2Decoders:Vector.<int>=decoder_12.slice();
		isRepG2Decoders.fixed=true;
		
		var isMatchDecoders:Vector.<int>=decoder_192.slice();
		isMatchDecoders.fixed=true;
		
		var isRep0LongDecoders:Vector.<int>=decoder_192.slice();
		isRep0LongDecoders.fixed=true;
		
		var decoders:Vector.<Vector.<int>>=new Vector.<Vector.<int>>(numStates,true);
		i=numStates;
		while(i){
			i--;
			decoders[i]=decoder_0x300.slice();
			decoders[i].fixed=true;
		}
		
		var posSlotDecoder_modelss:Vector.<Vector.<int>>=new <Vector.<int>>[
			decoder_64.slice(),
			decoder_64.slice(),
			decoder_64.slice(),
			decoder_64.slice()
		];
		posSlotDecoder_modelss.fixed=true;
		posSlotDecoder_modelss[0].fixed=true;
		posSlotDecoder_modelss[1].fixed=true;
		posSlotDecoder_modelss[2].fixed=true;
		posSlotDecoder_modelss[3].fixed=true;
		
		var posAlignDecoder_models:Vector.<int>=decoder_16.slice();
		posAlignDecoder_models.fixed=true;
		
		//var repLenDecoder:LenDecoder=new LenDecoder(posStates);
		var repLenDecoder_choice:Vector.<int>=decoder_2.slice();
		repLenDecoder_choice.fixed=true;
		var repLenDecoder_lowCoder_modelss:Vector.<Vector.<int>>=new Vector.<Vector.<int>>(posStates,true);
		var repLenDecoder_midCoder_modelss:Vector.<Vector.<int>>=new Vector.<Vector.<int>>(posStates,true);
		i=posStates;
		while(i){
			i--;
			repLenDecoder_lowCoder_modelss[i]=decoder_8.slice();
			repLenDecoder_lowCoder_modelss[i].fixed=true;
			repLenDecoder_midCoder_modelss[i]=decoder_8.slice();
			repLenDecoder_midCoder_modelss[i].fixed=true;
		}
		var repLenDecoder_highCoder_models:Vector.<int>=decoder_256.slice();
		repLenDecoder_highCoder_models.fixed=true;
		
		//var lenDecoder:LenDecoder=new LenDecoder(posStates);
		var lenDecoder_choice:Vector.<int>=decoder_2.slice();
		lenDecoder_choice.fixed=true;
		var lenDecoder_lowCoder_modelss:Vector.<Vector.<int>>=new Vector.<Vector.<int>>(posStates,true);
		var lenDecoder_midCoder_modelss:Vector.<Vector.<int>>=new Vector.<Vector.<int>>(posStates,true);
		i=posStates;
		while(i){
			i--;
			lenDecoder_lowCoder_modelss[i]=decoder_8.slice();
			lenDecoder_lowCoder_modelss[i].fixed=true;
			lenDecoder_midCoder_modelss[i]=decoder_8.slice();
			lenDecoder_midCoder_modelss[i].fixed=true;
		}
		var lenDecoder_highCoder_models:Vector.<int>=decoder_256.slice();
		lenDecoder_highCoder_models.fixed=true;
		
		//5f 78 00 00 5d 00 00 00 01 00 3b ff fc a6 14 16...
		//inputPos-------------------^
		//inputPos=17;
		var inputPos:int=18;
		var code:int=
			//(inputData[inputPos++]<<32) ---------------?
			//|
			(swfData[inputPos++]<<24)
			|
			(swfData[inputPos++]<<16)
			|
			(swfData[inputPos++]<<8)
			|
			swfData[inputPos++];
		//trace("code="+code.toString(16));//3bfffca6
		
		//5f 78 00 00 5d 00 00 00 01 00 3b ff fc a6 14 16...
		//inputPos----------------------------------^
		
		var range:int=-1;
		
		var nowPos64:int=0;
		var state:int=0;
		var prevByte:int=0;
		
		var rep0:int=0;
		var rep1:int=0;
		var rep2:int=0;
		var rep3:int=0;
		
		var len:int,distance:int,m:int,prob:int,newBound:int,models:Vector.<int>;
		
		var outputData:ByteArray=new ByteArray();
		var outputPos:int=0;
		var outputSize:int=swfData[4]|(swfData[5]<<8)|(swfData[6]<<16)|(swfData[7]<<24);
		
		posStates--;//3
		
		while(nowPos64<outputSize){
			var posState:int=nowPos64&posStates;//0,1,2,3
			
			prob=isMatchDecoders[(state<<4)+posState];
			newBound=(range>>>11)*prob;
			if((code^0x80000000)<(newBound^0x80000000)){
				range=newBound;
				prob+=((2048-prob)>>>5);
				if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
				isMatchDecoders[(state<<4)+posState]=prob;
				
				i=((nowPos64&posMask)<<numPrevBits)+((prevByte&0xFF)>>>(8-numPrevBits));
				if(state<7){
					prevByte=1;
					while(prevByte<0x100){
						
						prob=decoders[i][prevByte];
						newBound=(range>>>11)*prob;
						if((code^0x80000000)<(newBound^0x80000000)){
							range=newBound;
							prob+=((2048-prob)>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							decoders[i][prevByte]=prob;
							
							prevByte<<=1;
						}else{
							range-=newBound;
							code-=newBound;prob-=(prob>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							decoders[i][prevByte]=prob;
							
							prevByte=(prevByte<<1)|1;
						}
						
					}
				}else{
					var matchByte:int=outputData[outputPos-rep0-1];
					for(prevByte=1;prevByte<0x100;matchByte<<=1){
						if((matchByte>>7)&1){
							
							prob=decoders[i][512+prevByte];
							newBound=(range>>>11)*prob;
							if((code^0x80000000)<(newBound^0x80000000)){
								range=newBound;
								prob+=((2048-prob)>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								decoders[i][512+prevByte]=prob;
								
								prevByte<<=1;
								while(prevByte<0x100){
									
									prob=decoders[i][prevByte];
									newBound=(range>>>11)*prob;
									if((code^0x80000000)<(newBound^0x80000000)){
										range=newBound;
										prob+=((2048-prob)>>>5);
										if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
										decoders[i][prevByte]=prob;
										
										prevByte<<=1;
									}else{
										range-=newBound;
										code-=newBound;prob-=(prob>>>5);
										if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
										decoders[i][prevByte]=prob;
										
										prevByte=(prevByte<<1)|1;
									}
									
								}
								break;
							}else{
								range-=newBound;
								code-=newBound;prob-=(prob>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								decoders[i][512+prevByte]=prob;
								
								prevByte=(prevByte<<1)|1;
							}
						}else{
							
							prob=decoders[i][256+prevByte];
							newBound=(range>>>11)*prob;
							if((code^0x80000000)<(newBound^0x80000000)){
								range=newBound;
								prob+=((2048-prob)>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								decoders[i][256+prevByte]=prob;
								
								prevByte<<=1;
							}else{
								range-=newBound;
								code-=newBound;prob-=(prob>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								decoders[i][256+prevByte]=prob;
								
								prevByte=(prevByte<<1)|1;
								while(prevByte<0x100){
									
									prob=decoders[i][prevByte];
									newBound=(range>>>11)*prob;
									if((code^0x80000000)<(newBound^0x80000000)){
										range=newBound;
										prob+=((2048-prob)>>>5);
										if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
										decoders[i][prevByte]=prob;
										
										prevByte<<=1;
									}else{
										range-=newBound;
										code-=newBound;prob-=(prob>>>5);
										if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
										decoders[i][prevByte]=prob;
										
										prevByte=(prevByte<<1)|1;
									}
									
								}
								break;
							}
						}
					}
				}
				if(state<4){
					state=0;
				}else if(state<10){
					state-=3;
				}else{
					state-=6;
				}
				outputData[outputPos++]=prevByte;
				nowPos64++;
			}else{
				range-=newBound;
				code-=newBound;prob-=(prob>>>5);
				if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
				isMatchDecoders[(state<<4)+posState]=prob;
				
				prob=isRepDecoders[state];
				newBound=(range>>>11)*prob;
				if((code^0x80000000)<(newBound^0x80000000)){
					range=newBound;
					prob+=((2048-prob)>>>5);
					if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					isRepDecoders[state]=prob;
					
					rep3=rep2;
					rep2=rep1;
					rep1=rep0;
					
					//len=lenDecoder.decode(this,posState)+2;
					prob=lenDecoder_choice[0];
					newBound=(range>>>11)*prob;
					if((code^0x80000000)<(newBound^0x80000000)){
						range=newBound;
						prob+=((2048-prob)>>>5);
						if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
						lenDecoder_choice[0]=prob;
						
						models=lenDecoder_lowCoder_modelss[posState];
						m=0x08;
						prob=models[1];
						newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
						models[1]=prob;
						prob=models[m>>>2];
						newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
						models[m>>>2]=prob;
						prob=models[m>>>1];
						newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
						models[m>>>1]=prob;
						len=m-6;
					}else{
						range-=newBound;
						code-=newBound;prob-=(prob>>>5);
						if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
						lenDecoder_choice[0]=prob;
						
						prob=lenDecoder_choice[1];
						newBound=(range>>>11)*prob;
						if((code^0x80000000)<(newBound^0x80000000)){
							range=newBound;
							prob+=((2048-prob)>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_choice[1]=prob;
							
							models=lenDecoder_midCoder_modelss[posState];
							m=0x08;
							prob=models[1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							models[1]=prob;
							prob=models[m>>>2];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							models[m>>>2]=prob;
							prob=models[m>>>1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							models[m>>>1]=prob;
							len=m+2;
						}else{
							range-=newBound;
							code-=newBound;prob-=(prob>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_choice[1]=prob;
							
							m=0x100;
							prob=lenDecoder_highCoder_models[1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x80;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[1]=prob;
							prob=lenDecoder_highCoder_models[m>>>7];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x40;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[m>>>7]=prob;
							prob=lenDecoder_highCoder_models[m>>>6];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x20;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[m>>>6]=prob;
							prob=lenDecoder_highCoder_models[m>>>5];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x10;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[m>>>5]=prob;
							prob=lenDecoder_highCoder_models[m>>>4];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x08;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[m>>>4]=prob;
							prob=lenDecoder_highCoder_models[m>>>3];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[m>>>3]=prob;
							prob=lenDecoder_highCoder_models[m>>>2];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[m>>>2]=prob;
							prob=lenDecoder_highCoder_models[m>>>1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							lenDecoder_highCoder_models[m>>>1]=prob;
							len=0x10+m-0x100+2;
						}
					}
					
					if(state<7){
						state=7;
					}else{
						state=10;
					}
					
					models=posSlotDecoder_modelss[len<6?len-2:3];
					m=0x40;
					prob=models[1];
					newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x20;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					models[1]=prob;
					prob=models[m>>>5];
					newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x10;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					models[m>>>5]=prob;
					prob=models[m>>>4];
					newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x08;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					models[m>>>4]=prob;
					prob=models[m>>>3];
					newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					models[m>>>3]=prob;
					prob=models[m>>>2];
					newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					models[m>>>2]=prob;
					prob=models[m>>>1];
					newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					models[m>>>1]=prob;
					var posSlot:int=m-0x40;
					
					if(posSlot>=4){
						var numDirectBits:int=(posSlot>>1)-1;
						rep0=(2|(posSlot&1))<<numDirectBits;
						if(posSlot<14){
							m=1;
							var startIndex:int=rep0-posSlot-1;
							for(var bitIndex:int=0;bitIndex<numDirectBits;bitIndex++){
								
								prob=posDecoders[startIndex+m];
								newBound=(range>>>11)*prob;
								if((code^0x80000000)<(newBound^0x80000000)){
									range=newBound;
									prob+=((2048-prob)>>>5);
									if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									posDecoders[startIndex+m]=prob;
									
									m<<=1;
								}else{
									range-=newBound;
									code-=newBound;prob-=(prob>>>5);
									if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									posDecoders[startIndex+m]=prob;
									
									m=(m<<1)|1;
									rep0+=(1<<bitIndex);
								}
								
							}
						}else{
							
							//rep0+=(decodeDirectBits(numDirectBits-4)<<4);
							i=numDirectBits-4;
							while(i){
								i--;
								range>>>=1;
								if(((code-range)>>>31)){
								}else{
									rep0+=(1<<(i+4));
									code-=range;
								}
								if((range&0xff000000)){
								}else{
									code=(code<<8)|swfData[inputPos++];
									range<<=8;
								}
							}
							//
							
							m=0x10;
							prob=posAlignDecoder_models[1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x08;rep0+=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							posAlignDecoder_models[1]=prob;
							prob=posAlignDecoder_models[m>>>3];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;rep0+=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							posAlignDecoder_models[m>>>3]=prob;
							prob=posAlignDecoder_models[m>>>2];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;rep0+=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							posAlignDecoder_models[m>>>2]=prob;
							prob=posAlignDecoder_models[m>>>1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;rep0+=0x08;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							posAlignDecoder_models[m>>>1]=prob;
							if(rep0<0){
								if(rep0==-1){
									break;
								}
								throw new Error("LZMAUncompressSWF 失败：rep0="+rep0);
							}
						}
					}else{
						rep0=posSlot;
					}
				}else{
					range-=newBound;
					code-=newBound;prob-=(prob>>>5);
					if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
					isRepDecoders[state]=prob;
					
					prob=isRepG0Decoders[state];
					newBound=(range>>>11)*prob;
					if((code^0x80000000)<(newBound^0x80000000)){
						range=newBound;
						prob+=((2048-prob)>>>5);
						if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
						isRepG0Decoders[state]=prob;
						
						prob=isRep0LongDecoders[(state<<4)+posState];
						newBound=(range>>>11)*prob;
						if((code^0x80000000)<(newBound^0x80000000)){
							range=newBound;
							prob+=((2048-prob)>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							isRep0LongDecoders[(state<<4)+posState]=prob;
							
							len=1;
							if(state<7){
								state=9;
							}else{
								state=11;
							}
						}else{
							range-=newBound;
							code-=newBound;prob-=(prob>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							isRep0LongDecoders[(state<<4)+posState]=prob;
							
							//len=repLenDecoder.decode(this,posState)+2;//跟下面一样
							prob=repLenDecoder_choice[0];
							newBound=(range>>>11)*prob;
							if((code^0x80000000)<(newBound^0x80000000)){
								range=newBound;
								prob+=((2048-prob)>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_choice[0]=prob;
								
								models=repLenDecoder_lowCoder_modelss[posState];
								m=0x08;
								prob=models[1];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								models[1]=prob;
								prob=models[m>>>2];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								models[m>>>2]=prob;
								prob=models[m>>>1];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								models[m>>>1]=prob;
								len=m-6;
							}else{
								range-=newBound;
								code-=newBound;prob-=(prob>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_choice[0]=prob;
								
								prob=repLenDecoder_choice[1];
								newBound=(range>>>11)*prob;
								if((code^0x80000000)<(newBound^0x80000000)){
									range=newBound;
									prob+=((2048-prob)>>>5);
									if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_choice[1]=prob;
									
									models=repLenDecoder_midCoder_modelss[posState];
									m=0x08;
									prob=models[1];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									models[1]=prob;
									prob=models[m>>>2];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									models[m>>>2]=prob;
									prob=models[m>>>1];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									models[m>>>1]=prob;
									len=m+2;
								}else{
									range-=newBound;
									code-=newBound;prob-=(prob>>>5);
									if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_choice[1]=prob;
									
									m=0x100;
									prob=repLenDecoder_highCoder_models[1];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x80;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[1]=prob;
									prob=repLenDecoder_highCoder_models[m>>>7];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x40;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[m>>>7]=prob;
									prob=repLenDecoder_highCoder_models[m>>>6];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x20;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[m>>>6]=prob;
									prob=repLenDecoder_highCoder_models[m>>>5];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x10;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[m>>>5]=prob;
									prob=repLenDecoder_highCoder_models[m>>>4];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x08;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[m>>>4]=prob;
									prob=repLenDecoder_highCoder_models[m>>>3];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[m>>>3]=prob;
									prob=repLenDecoder_highCoder_models[m>>>2];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[m>>>2]=prob;
									prob=repLenDecoder_highCoder_models[m>>>1];
									newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
									repLenDecoder_highCoder_models[m>>>1]=prob;
									len=0x10+m-0x100+2;
								}
							}
							
							if(state<7){
								state=8;
							}else{
								state=11;
							}
							//
							
						}
					}else{
						range-=newBound;
						code-=newBound;prob-=(prob>>>5);
						if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
						isRepG0Decoders[state]=prob;
						
						prob=isRepG1Decoders[state];
						newBound=(range>>>11)*prob;
						if((code^0x80000000)<(newBound^0x80000000)){
							range=newBound;
							prob+=((2048-prob)>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							isRepG1Decoders[state]=prob;
							
							distance=rep1;
						}else{
							range-=newBound;
							code-=newBound;prob-=(prob>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							isRepG1Decoders[state]=prob;
							
							prob=isRepG2Decoders[state];
							newBound=(range>>>11)*prob;
							if((code^0x80000000)<(newBound^0x80000000)){
								range=newBound;
								prob+=((2048-prob)>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								isRepG2Decoders[state]=prob;
								
								distance=rep2;
							}else{
								range-=newBound;
								code-=newBound;prob-=(prob>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								isRepG2Decoders[state]=prob;
								
								distance=rep3;
								rep3=rep2;
							}
							
							rep2=rep1;
						}
						
						rep1=rep0;
						rep0=distance;
						
						//len=repLenDecoder.decode(this,posState)+2;//跟上面一样
						prob=repLenDecoder_choice[0];
						newBound=(range>>>11)*prob;
						if((code^0x80000000)<(newBound^0x80000000)){
							range=newBound;
							prob+=((2048-prob)>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							repLenDecoder_choice[0]=prob;
							
							models=repLenDecoder_lowCoder_modelss[posState];
							m=0x08;
							prob=models[1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							models[1]=prob;
							prob=models[m>>>2];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							models[m>>>2]=prob;
							prob=models[m>>>1];
							newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							models[m>>>1]=prob;
							len=m-6;
						}else{
							range-=newBound;
							code-=newBound;prob-=(prob>>>5);
							if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
							repLenDecoder_choice[0]=prob;
							
							prob=repLenDecoder_choice[1];
							newBound=(range>>>11)*prob;
							if((code^0x80000000)<(newBound^0x80000000)){
								range=newBound;
								prob+=((2048-prob)>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_choice[1]=prob;
								
								models=repLenDecoder_midCoder_modelss[posState];
								m=0x08;
								prob=models[1];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								models[1]=prob;
								prob=models[m>>>2];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								models[m>>>2]=prob;
								prob=models[m>>>1];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								models[m>>>1]=prob;
								len=m+2;
							}else{
								range-=newBound;
								code-=newBound;prob-=(prob>>>5);
								if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_choice[1]=prob;
								
								m=0x100;
								prob=repLenDecoder_highCoder_models[1];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x80;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[1]=prob;
								prob=repLenDecoder_highCoder_models[m>>>7];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x40;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[m>>>7]=prob;
								prob=repLenDecoder_highCoder_models[m>>>6];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x20;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[m>>>6]=prob;
								prob=repLenDecoder_highCoder_models[m>>>5];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x10;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[m>>>5]=prob;
								prob=repLenDecoder_highCoder_models[m>>>4];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x08;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[m>>>4]=prob;
								prob=repLenDecoder_highCoder_models[m>>>3];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x04;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[m>>>3]=prob;
								prob=repLenDecoder_highCoder_models[m>>>2];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x02;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[m>>>2]=prob;
								prob=repLenDecoder_highCoder_models[m>>>1];
								newBound=(range>>>11)*prob;if((code^0x80000000)<(newBound^0x80000000)){range=newBound;prob+=((2048-prob)>>>5);}else{m|=0x01;range-=newBound;code-=newBound;prob-=(prob>>>5);}if((range&0xff000000)){}else{code=(code<<8)|swfData[inputPos++];range<<=8;}
								repLenDecoder_highCoder_models[m>>>1]=prob;
								len=0x10+m-0x100+2;
							}
						}
						
						if(state<7){
							state=8;
						}else{
							state=11;
						}
						//
					}
				}
				i=len;
				while(i){
					i--;
					outputData[outputPos]=outputData[outputPos-rep0-1];
					outputPos++;
				}
				nowPos64+=len;
				prevByte=outputData[outputPos-1];
			}
		}
		return outputData;
	}
}

function get_decoder(i:int):Vector.<int>{
	var decoder:Vector.<int>=new Vector.<int>(i,true);
	while(i){decoder[--i]=1024;}
	return decoder;
}
const decoder_2:Vector.<int>=get_decoder(2);
const decoder_8:Vector.<int>=get_decoder(8);
const decoder_12:Vector.<int>=get_decoder(12);
const decoder_16:Vector.<int>=get_decoder(16);
const decoder_64:Vector.<int>=get_decoder(64);
const decoder_114:Vector.<int>=get_decoder(114);
const decoder_192:Vector.<int>=get_decoder(192);
const decoder_256:Vector.<int>=get_decoder(256);
const decoder_0x300:Vector.<int>=get_decoder(0x300);
