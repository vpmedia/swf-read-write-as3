package abc {
	import abc.traits.*
	import swf.*
	
	import flash.display.*
	import flash.utils.*
	
	/**
	 * Reads a ByteArray into an ABC instance.  The ByteArray shouldn't include the header info from the DoABC tag.
	 */
	public class ABCReader {
		protected const TAG_ID_DO_ABC:uint = 82
		
		private var _bytes:ByteArray
		private var currentByte:int // used in bit reading
		private var bitPosition:int // used in bit reading
		
		private var
			_isSWF:Boolean,
			rawABC:Boolean
		
		private var class_count:int
		
		private var	int_pool:Array,
					uint_pool:Array,
					double_pool:Array,
					string_pool:Array,
					namespace_pool:Array,
					ns_set_pool:Array,
					multiname_pool:Array,
					method_info_pool:Array,
					metadata_pool:Array,
					instance_info_pool:Array,
					class_info_pool:Array,
					script_info_pool:Array,
					method_body_info_pool:Array;
		
		private var _abc:ABC
		public var abcs:Array = []
		public var abcBytes:Array = []
		public var abcModifyFunc:Function
		public var modABC:ByteArray
		
		public var doABC:ByteArray
		
		/**
		 * 
		 * @param	rawABC		If this argument is true, then slightly different ABC reading semantics are used.
		 */
		public function ABCReader(bytes:ByteArray, rawABC:Boolean = false){
				bytes.position = 0
				this.rawABC = rawABC
				_parseABC(bytes)
		}
		
		public function get abc():ABC {
			return _abc
		}
		
		private function _scanForABC(tag:uint, bytes:ByteArray):void {
			if(tag == TAG_ID_DO_ABC){ // so far, I'm only parsing one ABC file
				bytes.position = 0 
				var clone:ByteArray = new ByteArray
				clone.writeBytes(bytes)
				clone.position = 0
				abcBytes.push(clone)
				bytes.position = 0
				
				_parseABC(bytes)
				
				if(abcModifyFunc != null){
					abcModifyFunc(_abc)
					var abcBytes:ByteArray = ABCWriter.writeABC(_abc)
					this.modABC = abcBytes
				}
				abcs.push(_abc)
			}
		}
		
		private function _parseABC(bytes:ByteArray):void {
			if(!bytes) throw new ArgumentError('"bytes" argument cannot reasonably be null.', 1491)
			_bytes = bytes
			_abc = new ABC
			_abc.length = _bytes.length
			
			if(_isSWF){
				var flags:uint = readBits(32)
				_abc.flags = flags
				
				var abcname:String = readString()
				_abc.abcname = abcname
			}
			
			bytes.endian = Endian.LITTLE_ENDIAN
			
			var minor:uint = _bytes.readUnsignedShort()
			var major:uint = _bytes.readUnsignedShort()
			_abc.major_version = major
			_abc.minor_version = minor
			
			//trace('abcVersion', _abc.major_version, _abc.minor_version, flags, abcname)

			if(!rawABC) _bytes.readByte() // wasting this byte
			_readConstantPool()			// cpool_info		constant_pool
			_readMethodInfoPool()		// method_info		method[method_count]
			_readMetadataPool()			// metadata_info	metadata[metadata_count]
			_readInstanceInfoPool()		// instance_info	instance[class_count]
			_readClassInfoPool()		// class_info		class[class_count]
			_readScriptInfoPool()		// script_info		script[script_count]
			_readMethodBodyInfoPool()	// method_body_info	method_body[method_body_count]
		}
		
		private function _readConstantPool():void {
			_readIntPool()			// s32				integer[int_count]
			_readUintPool()			// u32				uinteger[uint_count]
			_readDoublePool()		// d64				double[double_count]
			_readStringPool()		// string_info		string[string_count]
			_readNamespacePool()	// namespace_info	namespace[namespace_count]
			_readNSSetPool()		// ns_set_info		ns_set[ns_set_count]
			_readMultinamePool()	// multiname_info	multiname[multiname_count]
		}
		
		private function _readIntPool():void {
			var int_count:uint = readU30()
			_abc.int_count = int_count
			
			if(int_count){
				// read int pool
				int_pool = _abc.int_pool = new Array(int_count)
				int_pool[0] = 0
				
				for(var i:int = 1; i < int_count; i++){
					int_pool[i] = readS32()
				}
			} else {
				int_pool = _abc.int_pool = [0]
			}
		}
		
		private function _readUintPool():void {
			var uint_count:uint = _abc.uint_count = readU30()
			if(uint_count){
				// read uint pool
				uint_pool = _abc.uint_pool = new Array(uint_count)
				uint_pool[0] = 0
				
				for(var i:int = 1; i < uint_count; i++){
					uint_pool[i] = readS32()
				}
			} else {
				uint_pool = _abc.uint_pool = [0]
			}
		}
		
		private function _readDoublePool():void {
			var double_count:uint = _abc.double_count = readU30()
			if(double_count){
				// read double pool
				double_pool = _abc.double_pool = new Array(double_count)
				double_pool[0] = 0
				var old_endian:String = _bytes.endian
				_bytes.endian = Endian.LITTLE_ENDIAN
				for(var i:int = 1; i < double_count; i++){
					double_pool[i] = _bytes.readDouble()
				}
				_bytes.endian = old_endian
			} else {
				double_pool = _abc.double_pool = [0]
			}
		}
		
		private function _readStringPool():void {
			var string_count:int = _abc.string_count = readU30()
			if(string_count){
				string_pool = _abc.string_pool = [{ toString: function():String { return '' }}] //checkme
				//string_pool[0] = ''
				
				for(var i:int = 1; i < string_count; i++){
					// parse the string_info struct
					var str_len:int = readU30()
					var str:String = _bytes.readUTFBytes(str_len)
					string_pool[i] = str
				}
			} else {
				string_pool = [{}]
			}
		}
		
		private function _readNamespacePool():void {
			var namespace_count:int = _abc.namespace_count = readU30()
			if(namespace_count){
				namespace_pool = _abc.namespace_pool = new Array(namespace_count)
				namespace_pool[0] = new ABCNamespace(ABC.PackageNamespace, '')
				
				for(var i:int = 1; i < namespace_count; i++){
					// parse the namespace_info struct.  it's just [u8, u30]
					var ns_kind:int = _bytes.readByte()
					var index:int = readU30()
					//trace('ns name from string pool index: ', index)
					var ns_name:String = string_pool[index]
					if(ns_kind == ABC.PackageNamespace && ns_name == ''){
						ns = ABCNamespace.public_ns
					} else {
						var ns:ABCNamespace = new ABCNamespace(ns_kind, ns_name)
					}
					namespace_pool[i] = ns
				}
			} else {
				namespace_pool = _abc.namespace_pool = [new ABCNamespace(ABC.PackageNamespace, '')]
			}
		}
		
		private function _readNSSetPool():void {
			var ns_set_count:int = _abc.ns_set_count = readU30()
			if(ns_set_count){
				ns_set_pool = _abc.ns_set_pool = new Array(ns_set_count)
				ns_set_pool[0] = [new ABCNamespace(ABC.PackageNamespace, '')]
				
				for(var i:int = 1; i < ns_set_count; i++){
					// parse each ns_set_info, [u30, u30]
					var set_count:int = readU30()
					var ns_set:Array = new Array
					for(var j:int = 0; j < set_count; j++){
						var index:int = readU30()
						ns_set[j] = namespace_pool[index]
					}
					ns_set_pool[i] = ns_set
				}
			} else {
				ns_set_pool = _abc.ns_set_pool = [[new ABCNamespace(ABC.PackageNamespace, '')]]
			}
		}
		
		private function _readMultinamePool():void {
			var multiname_count:int = _abc.multiname_count = readU30()
			if(multiname_count){
				multiname_pool = _abc.multiname_pool = new Array(multiname_count)
				multiname_pool[0] = Multiname.Any 
				
				for(var i:int = 1; i < multiname_count; i++){
					// parse multiname_info [u8, ?depends?]
					var multiname_kind:int = _bytes.readByte()
					var multiname:Multiname
					switch(multiname_kind){
						case Multiname.QName:
						case Multiname.QNameA:
							
							var qn_ns_index:int = readU30()
							var qn_s_index:int = readU30()
							multiname = new Multiname(multiname_kind, namespace_pool[qn_ns_index], string_pool[qn_s_index])
							break
						
						case Multiname.RTQName:
						case Multiname.RTQNameA:
							multiname = new Multiname(multiname_kind, string_pool[readU30()])
							break
						
						case Multiname.RTQNameL:
						case Multiname.RTQNameLA:
							multiname = new Multiname(multiname_kind)
							break
						
						case Multiname.Multiname:
						case Multiname.MultinameA:
							multiname = new Multiname(multiname_kind, string_pool[readU30()], ns_set_pool[readU30()])
							break
						
						case Multiname.MultinameL:
						case Multiname.MultinameLA:
							multiname = new Multiname(multiname_kind, ns_set_pool[readU30()])
							break
						
						case Multiname.TypeName:
							var type_name:Multiname = multiname_pool[readU30()]
							var param_count:int = readU30() // always 1 for now?
							var params:Array = []
							for(var j:int = 0; j < param_count; j++){
								params[j] = multiname_pool[readU30()]
							}
							multiname = new Multiname(multiname_kind, type_name, params)
							break
						
						default:
							throw new VerifyError('Unexpected multiname kind: ' + multiname_kind)
					}
					multiname_pool[i] = multiname
				}
			} else {
				multiname_pool = _abc.multiname_pool = [new Multiname(Multiname.Multiname, '~any~', ns_set_pool[0])]
			}
		}
		
		private function _readMethodInfoPool():void {
			var method_count:int = _abc.method_count = readU30()
			if(method_count){
				method_info_pool = _abc.method_info_pool = new Array(method_count)
				for(var i:int = 0; i < method_count; i++){
					var param_count:int = readU30()
					var return_type:Multiname = multiname_pool[readU30()]
					var param_types:Array = new Array(param_count)
					for(j = 0; j < param_count; j++){
						param_types[j] = multiname_pool[readU30()]
					}
					var method_name:String = string_pool[readU30()]
					var method_flags:uint = _bytes.readUnsignedByte()
					
					if(MethodInfo.hasOptionalFlag(method_flags)){
						// parse option_info [ u30, option_detail[] ]
						var option_count:int = readU30()
						var default_values:Array = new Array(option_count)
						for(var j:int = 0; j < option_count; j++){
							var index:int = readU30()
							var val_kind:int = _bytes.readByte()
							var val:* = _valueFromPool(val_kind, index)
							
							default_values[j] = { value: val, kind: val_kind }
						}
					}
					
					if(MethodInfo.hasParamNamesFlag(method_flags)){
						var param_names:Array = new Array(param_count)
						for(j = 0; j < param_count; j++){
							param_names[j] = string_pool[readU30()]
						}
					}
					
					var method_info:MethodInfo = new MethodInfo(param_count, return_type, param_types, method_name, method_flags, default_values, param_names)
					method_info_pool[i] = method_info
				}
			} else {
				method_info_pool = _abc.method_info_pool = new Array()
			}
		}
		
		private function _readMetadataPool():void {
			var metadata_count:int = _abc.metadata_count = readU30()
			if(metadata_count){
				metadata_pool = _abc.metadata_pool = new Array(metadata_count)
				for(var i:int = 0; i < metadata_count; i++){
					var meta_name:String = string_pool[readU30()]
					var meta_count:int = readU30()
					var metadata_data:Array = new Array
					for(var j:int = 0; j < meta_count; j++){
						// this structure permits multiple blank keys to carry different values
						metadata_data.push({ key: string_pool[readU30()], value: string_pool[readU30()] })
					}
					
					var metadata:Metadata = new Metadata(meta_name, metadata_data)
					metadata_pool[i] = metadata
				}
			} else {
				metadata_pool = _abc.metadata_pool = new Array()
			}
		}
		
		private function _readInstanceInfoPool():void {
			class_count = _abc.class_count = readU30()
			
			if(class_count){
				instance_info_pool = _abc.instance_info_pool = new Array(class_count)
				for(var i:int = 0; i < class_count; i++){
					var class_instance_name:Multiname = multiname_pool[readU30()] // must be of kind QName
					var class_super_name:Multiname = multiname_pool[readU30()]
					var instance_flags:int = _bytes.readByte()
					
					if(InstanceInfo.hasProtectedNsFlag(instance_flags)){
						var protectedNs:ABCNamespace = namespace_pool[readU30()]
					}
					
					var interface_count:int = readU30()
					if(interface_count){
						var interfaces:Array = new Array(interface_count)
						for(var j:int = 0; j < interface_count; j++){
							interfaces[j] = multiname_pool[readU30()]
						}
					} else {
						interfaces = new Array
					}
					
					var iinit:MethodInfo = method_info_pool[readU30()]
					
					var trait_count:int = readU30()
					
					var traits:Array = _readTraits(trait_count)
					var instance_info:InstanceInfo = new InstanceInfo(class_instance_name, class_super_name, instance_flags, protectedNs, interfaces, iinit, traits)
					instance_info_pool[i] = instance_info
				}
			} else {
				instance_info_pool = _abc.instance_info_pool = new Array
			}
		}
		
		private function _readClassInfoPool():void {
			if(class_count){
				class_info_pool = _abc.class_info_pool = new Array(class_count)
				for(var i:int = 0; i < class_count; i++){
					var cinit:MethodInfo = method_info_pool[readU30()]
					var trait_count:int = readU30()
					
					var traits:Array = _readTraits(trait_count)
					
					var class_info:ClassInfo = new ClassInfo(cinit, traits)
					class_info_pool[i] = class_info
				}
			} else {
				class_info_pool = _abc.class_info_pool = new Array
			}
		}
		
		private function _readScriptInfoPool():void {
			var script_count:int = _abc.script_count = readU30()
			
			if(script_count){
				script_info_pool = _abc.script_info_pool = new Array(script_count)
				
				for(var i:int = 0; i < script_count; i++){
					var init:MethodInfo = method_info_pool[readU30()]
					var trait_count:int = readU30()
					var traits:Array = _readTraits(trait_count)
					
					var script_info:ScriptInfo = new ScriptInfo(init, traits)
					script_info_pool[i] = script_info
				}
			} else {
				script_info_pool = _abc.script_info_pool = new Array
			}
		}
		
		private function _readMethodBodyInfoPool():void {
			var method_body_info_count:int = _abc.method_body_count = readU30()
			
			if(method_body_info_count){ // you'd hope that there'd be at least one in an ABC file =p
				method_body_info_pool = _abc.method_body_info_pool = new Array(method_body_info_count)
				
				for(var i:int = 0; i < method_body_info_count; i++){
					var method:MethodInfo = method_info_pool[readU30()]
					var max_stack:int = readU30()
					var local_count:int = readU30()
					var init_scope_depth:int = readU30()
					var max_scope_depth:int = readU30()
					var code_length:int = readU30()
					
					var code_start:int = _bytes.position
					
					if(code_length){
						var code:Array = new Array()
						
						var addrs:Array = []
						var init_pos:int = _bytes.position
						var bytes_read:int = 0
						while(bytes_read < code_length){
							var instr_addr:uint = _bytes.position - code_start
							var instr:Instruction = _readInstr()
							instr.addr = instr_addr
							instr.size = (_bytes.position - code_start) - instr_addr
							addrs.push(instr_addr)
							code.push(instr)
							// instructions are variable-length, and lookupswitch is 'dynamic' because it depends on an operand
							bytes_read = _bytes.position - init_pos
						}
						
						/*
							Change the targets of jump/branch instructions to be relative instr indices, rather 
							than byte offsets, so that they're more abstract jumps.  It needs to be done here 
							rather than in readInstr because forward jumps don't yet have known indices.
						*/
						var new_instr:Instruction
						for(j = 0; j < code.length; j++){
							instr = code[j]
							switch(instr.opcode){
								case Op.jump:
								case Op.iftrue:     case Op.iffalse:
								case Op.ifeq:       case Op.ifne:
								case Op.ifge:       case Op.ifnge:
								case Op.ifgt:       case Op.ifngt:
								case Op.ifle:       case Op.ifnle:
								case Op.iflt:       case Op.ifnlt:
								case Op.ifstricteq: case Op.ifstrictne:
									var offset:int = instr.operands[0]
									var new_addr:int = (instr.addr + instr.size) + offset
									var offset_index:int = addrs.indexOf(new_addr)
									if(offset_index == -1){
										//throw 'Invalid offset in jump/branch instruction'
										instr.operands[0] = '[~~Invalid offset ' + offset  + ' ~~ ' + new_addr + ']'
										break
									}
									
									instr.operands[0] = new_instr = code[offset_index]
									new_instr.needsLabel = true
									break
								case Op.lookupswitch:
									var default_offset:int = instr.operands[0]
									var default_offset_index:int = addrs.indexOf(instr.addr + default_offset)
									instr.operands[0] = code[default_offset_index]
									for(var k:int = 2; k < instr.operands.length; k++){ // 2 skips default_offset and case_count
										var cur_offset:int = instr.operands[k]
										var cur_offset_index:int = addrs.indexOf(instr.addr + cur_offset)
										instr.operands[k] = new_instr = code[cur_offset_index]
										new_instr.needsLabel = true
									}
							}
						}
					}
					
					var exception_count:int = readU30()
					
					if(exception_count){
						var exceptions:Array = new Array(exception_count)
						
						for(var j:int = 0; j < exception_count; j++){
							var e_from:int = readU30()
							var e_to:int = readU30()
							var e_target:int = readU30()
							var exc_type:String = string_pool[readU30()]
							var var_name:String = string_pool[readU30()]
							var exception:Exception = new Exception(e_from, e_to, e_target, exc_type, var_name)
							exceptions[j] = exception
						}
					} else {
						exceptions = new Array
					}
					
					var trait_count:int = readU30()
					var traits:Array = _readTraits(trait_count)
					
					var method_body_info:MethodBodyInfo = new MethodBodyInfo(method, max_stack, local_count, init_scope_depth, max_scope_depth, code_length, code, exceptions, traits)
					method_body_info_pool[i] = method_body_info
				}
			} else {
				method_body_info_pool = _abc.method_body_info_pool = new Array
			}
		}
		
		private function _readInstr():Instruction {
			var opcode:int = _bytes.readUnsignedByte()
			var opcode_info:Object = Instruction.opcodes[opcode]
			var instr:Instruction
			var operands:Array = []
			
			switch(opcode){
				case Op.debugfile:
				case Op.pushstring:
					instr = new Instruction(opcode, [string_pool[readU30()]])
					break
				case Op.pushnamespace:
					instr = new Instruction(opcode, [namespace_pool[readU30()]])
					break
				case Op.pushint:
					instr = new Instruction(opcode, [int_pool[readU30()]])
					break
				case Op.pushuint:
					instr = new Instruction(opcode, [uint_pool[readU30()]])
					break
				case Op.pushdouble:
					instr = new Instruction(opcode, [double_pool[readU30()]])
					break
				
				case Op.dxns:
					instr = new Instruction(opcode, [readU30()])
					break
				
				case Op.getsuper: 
				case Op.setsuper: 
				case Op.getproperty: 
				case Op.initproperty: 
				case Op.setproperty: 
				case Op.getlex: 
				case Op.findpropstrict: 
				case Op.findproperty:
				case Op.finddef:
				case Op.deleteproperty: 
				case Op.istype: 
				case Op.coerce: 
				case Op.astype: 
				case Op.getdescendants:
					var multin_index:int = readU30()
					instr = new Instruction(opcode, [multiname_pool[multin_index]])
					break
				case Op.constructprop:
				case Op.callproperty:
				case Op.callproplex:
				case Op.callsuper:
				case Op.callsupervoid:
				case Op.callpropvoid:
					instr = new Instruction(opcode, [multiname_pool[readU30()], readU30()])
					break
				case Op.newfunction:
					instr = new Instruction(opcode, [method_info_pool[readU30()]])
					break
				case Op.callstatic:
					instr = new Instruction(opcode, [method_info_pool[readU30()], readU30()])
					break
				case Op.newclass: 
					instr = new Instruction(opcode, [instance_info_pool[readU30()]])
					break
				case Op.lookupswitch:
					var default_offset:int = readS24()
					var case_count:int = readU30()
					operands = [default_offset, case_count]
					for(var i:int = 0; i < case_count + 1; i++){
						operands.push(readS24())
					}
					instr = new Instruction(opcode, operands)
					break
				case Op.jump:
				case Op.iftrue:     case Op.iffalse:
				case Op.ifeq:       case Op.ifne:
				case Op.ifge:       case Op.ifnge:
				case Op.ifgt:       case Op.ifngt:
				case Op.ifle:       case Op.ifnle:
				case Op.iflt:       case Op.ifnlt:
				case Op.ifstricteq: case Op.ifstrictne:
					instr = new Instruction(opcode, [readS24()])
					break
				
				case Op.inclocal:
				case Op.declocal:
				case Op.inclocal_i:
				case Op.declocal_i:
				case Op.getlocal:
				case Op.kill:
				case Op.setlocal:
				case Op.debugline:
				case Op.getglobalslot:
				case Op.getslot:
				case Op.setglobalslot:
				case Op.setslot:
				case Op.pushshort:
				case Op.newcatch:
					instr = new Instruction(opcode, [readU30()])
					break
				case Op.debug:
					operands = [_bytes.readUnsignedByte(), readU30(), _bytes.readUnsignedByte(), readU30()]
					instr = new Instruction(opcode, operands)
					break
				case Op.newobject:
					instr = new Instruction(opcode, [readU30()])
					break
				case Op.newarray:
					instr = new Instruction(opcode, [readU30()])
					break
				case Op.call:
				case Op.construct:
				case Op.constructsuper:
					instr = new Instruction(opcode, [readU30()])
					break
				case Op.pushbyte:
				case Op.getscopeobject:
					instr = new Instruction(opcode, [_bytes.readUnsignedByte()])
					break
				case Op.hasnext2:
					instr = new Instruction(opcode, [readU30(), readU30()])
					break
				
				case Op.applytype: 
					instr = new Instruction(opcode, [readU30()])
					break
				
				default:
					if(opcode_info && opcode_info.operands == 0){
						instr = new Instruction(opcode, null)
					} else {
						trace('unknown opcode', opcode, '0x' + opcode.toString(16))
					}
					break
			}
			
			return instr
		}
		
		/**
		 * This is the original version.  It's not very flexible.
		 */
		private function _readInstr2():Instruction {
			var opcode:int = _bytes.readUnsignedByte()
			var opcode_info:Object = Instruction.opcodes[opcode]
			var instr:Instruction
			var operands:Array = []
			
			if(opcode_info.operands == 0){
				instr = new Instruction(opcode)
			} else if(opcode_info.otype == 's24'){
				for(var i:int = 0; i < opcode_info.operands; i++){
					operands[i] = readS24()
				}
				instr = new Instruction(opcode, operands)
			} else if(opcode_info.otype == 'lookupswitch'){
				var default_offset:int = readS24()
				var case_count:int = readU30()
				operands = [default_offset, case_count]
				for(i = 0; i < case_count + 1; i++){
					operands.push(readS24())
				}
				instr = new Instruction(opcode, operands)
			} else if(opcode == Op.debug){
				operands = [_bytes.readUnsignedByte(), readU30(), _bytes.readUnsignedByte(), readU30()]
				instr = new Instruction(opcode, operands)
			} else if(opcode == Op.pushbyte){
				operands = [_bytes.readUnsignedByte()]
				instr = new Instruction(opcode, operands)
			} else { // there are some u30 operands
				for(i = 0; i < opcode_info.operands; i++){
					operands[i] = readU30()
				}
				instr = new Instruction(opcode, operands)
			}
			
			return instr
		}
		
		private function _readTraits(count:int):Array {
			var traits:Array
			if(count){
				traits = new Array(count)
				for(var i:int = 0; i < count; i++){
					var trait:Trait = _readTrait()
					traits[i] = trait
				}
			} else {
				traits = new Array
			}
			return traits
		}
		
		private function _readTrait():Trait {
			var trait_name:Multiname = multiname_pool[readU30()]
			
			var trait_kind:int = _bytes.readByte()
			var trait_type:int = trait_kind & 0x0f // lower 4 bits
			var trait_attrs:int = (trait_kind & 0xf0) >> 4 // upper 4 bits
			
			var trait:Trait = Trait.subtype(trait_name, trait_kind)
			switch(trait_type){
				case Trait.Slot:
				case Trait.Const:
					var slot_id:int = readU30()
					var type_name:Multiname = multiname_pool[readU30()]
					var vindex:int = readU30()
					if(vindex){
						var vkind:int = _bytes.readByte()
						var trait_value:* = _valueFromPool(vkind, vindex)
					}
					trait.fastInit(slot_id, type_name, trait_value, vkind)
					break
				
				case Trait.Class:
					slot_id = readU30()
					var classi:int = readU30()
					if(!class_info_pool) throw new Error('ClassInfo pool not yet initialized')
					var class_info:ClassInfo = class_info_pool[classi]
					trait.fastInit(slot_id, class_info)
					break
				
				case Trait.Function:
					slot_id = readU30()
					var func:MethodInfo = method_info_pool[readU30()]
					trait.fastInit(slot_id, func)
					break
				
				case Trait.Method:
				case Trait.Getter:
				case Trait.Setter:
					var disp_id:int = readU30() // this is probably a displacement id for a vtable
					var method_index:int = readU30()
					var method:MethodInfo = method_info_pool[method_index]
					trait.fastInit(disp_id, method)
					break
				
				default:
					throw new VerifyError('Unknown trait type encountered: ' + trait_type)
			}
			
			if(trait_attrs & Trait.Metadata){
				var trait_meta_count:int = readU30()
				for(var k:int = 0; k < trait_meta_count; k++){
					var meta_pool_index:int = readU30()
					trait.metadata.push(metadata_pool[meta_pool_index])
				}
			}
			return trait
		}
		
		private function _valueFromPool(kind:int, index:int):* {
			var val:*
			switch(kind){
				case ABC.Int:
					val = int_pool[index]
					break
				
				case ABC.UInt:
					val = uint_pool[index]
					break
				
				case ABC.Double:
					val = double_pool[index]
					break
				
				case ABC.Utf8:
					val = string_pool[index]
					break
				
				case ABC.True:
					val = true
					break
				
				case ABC.False:
					val = false
					break
				
				case ABC.Null:
					val = null
					break
				
				case ABC.Undefined:
					val = undefined
					break
				
				case ABC.Namespace:
				case ABC.PackageNamespace:
				case ABC.PackageInternalNs:
				case ABC.ProtectedNamespace:
				case ABC.ExplicitNamespace:
				case ABC.StaticProtectedNs:
				case ABC.PrivateNs:
					val = namespace_pool[index]
					break
				
				default:
					throw new VerifyError('Unexpected constant kind: ' + kind)
			}
			return val
		}
		
		/**
		 * Ripped wholesale from AVM+'s AvmCore.h
		 * See: http://hg.mozilla.org/tamarin-central/raw-file/fbecf6c8a86f/core/AvmCore.h
		 */
		private function readU30():uint {
			var result:uint = _bytes.readByte()
			if (!(result & 0x00000080)){
				//trace('u30 ' + result + ' at:', _bytes.position)
				return result
			}
			result = (result & 0x0000007f) | _bytes.readByte() << 7
			if (!(result & 0x00004000)){
				//trace('u30 ' + result + ' at:', _bytes.position)
				return result
			}
			result = (result & 0x00003fff) | _bytes.readByte() << 14
			if (!(result & 0x00200000)){
				//trace('u30 ' + result + ' at:', _bytes.position)
				return result
			}
			result = (result & 0x001fffff) | _bytes.readByte() << 21
			if (!(result & 0x10000000)){
				//trace('u30 ' + result + ' at:', _bytes.position)
				return result
			}
			result = (result & 0x0fffffff) | _bytes.readByte() << 28
			//trace('u30 ' + result + ' at:', _bytes.position)
			return result
		}
		
		/**
		 * Also taken from AVM+
		 */
		private function readS32():int {
			var result:int = _bytes.readByte()
			if (!(result & 0x00000080)) {
				return result
			}
			result = (result & 0x0000007f) | _bytes.readByte() << 7
			if (!(result & 0x00004000)) {
				return result
			}
			result = (result & 0x00003fff) | _bytes.readByte() << 14
			if (!(result & 0x00200000)) {
				return result
			}
			result = (result & 0x001fffff) | _bytes.readByte() << 21
			if (!(result & 0x10000000)) {
				return result
			}
			result = (result & 0x0fffffff) | _bytes.readByte() << 28
			return result
		}
		
		/**
		 * Reads a 24-bit / 3-byte, signed integer from the ABC file.  Used by some (annoying) AVM2 instructions.
		 */
		private function readS24():int {
			var result:int = _bytes.readUnsignedByte() | (_bytes.readUnsignedByte() << 8) | (_bytes.readByte() << 16)
			return result
		}
		
		/**
		 * Reads a string in the byte stream by
		 * reading all bytes until a null byte (0)
		 * is reached.
		 * @return The string having been read.
		 */
		public function readString():String {
			
			// find ending null character that
			// terminates the string
			var i:uint = _bytes.position
			try {
				while(_bytes[i] != 0) i++
			}catch (error:Error) {
				return ""
			}
			
			// null byte should have been found
			// return the read string
			return _bytes.readUTFBytes(i - _bytes.position)
		}
		
		/**
		 * Reads a series of bits from the current byte
		 * defined by currentByte based on the bit at
		 * position bitPosition.  If more bits are required
		 * than are available in the current byte, the next
		 * byte in the bytes array is read and the bits are
		 * taken from there to complete the request.
		 * @param	numBits The number of bits to read.
		 * @return The bits read as a uint.
		 */
		public function readBits(numBits:uint, signed:Boolean = false):Number {
			var value:Number	= 0 // int or uint
			var remaining:uint	= 8 - bitPosition
			var mask:uint
			
			// can get all bits from current byte
			if (numBits <= remaining){
				mask	= (1 << numBits) - 1
				value	= (currentByte >> (remaining - numBits)) & mask
				if (numBits == remaining) nextBitByte()
				else bitPosition += numBits
				
				// have to get bits from 2 (or more)
				// bytes the current and the next (recursive)
			}else{
				mask				= (1 << remaining) - 1
				var firstValue:uint	= currentByte & mask
				var over:uint		= numBits - remaining
				nextBitByte()
				value = (firstValue << over) | readBits(over)
			}
			
			// convert to signed int if signed bitflag exists
			if (signed && value >> (numBits - 1) == 1){
				remaining = 32 - numBits // 32-bit uint
				mask = (1 << remaining) - 1
				return int(mask << numBits | value)
			}
			
			// unsigned int
			return uint(value)
		}
		
		/**
		 * Reads the next byte in the stream assigning
		 * it to currentByte and resets the value of
		 * bitPosition to 0.
		 */
		public function nextBitByte():void {
			currentByte = _bytes.readByte()
			bitPosition = 0
		}
	}
}