package abc.analysis {
	import abc.*
	import abc.traits.*

	import flash.utils.*

	public class AbstractInterpretation {
		private var
			mbi:MethodBodyInfo,
			mi:MethodInfo,
			ii:InstanceInfo,
			ci:ClassInfo,
			bc:ABC,
			interpretation:Vector.<InterpretationPath>,
			leaders:Vector.<CFGNode>,
			leaderInstrs:Dictionary,
			cfgRoot:CFGNode,
			nameTable:Array
		
		public var
			slicesForInstruction:Dictionary
		
		public function AbstractInterpretation(methodContext:MethodInfo, instanceContext:InstanceInfo, classContext:ClassInfo, bc:ABC){
			mi = methodContext
			mbi = mi.body
			ii = instanceContext
			ci = classContext
			this.bc = bc
			
			// speeds up Multiname lookups
			initNameTable()
			
			// need a CFG
			constructCFG()
			
			// run the interpretation on the CFG
			interpret()
		}
		
		private function interpret():void {
			interpretation = new <InterpretationPath>[]
			slicesForInstruction = new Dictionary
			var path:InterpretationPath = new InterpretationPath
			var methodEntry:CallSlice = new CallSlice
			enterMethod(methodEntry, mi)
			path.sliceLists = new <Vector.<CallSlice>>[new <CallSlice>[methodEntry]]
			visit(cfgRoot, path)
		}
		
		/**
		 * Initializes registers with parameters, etc.
		 */
		private function enterMethod(slice:CallSlice, mi:MethodInfo):void {
			if(mi.paramCount > 0){
				for(var i:int = 0; i < mi.paramCount; i++){
					slice.registers[i + 1] = symbolicType(mi.paramTypes[i])
				}
			}
		}
		
		private function visit(node:CFGNode, path:InterpretationPath):void {
			path.nodes.push(node)
			
			var lastSliceList:Vector.<CallSlice> = path.sliceLists[path.sliceLists.length - 1]
			var lastSlice:CallSlice = lastSliceList[lastSliceList.length - 1]
			
			var curSliceList:Vector.<CallSlice> = new <CallSlice>[]
			var curSlice:CallSlice = lastSlice
			for each(var instr:Instruction in node.instrs){
				if(!slicesForInstruction[instr]) slicesForInstruction[instr] = []
				slicesForInstruction[instr].push(curSlice)
				curSlice = execInstr(instr, curSlice)
				trace('\tStack: ' + curSlice.inspectStack)
				trace('\tScope: ' + curSlice.inspectScope)
				trace('\tRegs ' + curSlice.inspectRegs)
				curSliceList.push(curSlice)
			}
			
			path.sliceLists.push(curSliceList)
			
			trace('-- node')
			
			if(node.outEdges.length == 0){ // these are terminal control flow nodes
				interpretation.push(path)
				return
			}
			
			for each(var nextNode:CFGNode in node.outEdges){
				if(nextNode.depth <= node.depth) break // don't want to endlessly execute loops
				visit(nextNode, path.clone())
			}
			
		}
		
		private function constructCFG():void {
			var root:CFGNode
			
			// BBs
			leaders = new <CFGNode>[]
			leaderInstrs = new Dictionary(true)
			for(var i:int = 0; i < mbi.code.length; i++){
				var instr:Instruction = mbi.code[i]
				var nextInstr:Instruction
				var index:int
				var node:CFGNode
				if(i == 0){ // first node is always a leader
					node = new CFGNode
					node.instrs.push(instr)
					node.isRoot = true
					leaders.push(node)
					leaderInstrs[instr] = node
					root = node
				}
				
				switch(instr.opcode){
					case Op.jump:
						if(instr.operands[0] is Instruction) addLeader(instr.operands[0])
						break
					case Op.iftrue:     case Op.iffalse:
					case Op.ifeq:       case Op.ifne:
					case Op.ifge:       case Op.ifnge:
					case Op.ifgt:       case Op.ifngt:
					case Op.ifle:       case Op.ifnle:
					case Op.iflt:       case Op.ifnlt:
					case Op.ifstricteq: case Op.ifstrictne:
						// code after a conditional branch starts a leader
						index = mbi.code.indexOf(instr) + 1
						if(mbi.code[index]){
							nextInstr = mbi.code[index]
							addLeader(nextInstr)
						}
						
						// branch targets are leaders
						nextInstr = instr.operands[0]
						addLeader(nextInstr)
						break
					case Op.throw_:		case Op.returnvalue:
					case Op.returnvoid:
						nextInstr = mbi.code[mbi.code.indexOf(instr) + 1]
						if(nextInstr) addLeader(nextInstr)
						break
					case Op.label:
						addLeader(instr)
						break
					case Op.lookupswitch:
						index = mbi.code.indexOf(instr) + 1
						if(mbi.code[index]){
							nextInstr = mbi.code[index]
							addLeader(nextInstr)
						}
						
						// operands[1] is the number of jump targets (- 1)
						
						for(var k:int = 2; k < instr.operands.length; k++){
							addLeader(instr.operands[k])
						}
						break
				}
			}
			
			// fill out the blocks until an end is reached
			for(i = 0; i < leaders.length; i++){
				var isEndInstr:Boolean = false
				node = leaders[i]
				instr = node.instrs[0]
				
				for(var j:int = mbi.code.indexOf(instr); j < mbi.code.length; j++){
					nextInstr = mbi.code[j]
					
					switch(nextInstr.opcode){
						case Op.iftrue:     case Op.iffalse:
						case Op.ifeq:       case Op.ifne:
						case Op.ifge:       case Op.ifnge:
						case Op.ifgt:       case Op.ifngt:
						case Op.ifle:       case Op.ifnle:
						case Op.iflt:       case Op.ifnlt:
						case Op.ifstricteq: case Op.ifstrictne:
							isEndInstr = true
							node.outEdges.push(leaderInstrs[mbi.code[j + 1]]) // the fall-through case
							node.outEdges.push(leaderInstrs[nextInstr.operands[0]]) //  node for the jump target instr
							break
						case Op.jump:
							isEndInstr = true
							node.outEdges.push(leaderInstrs[nextInstr.operands[0]])
							break
						case Op.returnvalue:
						case Op.returnvoid:
						case Op.throw_:
							isEndInstr = true
							break
						case Op.lookupswitch:
							isEndInstr = true
							node.outEdges.push(leaderInstrs[nextInstr.operands[0]])
							for(k = 2; k < nextInstr.operands.length; k++){
								node.outEdges.push(leaderInstrs[nextInstr.operands[k]])
							}
							break
					}
					if(instr != nextInstr) node.instrs.push(nextInstr)
					
					if(isEndInstr){
						break
					}
				}
			}
			
			// now piece together the CFG depths from the root node 
			root.depth = 0
			var queue:Vector.<CFGNode> = new <CFGNode>[root]
			i = 0
			var depth:int = 0
			while(queue.length > 0){
				node = queue.shift()
				
				for(j = 0; j < node.outEdges.length; j++){
					var nextNode:CFGNode = node.outEdges[j]
					if(nextNode.depth == -1){
						queue.push(nextNode)
						nextNode.depth = node.depth + 1
					}
				}
			}
			
			cfgRoot = root
		}
		
		private function addLeader(instr:Instruction):void {
			if(leaderInstrs[instr]) return
			var node:CFGNode = new CFGNode
			node.instrs.push(instr)
			leaders.push(node)
			leaderInstrs[instr] = node
		}
		
		private function execInstr(instr:Instruction, prevSlice:CallSlice):CallSlice {
			trace('->' + instr)
			var slice:CallSlice = prevSlice.clone()
			slice.instr = instr
			var stack:Vector.<Object> = slice.stack
			var scope:Vector.<Object> = slice.scopeStack
			var regs:Array = slice.registers
			
			if(instr.operands){
				var arg0:* = instr.operands[0]
				var arg1:* = instr.operands[1]
				var arg2:* = instr.operands[2]
			}
			var vals:Array // for instructions that take varying amounts of items from the stack
			var val1:*, val2:*, val3:*
			
			var mn:Multiname
			var temp:*
			
			var i:int, count:int
			switch(instr.opcode){
				case Op.add:
					val2 = stack.pop()
					val1 = stack.pop()
					val3 = Object // or implement ECMA-262 § 11.6, ECMA-357 § 11.4
					stack.push(val3)
					break
				case Op.add_i:
					val2 = stack.pop()
					val1 = stack.pop()
					val3 = int
					stack.push(val3)
					break
				case Op.applytype:
					val1 = stack.pop() // a Multiname.TypeName
					vals = unstack(stack, arg0)
					stack.push(val1)
				case Op.astype:
					val1 = stack.pop()
					stack.push(Object)
					//TODO: plenty of work to get anything usable out of this
					break
				case Op.astypelate:
					val2 = stack.pop() // class
					val1 = stack.pop() // val
					stack.push(Object)
					//TODO: plenty of work to get anything usable out of this
					break
				case Op.bitand:
				case Op.bitor:
				case Op.bitxor:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.bitnot:
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.call:
					vals = unstack(stack, arg0)
					val2 = stack.pop() // receiver
					val1 = stack.pop() // function
					//TODO: seems like a possible place for inlining/etc.
					stack.push(Object)
					break
				case Op.callmethod:
					vals = unstack(stack, arg1)
					val1 = stack.pop()
					stack.push(Object)
					break
				case Op.callproperty:
					vals = unstack(stack, arg1)
					applyMultiname(stack, arg0)
					val1 = stack.pop()
					
					mn = arg0
					if(mn.kind == Multiname.QName && val1 is Multiname && val1.kind == Multiname.QName){
						temp = lookupQName(val1 as Multiname)
						if(temp is InstanceInfo){
							temp = accessTrait(mn, temp, true)
							
							stack.push(temp)
							break
						}
					} else {
						stack.push(Object)
					}
				case Op.callproplex:
					vals = unstack(stack, arg1)
					applyMultiname(stack, arg0)
					val1 = stack.pop()
					stack.push(Object)
					break
				case Op.callpropvoid:
					vals = unstack(stack, arg1)
					applyMultiname(stack, arg0)
					val1 = stack.pop()
					stack.push(undefined)
					break
				case Op.callstatic:
					vals = unstack(stack, arg1)
					val1 = stack.pop() // receiver, seems useless for static methods
					stack.push(Object)
					break
				case Op.callsuper:
					vals = unstack(stack, arg1)
					applyMultiname(stack, arg0)
					val1 = stack.pop() // receiver
					stack.push(Object)
					break
				case Op.callsupervoid:
					vals = unstack(stack, arg1)
					applyMultiname(stack, arg0)
					val1 = stack.pop() // receiver
					stack.push(undefined)
					break
				case Op.checkfilter:
					// does nothing interesting
					break
				case Op.coerce:
					val1 = stack.pop()
					// can't put val1 back on the stack until we can guarantee it's that type
					stack.push(Object)
					break
				case Op.coerce_a:
					// do nothing
					break
				case Op.coerce_s:
					val1 = stack.pop()
					stack.push(String)
					break
				case Op.construct:
					vals = unstack(stack, arg0)
					val1 = stack.pop()
					stack.push(Object) // could be more specific if we knew about val1
					break
				case Op.constructprop:
					vals = unstack(stack, arg1)
					applyMultiname(stack, arg0)
					val1 = stack.pop() // obj
					stack.push(Object)
					break
				case Op.constructsuper:
					vals = unstack(stack, arg0)
					val1 = stack.pop()
					break
				case Op.convert_b:
					val1 = stack.pop()
					stack.push(Boolean)
					break
				case Op.convert_i:
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.convert_d:
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.convert_o:
					// nothing but possible exception
					break
				case Op.convert_u:
					val1 = stack.pop()
					stack.push(uint)
					break
				case Op.convert_s:
					val1 = stack.pop()
					stack.push(String)
					break
				case Op.debug:
				case Op.debugfile:
				case Op.debugline:
					break
				case Op.declocal:
					regs[arg0] = Number
					break
				case Op.declocal_i:
					regs[arg0] = int
					break
				case Op.decrement:
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.decrement_i:
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.deleteproperty:
					applyMultiname(stack, arg0) // presumably the MN only matters for XML?
					val1 = stack.pop()
					stack.push(Boolean)
					break
				case Op.divide:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.dup:
					val1 = stack.pop()
					stack.push(val1)
					stack.push(val1)
					break
				case Op.dxns:
					break
				case Op.dxnslate:
					val1 = stack.pop()
					break
				case Op.equals:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Boolean)
					break
				case Op.esc_xattr:
				case Op.esc_xelem:
					val1 = stack.pop()
					stack.push(String)
					break
				case Op.findproperty:
				case Op.findpropstrict:
					applyMultiname(stack, arg0)
					
					
					
					stack.push(Object)
					break
				case Op.getdescendants:
					applyMultiname(stack, arg0)
					val1 = stack.pop()
					stack.push(Object)
					break
				case Op.getglobalscope:
					stack.push(_global)
					break
				case Op.getglobalslot:
					stack.push(Object)
					break
				case Op.getlex:
					stack.push(Object)
					break
				case Op.getlocal:
					stack.push(regs[arg0])
					break
				case Op.getlocal0:
					stack.push(regs[0]) // _this
					break
				case Op.getlocal1:
					stack.push(regs[1])
					break
				case Op.getlocal2:
					stack.push(regs[2])
					break
				case Op.getlocal3:
					stack.push(regs[3])
					break
				case Op.getproperty:
					val2 = applyMultiname(stack, arg0)
					val1 = stack.pop() // obj
					
					// an initial stab at carrying forward information
					mn = arg0
					if(mn.kind == Multiname.QName && val1 == _this){
						temp = accessTrait(mn, ii)
						stack.push(temp)
					} else {
						if(val1 is Multiname && val1.kind == Multiname.QName){
							temp = lookupQName(val1 as Multiname)
							if(temp is InstanceInfo){
								temp = accessTrait(mn, temp)
								stack.push(temp)
								break
							}
						}
						
						if(val2.kind == Multiname.MultinameL && val1 is Vektor){
							if((val1 as Vektor).type == int){
								stack.push(int)
								break
							} else if(val2.name is int || val2.name == int){
								stack.push((val1 as Vektor).type)
								break
							}
						}
						
						stack.push(Object)
					}
					
					break
				case Op.getscopeobject:
					stack.push(scope[arg0])
					break
				case Op.getslot:
					val1 = stack.pop()
					// figure out traits here
					if(val1 == _global){
						trace('get global slot')
						stack.push(getGlobalSlot(arg0))
						break
					}
					
					stack.push(Object)
					break
				case Op.getsuper:
					applyMultiname(stack, arg0)
					val1 = stack.pop()
					stack.push(Object)
					break
				case Op.greaterequals:
				case Op.greaterthan:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Boolean)
					break
				case Op.hasnext:
					val2 = stack.pop() // cur_index
					val1 = stack.pop() // obj
					stack.push(int)
					break
				case Op.hasnext2:
					stack.push(Boolean)
					break
				case Op.ifeq:
					val2 = stack.pop()
					val1 = stack.pop()
					// jump
					break
				case Op.iffalse:
				case Op.iftrue:
					val1 = stack.pop()
					break
				case Op.ifge:
				case Op.ifgt:
				case Op.ifle:
				case Op.iflt:
				case Op.ifnge:
				case Op.ifngt:
				case Op.ifnle:
				case Op.ifnlt:
				case Op.ifne:
				case Op.ifstricteq:
				case Op.ifstrictne:
					val2 = stack.pop()
					val1 = stack.pop()
					break
				case Op.in_:
					val2 = stack.pop() // obj
					val1 = stack.pop() // name
					stack.push(Boolean)
					break
				case Op.inclocal:
					regs[arg0] = Number
					break
				case Op.inclocal_i:
					regs[arg0] = int
					break
				case Op.increment:
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.increment_i:
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.initproperty:
					val2 = stack.pop() // value
					applyMultiname(stack, arg0)
					val1 = stack.pop() // object
					break
				case Op.instanceof_:
					val2 = stack.pop() // type
					val1 = stack.pop() // value
					stack.push(Boolean)
					break
				case Op.istype:
					val1 = stack.pop() // value
					stack.push(Boolean)
					break
				case Op.istypelate:
					val2 = stack.pop() // type
					val1 = stack.pop() // value
					stack.push(Boolean)
					break
				case Op.jump:
					break
				case Op.kill:
					regs[arg0] = undefined
					break
				case Op.label:
					break
				case Op.lessequals:
				case Op.lessthan:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Boolean)
					break
				case Op.lookupswitch:
					val1 = stack.pop()
					break
				case Op.lshift:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(uint) // seems likely
					break
				case Op.modulo:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.multiply:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.multiply_i:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.negate:
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.negate_i:
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.newactivation:
					//TODO: convert uses of activation to auto-generated classes with slots instead of props
					stack.push(Object) // not quite an actual object
					break
				case Op.newarray:
					vals = unstack(stack, arg0)
					stack.push(vals)
					break
				case Op.newcatch:
					stack.push(Object)
					break
				case Op.newclass:
					val1 = stack.pop() // base class
					stack.push(Class)
					break
				case Op.newfunction:
					stack.push(Function)
					break
				case Op.newobject:
					vals = unstack(stack, arg0 * 2)
					stack.push(Object) // could also create { name1: Object, ..., nameN: Object }
					break
				case Op.nextname:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(String) // I think these are only for..in names, which would be strings
					break
				case Op.nextvalue:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Object)
					break
				case Op.nop:
					// it would be pretty silly to do something here
					break
				case Op.not:
					val1 = stack.pop()
					stack.push(Boolean)
					break
				case Op.pop:
					stack.pop()
					break
				case Op.popscope:
					scope.pop()
					break
				case Op.pushbyte:
					stack.push(int) // value is int(arg0)
					break
				case Op.pushdouble:
					stack.push(Number) // Number(arg0)
					break
				case Op.pushfalse:
					stack.push(false)
					break
				case Op.pushint:
					stack.push(int) // int(arg0)
					break
				case Op.pushnamespace:
					stack.push(ABCNamespace(arg0))
					break
				case Op.pushnan:
					stack.push(NaN)
					break
				case Op.pushnull:
					stack.push(null)
					break
				case Op.pushscope:
					val1 = stack.pop()
					scope.push(val1)
					break
				case Op.pushshort:
					stack.push(int(arg0))
					break
				case Op.pushstring:
					stack.push(String(arg0))
					break
				case Op.pushtrue:
					stack.push(true)
					break
				case Op.pushuint:
					stack.push(uint(arg0))
					break
				case Op.pushundefined:
					stack.push(undefined)
					break
				case Op.pushwith:
					val1 = stack.pop()
					scope.push(val1)
					break
				case Op.returnvalue:
					val1 = stack.pop() // ret val
					break
				case Op.returnvoid:
					break
				case Op.rshift:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(int)
					break
				case Op.setlocal:
					val1 = stack.pop()
					regs[arg0] = val1
					break
				case Op.setlocal0:
					val1 = stack.pop()
					regs[0] = val1
					break
				case Op.setlocal1:
					val1 = stack.pop()
					regs[1] = val1
					break
				case Op.setlocal2:
					val1 = stack.pop()
					regs[2] = val1
					break
				case Op.setlocal3:
					val1 = stack.pop()
					regs[3] = val1
					break
				case Op.setglobalslot:
					val1 = stack.pop()
					break
				case Op.setproperty:
					val2 = stack.pop() // value
					applyMultiname(stack, arg0)
					val1 = stack.pop() // obj
					break
				case Op.setslot:
					val2 = stack.pop() // value
					val1 = stack.pop()	// obj
					break
				case Op.setsuper:
					val2 = stack.pop() // value
					applyMultiname(stack, arg0)
					val1 = stack.pop() // obj
					break
				case Op.strictequals:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Boolean)
					break
				case Op.subtract:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(Number)
					break
				case Op.subtract_i:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(int)
				case Op.swap:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(val2)
					stack.push(val1)
					break
				case Op.throw_:
					val1 = stack.pop() // thrown obj
					break
				case Op.typeof_:
					val1 = stack.pop()
					stack.push(String)
					break
				case Op.urshift:
					val2 = stack.pop()
					val1 = stack.pop()
					stack.push(uint)
					break
				default:
					//throw 'Unhandled symbolic execution of instruction: 0x' + instr.opcode.toString(16)
			}
			
			return slice
		}
		
		private function accessTrait(mn:Multiname, instance:InstanceInfo, call:Boolean = false):* {
			for each(var t:Trait in instance.traits){
				switch(t.kind){
					case Trait.Slot:
						var st:SlotTrait = t as SlotTrait
						if(st.name.eq(mn)){
							return symbolicType(st.type_name)
						}
						break
					case Trait.Method:
						var mt:MethodTrait = t as MethodTrait
						if(mt.name.eq(mn)){
							if(call){
								return symbolicType(mt.method.returnType)
							} else {
								return Function // hmmm
							}
						}
						break
				}

			}
			return Object
		}
		
		private function resolveReturnType(obj:*, mn:Multiname):* {
			if(obj is Multiname && obj.kind == Multiname.QName){
				
			} else if(obj is Class){
			
			} else {
				
			}
			return Object
		}
		
		// already guaranteed QName kind
		private function lookupQName(mn:Multiname):* {
			var val:* = nameTable[mn.ns.kind]
			if(!val) return
			val = val[mn.ns.name]
			if(!val) return
			val = val[mn.name]
			return val
		}
		
		private function initNameTable():void {
			nameTable = []
			for each(var mn:Multiname in bc.multiname_pool){
				if(mn.kind != Multiname.QName) break
				var kind:Object, nsName:Object
				if(!nameTable[mn.ns.kind]) nameTable[mn.ns.kind] = kind = {}
				if(!kind[mn.ns.name]) kind[mn.ns.name] = nsName = {}
				nsName[mn.name] = findQNameDefinition(mn)
			}
		}
		
		private function findQNameDefinition(mn:Multiname):* {
			for each(var ii:InstanceInfo in bc.instance_info_pool) if(ii.name.eq(mn)) return ii
			//TODO: do more searches
			for each(var s:ScriptInfo in bc.script_info_pool){
				for each(var t:Trait in s.traits){
					if(t is SlotTrait){
						var st:SlotTrait = t as SlotTrait
						if(st.name.eq(mn)) return findQNameDefinition(st.type_name)
					}
				}
			}
		}
		
		private function getGlobalSlot(index:int):* {
			for each(var t:Trait in bc.script_info_pool[0].traits){
				if(t is SlotTrait){
					var st:SlotTrait = t as SlotTrait
					if(st.slot_id == index){
						return symbolicType(st.type_name)
					}
				}
			}
			return null
		}
		
		private function symbolicType(mn:Multiname):* {
			if(mn.kind == Multiname.TypeName){
				return new Vektor(symbolicType(mn.params[0]))
			} else {
				var ns:Namespace = new Namespace(mn.ns.name)
				try {
					return ns::[mn.name] // unfortunately, this is wrapped in a try{} because ns::[name] existence tests throw.
				} catch(err:*){}
			}
			return mn
		}
		
		/**
		 * Removes any runtime pieces of a multiname from the stack and returns them in 
		 * an array.  Should probably be a struct of some kind so further MN type special-
		 * casing doesn't need to be done.  But, that info isn't used right now.
		 */
		private static function applyMultiname(stack:Vector.<Object>, mn:Multiname):* {
			switch(mn.kind){
				case Multiname.QName:
				case Multiname.Multiname:
				case Multiname.MultinameA:
					return []
					break
				case Multiname.RTQName:
					return [stack.pop()]
					break
				case Multiname.RTQNameL:
					var name:* = stack.pop()
					return [stack.pop(), name]
					break
				case Multiname.MultinameL:
				case Multiname.MultinameLA:
					name = stack.pop()
					var newMn:Multiname = new Multiname(mn.kind, mn.nsSet)
					newMn.name = name
					return newMn
					break
			}
			return []
		}
		
		private static function unstack(stack:Vector.<Object>, n:int):Array {
			var vals:Array = []
			for(var i:int = 0; i < n; i++){
				vals.unshift(stack.pop())
			}
			return vals
		}
	}
}