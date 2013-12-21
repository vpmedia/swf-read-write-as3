package abc {
	public class ClassInfo {
		public var	cinit:MethodInfo,
					traits:Array
					
		public function ClassInfo(cinit:MethodInfo, traits:Array) {
			this.cinit = cinit
			this.traits = traits
		}
		
		public function toString():String {
			return '[ClassInfo ' + cinit + ', traits: ' + traits + ']'
		}
	}
}