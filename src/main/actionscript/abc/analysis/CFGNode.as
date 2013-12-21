package abc.analysis {
	import abc.*
	
	/**
	 * A representation of a control flow graph.  The _instrs_ vector holds what has been identified as a 
	 * basic block.
	 */
	public class CFGNode {
		public var
			instrs:Vector.<Instruction>,
			isRoot:Boolean,
			inEdges:Vector.<CFGNode>,
			outEdges:Vector.<CFGNode>,
			depth:int = -1,
			slices:Vector.<CallSlice>
			
		public function CFGNode(){
			instrs = new <Instruction>[]
			inEdges = new <CFGNode>[]
			outEdges = new <CFGNode>[]
			slices = new <CallSlice>[]
		}
	}
}