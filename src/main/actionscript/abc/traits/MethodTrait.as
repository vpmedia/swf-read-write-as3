package abc.traits {
	import abc.*
	
	public class MethodTrait extends Trait {
		public var	disp_id:int, // most likely a displacement ID for an object's virtual function table
					method:MethodInfo
		
		public function MethodTrait(name:Multiname, kind:int) {
			super(name, kind)
		}
		
		override public function fastInit(...args):void {
			disp_id = args[0]
			method = args[1]
		}
		
		override public function dump():String {
			var s:String = ''
			s += '[[ MethodTrait name: ' + name + ', kind: ' + kind.toString(2) + 'disp_id: ' + disp_id
			s += '\n\tmethod: ' + method.dump() + ' ]]'
			return s
		}
		
		public function toString():String {
			return dump()
		}
	}
}