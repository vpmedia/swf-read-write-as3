package abc {
	/**
	 * An extended namespace to handle the extra information contained in a bytecode namespace.  
	 * The main difference is that there's an additional level of qualification, where ABCNamespaces 
	 * have a 'kind' that determines their visibility to external code.  'private' has its own kind, 
	 * for example.  These kinds aren't forgeable by external code.
	 * 
	 * The AS3 Namespace class is final, so this is a completely separate class.  
	 */
	public class ABCNamespace {
		public var kind:int
		public var name:String
		
		private static var kindMap:Array = []
		kindMap[0x08] = 'CONSTANT_Namespace'
		kindMap[0x16] = 'CONSTANT_PackageNamespace'
		kindMap[0x17] = 'CONSTANT_PackageInternalNs'
		kindMap[0x18] = 'CONSTANT_ProtectedNamespace'
		kindMap[0x19] = 'CONSTANT_ExplicitNamespace'
		kindMap[0x1a] = 'CONSTANT_StaticProtectedNs'
		kindMap[0x05] = 'CONSTANT_PrivateNs'
		
		public static var public_ns:ABCNamespace = new ABCNamespace(ABC.PackageNamespace, '')
		
		public function ABCNamespace(kind:int, name:String) {
			this.kind = kind
			this.name = name
		}
		
		public function toString():String {
			var name:* = this.name == '\0' ? '' : this.name
			switch(kind){
				case ABC.Namespace:
					return '[namespace]::' + name
					break
				case ABC.PackageNamespace:
					if(this == public_ns) return 'public'
					return name
					break
				case ABC.PackageInternalNs:
					return '[internal]::' + name
					break
				case ABC.ProtectedNamespace:
					return '[protected]::' + name
					break
				case ABC.ExplicitNamespace:
					return '[explicit]::' + name
					break
				case ABC.StaticProtectedNs:
					return '[static]::' + name
					break
				case ABC.PrivateNs:
					return '[private]::' + name
					break
				
				default:
					return 'unknown namespace' + name
			}
			return kindMap[kind] + '::' + name
		}
	}
}