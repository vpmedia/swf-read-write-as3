/***
AVM2Ops
创建人：ZЁЯ¤　身高：168cm+；体重：57kg+；未婚（已有女友）；最爱的运动：睡觉；格言：路见不平，拔腿就跑。QQ：358315553。
创建时间：2011年7月5日 13:52:18（代码生成器 V2.0.0 F:/airs/program files2/CodesGenerater/bin-debug/CodesGenerater.swf）
简要说明：这家伙很懒什么都没写。
用法举例：这家伙还是很懒什么都没写。
*/

package zero.swf.avm2{

	public class AVM2Ops{
		//0x00
		public static const bkpt:int=1;//0x01
		public static const nop:int=2;//0x02
		public static const throw_:int=3;//0x03
		public static const getsuper:int=4;//0x04
		public static const setsuper:int=5;//0x05
		public static const dxns:int=6;//0x06
		public static const dxnslate:int=7;//0x07
		public static const kill:int=8;//0x08
		public static const label:int=9;//0x09
		//0x0a
		//0x0b
		public static const ifnlt:int=12;//0x0c
		public static const ifnle:int=13;//0x0d
		public static const ifngt:int=14;//0x0e
		public static const ifnge:int=15;//0x0f
		public static const jump:int=16;//0x10
		public static const iftrue:int=17;//0x11
		public static const iffalse:int=18;//0x12
		public static const ifeq:int=19;//0x13
		public static const ifne:int=20;//0x14
		public static const iflt:int=21;//0x15
		public static const ifle:int=22;//0x16
		public static const ifgt:int=23;//0x17
		public static const ifge:int=24;//0x18
		public static const ifstricteq:int=25;//0x19
		public static const ifstrictne:int=26;//0x1a
		public static const lookupswitch:int=27;//0x1b
		public static const pushwith:int=28;//0x1c
		public static const popscope:int=29;//0x1d
		public static const nextname:int=30;//0x1e
		public static const hasnext:int=31;//0x1f
		public static const pushnull:int=32;//0x20
		public static const pushundefined:int=33;//0x21
		//public static const pushconstant:int=34;//0x22
		public static const nextvalue:int=35;//0x23
		public static const pushbyte:int=36;//0x24
		public static const pushshort:int=37;//0x25
		public static const pushtrue:int=38;//0x26
		public static const pushfalse:int=39;//0x27
		public static const pushnan:int=40;//0x28
		public static const pop:int=41;//0x29
		public static const dup:int=42;//0x2a
		public static const swap:int=43;//0x2b
		public static const pushstring:int=44;//0x2c
		public static const pushint:int=45;//0x2d
		public static const pushuint:int=46;//0x2e
		public static const pushdouble:int=47;//0x2f
		public static const pushscope:int=48;//0x30
		public static const pushnamespace:int=49;//0x31
		public static const hasnext2:int=50;//0x32
		//0x33
		//0x34
		public static const li8:int=53;//0x35
		public static const li16:int=54;//0x36
		public static const li32:int=55;//0x37
		public static const lf32:int=56;//0x38
		public static const lf64:int=57;//0x39
		public static const si8:int=58;//0x3a
		public static const si16:int=59;//0x3b
		public static const si32:int=60;//0x3c
		public static const sf32:int=61;//0x3d
		public static const sf64:int=62;//0x3e
		//0x3f
		public static const newfunction:int=64;//0x40
		public static const call:int=65;//0x41
		public static const construct:int=66;//0x42
		public static const callmethod:int=67;//0x43
		public static const callstatic:int=68;//0x44
		public static const callsuper:int=69;//0x45
		public static const callproperty:int=70;//0x46
		public static const returnvoid:int=71;//0x47
		public static const returnvalue:int=72;//0x48
		public static const constructsuper:int=73;//0x49
		public static const constructprop:int=74;//0x4a
		//public static const callsuperid:int=75;//0x4b
		public static const callproplex:int=76;//0x4c
		//public static const callinterface:int=77;//0x4d
		public static const callsupervoid:int=78;//0x4e
		public static const callpropvoid:int=79;//0x4f
		public static const sxi1:int=80;//0x50
		public static const sxi8:int=81;//0x51
		public static const sxi16:int=82;//0x52
		public static const applytype:int=83;//0x53
		//0x54
		public static const newobject:int=85;//0x55
		public static const newarray:int=86;//0x56
		public static const newactivation:int=87;//0x57
		public static const newclass:int=88;//0x58
		public static const getdescendants:int=89;//0x59
		public static const newcatch:int=90;//0x5a
		//0x5b
		//0x5c
		public static const findpropstrict:int=93;//0x5d
		public static const findproperty:int=94;//0x5e
		public static const finddef:int=95;//0x5f
		public static const getlex:int=96;//0x60
		public static const setproperty:int=97;//0x61
		public static const getlocal:int=98;//0x62
		public static const setlocal:int=99;//0x63
		public static const getglobalscope:int=100;//0x64			//stack[++stackTop]=[object global]
		public static const getscopeobject:int=101;//0x65			//stack[++stackTop]=scopeStack[id]		//getscopeobject 0 跟 getglobalscope 不等价
		public static const getproperty:int=102;//0x66
		//public static const getouterscope:int=103;//0x67
		public static const initproperty:int=104;//0x68
		//public static const setpropertylate:int=105;//0x69
		public static const deleteproperty:int=106;//0x6a
		//public static const deletepropertylate:int=107;//0x6b
		public static const getslot:int=108;//0x6c
		public static const setslot:int=109;//0x6d
		public static const getglobalslot:int=110;//0x6e
		public static const setglobalslot:int=111;//0x6f
		public static const convert_s:int=112;//0x70
		public static const esc_xelem:int=113;//0x71
		public static const esc_xattr:int=114;//0x72
		public static const convert_i:int=115;//0x73
		public static const convert_u:int=116;//0x74
		public static const convert_d:int=117;//0x75
		public static const convert_b:int=118;//0x76
		public static const convert_o:int=119;//0x77
		public static const checkfilter:int=120;//0x78
		//0x79
		//0x7a
		//0x7b
		//0x7c
		//0x7d
		//0x7e
		//0x7f
		public static const coerce:int=128;//0x80
		public static const coerce_b:int=129;//0x81
		public static const coerce_a:int=130;//0x82
		public static const coerce_i:int=131;//0x83
		public static const coerce_d:int=132;//0x84
		public static const coerce_s:int=133;//0x85
		public static const astype:int=134;//0x86
		public static const astypelate:int=135;//0x87
		public static const coerce_u:int=136;//0x88
		public static const coerce_o:int=137;//0x89
		//0x8a
		//0x8b
		//0x8c
		//0x8d
		//0x8e
		//0x8f
		public static const negate:int=144;//0x90
		public static const increment:int=145;//0x91
		public static const inclocal:int=146;//0x92
		public static const decrement:int=147;//0x93
		public static const declocal:int=148;//0x94
		public static const typeof_:int=149;//0x95
		public static const not:int=150;//0x96
		public static const bitnot:int=151;//0x97
		//0x98
		//0x99
		//public static const concat:int=154;//0x9a
		//public static const add_d:int=155;//0x9b
		//0x9c
		//0x9d
		//0x9e
		//0x9f
		public static const add:int=160;//0xa0
		public static const subtract:int=161;//0xa1
		public static const multiply:int=162;//0xa2
		public static const divide:int=163;//0xa3
		public static const modulo:int=164;//0xa4
		public static const lshift:int=165;//0xa5
		public static const rshift:int=166;//0xa6
		public static const urshift:int=167;//0xa7
		public static const bitand:int=168;//0xa8
		public static const bitor:int=169;//0xa9
		public static const bitxor:int=170;//0xaa
		public static const equals:int=171;//0xab
		public static const strictequals:int=172;//0xac
		public static const lessthan:int=173;//0xad
		public static const lessequals:int=174;//0xae
		public static const greaterthan:int=175;//0xaf
		public static const greaterequals:int=176;//0xb0
		public static const instanceof_:int=177;//0xb1
		public static const istype:int=178;//0xb2
		public static const istypelate:int=179;//0xb3
		public static const in_:int=180;//0xb4
		//0xb5
		//0xb6
		//0xb7
		//0xb8
		//0xb9
		//0xba
		//0xbb
		//0xbc
		//0xbd
		//0xbe
		//0xbf
		public static const increment_i:int=192;//0xc0
		public static const decrement_i:int=193;//0xc1
		public static const inclocal_i:int=194;//0xc2
		public static const declocal_i:int=195;//0xc3
		public static const negate_i:int=196;//0xc4
		public static const add_i:int=197;//0xc5
		public static const subtract_i:int=198;//0xc6
		public static const multiply_i:int=199;//0xc7
		//0xc8
		//0xc9
		//0xca
		//0xcb
		//0xcc
		//0xcd
		//0xce
		//0xcf
		public static const getlocal0:int=208;//0xd0
		public static const getlocal1:int=209;//0xd1
		public static const getlocal2:int=210;//0xd2
		public static const getlocal3:int=211;//0xd3
		public static const setlocal0:int=212;//0xd4
		public static const setlocal1:int=213;//0xd5
		public static const setlocal2:int=214;//0xd6
		public static const setlocal3:int=215;//0xd7
		//0xd8
		//0xd9
		//0xda
		//0xdb
		//0xdc
		//0xdd
		//0xde
		//0xdf
		//0xe0
		//0xe1
		//0xe2
		//0xe3
		//0xe4
		//0xe5
		//0xe6
		//0xe7
		//0xe8
		//0xe9
		//0xea
		//0xeb
		//0xec
		//0xed
		//0xee
		public static const debug:int=239;//0xef
		public static const debugline:int=240;//0xf0
		public static const debugfile:int=241;//0xf1
		public static const bkptline:int=242;//0xf2
		public static const timestamp:int=243;//0xf3
		//0xf4
		//public static const verifypass:int=245;//0xf5
		//public static const alloc:int=246;//0xf6
		//public static const mark:int=247;//0xf7
		//public static const wb:int=248;//0xf8
		//public static const prologue:int=249;//0xf9
		//public static const sendenter:int=250;//0xfa
		//public static const doubletoatom:int=251;//0xfb
		//public static const sweep:int=252;//0xfc
		//public static const codegenop:int=253;//0xfd
		//public static const verifyop:int=254;//0xfe
		//public static const decode:int=255;//0xff
		
		public static const nameV:Vector.<String>=new <String>[
			null,//0x00
			"bkpt",//0x01
			"nop",//0x02
			"throw_",//0x03
			"getsuper",//0x04
			"setsuper",//0x05
			"dxns",//0x06
			"dxnslate",//0x07
			"kill",//0x08
			"label",//0x09
			null,//0x0a
			null,//0x0b
			"ifnlt",//0x0c
			"ifnle",//0x0d
			"ifngt",//0x0e
			"ifnge",//0x0f
			"jump",//0x10
			"iftrue",//0x11
			"iffalse",//0x12
			"ifeq",//0x13
			"ifne",//0x14
			"iflt",//0x15
			"ifle",//0x16
			"ifgt",//0x17
			"ifge",//0x18
			"ifstricteq",//0x19
			"ifstrictne",//0x1a
			"lookupswitch",//0x1b
			"pushwith",//0x1c
			"popscope",//0x1d
			"nextname",//0x1e
			"hasnext",//0x1f
			"pushnull",//0x20
			"pushundefined",//0x21
			null,//0x22
			"nextvalue",//0x23
			"pushbyte",//0x24
			"pushshort",//0x25
			"pushtrue",//0x26
			"pushfalse",//0x27
			"pushnan",//0x28
			"pop",//0x29
			"dup",//0x2a
			"swap",//0x2b
			"pushstring",//0x2c
			"pushint",//0x2d
			"pushuint",//0x2e
			"pushdouble",//0x2f
			"pushscope",//0x30
			"pushnamespace",//0x31
			"hasnext2",//0x32
			null,//0x33
			null,//0x34
			"li8",//0x35
			"li16",//0x36
			"li32",//0x37
			"lf32",//0x38
			"lf64",//0x39
			"si8",//0x3a
			"si16",//0x3b
			"si32",//0x3c
			"sf32",//0x3d
			"sf64",//0x3e
			null,//0x3f
			"newfunction",//0x40
			"call",//0x41
			"construct",//0x42
			"callmethod",//0x43
			"callstatic",//0x44
			"callsuper",//0x45
			"callproperty",//0x46
			"returnvoid",//0x47
			"returnvalue",//0x48
			"constructsuper",//0x49
			"constructprop",//0x4a
			null,//0x4b
			"callproplex",//0x4c
			null,//0x4d
			"callsupervoid",//0x4e
			"callpropvoid",//0x4f
			"sxi1",//0x50
			"sxi8",//0x51
			"sxi16",//0x52
			"applytype",//0x53
			null,//0x54
			"newobject",//0x55
			"newarray",//0x56
			"newactivation",//0x57
			"newclass",//0x58
			"getdescendants",//0x59
			"newcatch",//0x5a
			null,//0x5b
			null,//0x5c
			"findpropstrict",//0x5d
			"findproperty",//0x5e
			"finddef",//0x5f
			"getlex",//0x60
			"setproperty",//0x61
			"getlocal",//0x62
			"setlocal",//0x63
			"getglobalscope",//0x64
			"getscopeobject",//0x65
			"getproperty",//0x66
			null,//0x67
			"initproperty",//0x68
			null,//0x69
			"deleteproperty",//0x6a
			null,//0x6b
			"getslot",//0x6c
			"setslot",//0x6d
			"getglobalslot",//0x6e
			"setglobalslot",//0x6f
			"convert_s",//0x70
			"esc_xelem",//0x71
			"esc_xattr",//0x72
			"convert_i",//0x73
			"convert_u",//0x74
			"convert_d",//0x75
			"convert_b",//0x76
			"convert_o",//0x77
			"checkfilter",//0x78
			null,//0x79
			null,//0x7a
			null,//0x7b
			null,//0x7c
			null,//0x7d
			null,//0x7e
			null,//0x7f
			"coerce",//0x80
			"coerce_b",//0x81
			"coerce_a",//0x82
			"coerce_i",//0x83
			"coerce_d",//0x84
			"coerce_s",//0x85
			"astype",//0x86
			"astypelate",//0x87
			"coerce_u",//0x88
			"coerce_o",//0x89
			null,//0x8a
			null,//0x8b
			null,//0x8c
			null,//0x8d
			null,//0x8e
			null,//0x8f
			"negate",//0x90
			"increment",//0x91
			"inclocal",//0x92
			"decrement",//0x93
			"declocal",//0x94
			"typeof_",//0x95
			"not",//0x96
			"bitnot",//0x97
			null,//0x98
			null,//0x99
			null,//0x9a
			null,//0x9b
			null,//0x9c
			null,//0x9d
			null,//0x9e
			null,//0x9f
			"add",//0xa0
			"subtract",//0xa1
			"multiply",//0xa2
			"divide",//0xa3
			"modulo",//0xa4
			"lshift",//0xa5
			"rshift",//0xa6
			"urshift",//0xa7
			"bitand",//0xa8
			"bitor",//0xa9
			"bitxor",//0xaa
			"equals",//0xab
			"strictequals",//0xac
			"lessthan",//0xad
			"lessequals",//0xae
			"greaterthan",//0xaf
			"greaterequals",//0xb0
			"instanceof_",//0xb1
			"istype",//0xb2
			"istypelate",//0xb3
			"in_",//0xb4
			null,//0xb5
			null,//0xb6
			null,//0xb7
			null,//0xb8
			null,//0xb9
			null,//0xba
			null,//0xbb
			null,//0xbc
			null,//0xbd
			null,//0xbe
			null,//0xbf
			"increment_i",//0xc0
			"decrement_i",//0xc1
			"inclocal_i",//0xc2
			"declocal_i",//0xc3
			"negate_i",//0xc4
			"add_i",//0xc5
			"subtract_i",//0xc6
			"multiply_i",//0xc7
			null,//0xc8
			null,//0xc9
			null,//0xca
			null,//0xcb
			null,//0xcc
			null,//0xcd
			null,//0xce
			null,//0xcf
			"getlocal0",//0xd0
			"getlocal1",//0xd1
			"getlocal2",//0xd2
			"getlocal3",//0xd3
			"setlocal0",//0xd4
			"setlocal1",//0xd5
			"setlocal2",//0xd6
			"setlocal3",//0xd7
			null,//0xd8
			null,//0xd9
			null,//0xda
			null,//0xdb
			null,//0xdc
			null,//0xdd
			null,//0xde
			null,//0xdf
			null,//0xe0
			null,//0xe1
			null,//0xe2
			null,//0xe3
			null,//0xe4
			null,//0xe5
			null,//0xe6
			null,//0xe7
			null,//0xe8
			null,//0xe9
			null,//0xea
			null,//0xeb
			null,//0xec
			null,//0xed
			null,//0xee
			"debug",//0xef
			"debugline",//0xf0
			"debugfile",//0xf1
			"bkptline",//0xf2
			"timestamp",//0xf3
			null,//0xf4
			null,//0xf5
			null,//0xf6
			null,//0xf7
			null,//0xf8
			null,//0xf9
			null,//0xfa
			null,//0xfb
			null,//0xfc
			null,//0xfd
			null,//0xfe
			null//0xff
		];
		nameV.fixed=true;
		
		public static const dataTypeV:Vector.<String>=new Vector.<String>(nameV.length);
		dataTypeV.fixed=true;
		
		public static const valueTypeV:Vector.<String>=new Vector.<String>(nameV.length);
		valueTypeV.fixed=true;
		
		public static const stackStatusV:Vector.<Object>=new Vector.<Object>(nameV.length);
		stackStatusV.fixed=true;
		
		public static const sampleCodeV:Vector.<String>=new Vector.<String>(nameV.length);
		sampleCodeV.fixed=true;
		
	}
}
import zero.swf.avm2.AVM2Ops;

