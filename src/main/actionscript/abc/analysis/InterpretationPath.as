package abc.analysis {
	public class InterpretationPath {
		public var
			nodes:Vector.<CFGNode>,
			sliceLists:Vector.<Vector.<CallSlice>>
			
		public function InterpretationPath(){
			nodes = new <CFGNode>[]
			sliceLists = new <Vector.<CallSlice>>[]
		}
		
		public function clone():InterpretationPath {
			var clone:InterpretationPath = new InterpretationPath
			clone.nodes = nodes.concat()
			clone.sliceLists = sliceLists.concat() // may have to concat forEach
			return clone
		}
		
	}
}