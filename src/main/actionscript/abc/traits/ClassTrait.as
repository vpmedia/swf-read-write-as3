package abc.traits {
	import abc.*
	
	public class ClassTrait extends Trait {
		public var	slot_id:int,
					class_info:ClassInfo
		
		public function ClassTrait(name:Multiname, kind:int) {
			super(name, kind)
		}
		
		override public function fastInit(...args):void {
			slot_id = args[0]
			class_info = args[1] as ClassInfo
		}
		
		public function toString():String {
			return '[ClassTrait ' + name + ', ' + class_info + ', slot #: ' + slot_id + ']'
		}
	}
}