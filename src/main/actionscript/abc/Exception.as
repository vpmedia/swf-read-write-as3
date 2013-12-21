package abc {
	public class Exception {
		public var	from:int,
					to:int,
					target:int,
					exc_type:String,
					var_name:String
		
		public function Exception(from:int, to:int, target:int, exc_type:String, var_name:String) {
			this.from = from
			this.to = to
			this.target = target
			this.exc_type = exc_type
			this.var_name = var_name
		}
		
		public function toString():String {
			return '[Exception from: ' + from + ', to: ' + to + ', target: ' + target + ', exc_type: ' + exc_type + ', var_name: ' + var_name + ']'
		}
	}
}