package abc {
	public class MethodBodyInfo {
		public var	method:MethodInfo,
					max_stack:int,
					local_count:int,
					init_scope_depth:int,
					max_scope_depth:int,
					code_length:int,
					code:Array,
					exceptions:Array,
					traits:Array,
					__id:int
		
		public function MethodBodyInfo(method:MethodInfo, max_stack:int, local_count:int, init_scope_depth:int, max_scope_depth:int, code_length:int, code:Array, exceptions:Array, traits:Array){
			this.method = method
			if(method) method.body = this
			this.max_stack = max_stack
			this.local_count = local_count
			this.init_scope_depth = init_scope_depth
			this.max_scope_depth = max_scope_depth
			this.code_length = code_length
			this.code = code
			this.exceptions = exceptions ? exceptions : []
			this.traits = traits
			__id = nextID()
		}
		
		private static var _id:int = 1
		private static function nextID():int {
			return _id++
		}
		
		public function toString():String {
			var s:String = '[MethodBodyInfo #' + __id + ', ' + method.dump() + ', code_len: ' + code_length
			s += '\n\tmax stack: ' + max_stack + ', local_cnt: ' + local_count + ', ini_sco: ' + init_scope_depth + ', max_sco: ' + max_scope_depth
			s += '\n\texceptions: ' + exceptions.length + ', traits: ' + traits.length + ']'
			return s
		}
	}
}