function outputCodeError(msg:String):void{
	throw msg;
}

function init(infos:Object):void{
	
	var op:int=-1;
	for each(var opName:String in AVM2Ops.nameV){
		op++;
		if(opName){
			if(op===AVM2Ops[opName]){
			}else{
				throw new Error("op："+op+"，opName："+opName+" 对应不上");
			}
			var infoArr:Array=infos[opName].split("|");
			AVM2Ops.dataTypeV[op]=infoArr[0].replace(/\s+/g,"");
			AVM2Ops.valueTypeV[op]=infoArr[1].replace(/\s+/g,"");
			switch(AVM2Ops.dataTypeV[op]){
				case "":
				case "u30":
				case "u30,u30":
				case "s24":
				case "u8":
				case "u8,u30,u8,u30":
				case "s24,u30,s24[count+1]":
					//
				break;
				default:
					outputCodeError("未知 dataType："+AVM2Ops.dataTypeV[op]);
				break;
			}
			switch(AVM2Ops.valueTypeV[op]){
				case "":
					
				case "registerid":
				case "slotid":
				case "scopeid":
				case "linenum":
					
				case "integerid":
				case "uintegerid":
				case "doubleid":
				case "stringid":
				case "namespaceid":
				case "multinameid":
					
				case "methodid":
				case "exceptionid":
				case "classid":
				
				case "arg_count":
					
				case "offset":
					
				case "registerid,registerid":
				case "multinameid,arg_count":
				case "dispid,arg_count":
				case "methodid,arg_count":
				
				case "sbyte":
				case "sshort":
				case "debug_type,index,reg,extra":
				case "default_offset,case_count,case_offsets...":
					//
				break;
				default:
					outputCodeError("未知 valueType："+AVM2Ops.valueTypeV[op]);
				break;
			}
			
			var stackStatusStr:String=infoArr[2].replace(/^\s*|\s*$/g,"");
			
			switch(op){
				case AVM2Ops.pushscope:
				case AVM2Ops.pushwith:
					var statckStatus:Object={dScopeStack:1};
				break;
				case AVM2Ops.popscope:
					statckStatus={dScopeStack:-1};
				break;
				default:
					statckStatus={dScopeStack:0};
				break;
			}
			if(stackStatusStr.indexOf(", [ns], [name]")>-1){
				if(AVM2Ops.valueTypeV[op].indexOf("multinameid")==0){
					stackStatusStr=stackStatusStr.replace(", [ns], [name]","");
				}else{
					outputCodeError(AVM2Ops.nameV[op]+" valueType 需要含有 multinameid");
				}
			}else{
				if(AVM2Ops.valueTypeV[op].indexOf("multinameid")>-1){
					switch(op){
						case AVM2Ops.getlex://The multiname at index must not be a runtime multiname.
						case AVM2Ops.finddef://?
						case AVM2Ops.coerce://The multiname at index must not be a runtime multiname. 
						case AVM2Ops.astype://The multiname at index must not be a runtime multiname, and must be the name of a type. 
						case AVM2Ops.istype://The multiname at index must not be a runtime multiname.
							//
						break;
						default:
							outputCodeError(AVM2Ops.nameV[op]+" valueType 不能含有 multinameid");
						break;
					}
				}
			}
			if(stackStatusStr.indexOf(", arg1, arg2, ..., argn")>-1){
				if(AVM2Ops.valueTypeV[op].indexOf("arg_count")>-1){
					stackStatusStr=stackStatusStr.replace(", arg1, arg2, ..., argn","");
				}else{
					outputCodeError(AVM2Ops.nameV[op]+" valueType 需要含有 arg_count");
				}
			}else{
				if(AVM2Ops.valueTypeV[op].indexOf("arg_count")>-1){
					switch(op){
						case AVM2Ops.newobject:
							stackStatusStr=stackStatusStr.replace(", name1, value1, name2, value2,...,nameN, valueN","");
						break;
						case AVM2Ops.newarray:
							stackStatusStr=stackStatusStr.replace(", value1, value2, ..., valueN","");
						break;
						default:
							outputCodeError(AVM2Ops.nameV[op]+" valueType 不能含有 arg_count");
						break;
					}
				}
			}
			
			if(
				stackStatusStr=="… => …"
				||
				/^…, \w+ => …, [\~\-\!\w]+$/.test(stackStatusStr)
				||
				/^…, \w+, \w+ => …, \w+, \w+$/.test(stackStatusStr)
			){
				statckStatus.dStack=0;
			}else if(
				/^…, \w+ => …$/.test(stackStatusStr)
				||
				/^…, \w+, \w+ => …, \w+$/.test(stackStatusStr)
			){
				statckStatus.dStack=-1;
			}else if(
				/^…, \w+, \w+ => …$/.test(stackStatusStr)
			){
				statckStatus.dStack=-2;
			}else if(
				/^… => …, \w+$/.test(stackStatusStr)
				||
				/^…, \w+ => …, \w+, \w+$/.test(stackStatusStr)
			){
				statckStatus.dStack=1;
			}else{
				outputCodeError(AVM2Ops.nameV[op]+" 未知 stackStatus："+stackStatusStr);
			}
			AVM2Ops.stackStatusV[op]=statckStatus;
			//trace(AVM2Ops.nameV[op]+"----------------------------\n"+
			//	"dStack="+AVM2Ops.stackStatusV[op].dStack+(AVM2Ops.valueTypeV[op].indexOf("multinameid")==0?"-(0~2)":"")+(AVM2Ops.valueTypeV[op].indexOf("arg_count")>-1?"-arg_count":"")+"\n"+
			//	"dScopeStack="+AVM2Ops.stackStatusV[op].dScopeStack+"\n"
			//);
			
			AVM2Ops.sampleCodeV[op]=infoArr[3].replace(/^\s*|\s*$/g,"");
			//trace(AVM2Ops.nameV[op]+"----------------------------\n"+AVM2Ops.sampleCodeV[op]+"\n");
			
		}
	}
	
}
init({
	//				dataType					|valueType					|stack
	//0x00 null
	bkpt:			"						|							|… => …																	|bkpt",//0x01，undoc	
	nop:			"						|							|… => …																	|nop",//0x02
	throw_:			"						|							|…, value => …															|pushstring \"Hello World!\"\nthrow_",//0x03
	getsuper:		"u30					|multinameid				|…, obj, [ns], [name] => …, value									|getlocal0\ngetsuper x\npop",//0x04
	setsuper:		"u30					|multinameid				|…, obj, [ns], [name], value => …									|getlocal0\npushbyte 123\nsetsuper x",//0x05
	dxns:			"u30					|stringid					|… => …																	|dxns \"http://ns.adobe.com/air/application/3.5\"",//0x06			
	dxnslate:		"						|							|…, value => …															|pushstring \"http://ns.adobe.com/air/application/3.5\"\ndxnslate",//0x07
	kill:			"u30					|registerid				|… => …																	|kill registerid=2",//0x08
	label:			"						|							|… => …																	|label",//0x09
	//0x0a null
	//0x0b null
	ifnlt:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifnlt label0\nlabel0:",//0x0c
	ifnle:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifnle label0\nlabel0:",//0x0d
	ifngt:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifngt label0\nlabel0:",//0x0e
	ifnge:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifnge label0\nlabel0:",//0x0f
	jump:			"s24					|offset					|… => …																	|jump label0\nlabel0:",//0x10
	iftrue:			"s24					|offset					|…, value => …															|pushtrue\niftrue label0\nlabel0:",//0x11
	iffalse:		"s24					|offset					|…, value => …															|pushfalse\niffalse label0\nlabel0:",//0x12
	ifeq:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifeq label0\nlabel0:",//0x13
	ifne:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifne label0\nlabel0:",//0x14
	iflt:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\niflt label0\nlabel0:",//0x15
	ifle:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifle label0\nlabel0:",//0x16
	ifgt:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifgt label0\nlabel0:",//0x17
	ifge:			"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifge label0\nlabel0:",//0x18
	ifstricteq:		"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifstricteq label0\nlabel0:",//0x19
	ifstrictne:		"s24					|offset					|…, value1, value2 => …												|pushbyte 1\npushbyte 2\nifstrictne label0\nlabel0:",//0x1a
	lookupswitch:	"s24,u30,s24[count+1]|default_offset,case_count,case_offsets...|…, index => …										|\n	lookupswitch default_offset=label3 case_offsets=label0,label1,label2\nlabel0:\n	pushstring \"label0\"\n	jump label4\nlabel1:\n	pushstring \"label1\"\n	jump label4\nlabel2:\n	pushstring \"label2\"\n	jump label4\nlabel3:\n	pushstring \"label3\"\nlabel4:\n	pop",//0x1b
	pushwith:		"						|							|…, scope_obj => …														|getlocal1\npushwith\ngetlex length\npopscope\npop",//0x1c
	popscope:		"						|							|… => …																	|getlocal1\npushscope\npopscope",//0x1d
	nextname:		"						|							|…, obj, index => …, name												|pushstring \"a\"\npushbyte 0\npushstring \"b\"\npushbyte 1\npushstring \"c\"\npushbyte 2\nnewobject 3\npushbyte 2\nnextname\npop",//0x1e
	hasnext:		"						|							|…, obj, cur_index => …, next_index									|pushstring \"a\"\npushbyte 0\npushstring \"b\"\npushbyte 1\npushstring \"c\"\npushbyte 2\nnewobject 3\npushbyte 2\nhasnext\npop",//0x1f
	pushnull:		"						|							|… => …, null															|pushnull\npop",//0x20
	pushundefined:	"						|							|… => …, undefined														|pushundefined\npop",//0x21
	//0x22 null
	nextvalue:		"						|							|…, obj, index => …, value												|pushstring \"a\"\npushbyte 0\npushstring \"b\"\npushbyte 1\npushstring \"c\"\npushbyte 2\nnewobject 3\npushbyte 2\nnextvalue\npop",//0x23
	pushbyte:		"u8						|sbyte						|… => …, value															|pushbyte 0\npop",//0x24
	pushshort:		"u30					|sshort					|… => …, value															|pushshort 0x7fff\npop",//0x25
	pushtrue:		"						|							|… => …, true															|pushtrue\npop",//0x26
	pushfalse:		"						|							|… => …, false															|pushfalse\npop",//0x27
	pushnan:		"						|							|… => …, NaN																|pushnan\npop",//0x28
	pop:			"						|							|…, value => …															|pushtrue\npop",//0x29
	dup:			"						|							|…, value => …, value, value											|pushtrue\ndup\npop\npop",//0x2a
	swap:			"						|							|…, value1, value2 => …, value2, value1								|pushtrue\npushfalse\nswap\npop\npop",//0x2b
	pushstring:		"u30					|stringid					|… => …, value															|pushstring \"Hello World!\"\npop",//0x2c
	pushint:		"u30					|integerid					|… => …, value															|pushint 12345\npop",//0x2d
	pushuint:		"u30					|uintegerid				|… => …, value															|pushuint 12345\npop",//0x2e
	pushdouble:		"u30					|doubleid					|… => …, value															|pushdouble 123.45\npop",//0x2f
	pushscope:		"						|							|…, value => …															|getlocal0\npushscope",//0x30
	pushnamespace:	"u30					|namespaceid				|… => …, namespace														|pushnamespace [Namespace]http://www.adobe.com/2006/actionscript/flash/proxy\npop",//0x31
	hasnext2:		"u30,u30				|registerid,registerid	|… => …, value															|pushstring \"a\"\npushbyte 0\npushstring \"b\"\npushbyte 1\npushstring \"c\"\npushbyte 2\nnewobject 3\nsetlocal2\npushbyte 2\nsetlocal3\nhasnext2 registerid1=2 registerid2=3\npop",//0x32
	//0x33 null
	//0x34 null
	li8:			"						|							|…, address => …, value												|pushbyte 0\nli8\npop",//0x35，undoc
	li16:			"						|							|…, address => …, value												|pushbyte 1\nli16\npop",//0x36，undoc
	li32:			"						|							|…, address => …, value												|pushbyte 3\nli32\npop",//0x37，undoc
	lf32:			"						|							|…, address => …, value												|pushbyte 7\nlf32\npop",//0x38，undoc
	lf64:			"						|							|…, address => …, value												|pushbyte 11\nlf64\npop",//0x39，undoc
	si8:			"						|							|…, value, address => …												|pushbyte 123\npushbyte 0\nsi8",//0x3a，undoc
	si16:			"						|							|…, value, address => …												|pushshort 12345\npushbyte 1\nsi16",//0x3b，undoc
	si32:			"						|							|…, value, address => …												|pushint 12345678\npushbyte 3\nsi32",//0x3c，undoc
	sf32:			"						|							|…, value, address => …												|pushdouble 1234.5678\npushbyte 7\nsf32",//0x3d，undoc
	sf64:			"						|							|…, value, address => …												|pushdouble 1234.5678\npushbyte 11\nsf64",//0x3e，undoc
	//0x3f null
	newfunction:	"u30					|methodid					|… => …, function_obj													|newfunction function ():void\npop",//0x40
	call:			"u30					|arg_count					|…, function, receiver, arg1, arg2, ..., argn => …, value			|newfunction function ():String\ngetlocal0\ncall 0",//0x41
	construct:		"u30					|arg_count					|…, object, arg1, arg2, ..., argn => …, value						|getlex XMLpushstring \"<xml/>\"\nconstruct 1\npop",//0x42
	callmethod:		"u30,u30				|dispid,arg_count			|…, receiver, arg1, arg2, ..., argn => …, value						|push xxx\ncallmethod dispid=1\npop",//0x43 //未知使用方法。43 00 00 报错 ：VerifyError: Error #1072: Disp_id 0 是非法的。43 01 00 报错 ：VerifyError: Error #1051: 对 xxx 的早期绑定访问是非法的。
	callstatic:		"u30,u30				|methodid,arg_count		|…, receiver, arg1, arg2, ..., argn => …, value						|getlocal0\ncallstatic function xxx():String 0",//0x44 //使用方法不太清楚。调用一个实例的方法成功，调用一个匿名函数报错：VerifyError: Error #1107: ABC 数据已损坏，尝试的读取操作超出范围。
	callsuper:		"u30,u30				|multinameid,arg_count	|…, receiver, [ns], [name], arg1, arg2, ..., argn => …, value				|getlocal0\npushstring \"x\"\ncallsuper [Namespace]http://adobe.com/AS3/2006/builtin.hasOwnProperty 1\npop",//0x45
	callproperty:	"u30,u30				|multinameid,arg_count	|…, obj, [ns], [name], arg1, arg2, ..., argn => …, value					|getlocal0\npushstring \"x\"\ncallproperty [Namespace]http://adobe.com/AS3/2006/builtin.hasOwnProperty 1\npop",//0x46
	returnvoid:		"						|							|… => …																	|returnvoid",//0x47
	returnvalue:	"						|							|…, return_value => …													|pushstring \"Hello World!\"\nreturnvalue",//0x48
	constructsuper:	"u30					|arg_count					|…, object, arg1, arg2, ..., argn => …								|getlocal0\nconstructsuper 0",//0x49
	constructprop:	"u30,u30				|multinameid,arg_count	|…, obj, [ns], [name], arg1, arg2, ..., argn => …, value					|findpropstrict String\npushstring \"Hello World!\"\nconstructprop String 1\npop",//0x4a
	//0x4b null
	callproplex:	"u30,u30				|multinameid,arg_count	|…, obj, [ns], [name], arg1, arg2, ..., argn => …, value					|getlocal0\npushstring \"x\"\ncallproplex [Namespace]http://adobe.com/AS3/2006/builtin.hasOwnProperty 1\npop",//0x4c //使用方法不太清楚。文档里和 callproperty 的唯一区别是：The [[Call]] property is invoked on the value of the resolved property with the arguments null（callproperty 里这里是 obj）, arg1, ...,  argn.
	//0x4d null
	callsupervoid:	"u30,u30				|multinameid,arg_count	|…, receiver, [ns], [name], arg1, arg2, ..., argn => …					|getlocal0\npushstring \"x\"\ncallsupervoid [Namespace]http://adobe.com/AS3/2006/builtin.hasOwnProperty 1",//0x4e
	callpropvoid:	"u30,u30				|multinameid,arg_count	|…, obj, [ns], [name], arg1, arg2, ..., argn => …							|getlocal0\npushstring \"x\"\ncallpropvoid [Namespace]http://adobe.com/AS3/2006/builtin.hasOwnProperty 1",//0x4f
	sxi1:			"						|							|…, value => …, value													|pushbyte 1\nsxi1\npop",//0x50，undoc
	sxi8:			"						|							|…, value => …, value													|pushshort 128\nsxi8\npop",//0x51，undoc
	sxi16:			"						|							|…, value => …, value													|pushint 32768\nsxi16\npop",//0x52，undoc
	applytype:		"u30					|arg_count					|…, Vector, arg1, arg2, ..., argn => …, value											|getlex __AS3__.vec.Vector\ngetlex String\napplytype 1\npop",//0x53，undoc
	//0x54 null
	newobject:		"u30					|arg_count					|…, name1, value1, name2, value2,...,nameN, valueN => …, newobj	|pushstring \"a\"\npushstring \"1\"\npushstring \"b\"\npushstring \"2\"\npushstring \"c\"\npushstring \"3\"\nnewobject 3\npop",//0x55
	newarray:		"u30					|arg_count					|…, value1, value2, ..., valueN => …, newarray						|pushbyte 1\npushbyte 2\npushbyte 3\nnewarray 3\npop",//0x56
	newactivation:	"						|							|… => …, newactivation													|newactivation\npop",//0x57
	newclass:		"u30					|classid					|…, basetype => …, newclass											|getlex flash.display.Sprite\nnewclass xxx\npop",//0x58
	getdescendants:	"u30					|multinameid				|…, obj, [ns], [name] => …, value										|pushstring \"<xml><xxx>xxx</xxx></xml>\"\nconstruct 1\ngetdescendants xxx\npop",//0x59
	newcatch:		"u30					|exceptionid				|… => …, catchscope														|label5:\n	pushstring \"xxx\"\n	throw_\nlabel6:\n	jump label8\nlabel7:\n	getlocal0\n	pushscope\n	newcatch from=label5 to=label6 target=label7 exc_type=String var_name=s\n	pop\n	pop\nlabel8:",//0x5a
	//0x5b null
	//0x5c null
	findpropstrict:	"u30					|multinameid				|…, [ns], [name] => …, obj											|findpropstrict String\npushstring \"Hello World!\"\nconstructprop String 1\npop",//0x5d
	findproperty:	"u30					|multinameid				|…, [ns], [name] => …, obj											|findproperty x\npushbyte 111\ninitproperty x",//0x5e
	finddef:		"u30					|multinameid				|… => …, value															|finddef XML\npop",//0x5f，undoc
	getlex:			"u30					|multinameid				|… => …, obj																|getlex XML\npop",//0x60
	setproperty:	"u30					|multinameid				|…, obj, [ns], [name], value => …										|getlocal0\npushbyte 111\nsetproperty x",//0x61
	getlocal:		"u30					|registerid				|… => …, value															|getlocal registerid=4\npop",//0x62
	setlocal:		"u30					|registerid				|…, value => …															|pushstring \"Hello World!\"\nsetlocal registerid=4",//0x63
	getglobalscope:	"						|							|… => …, obj																|getglobalscope\npop",//0x64
	getscopeobject:	"u8						|scopeid					|… => …, scope															|getscopeobject scopeid=1\ngetslot slotid=2\npop",//0x65
	getproperty:	"u30					|multinameid				|…, object, [ns], [name] => …, value								|getlocal0\ngetproperty x\npop",//0x66
	//0x67 null
	initproperty:	"u30					|multinameid				|…, object, [ns], [name], value => …									|findproperty x\npushbyte 111\ninitproperty x",//0x68
	//0x69 null
	deleteproperty:	"u30					|multinameid				|…, object, [ns], [name] => …, value									|getlocal1\ndeleteproperty\npop",//0x6a
	//0x6b null
	getslot:		"u30					|slotid					|…, obj => …, value														|getscopeobject scopeid=1\ngetslot slotid=2\npop",//0x6c
	setslot:		"u30					|slotid					|…, obj, value => …														|getscopeobject scopeid=1\ngetlocal0\nsetslot slotid=2",//0x6d
	getglobalslot:	"u30					|slotid					|… => …, value															|getglobalslot slotid=1\npop",//0x6e
	setglobalslot:	"u30					|slotid					|…, value => …															|getlex OPCodeTest\nsetglobalslot slotid=1",//0x6f
	convert_s:		"						|							|…, value => …, stringvalue											|pushnull\nconvert_s\npop",//0x70
	esc_xelem:		"						|							|…, value => …, stringvalue											|pushstring \"<\"\nesc_xelem\npop",//0x71
	esc_xattr:		"						|							|…, value => …, stringvalue											|pushstring \"<\"\nesc_xattr\npop",//0x72
	convert_i:		"						|							|…, value => …, intvalue												|pushnull\nconvert_i\npop",//0x73
	convert_u:		"						|							|…, value => …, uintvalue												|pushnull\nconvert_u\npop",//0x74
	convert_d:		"						|							|…, value => …, doublevalue											|pushnull\nconvert_d\npop",//0x75
	convert_b:		"						|							|…, value => …, booleanvalue											|pushnull\nconvert_b\npop",//0x76
	convert_o:		"						|							|…, value => …, value													|pushnull\nconvert_o\npop",//0x77
	checkfilter:	"						|							|…, value => …, value													|getlex XML\npushstring \"xxx\"\nconstruct 1\ncheckfilter\npop",//0x78
	//0x79 null
	//0x7a null
	//0x7b null
	//0x7c null
	//0x7d null
	//0x7e null
	//0x7f null
	coerce:			"u30					|multinameid				|…, value => …, coercedvalue											|pushstring \"Hello World!\"\ncoerce XML\npop",//0x80 //TypeError: Error #1034: 强制转换类型失败:无法将 "Hello World!" 转换为 XML。
	coerce_b:		"						|							|…, value => …, coercedvalue											|pushnull\ncoerce_b\npop",//0x81，undoc
	coerce_a:		"						|							|…, value => …, value													|pushnull\ncoerce_a\npop",//0x82
	coerce_i:		"						|							|…, value => …, coercedvalue											|pushnull\ncoerce_i\npop",//0x83，undoc
	coerce_d:		"						|							|…, value => …, coercedvalue											|pushnull\ncoerce_d\npop",//0x84，undoc
	coerce_s:		"						|							|…, value => …, stringvalue											|pushnull\ncoerce_s\npop",//0x85
	astype:			"u30					|multinameid				|…, value => …, value													|pushstring \"Hello World!\"\nastype XML\npop",//0x86
	astypelate:		"						|							|…, value, class => …, value											|pushstring \"Hello World!\"\ngetlex XML\nastypelate\npop",//0x87
	coerce_u:		"						|							|…, value => …, coercedvalue											|pushnull\ncoerce_u\npop",//0x88，undoc
	coerce_o:		"						|							|…, value => …, coercedvalue											|pushnull\ncoerce_o\npop",//0x89，undoc
	//0x8a null
	//0x8b null
	//0x8c null
	//0x8d null
	//0x8e null
	//0x8f null
	negate:			"						|							|…, value => …, -value													|pushbyte 1\nnegate\npop",//0x90
	increment:		"						|							|…, value => …, incrementedvalue										|pushbyte 1\nincrement\npop",//0x91
	inclocal:		"u30					|registerid				|… => …																	|inclocal registerid=1",//0x92
	decrement:		"						|							|…, value => …, decrementedvalue										|pushbyte 1\ndecrement\npop",//0x93
	declocal:		"u30					|registerid				|… => …																	|declocal registerid=1",//0x94
	typeof_:		"						|							|…, value => …, typename												|pushstring \"Hello World!\"\ntypeof_\npop",//0x95
	not:			"						|							|…, value => …, !value													|pushtrue\nnot\npop",//0x96
	bitnot:			"						|							|…, value => …, ~value													|pushbyte 123\nbitnot\npop",//0x97
	//0x98 null
	//0x99 null
	//0x9a null
	//0x9b null
	//0x9c null
	//0x9d null
	//0x9e null
	//0x9f null
	add:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nadd\npop",//0xa0
	subtract:		"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nsubtract\npop",//0xa1
	multiply:		"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nmultiply\npop",//0xa2
	divide:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\ndivide\npop",//0xa3
	modulo:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nmodulo\npop",//0xa4
	lshift:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nlshift\npop",//0xa5
	rshift:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nrshift\npop",//0xa6
	urshift:		"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nurshift\npop",//0xa7
	bitand:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nbitand\npop",//0xa8
	bitor:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nbitor\npop",//0xa9
	bitxor:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nbitxor\npop",//0xaa
	equals:			"						|							|…, value1, value2 => …, result										|pushbyte 12\npushbyte 34\nequals\npop",//0xab
	strictequals:	"						|							|…, value1, value2 => …, result										|pushbyte 12\npushbyte 34\nstrictequals\npop",//0xac
	lessthan:		"						|							|…, value1, value2 => …, result										|pushbyte 12\npushbyte 34\nlessthan\npop",//0xad
	lessequals:		"						|							|…, value1, value2 => …, result										|pushbyte 12\npushbyte 34\nlessequals\npop",//0xae
	greaterthan:	"						|							|…, value1, value2 => …, result										|pushbyte 12\npushbyte 34\ngreaterthan\npop",//0xaf
	greaterequals:	"						|							|…, value1, value2 => …, result										|pushbyte 12\npushbyte 34\ngreaterequals\npop",//0xb0
	instanceof_:	"						|							|…, value, type => …, result											|pushstring \"Hello World!\"\ngetlex XML\ninstanceof_\npop",//0xb1
	istype:			"u30					|multinameid				|…, value => …, result													|pushstring \"Hello World!\"\nistype XML\npop",//0xb2
	istypelate:		"						|							|…, value, type => …, result											|pushstring \"Hello World!\"\ngetlex XML\nistypelate\npop",//0xb3
	in_:			"						|							|…, name, obj => …, result												|pushstring \"x\"\ngetlocal0\nin_\npop",//0xb4
	//0xb5 null
	//0xb6 null
	//0xb7 null
	//0xb8 null
	//0xb9 null
	//0xba null
	//0xbb null
	//0xbc null
	//0xbd null
	//0xbe null
	//0xbf null
	increment_i:	"						|							|…, value => …, incrementedvalue										|pushbyte 1\nincrement_i\npop",//0xc0
	decrement_i:	"						|							|…, value => …, dencrementedvalue										|pushbyte 1\ndecrement_i\npop",//0xc1
	inclocal_i:		"u30					|registerid				|… => …																	|inclocal_i registerid=1",//0xc2
	declocal_i:		"u30					|registerid				|… => …																	|declocal_i registerid=1",//0xc3
	negate_i:		"						|							|…, value => …, -value													|pushbyte 1\nnegate_i\npop",//0xc4
	add_i:			"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nadd_i\npop",//0xc5
	subtract_i:		"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nsubtract_i\npop",//0xc6
	multiply_i:		"						|							|…, value1, value2 => …, value3										|pushbyte 12\npushbyte 34\nmultiply_i\npop",//0xc7
	//0xc8 null
	//0xc9 null
	//0xca null
	//0xcb null
	//0xcc null
	//0xcd null
	//0xce null
	//0xcf null
	getlocal0:		"						|							|… => …, value															|getlocal0\npop",//0xd0
	getlocal1:		"						|							|… => …, value															|getlocal1\npop",//0xd1
	getlocal2:		"						|							|… => …, value															|getlocal2\npop",//0xd2
	getlocal3:		"						|							|… => …, value															|getlocal3\npop",//0xd3
	setlocal0:		"						|							|…, value => …															|pushbyte 0\nsetlocal0",//0xd4
	setlocal1:		"						|							|…, value => …															|pushbyte 0\nsetlocal1",//0xd5
	setlocal2:		"						|							|…, value => …															|pushbyte 0\nsetlocal2",//0xd6
	setlocal3:		"						|							|…, value => …															|pushbyte 0\nsetlocal3",//0xd7
	//0xd8 null
	//0xd9 null
	//0xda null
	//0xdb null
	//0xdc null
	//0xdd null
	//0xde null
	//0xdf null
	//0xe0 null
	//0xe1 null
	//0xe2 null
	//0xe3 null
	//0xe4 null
	//0xe5 null
	//0xe6 null
	//0xe7 null
	//0xe8 null
	//0xe9 null
	//0xea null
	//0xeb null
	//0xec null
	//0xed null
	//0xee null
	debug:			"u8,u30,u8,u30		|debug_type,index,reg,extra		|… => …															|debug debug_type=1 index=\"output\" reg=0 extra=15",//0xef
	debugline:		"u30					|linenum							|… => …															|debugline linenum=5",//0xf0
	debugfile:		"u30					|stringid							|… => …															|debugfile \"F:\\\\zero\\\\flash2013\\\\SWFTest\\\\tests\\\\opcodetest;;OPCodeTest.as\"",//0xf1
	bkptline:		"u30					|linenum							|… => …															|bkptline linenum=123",//0xf2，undoc
	timestamp:		"						|									|… => …															|timestamp"//0xf3
	//0xf4 null
	//0xf5 null
	//0xf6 null
	//0xf7 null
	//0xf8 null
	//0xf9 null
	//0xfa null
	//0xfb null
	//0xfc null
	//0xfd null
	//0xfe null
	//0xff null
});