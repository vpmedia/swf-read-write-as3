package abc.traits {
	import abc.Multiname

	public class Trait {
		public static var	Slot:int		= 0,
							Method:int		= 1,
							Getter:int		= 2,
							Setter:int		= 3,
							Class:int		= 4,
							Function:int	= 5,
							Const:int		= 6
		
		public static var	Final:int		= 0x01,
							Override:int	= 0x02,
							Metadata:int	= 0x04
		
		public static function subtype(name:Multiname, kind:int):Trait {
			// multiline because a single line version breaks Flash Builder
			var klass:* = classFromKind(kind)
			return new klass(name, kind) as Trait
		}
		
		public static function typeFromKind(kind:int):int {
			return kind & 0x0f // lower 4 bits
		}
		
		// strange shadowing prevents type expressions from seeing top-level's Class class
		public static function classFromKind(kind:int):* {
			switch(typeFromKind(kind)){
				case Slot:
					return SlotTrait
					break // technically this break is deadcode
				
				case Method:
					return MethodTrait
					break
				
				case Getter:
					return GetterTrait
					break
				
				case Setter:
					return SetterTrait
					break
				
				case Trait.Class: // careful of top-level Class shadowing
					return ClassTrait
					break
				
				case Trait.Function:
					return FunctionTrait
					break
				
				case Const:
					return ConstTrait
					break
				
				default:
					throw 'Unhandled trait kind: ' + kind
					break
			}
			return null;
		}
		
		public var	name:Multiname,
					kind:int,
					type:int,
					attr:int,
					metadata:Array
		
		public function Trait(name:Multiname, kind:int) {
			this.name = name
			this.kind = kind
			type = typeFromKind(kind)
			attr = (kind & 0xf0) >> 4 // upper 4 bits
			metadata = []
		}
		
		public function fastInit(...args):void {
			throw new Error('fastInit is abstract for the Trait class; use it via overrides')
		}
		
		public function dump():String {
			var s:String = ''
			s += '[[ Trait name: ' + name + ', kind: ' + kind.toString(2) + ' ]]'
			return s
		}
	}
}