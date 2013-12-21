package abc {
	public class ScriptInfo {
		public var	init:MethodInfo,
					traits:Array
		
		public function ScriptInfo(init:MethodInfo, traits:Array){
			this.init = init
			this.traits = traits
		}
		
		public function toString():String {
			return '[ScriptInfo init: ' + init + ', traits: ' + traits + ']'
		}
	}
}