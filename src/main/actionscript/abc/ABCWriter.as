package abc {
	import flash.utils.*
	import abc.traits.*
	
	/**
	 * Encodes an ABC instance as a ByteArray.
	 */
	public class ABCWriter {
		private var
			_abc:ABC,
			_bytes:ByteArray,
			_offsetEntries:Array = [],
			_rawABC:Boolean
		
		private var
			_estObjs:Dictionary = new Dictionary(true),
			_estInts:Array = [],
			_estUints:Array = [],
			_estDoubles:Array = [],
			_estStrings:Object = {}
		
		public function ABCWriter(abc:ABC, rawABC:Boolean = false){
			_abc = abc
			_rawABC = rawABC
		}
		
		public function toByteArray():ByteArray {
			_establish()
			_reconcile()
			_write()
			return _bytes
		}
		
		public static function writeABC(abc:ABC):ByteArray {
			var w:ABCWriter = new ABCWriter(abc)
			return w.toByteArray()
		}
		
		/**
		 * Merges the ABC pools with the Dictionary/Arrays of established objects that
		 * weren't in the original SWF (probably because they were added via code).
		 */
		private function _reconcile():void {
			_reconcileArray(_abc.int_pool, _estInts)
			_reconcileArray(_abc.uint_pool, _estUints)
			_reconcileArray(_abc.double_pool, _estDoubles)
			
			// reconcile string pool
			for each(var s:String in _estStrings){
				if(_abc.string_pool.indexOf(s) == -1 && s != null){
					_abc.string_pool.push(s)
				}
			}
			
			// reconcile objects
			var pool:Array
			for each(var o:* in _estObjs){
				if(o is ABCNamespace){
					pool = _abc.namespace_pool
				} else if(o is Array && o[0] is ABCNamespace){ // NSSet
					pool = _abc.ns_set_pool
				} else if(o is Multiname){
					pool = _abc.multiname_pool
				} else if(o is MethodInfo){
					pool = _abc.method_info_pool
				} else if(o is Metadata){
					pool = _abc.metadata_pool
				} else if(o is InstanceInfo){
					pool = _abc.instance_info_pool
				} else if(o is ClassInfo){
					pool = _abc.class_info_pool
				} else if(o is ScriptInfo){
					pool = _abc.script_info_pool
				} else if(o is MethodBodyInfo){
					pool = _abc.method_body_info_pool
				} else if(o is Instruction || o is Exception || o is Trait || o is Array){
					continue
				} else {
					throw new Error('Unexpected reconciliation type: ' + o)
				}
				
				if(pool && pool.indexOf(o) == -1){
					pool.push(o)
				}
			}
		}
		
		private function _reconcileArray(pool:Array, vals:Array):void {
			for each(var o:* in vals){
				if(pool.indexOf(o) == -1){
					pool.push(o)
				}
			}
		}
		
		/**
		 * Presumably, the ABC instance has either been generated from scratch or (at least)
		 * modified from its original form.  The constant pools may or may not reflect those 
		 * changes, since the pools can't be kept up to date without tying all abstractions 
		 * to a particular ABC instance.
		 */ 
		private function _establish():void {
			var len:int = _abc.method_body_info_pool.length
			for(var i:int = 0; i < len; i++){
				_establishMethodBodyInfo(_abc.method_body_info_pool[i])
			}
			
			len = _abc.script_info_pool.length
			for(i = 0; i < len; i++){
				_establishScriptInfo(_abc.script_info_pool[i])
			}
			
			len = _abc.class_info_pool.length
			for(i = 0; i < len; i++){
				_establishClassInfo(_abc.class_info_pool[i])
			}
			
			len = _abc.instance_info_pool.length
			for(i = 0; i < len; i++){
				_establishInstanceInfo(_abc.instance_info_pool[i])
			}
			
			len = _abc.metadata_pool.length
			for(i = 0; i < len; i++){
				_establishMetadata(_abc.metadata_pool[i])
			}
			
			len = _abc.method_info_pool.length
			for(i = 0; i < len; i++){
				_establishMethodInfo(_abc.method_info_pool[i])
			}
		}
		
		private function _establishTraits(ts:Array):void {
			if(_estObjs[ts]) return
			_estObjs[ts] = ts
			
			var len:int = ts.length
			for(var i:int = 0; i < len; i++){
				_establishTrait(ts[i])
			}
		}
		
		private function _establishTrait(t:Trait):void {
			if(_estObjs[t]) return
			_estObjs[t] = t
			_establishMultiname(t.name)
			switch(t.type){
				case Trait.Slot:
				case Trait.Const:
					// it's not worth casting these...
					_establishMultiname(t['type_name'])
					
					_establishValFromPool(t['value_kind'], t['value'])
					break
				
				case Trait.Class:
					_establishClassInfo(t['class_info'])
					break
				
				case Trait.Function:
					_establishMethodInfo(t['function_info'])
					break
				
				case Trait.Method:
				case Trait.Getter:
				case Trait.Setter:
					_establishMethodInfo(t['method'])
					break
				
				default:
					throw new VerifyError('Unknown trait type encountered: ' + t.type)
			}
			
			if(t.attr & Trait.Metadata){
				var len:int = t.metadata.length
				if(len){
					for(var i:int = 0; i < len; i++){
						_establishMetadata(t.metadata[i])
					}
				}
			}
		}
		
		private function _establishMetadata(m:Metadata):void {
			if(_estObjs[m]) return
			_estObjs[m] = m
			
			_establishString(m.name)
			var len:int = m.data.length
			for(var i:int = 0; i < len; i++){
				if(m.data[i]){
					_establishString(m.data[i].key)
					_establishString(m.data[i].value)
				}
			}
		}
		
		private function _establishValFromPool(kind:int, val:*):void {
			var val:*
			switch(kind){
				case ABC.Int:
					_establishInt(val)
					break
				
				case ABC.UInt:
					_establishUint(val)
					break
				
				case ABC.Double:
					_establishDouble(val)
					break
				
				case ABC.Utf8:
					_establishString(val)
					break
				
				case ABC.Namespace:
				case ABC.PackageNamespace:
				case ABC.PackageInternalNs:
				case ABC.ProtectedNamespace:
				case ABC.ExplicitNamespace:
				case ABC.StaticProtectedNs:
				case ABC.PrivateNs:
					_establishNamespace(val)
					break
				
				default:
					// it's some type that doesn't need to be established
			}
		}
		
		private function _establishInstanceInfo(ii:InstanceInfo):void {
			if(_estObjs[ii]) return
			_estObjs[ii] = ii
			
			_establishMultiname(ii.name)
			_establishMultiname(ii.super_name)
			
			if(ii.protectedNs) _establishNamespace(ii.protectedNs)
			
			var len:int = ii.interfaces.length
			for(var i:int = 0; i < len; i++){
				_establishMultiname(ii.interfaces[i])
			}
			
			_establishMethodInfo(ii.iinit)
			_establishTraits(ii.traits)
		}
		
		private function _establishClassInfo(ci:ClassInfo):void {
			if(_estObjs[ci]) return
			_estObjs[ci] = ci
			
			_establishMethodInfo(ci.cinit)
			_establishTraits(ci.traits)
		}
		
		private function _establishScriptInfo(si:ScriptInfo):void {
			if(_estObjs[si]) return
			_estObjs[si] = si
			
			_establishMethodInfo(si.init)
			_establishTraits(si.traits)
		}
		
		private function _establishMethodBodyInfo(mbi:MethodBodyInfo):void {
			if(_estObjs[mbi]) return
			_estObjs[mbi] = mbi
			
			_establishMethodInfo(mbi.method)
			var code:Array = mbi.code
			var len:int = code.length
			for(var i:int = 0; i < len; i++){
				_establishInstruction(code[i])
			}
			
			var exceptions:Array = mbi.exceptions
			len = exceptions.length
			for(i = 0; i < len; i++){
				_establishException(exceptions[i])
			}
			
			_establishTraits(mbi.traits)
		}
		
		private function _establishMethodInfo(mi:MethodInfo):void {
			if(_estObjs[mi]) return
			_estObjs[mi] = mi
			
			_establishMultiname(mi.returnType)
			
			var len:int = mi.paramTypes.length
			for(var i:int = 0; i < len; i++){
				_establishMultiname(mi.paramTypes[i])
			}
			
			_establishString(mi.name)
			
			if(MethodInfo.hasOptionalFlag(mi.flags)){
				len = mi.defaultValues.length
				for(i = 0; i < len; i++){
					
					_establishValFromPool(mi.defaultValues[i].kind, mi.defaultValues[i].val)
				}
			}
			
			if(MethodInfo.hasParamNamesFlag(mi.flags)){
				len = mi.paramNames.length
				for(i = 0; i < len; i++){
					_establishString(mi.paramNames[i])
				}
			}
		}
		
		private function _establishInstruction(instr:Instruction):void {
			if(_estObjs[instr]) return
			_estObjs[instr] = instr
			
			var opcode:int = instr.opcode
			var operands:Array = instr.operands
			
			switch(opcode){
				case Op.debugfile:
				case Op.pushstring:
					_establishString(operands[0])
					break
				case Op.pushnamespace:
					_establishNamespace(operands[0])
					break
				case Op.pushint:
					_establishInt(operands[0])
					break
				case Op.pushuint:
					_establishUint(operands[0])
					break
				case Op.pushdouble:
					_establishDouble(operands[0])
					break
				
				case Op.dxns:
					// nothing
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
					_establishMultiname(operands[0])
					break
				case Op.constructprop:
				case Op.callproperty:
				case Op.callproplex:
				case Op.callsuper:
				case Op.callsupervoid:
				case Op.callpropvoid:
					_establishMultiname(operands[0]);
					break
				case Op.newfunction:
					_establishMethodInfo(operands[0])
					break
				case Op.callstatic:
					_establishMethodInfo(operands[0])
					break
				case Op.newclass: 
					_establishInstanceInfo(operands[0])
					break
				case Op.lookupswitch:
					// nothing to establish
					break
				case Op.jump:
				case Op.iftrue:     case Op.iffalse:
				case Op.ifeq:       case Op.ifne:
				case Op.ifge:       case Op.ifnge:
				case Op.ifgt:       case Op.ifngt:
				case Op.ifle:       case Op.ifnle:
				case Op.iflt:       case Op.ifnlt:
				case Op.ifstricteq: case Op.ifstrictne:
					// nothing
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
					// nothing
					break
				case Op.debug:
					// nothing
					break
				case Op.newobject:
					// nothing
					break
				case Op.newarray:
					// nothing
					break
				case Op.call:
				case Op.construct:
				case Op.constructsuper:
					// nothing
					break
				case Op.pushbyte:
				case Op.getscopeobject:
					// nothing
					break
				case Op.hasnext2:
					// nothing
					break
				case Op.applytype: 
					// nothing
					break
				default:
					break
			}
		}
		
		private function _establishException(err:Exception):void {
			if(_estObjs[err]) return
			_estObjs[err] = err
			
			_establishString(err.exc_type)
			_establishString(err.var_name)
		}
		
		private function _establishInt(i:int):void {
			_estInts[i] = i
		}
		
		private function _establishUint(u:uint):void {
			_estUints[u] = u
		}
		
		private function _establishDouble(d:Number):void {
			_estDoubles[d] = d
		}
		
		private function _establishString(s:String):void {
			_estStrings[s] = s
		}
		
		private function _establishNamespace(n:ABCNamespace):void {
			_estObjs[n] = n
			_establishString(n.name)
		}
		
		private function _establishNSSet(nss:Array):void {
			if(_estObjs[nss]) return
			_estObjs[nss] = nss
			
			var len:int = nss.length
			for(var i:int = 0; i < len; i++){
				if(nss[i] is Namespace) _establishNamespace(nss[i])
			}
		}
		
		private function _establishMultiname(m:Multiname):void {
			if(_estObjs[m]) return
			_estObjs[m] = m
			
			if(m.name) _establishString(m.name)
			if(m.ns) _establishNamespace(m.ns)
			if(m.nsSet) _establishNSSet(m.nsSet)
			if(m.typeName) _establishMultiname(m.typeName)
			if(m.params){
				for(var i:int = 0; i < m.params.length; i++){
					if(m.params[i]) _establishMultiname(m.params[i])
				}
			}
		}
		
		private function _write():void {
			//trace('starting write')
			_bytes = new ByteArray
			//_bytes.endian = Endian.LITTLE_ENDIAN // for avmshell/rawabc
			/*if(_abc.abcname){
				_bytes.writeUnsignedInt(_abc.flags)
				trace(_bytes.position)
				_bytes.writeUTFBytes(_abc.abcname)
				trace(_bytes.position)
				_bytes.writeByte(0) // null terminate string?
				trace(_bytes.position)
			}*/
			
			//_writeU16(_abc.minor_version)
			//_writeU16(_abc.major_version)
			_bytes.writeByte(0x0)
			_bytes.writeByte(0x10)
			_bytes.writeByte(0x0)
			_bytes.writeByte(0x2e)
			//----ByteUtils.writeU16(_bytes, _abc.minor_version)
			//----ByteUtils.writeU16(_bytes, _abc.major_version)
			//_bytes.writeShort(_abc.minor_version)
			//_bytes.writeShort(_abc.major_version)
			
			if(!_rawABC) _bytes.writeByte(0) // appears to be unused (?)
			
			// constant pool
			//trace('starting constant')
			_writeConstantPool()
			
			//trace('starting rest')
			_writeRest()
			_bytes.position = 0
		}
		
		private function _spi(s:String):int {
			var index:int = _abc.string_pool.indexOf(s)
			//if(index < 10) trace('spi', index, '->' + s + '<-')
			//if(s.toString() == '') return 0
			if(index == -1) throw 'wtf, ' + s
			return index
		}
		
		private function _writeConstantPool():void {
			//trace('int pool')
			// int pool
			var int_count:int = _abc.int_pool.length
			if(int_count <= 1){
				_writeU30(0)
			} else {
				_writeU30(int_count)
				var int_pool:Array = _abc.int_pool
				for(var i:int = 1; i < int_count; i++){ // 1st pool entry is implicit
					_writeU30(int_pool[i])
				}
			}
			
			//trace('uints')
			// uint pool
			var uint_count:int = _abc.uint_pool.length
			if(uint_count <= 1){
				_writeU30(0)
			} else {
				_writeU30(uint_count)
				var uint_pool:Array = _abc.uint_pool
				for(i = 1; i < uint_count; i++){
					_writeU30(uint_pool[i])
				}
			}
			
			// double pool
			var double_count:int = _abc.double_pool.length
			if(double_count <= 1){
				_writeU30(0)
			} else {
				_writeU30(double_count)
				var double_pool:Array = _abc.double_pool
				for(i = 1; i < double_count; i++){
					_bytes.endian = Endian.LITTLE_ENDIAN
					_bytes.writeDouble(double_pool[i])
					_bytes.endian = Endian.BIG_ENDIAN
				}
			}
			
			// string pool
			var string_count:int = _abc.string_pool.length
			if(string_count <= 1){
				_writeU30(0)
			} else {
				_writeU30(string_count)
				var string_pool:Array = _abc.string_pool
				for(i = 1; i < string_count; i++){
					var str:String = string_pool[i]
					_writeU30(str.length)
					_bytes.writeUTFBytes(str)
				}
			}
			//trace('namespaces')
			
			var namespace_count:int = _abc.namespace_pool.length
			if(namespace_count <= 1){
				_writeU30(0)
			} else {
				_writeU30(namespace_count)
				var namespace_pool:Array = _abc.namespace_pool
				for(i = 1; i < namespace_count; i++){
					var namespace:ABCNamespace = namespace_pool[i]
					_bytes.writeByte(namespace.kind)
					//if(namespace.name == '' && namespace.kind == ABC.PackageNamespace){
					//	_writeU30(2)
					//} else {
						_writeU30(_spi(namespace.name))
					//}
				}
			}
			
			var ns_set_count:int = _abc.ns_set_pool.length
			if(ns_set_count <= 1){
				_writeU30(0)
			} else {
				_writeU30(ns_set_count)
				for(i = 1; i < ns_set_count; i++){
					var ns_set:Array = _abc.ns_set_pool[i]
					_writeU30(ns_set.length)
					for(var j:int = 0; j < ns_set.length; j++){
						_writeU30(_abc.namespace_pool.indexOf(ns_set[j]))
					}
				}
			}
			
			//trace('multinames')
			var multiname_count:int = _abc.multiname_pool.length
			if(multiname_count <= 1){
				_writeU30(0)
			} else {
				_writeU30(multiname_count)
				for(i = 1; i < multiname_count; i++){
					var m:Multiname = _abc.multiname_pool[i]
					_bytes.writeByte(m.kind)
					switch(m.kind){
						case Multiname.QName:
						case Multiname.QNameA:
							_writeU30(_abc.namespace_pool.indexOf(m.ns))
							_writeU30(_spi(m.name))
							break
						
						case Multiname.RTQName:
						case Multiname.RTQNameA:
							_writeU30(_spi(m.name))
							break
						
						case Multiname.RTQNameL:
						case Multiname.RTQNameLA:
							// nothing
							break
						
						case Multiname.Multiname:
						case Multiname.MultinameA:
							_writeU30(_spi(m.name))
							_writeU30(_abc.ns_set_pool.indexOf(m.nsSet))
							break
						
						case Multiname.MultinameL:
						case Multiname.MultinameLA:
							_writeU30(_abc.ns_set_pool.indexOf(m.nsSet))
							break
						
						case Multiname.TypeName:
							_writeU30(_abc.multiname_pool.indexOf(m.typeName))
							_writeU30(m.params.length)
							for(j = 0; j < m.params.length; j++){
								_writeU30(_abc.multiname_pool.indexOf(m.params[j]))
							}
							break
						
						default:
							throw new VerifyError('Unexpected multiname kind: ' + m.kind)
					}
				}
			}
		}
		
		/**
		 * Write the parts of the ABC file that aren't part of the constant pool.
		 */
		private function _writeRest():void {
			var method_count:int = _abc.method_info_pool.length
			_writeU30(method_count)
			for(var i:int = 0; i < method_count; i++){
				var mi:MethodInfo = _abc.method_info_pool[i]
				_writeU30(mi.paramTypes.length)
				_writeU30(_abc.multiname_pool.indexOf(mi.returnType))
				
				for(var j:int = 0; j < mi.paramTypes.length; j++){
					var index:int = _abc.multiname_pool.indexOf(mi.paramTypes[j])
					_writeU30(index)
				}
				
				_writeU30(_spi(mi.name))
				_bytes.writeByte(mi.flags)
				
				if(MethodInfo.hasOptionalFlag(mi.flags)){
					_writeU30(mi.defaultValues.length) // option_count
					for(j = 0; j < mi.defaultValues.length; j++){
						var valObj:Object = mi.defaultValues[j]
						_writeU30(_poolIndexFromKind(valObj.value, valObj.kind))
						_bytes.writeByte(valObj.kind)
					}
				}
				
				if(MethodInfo.hasParamNamesFlag(mi.flags)){
					for(j = 0; j < mi.paramNames.length; j++){
						_writeU30(_spi(mi.paramNames[j]))
					}
				}
			}
			
			var metadata_count:int = _abc.metadata_pool.length
			_writeU30(metadata_count)
			for(i = 0; i < metadata_count; i++){
				var md:Metadata = _abc.metadata_pool[i]
				_writeU30(_spi(md.name))
				_writeU30(md.data.length)
				for(j = 0; j < md.data.length; j++){
					_writeU30(_spi(md.data[j].key))
					_writeU30(_spi(md.data[j].value))
				}
			}
			
			var class_count:int = Math.min(_abc.instance_info_pool.length,_abc.class_info_pool.length)
			_writeU30(class_count)
			for(i = 0; i < class_count; i++){
				var ii:InstanceInfo = _abc.instance_info_pool[i]
				_writeU30(_abc.multiname_pool.indexOf(ii.name))
				_writeU30(_abc.multiname_pool.indexOf(ii.super_name))
				_bytes.writeByte(ii.flags)
				if(InstanceInfo.hasProtectedNsFlag(ii.flags)){
					_writeU30(_abc.namespace_pool.indexOf(ii.protectedNs))
				}
				_writeU30(ii.interfaces.length)
				for(j = 0; j < ii.interfaces.length; j++){
					_writeU30(_abc.multiname_pool.indexOf(ii.interfaces[j]))
				}
				_writeU30(_abc.method_info_pool.indexOf(ii.iinit))
				_writeU30(ii.traits.length)
				_writeTraits(ii.traits)
			}
			
			for(i = 0; i < class_count; i++){
				var ci:ClassInfo = _abc.class_info_pool[i]
				_writeU30(_abc.method_info_pool.indexOf(ci.cinit))
				_writeU30(ci.traits.length)
				_writeTraits(ci.traits)
			}
			
			var script_count:int = _abc.script_info_pool.length
			_writeU30(script_count)
			for(i = 0; i < script_count; i++){
				var si:ScriptInfo = _abc.script_info_pool[i]
				_writeU30(_abc.method_info_pool.indexOf(si.init))
				_writeU30(si.traits.length)
				_writeTraits(si.traits)
			}
			
			var method_body_info_count:int = _abc.method_body_info_pool.length
			_writeU30(method_body_info_count)
			for(i = 0; i < method_body_info_count; i++){
				var mbi:MethodBodyInfo = _abc.method_body_info_pool[i]
				
				_walkBytecode(mbi)
				
				_writeU30(_abc.method_info_pool.indexOf(mbi.method))
				_writeU30(mbi.max_stack + 4) // TODO: Obviously this is calculated incorrectly, but +4 helps for now.
				_writeU30(mbi.local_count)
				_writeU30(mbi.init_scope_depth)
				_writeU30(mbi.max_scope_depth)
				
				// instrs need to be written into a separate ByteArray first, so that the size is known for mbi.code_length
				var instrBytes:ByteArray = new ByteArray
				for(j = 0; j < mbi.code.length; j++){
					_writeInstr(instrBytes, mbi.code[j])
				}
				
				_writeOffsets(instrBytes)
				
				_writeU30(instrBytes.length)
				
				// actually write the code to the ABC block
				instrBytes.position = 0
				_bytes.writeBytes(instrBytes)
				
				_writeU30(mbi.exceptions.length)
				for(j = 0; j < mbi.exceptions.length; j++){
					var err:Exception = mbi.exceptions[j]
					_writeU30(err.from)
					_writeU30(err.to)
					_writeU30(err.target)
					_writeU30(_spi(err.exc_type))
					_writeU30(_spi(err.var_name))
				}
				_writeU30(mbi.traits.length)
				_writeTraits(mbi.traits)
			}
		}
		
		
		private function _walkBytecode(mbi:MethodBodyInfo):void {
			var code:Array = mbi.code
			
			var scope_stack:int = mbi.init_scope_depth
			var max_scope:int = scope_stack
			
			var stack:int = 0
			var max_stack:int = 0
			
			var max_register:uint = 0
			var reg:uint = 0
			
			var len:int = code.length
			for(var i:int = 0; i < len; i++){
				var instr:Instruction = code[i]
				scope_stack += instr.scopeEffect
				if(scope_stack > max_scope) max_scope = scope_stack
				
				stack += instr.stackEffect
				if(stack > max_stack) max_stack = stack
				
				reg = instr.register
				if(reg > max_register) max_register = reg
			}
			
			// TODO: init_scope_depth is probably the max_scope of the lexically enclosing parent method
			mbi.max_scope_depth = max_scope
			mbi.max_stack = max_stack + 1 // added 6.6.12, due to a constructor with "throw function(){ return function(){ return this }() }"
			mbi.local_count = max_register + 2
		}
		
		private function _writeInstr(bytes:ByteArray, instr:Instruction):void {
			instr.addr = bytes.position
			var opcode:int = instr.opcode
			var operands:Array = instr.operands
			bytes.writeByte(opcode)
			
			if(!operands || operands.length == 0) return
			
			switch(opcode){
				case Op.debugfile:
				case Op.pushstring:
					ByteUtils.writeU30(bytes, _spi(operands[0]))
					break
				case Op.pushnamespace:
					ByteUtils.writeU30(bytes, _abc.namespace_pool.indexOf(operands[0]))
					break
				case Op.pushint:
					ByteUtils.writeU30(bytes, _abc.int_pool.indexOf(operands[0]))
					break
				case Op.pushuint:
					ByteUtils.writeU30(bytes, _abc.uint_pool.indexOf(operands[0]))
					break
				case Op.pushdouble:
					ByteUtils.writeU30(bytes, _abc.double_pool.indexOf(operands[0]))
					break
				
				case Op.dxns:
					ByteUtils.writeU30(bytes, operands[0])
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
					ByteUtils.writeU30(bytes, _abc.multiname_pool.indexOf(operands[0]))
					break
				case Op.constructprop:
				case Op.callproperty:
				case Op.callproplex:
				case Op.callsuper:
				case Op.callsupervoid:
				case Op.callpropvoid:
					ByteUtils.writeU30(bytes, _abc.multiname_pool.indexOf(operands[0]))
					ByteUtils.writeU30(bytes, operands[1])
					break
				case Op.newfunction:
					ByteUtils.writeU30(bytes, _abc.method_info_pool.indexOf(operands[0]))
					break
				case Op.callstatic:
					ByteUtils.writeU30(bytes, _abc.method_info_pool.indexOf(operands[0]))
					ByteUtils.writeU30(bytes, operands[1])
					break
				case Op.newclass: 
					ByteUtils.writeU30(bytes, _abc.instance_info_pool.indexOf(operands[0]))
					break
				case Op.lookupswitch:
					_writeOffsetLater(bytes.position, operands[0], instr.addr)
					ByteUtils.writeS24(bytes, 0)
					ByteUtils.writeU30(bytes, operands.length - 3)
					for(var i:int = 2; i < operands.length; i++){
						_writeOffsetLater(bytes.position, operands[i], instr.addr)
						ByteUtils.writeS24(bytes, operands[i])
					}
					break
				case Op.jump:
				case Op.iftrue:     case Op.iffalse:
				case Op.ifeq:       case Op.ifne:
				case Op.ifge:       case Op.ifnge:
				case Op.ifgt:       case Op.ifngt:
				case Op.ifle:       case Op.ifnle:
				case Op.iflt:       case Op.ifnlt:
				case Op.ifstricteq: case Op.ifstrictne:
					// TODO: operands[0] is now an Instruction reference, so this becomes more complicated
					if(operands[0] is Instruction) _writeOffsetLater(bytes.position, operands[0], instr.addr + 4) // + 4 because this offset is relative to the next instr
					ByteUtils.writeS24(bytes, 0) // just fill up the space
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
					ByteUtils.writeU30(bytes, operands[0])
					break
				case Op.debug:
					bytes.writeByte(operands[0])
					ByteUtils.writeU30(bytes, operands[1])
					bytes.writeByte(operands[2])
					ByteUtils.writeU30(bytes, operands[3])
					break
				case Op.newobject:
					ByteUtils.writeU30(bytes, operands[0])
					break
				case Op.newarray:
					ByteUtils.writeU30(bytes, operands[0])
					break
				case Op.call:
				case Op.construct:
				case Op.constructsuper:
					ByteUtils.writeU30(bytes, operands[0])
					break
				case Op.pushbyte:
				case Op.getscopeobject:
					bytes.writeByte(operands[0])
					break
				case Op.hasnext2:
					ByteUtils.writeU30(bytes, operands[0])
					ByteUtils.writeU30(bytes, operands[1])
					break
				
				case Op.applytype:
					ByteUtils.writeU30(bytes, operands[0])
					break
				default:
					// no operands
					break
			}
		}
		
		/**
		 * Stores information about where a jump/branch instruction's operand is stored, 
		 * for later use by _writeOffsets.
		 * 
		 * @param	position	The location in the ByteArray where 3 bytes should be written as the offset.
		 * @param	instr		The instruction that is the target of the jump.  Its address isn't yet known.
		 * @param	baseAddr	In bytes, the base address used for this type of instruction. 
		 */
		private function _writeOffsetLater(position:uint, instr:Instruction, baseAddr:uint):void {
			_offsetEntries.push({ position: position, instr: instr, baseAddr: baseAddr })
		}
		
		/**
		 * Jump/branch instructions need to know the byte offset of their target(s) 
		 * from the current instruction.  This can't easily be known until those other 
		 * instructions are written to a ByteArray, so this function takes stored 
		 * information about where to write the 3 bytes of the s24 that holds the offset 
		 * in the original branch instruction.  
		 * 
		 * @param	instrBytes	Method bodies use a separate ByteArray, so it needs to be supplied.
		 */
		private function _writeOffsets(instrBytes:ByteArray):void {
			var initPos:uint = instrBytes.position
			
			for each(var entry:Object in _offsetEntries){
				instrBytes.position = entry.position
				ByteUtils.writeS24(instrBytes, entry.instr.addr - entry.baseAddr)
			}
			
			_offsetEntries.length = 0
			instrBytes.position = initPos
		}
		
		private function _writeTraits(ts:Array):void {
			for(var i:int = 0; i < ts.length; i++){
				_writeTrait(ts[i])
			}
		}
		
		private function _writeTrait(t:Trait):void {
			_writeU30(_abc.multiname_pool.indexOf(t.name))
			_bytes.writeByte(t.kind)
			
			switch(t.type){
				case Trait.Slot:
				case Trait.Const:
					_writeU30(t['slot_id'])
					_writeU30(_abc.multiname_pool.indexOf(t['type_name']))
					var index:int = _poolIndexFromKind(t['value'], t['value_kind'])
					_writeU30(index)
					if(index != 0){
						_bytes.writeByte(t['value_kind'])
					}
					break
				
				case Trait.Class:
					_writeU30(t['slot_id'])
					_writeU30(_abc.class_info_pool.indexOf(t['class_info']))
					break
				
				case Trait.Function:
					_writeU30(t['slot_id'])
					_writeU30(_abc.method_info_pool.indexOf(t['function_info']))
					break
				
				case Trait.Method:
				case Trait.Getter:
				case Trait.Setter:
					_writeU30(t['disp_id'])
					_writeU30(_abc.method_info_pool.indexOf(t['method']))
					break
				
				default:
					throw new VerifyError('Unknown trait type encountered: ' + t.type)
			}
			
			if(t.attr & Trait.Metadata){
				_writeU30(t.metadata.length)
				for(var i:int = 0; i < t.metadata.length; i++){
					_writeU30(_abc.metadata_pool.indexOf(t.metadata[i]))
				}
			}
		}
		
		private function _poolIndexFromKind(val:*, kind:int):int {
			switch(kind){
				case ABC.Int:
					return _abc.int_pool.indexOf(val)
					break
				
				case ABC.UInt:
					return _abc.uint_pool.indexOf(val)
					break
				
				case ABC.Double:
					return _abc.double_pool.indexOf(val)
					break
				
				case ABC.Utf8:
					return _spi(val)
					break
				
				case ABC.True:
					return 0
					break
				
				case ABC.False:
					return 0
					break
				
				case ABC.Null:
					return 0
					break
				
				case ABC.Undefined:
					return 0
					break
				
				case ABC.Namespace:
				case ABC.PackageNamespace:
				case ABC.PackageInternalNs:
				case ABC.ProtectedNamespace:
				case ABC.ExplicitNamespace:
				case ABC.StaticProtectedNs:
				case ABC.PrivateNs:
					return _abc.namespace_pool.indexOf(val)
					break
				
				default:
					throw new VerifyError('Unexpected constant kind: ' + kind)
			}
			return 0
		}
		
		private function _writeU16(val:int):void {
			_bytes.writeByte(val)
			_bytes.writeByte(val >> 8)
		}
		
		private function _writeS24(val:int):void {
			_writeU16(val)
			_bytes.writeByte(val >> 16)
		}
		
		// adapted from:
		// opensource.adobe.com/svn/opensource/flex/sdk/trunk/modules/asc/src/java/adobe/abc/GlobalOptimizer.java
		private function _writeU30(val:int):void {
			if(val < 128 && val >= 0){
				_bytes.writeByte(val)
			} else if(val < 16384 && val >= 0){
				_bytes.writeByte(val & 0x7F | 0x80)
				_bytes.writeByte(val >> 7)
			} else if(val < 2097152 && val >= 0){
				_bytes.writeByte(val & 0x7F | 0x80)
				_bytes.writeByte(val >> 7 | 0x80)
				_bytes.writeByte(val >> 14)
			} else if(val < 268435456 && val >= 0){
				_bytes.writeByte(val & 0x7F | 0x80)
				_bytes.writeByte(val >> 7 | 0x80)
				_bytes.writeByte(val >> 14 | 0x80)
				_bytes.writeByte(val >> 21)
			} else {
				_bytes.writeByte(val & 0x7F | 0x80)
				_bytes.writeByte(val >> 7 | 0x80)
				_bytes.writeByte(val >> 14 | 0x80)
				_bytes.writeByte(val >> 21 | 0x80)
				_bytes.writeByte(val >> 28)
			}
		}
	}
}