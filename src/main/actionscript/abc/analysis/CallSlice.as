package abc.analysis {
	import abc.*

	/**
	 * Holds the relevant pieces of what we know about the (abstract) interpretation at a particular instruction: 
	 * the current contents of the stack, the scope stack, and the registers.
	 */
	public class CallSlice {
		public var
			stack:Vector.<Object>,
			scopeStack:Vector.<Object>,
			registers:Array,
			instr:Instruction
		
		
		public function CallSlice(){
			stack = new <Object>[]
			scopeStack = new <Object>[_global]
			registers = [_this]
			instr = new Instruction(Op.nop)
		}
		
		public function clone():CallSlice {
			var clone:CallSlice = new CallSlice
			clone.stack = stack.concat()
			clone.scopeStack = scopeStack.concat()
			clone.registers = registers.concat()
			if(instr) clone.instr = new Instruction(instr.opcode, instr.operands ? instr.operands.concat() : undefined)
			return clone
		}
		
		public function get inspectStack():String {
			var str:String = '[...'
			var i:int = stack.length - 4
			while(i < stack.length){
				if(i >= 0){
					str += ', (' + stack[i] + ')'
				}
				
				i++
			}
			return str + ']'
		}
		
		public function get inspectScope():String {
			var str:String = '[...'
			var i:int = scopeStack.length - 4
			while(i < scopeStack.length){
				if(i >= 0){
					str += ', (' + scopeStack[i] + ')'
				}
				
				i++
			}
			return str + ']'
		}
		
		public function get inspectRegs():String {
			var str:String = '['
			for(var i:int = 0; i < registers.length; i++){
				str += ' ' + i +' => (' + registers[i] + ')'
				if(i < registers.length - 1) str += ', '
			}
			return str + ']'
		}
	}
}