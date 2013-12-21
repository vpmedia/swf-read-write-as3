package abc {
	public class MethodInfo {
		public static const NEED_ARGUMENTS		:uint = 0x01,
							NEED_ACTIVATION		:uint = 0x02,
							NEED_REST			:uint = 0x04,
							HAS_OPTIONAL		:uint = 0x08,
							IGNORE_REST			:uint = 0x10, // not in avm2overview
							NATIVE				:uint = 0x20, // not in avm2overview
							SET_DXNS			:uint = 0x40,
							HAS_PARAM_NAMES		:uint = 0x80
		
		public var	paramCount:int,
					returnType:Multiname,
					paramTypes:Array, // could be Vector.<Multiname>
					name:String,
					flags:int,
					defaultValues:Array,
					__id:int, // just for debug display, it's not actually meaningful
					paramNames:Array // could be Vector.<String>
		
		private var	
			_body:MethodBodyInfo
		
		public function MethodInfo(paramCount:int, returnType:Multiname, paramTypes:Array, methodName:String, flags:int, defaultValues:Array = null, paramNames:Array = null) {
			this.paramCount = paramCount
			this.returnType = returnType
			this.paramTypes = paramTypes
			this.name = methodName
			this.flags = flags
			this.defaultValues = defaultValues ? defaultValues : []
			this.paramNames = paramNames ? paramNames : []
			__id = nextID()
		}
		
		public function get body():MethodBodyInfo {
			return _body
		}
		
		public function set body(b:MethodBodyInfo):void {
			_body = b
			b.method = this // FIXME: Is this safe to do in a fully-flexible environment?
		}
		
		public function get needRest():Boolean {
			return Boolean(flags & NEED_REST)
		}
		
		public function get hasOptional():Boolean {
			return Boolean(flags & HAS_OPTIONAL)
		}
		
		private static var _id:int = 1
		private static function nextID():int {
			return _id++
		}
		
		public function toString():String {
			return '[MethodInfo #' + __id +' ' + name + '(' + paramCount + ')]'
		}
		
		public function dump():String {
			var s:String = ''
			s += '[[ MethodInfo #' + __id + ': ' + name + '(' + paramCount + ') Params: \n\t' + paramTypes.join(', ') + '\n\tFlags: 0x' + flags.toString(16) + '\n\tret: ' + returnType + '\n\tpnames: ' + paramNames.join(', ') + '\n]]'
			return s
		}
		
		public static function hasOptionalFlag(flags:uint):Boolean {
			return Boolean(flags & HAS_OPTIONAL)
		}
		
		public static function hasParamNamesFlag(flags:uint):Boolean {
			return Boolean(flags & HAS_PARAM_NAMES)
		}
	}
}