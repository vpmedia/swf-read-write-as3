package abc {
	public class Instruction {
		public var	opcode:int,
					operands:Array,
					addr:uint,
					size:uint, // # bytes instruction took up when it was read
					needsLabel:Boolean,
					label:String
					
		public var used:Boolean = false
					
		public function Instruction(opcode:int, operands:Array = null){
			this.opcode = opcode
			this.operands = operands
		}
		
		public function toString():String {
			var s:String = opcodes[opcode].name

			if(operands){
				s += (new Array(16 - s.length).join(' '))
				if(operands[0] is Instruction && operands[0].label){
					s += '<' + operands[0].label + '> '
				}
				s += operands.join(', ')
			}
			return s
		}
		
		private static function generateOpcodeArray():Array {
			var arr:Array = new Array(opcodeList.length)
			var len:int = opcodeList.length
			for(var i:int = 0; i < len; i++){
				arr[opcodeList[i].opcode] = opcodeList[i]
			}
			return arr
		}
		
		private static var registerInstructions:Array = [
			0x94, 0xc3, 0x08, 0x92, 0xc2, 0x32, 0x63, 0xd4, 0xd5, 0xd6, 0xd7, 
			0x62, 0xd0, 0xd1, 0xd2, 0xd3, 0xef
		]
		
		public function get register():uint {
			if(registerInstructions.indexOf(opcode) == -1) return 0
			
			switch(opcode){
				case Op.declocal:	case Op.declocal_i:
				case Op.kill: 		case Op.inclocal:
				case Op.inclocal_i:	case Op.setlocal:
				case Op.getlocal:
					return operands[0]
					break
				case Op.hasnext2:
					return Math.max(operands[0], operands[1])
					break
				case Op.debug:
					if(operands[0] == 1){ // TODO: make enum for debug values
						return operands[2]
					} else {
						return 0
					}
					break
				case Op.getlocal0:	case Op.setlocal0:
					return 0
					break
				case Op.getlocal1:	case Op.setlocal1:
					return 1
					break
				case Op.getlocal2:	case Op.setlocal2:
					return 2
					break
				case Op.getlocal3:	case Op.setlocal3:
					return 3
					break
			}
			return 0
		}
		
		public function get scopeEffect():int {
			return opcodes[opcode].scope
		}
		
		public function get stackEffect():int {
			if(variableStack.indexOf(opcode) == -1) return opcodes[opcode].stack
			
			// otherwise, the stack size change is dependent on the operation's arguments
			switch(opcode){
				case Op.call:
					return -(2 + operands[0] - 1) // function, receiver, [n args] => value
					break
				case Op.callmethod:
				case Op.callstatic:
					return -operands[1]
					break
				case Op.callproperty:
				case Op.callproplex:
				case Op.callsuper:
				case Op.constructprop:
					var mn:Multiname = operands[0]
					var arg_count:int = operands[1]
					switch(mn.kind){
						case Multiname.QName:
							return -arg_count
							break
						case Multiname.RTQName:
						case Multiname.Multiname:
							return -(arg_count + 1)
							break
						case Multiname.RTQNameL:
						case Multiname.MultinameL:
							return -(arg_count + 2)
							break
						default:
							throw new Error('Unhandled multiname stack effect request', 1491)
					}
				
				case Op.callpropvoid:
				case Op.callsupervoid:
					mn = operands[0]
					arg_count = operands[1]
					switch(mn.kind){
						case Multiname.QName:
							return -(arg_count + 1)
							break
						case Multiname.RTQName:
						case Multiname.Multiname:
							return -(arg_count + 2)
							break
						case Multiname.RTQNameL:
						case Multiname.MultinameL:
							return -(arg_count + 3)
							break
						default:
							throw new Error('unhandled multiname stack effect', 1491)
					}
					break
				case Op.construct:
					return -operands[0]
					break
				case Op.constructsuper:
					return -(operands[0] + 1)
					break
				case Op.deleteproperty:
				case Op.getdescendants:
				case Op.getproperty:
				case Op.getsuper:
					mn = operands[0]
					switch(mn.kind){
						case Multiname.QName:
							return 0
							break
						case Multiname.RTQName:
						case Multiname.Multiname:
							return -1
							break
						case Multiname.RTQNameL:
						case Multiname.MultinameL:
							return -2
							break
						default:
							throw new Error('unhandled multiname stack effect:' + mn.kind.toString(16), 1491)
					}
					break
				case Op.findproperty:
				case Op.findpropstrict:
					mn = operands[0]
					switch(mn.kind){
						case Multiname.QName:
							return 1
							break
						case Multiname.RTQName:
						case Multiname.Multiname:
							return 0
							break
						case Multiname.RTQNameL:
						case Multiname.MultinameL:
							return -1
							break
						default:
							throw new Error('hmm', 1491)
					}
					break
				case Op.initproperty:
				case Op.setproperty:
				case Op.setsuper:
					mn = operands[0]
					switch(mn.kind){
						case Multiname.QName:
							return -2
							break
						case Multiname.RTQName:
						case Multiname.Multiname:
							return -3
							break
						case Multiname.RTQNameL:
						case Multiname.MultinameL:
							return -4
							break
						default:
							throw new Error('hmmm', 1491)
					}
				case Op.newarray:
					return -(operands[0] - 1)
					break
				case Op.newobject:
					return -(2 * operands[0] - 1)
					break
			}
			return 0
		}
		
		public static var variableStack:Array = [	
			0x41, 0x43, 0x46, 0x4c, 0x4f, 0x44, 0x45, 0x4e, 0x42, 0x4a, 0x49,
			0x6a, 0x5e, 0x5d, 0x59, 0x66, 0x4, 0x56, 0x55, 0x61, 0x5
		]
		
		
		public static var opcodeList:Array = [
			{ name: 'add',						opcode: 0xa0, operands: 0, stack: -1, scope:  0 },
			{ name: 'add_i',					opcode: 0xc5, operands: 0, stack: -1, scope:  0 },
			{ name: 'applytype',				opcode: 0x53, operands: 1, stack:  0, scope:  0 },
			{ name: 'astype',					opcode: 0x86, operands: 1, stack:  0, scope:  0 },
			{ name: 'astypelate',				opcode: 0x87, operands: 0, stack: -1, scope:  0 },
			{ name: 'bitand',					opcode: 0xa8, operands: 0, stack: -1, scope:  0 },
			{ name: 'bitnot',					opcode: 0x97, operands: 0, stack:  0, scope:  0 },
			{ name: 'bitor',					opcode: 0xa9, operands: 0, stack: -1, scope:  0 },
			{ name: 'bitxor',					opcode: 0xaa, operands: 0, stack: -1, scope:  0 },
			{ name: 'call',						opcode: 0x41, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'callmethod',				opcode: 0x43, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'callproperty',				opcode: 0x46, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'callproplex',				opcode: 0x4c, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'callpropvoid',				opcode: 0x4f, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'callstatic',				opcode: 0x44, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'callsuper',				opcode: 0x45, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'callsupervoid',			opcode: 0x4e, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'checkfilter',				opcode: 0x78, operands: 0, stack:  0, scope:  0 },
			{ name: 'coerce',					opcode: 0x80, operands: 1, stack:  0, scope:  0 },
			{ name: 'coerce_a',					opcode: 0x82, operands: 0, stack:  0, scope:  0 },
			{ name: 'coerce_s',					opcode: 0x85, operands: 0, stack:  0, scope:  0 },
			{ name: 'construct',				opcode: 0x42, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'constructprop',			opcode: 0x4a, operands: 2, stack:  0, scope:  0 }, //
			{ name: 'constructsuper',			opcode: 0x49, operands: 1, stack:  0, scope:  0 }, //
			{ name: 'convert_b',				opcode: 0x76, operands: 0, stack:  0, scope:  0 },
			{ name: 'convert_i',				opcode: 0x73, operands: 0, stack:  0, scope:  0 },
			{ name: 'convert_d',				opcode: 0x75, operands: 0, stack:  0, scope:  0 },
			{ name: 'convert_o',				opcode: 0x77, operands: 0, stack:  0, scope:  0 },
			{ name: 'convert_u',				opcode: 0x74, operands: 0, stack:  0, scope:  0 },
			{ name: 'convert_s',				opcode: 0x70, operands: 0, stack:  0, scope:  0 },
			{ name: 'debug',					opcode: 0xef, operands: 4, stack:  0, scope:  0 },
			{ name: 'debugfile',				opcode: 0xf1, operands: 1, stack:  0, scope:  0 },
			{ name: 'debugline',				opcode: 0xf0, operands: 1, stack:  0, scope:  0 },
			{ name: 'declocal',					opcode: 0x94, operands: 1, stack:  0, scope:  0 },
			{ name: 'declocal_i',				opcode: 0xc3, operands: 1, stack:  0, scope:  0 },
			{ name: 'decrement',				opcode: 0x93, operands: 0, stack:  0, scope:  0 },
			{ name: 'decrement_i',				opcode: 0xc1, operands: 0, stack:  0, scope:  0 },
			{ name: 'deleteproperty',			opcode: 0x6a, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'divide',					opcode: 0xa3, operands: 0, stack: -1, scope:  0 },
			{ name: 'dup',						opcode: 0x2a, operands: 0, stack:  1, scope:  0 },
			{ name: 'dxns',						opcode: 0x06, operands: 1, stack:  0, scope:  0 },
			{ name: 'dxnslate',					opcode: 0x07, operands: 0, stack: -1, scope:  0 },
			{ name: 'equals',					opcode: 0xab, operands: 0, stack: -1, scope:  0 },
			{ name: 'esc_xattr',				opcode: 0x72, operands: 0, stack:  0, scope:  0 },
			{ name: 'esc_xelem',				opcode: 0x71, operands: 0, stack:  0, scope:  0 },
			{ name: 'findproperty',				opcode: 0x5e, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'findpropstrict',			opcode: 0x5d, operands: 1, stack:  0, scope:  0 }, //
			{ name: 'getdescendants',			opcode: 0x59, operands: 1, stack:  0, scope:  0 }, //
			{ name: 'getglobalscope',			opcode: 0x64, operands: 0, stack:  1, scope:  0 },
			{ name: 'getglobalslot',			opcode: 0x6e, operands: 1, stack:  1, scope:  0 },
			{ name: 'getlex',					opcode: 0x60, operands: 1, stack:  1, scope:  0 },
			{ name: 'getlocal',					opcode: 0x62, operands: 1, stack:  1, scope:  0 },
			{ name: 'getlocal_0',				opcode: 0xd0, operands: 0, stack:  1, scope:  0 },
			{ name: 'getlocal_1',				opcode: 0xd1, operands: 0, stack:  1, scope:  0 },
			{ name: 'getlocal_2',				opcode: 0xd2, operands: 0, stack:  1, scope:  0 },
			{ name: 'getlocal_3',				opcode: 0xd3, operands: 0, stack:  1, scope:  0 },
			{ name: 'getouterscope',			opcode: 0x67, operands: 0, stack:  1, scope:  0 },
			{ name: 'getproperty',				opcode: 0x66, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'getscopeobject',			opcode: 0x65, operands: 1, stack:  1, scope:  0 },
			{ name: 'getslot',					opcode: 0x6c, operands: 1, stack:  0, scope:  0 },
			{ name: 'getsuper',					opcode: 0x04, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'greaterequals',			opcode: 0xaf, operands: 0, stack: -1, scope:  0 },
			{ name: 'greaterthan',				opcode: 0xb0, operands: 0, stack: -1, scope:  0 }, // !!
			{ name: 'hasnext',					opcode: 0x1f, operands: 0, stack: -1, scope:  0 },
			{ name: 'hasnext2',					opcode: 0x32, operands: 2, stack:  1, scope:  0 },
			{ name: 'ifeq',						opcode: 0x13, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'iffalse',					opcode: 0x12, operands: 1, stack: -1, scope:  0, otype: 's24' },
			{ name: 'ifge',						opcode: 0x18, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifgt',						opcode: 0x17, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifle',						opcode: 0x16, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'iflt',						opcode: 0x15, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifnge',					opcode: 0x0f, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifngt',					opcode: 0x0e, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifnle',					opcode: 0x0d, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifnlt',					opcode: 0x0c, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifne',						opcode: 0x14, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifstricteq',				opcode: 0x19, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'ifstrictne',				opcode: 0x1a, operands: 1, stack: -2, scope:  0, otype: 's24' },
			{ name: 'iftrue',					opcode: 0x11, operands: 1, stack: -1, scope:  0, otype: 's24' },
			{ name: 'in',						opcode: 0xb4, operands: 0, stack: -1, scope:  0 },
			{ name: 'inclocal',					opcode: 0x92, operands: 1, stack:  0, scope:  0 },
			{ name: 'inclocal_i',				opcode: 0xc2, operands: 1, stack:  0, scope:  0 },
			{ name: 'increment',				opcode: 0x91, operands: 0, stack:  0, scope:  0 },
			{ name: 'increment_i',				opcode: 0xc0, operands: 0, stack:  0, scope:  0 },
			{ name: 'initproperty',				opcode: 0x68, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'instanceof',				opcode: 0xb1, operands: 0, stack: -1, scope:  0 },
			{ name: 'istype',					opcode: 0xb2, operands: 1, stack:  0, scope:  0 },
			{ name: 'istypelate',				opcode: 0xb3, operands: 0, stack: -1, scope:  0 },
			{ name: 'jump',						opcode: 0x10, operands: 1, stack:  0, scope:  0 , otype: 's24' },
			{ name: 'kill',						opcode: 0x08, operands: 1, stack:  0, scope:  0 },
			{ name: 'label',					opcode: 0x09, operands: 0, stack:  0, scope:  0 },
			{ name: 'lessequals',				opcode: 0xae, operands: 0, stack: -1, scope:  0 },
			{ name: 'lessthan',					opcode: 0xad, operands: 0, stack: -1, scope:  0 },
			{ name: 'lookupswitch',				opcode: 0x1b, operands: 3, stack:  0, scope:  0, otype: 'lookupswitch' }, // s24, unbounded
			{ name: 'lshift',					opcode: 0xa5, operands: 0, stack: -1, scope:  0 },
			{ name: 'modulo',					opcode: 0xa4, operands: 0, stack: -1, scope:  0 },
			{ name: 'multiply',					opcode: 0xa2, operands: 0, stack: -1, scope:  0 },
			{ name: 'multiply_i',				opcode: 0xc7, operands: 0, stack: -1, scope:  0 },
			{ name: 'negate',					opcode: 0x90, operands: 0, stack:  0, scope:  0 },
			{ name: 'negate_i',					opcode: 0xc4, operands: 0, stack:  0, scope:  0 },
			{ name: 'newactivation',			opcode: 0x57, operands: 0, stack:  1, scope:  0 },
			{ name: 'newarray',					opcode: 0x56, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'newcatch',					opcode: 0x5a, operands: 1, stack:  1, scope:  0 },
			{ name: 'newclass',					opcode: 0x58, operands: 1, stack:  0, scope:  0 },
			{ name: 'newfunction',				opcode: 0x40, operands: 1, stack:  1, scope:  0 },
			{ name: 'newobject',				opcode: 0x55, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'nextname',					opcode: 0x1e, operands: 0, stack: -1, scope:  0 },
			{ name: 'nextvalue',				opcode: 0x23, operands: 0, stack: -1, scope:  0 },
			{ name: 'nop',						opcode: 0x02, operands: 0, stack:  0, scope:  0 },
			{ name: 'not',						opcode: 0x96, operands: 0, stack:  0, scope:  0 },
			{ name: 'pop',						opcode: 0x29, operands: 0, stack: -1, scope:  0 },
			{ name: 'popscope',					opcode: 0x1d, operands: 0, stack:  0, scope: -1 },
			{ name: 'pushbyte',					opcode: 0x24, operands: 1, stack:  1, scope:  0 },
			{ name: 'pushdouble',				opcode: 0x2f, operands: 1, stack:  1, scope:  0 },
			{ name: 'pushfalse',				opcode: 0x27, operands: 0, stack:  1, scope:  0 },
			{ name: 'pushint',					opcode: 0x2d, operands: 1, stack:  1, scope:  0 },
			{ name: 'pushnamespace',			opcode: 0x31, operands: 1, stack:  1, scope:  0 },
			{ name: 'pushnan',					opcode: 0x28, operands: 0, stack:  1, scope:  0 },
			{ name: 'pushnull',					opcode: 0x20, operands: 0, stack:  1, scope:  0 },
			{ name: 'pushscope',				opcode: 0x30, operands: 0, stack: -1, scope:  1 },
			{ name: 'pushshort',				opcode: 0x25, operands: 1, stack:  1, scope:  0 },
			{ name: 'pushstring',				opcode: 0x2c, operands: 1, stack:  1, scope:  0 },
			{ name: 'pushtrue',					opcode: 0x26, operands: 0, stack:  1, scope:  0 },
			{ name: 'pushuint',					opcode: 0x2e, operands: 1, stack:  1, scope:  0 },
			{ name: 'pushundefined',			opcode: 0x21, operands: 0, stack:  1, scope:  0 },
			{ name: 'pushwith',					opcode: 0x1c, operands: 0, stack: -1, scope:  1 },
			{ name: 'returnvalue',				opcode: 0x48, operands: 0, stack: -1, scope:  0 },
			{ name: 'returnvoid',				opcode: 0x47, operands: 0, stack:  0, scope:  0 },
			{ name: 'rshift',					opcode: 0xa6, operands: 0, stack: -1, scope:  0 },
			{ name: 'setlocal',					opcode: 0x63, operands: 1, stack: -1, scope:  0 },
			{ name: 'setlocal_0',				opcode: 0xd4, operands: 0, stack: -1, scope:  0 },
			{ name: 'setlocal_1',				opcode: 0xd5, operands: 0, stack: -1, scope:  0 },
			{ name: 'setlocal_2',				opcode: 0xd6, operands: 0, stack: -1, scope:  0 },
			{ name: 'setlocal_3',				opcode: 0xd7, operands: 0, stack: -1, scope:  0 },
			{ name: 'setglobalslot',			opcode: 0x6f, operands: 1, stack: -1, scope:  0 },
			{ name: 'setproperty',				opcode: 0x61, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'setslot',					opcode: 0x6d, operands: 1, stack: -2, scope:  0 },
			{ name: 'setsuper',					opcode: 0x05, operands: 1, stack:  0, scope:  0 }, // variable stack
			{ name: 'strictequals',				opcode: 0xac, operands: 0, stack: -1, scope:  0 },
			{ name: 'subtract',					opcode: 0xa1, operands: 0, stack: -1, scope:  0 },
			{ name: 'subtract_i',				opcode: 0xc6, operands: 0, stack: -1, scope:  0 },
			{ name: 'swap',						opcode: 0x2b, operands: 0, stack:  0, scope:  0 },
			{ name: 'throw',					opcode: 0x03, operands: 0, stack: -1, scope:  0 },
			{ name: 'typeof',					opcode: 0x95, operands: 0, stack:  0, scope:  0 },
			{ name: 'timestamp',				opcode: 0xF3, operands: 0, stack:  0, scope:  0 },
			{ name: 'urshift',					opcode: 0xa7, operands: 0, stack: -1, scope:  0 },
			
			{ name: 'applytype',				opcode: 0x53, operands: 1, stack:  0, scope:  0 } // TODO: this
		]
				
		public static var opcodes:Array = generateOpcodeArray()
	}
}