package abc {
	public class InstanceInfo {
		
		public static function hasProtectedNsFlag(flags:int):Boolean {
			return Boolean(flags & ABC.ClassProtectedNs)
		}
		
		public var	name:Multiname,
					super_name:Multiname,
					flags:int,
					protectedNs:ABCNamespace,
					interfaces:Array,
					iinit:MethodInfo,
					traits:Array
		
		public function InstanceInfo(name:Multiname, super_name:Multiname, flags:int, protectedNs:ABCNamespace, interfaces:Array, iinit:MethodInfo, traits:Array) {
			this.name = name
			this.super_name = super_name
			this.flags = flags
			this.protectedNs = protectedNs
			this.interfaces = interfaces
			this.iinit = iinit
			this.traits = traits
		}
		
		public function dump():String {
			var s:String = ''
			s += '[[ InstanceInfo ' + name + ', super: ' + super_name + '\nFlags: ' + flags.toString(2)
			s += '\nProtectedNs?: ' + protectedNs + ', interface count: ' + (interfaces ? interfaces.length : null)
			s += '\niinit: ' + iinit + '\nTraits: ' + (!traits ? null : traits.join(', ')) + '\n]]'
			return s
		}
		
		public function toString():String {
			return '[InstanceInfo ' + name + ' extends ' + super_name + ']'
		}
	}
}