/***
getAllTraitsAndMethods
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；已婚（单身美女们没机会了~~）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2013年05月03日 09:29:01
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.utils{
	import flash.utils.Dictionary;
	
	import zero.swf.avm2.ABCClass;
	import zero.swf.avm2.ABCClasses;
	import zero.swf.avm2.ABCMethod;
	import zero.swf.avm2.ABCScript;
	import zero.swf.avm2.ABCTrait;
	import zero.swf.avm2.AVM2Ops;
	import zero.swf.avm2.TraitTypeAndAttributes;
	
	/**
	 *获取所有 trait 和 method 
	 */	
	public function getAllTraitsAndMethods(ABCData:ABCClasses,allTraitV:Vector.<ABCTrait>,allMethodV:Vector.<ABCMethod>):void{
		
		var seed:Array=new Array();
		var dict:Dictionary=new Dictionary();
		
		for each(var clazz:ABCClass in ABCData.classV){
			if(clazz.iinit){
				if(dict[clazz.iinit]){
				}else{
					dict[clazz.iinit]=true;
					seed.push(clazz.iinit);
					allMethodV.push(clazz.iinit);
				}
			}
			for each(var trait:ABCTrait in clazz.itraitV){
				if(dict[trait]){
				}else{
					dict[trait]=true;
					seed.push(trait);
					allTraitV.push(trait);
				}
			}
			if(clazz.cinit){
				if(dict[clazz.cinit]){
				}else{
					dict[clazz.cinit]=true;
					seed.push(clazz.cinit);
					allMethodV.push(clazz.cinit);
				}
			}
			for each(trait in clazz.ctraitV){
				if(dict[trait]){
				}else{
					dict[trait]=true;
					seed.push(trait);
					allTraitV.push(trait);
				}
			}
		}
		
		for each(var script:ABCScript in ABCData.scriptV){
			if(script.init){
				if(dict[script.init]){
				}else{
					dict[script.init]=true;
					seed.push(script.init);
					allMethodV.push(script.init);
				}
			}
			for each(trait in script.traitV){
				if(dict[trait]){
				}else{
					dict[trait]=true;
					seed.push(trait);
					allTraitV.push(trait);
				}
			}
		}
		
		do{
			var newSeed:Array=new Array();
			for each(var element:* in seed){
				switch(element.constructor){
					case ABCTrait:
						trait=element;
						switch(trait.kind_trait_type){
							case TraitTypeAndAttributes.Method:
							case TraitTypeAndAttributes.Getter:
							case TraitTypeAndAttributes.Setter:
								if(trait.method){
									if(dict[trait.method]){
									}else{
										dict[trait.method]=true;
										seed.push(trait.method);
										allMethodV.push(trait.method);
									}
								}
							break;
							case TraitTypeAndAttributes.Function_:
								if(trait.function_){
									if(dict[trait.function_]){
									}else{
										dict[trait.function_]=true;
										seed.push(trait.function_);
										allMethodV.push(trait.function_);
									}
								}
							break;
						}
					break;
					case ABCMethod:
						var method:ABCMethod=element;
						if(method.codes){
							for each(var code:Object in method.codes.codeArr){
								if(code.op>-1){
									switch(AVM2Ops.valueTypeV[code.op]){
										case "methodid":
										case "methodid,arg_count":
											if(code.method){
												if(dict[code.method]){
												}else{
													dict[code.method]=true;
													seed.push(code.method);
													allMethodV.push(code.method);
												}
											}
										break;
										//case "dispid,arg_count":
										//	//
										//break;
									}
								}
							}
						}
						for each(trait in method.traitV){
							if(dict[trait]){
							}else{
								dict[trait]=true;
								seed.push(trait);
								allTraitV.push(trait);
							}
						}
					break;
				}
			}
			seed=newSeed;
		}while(seed.length);
		
	}
	
}