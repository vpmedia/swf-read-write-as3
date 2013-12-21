package abc.traits {
	import abc.Multiname

	public class SlotTrait extends Trait {
		public var	slot_id:int,
					type_name:Multiname,
					value:*,
					value_kind:int
					
		public function SlotTrait(name:Multiname, kind:int) {
			super(name, kind)
		}
		
		override public function fastInit(...args):void {
			slot_id = args[0]
			type_name = args[1]
			value = args[2]
			value_kind = args[3]
		}
		
		public function toString():String {
			return '[SlotTrait #' + slot_id + ' ' + name + ']'
		}
	}
}