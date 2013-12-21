package abc {
	import abc.traits.*

	import avmplus.getQualifiedClassName

	/**
	 * Pretty prints ABC blocks.  Eventually this output should be similar to that of abcdump in Tamarin.
	 * 
	 * This is only intended to be human-readable output, but no effort was made to make it hard to parse algorithmically.
	 * 
	 */
	public class ABCInspector {
		public var _abc:ABC
		
		private var
			s:String = '',
			_indent:int
		
		public function ABCInspector(abc:ABC){
			this._abc = abc
		}
		
		public function get inspect():String {
			s = ''
			block(_abc)
			return s
		}
		
		/**
		 * Inspects a bytecode block.
		 */
		private function block(bc:ABC):void {
			for(var i:int = bc.script_info_pool.length - 1; i >= 0; i--){
				script(bc.script_info_pool[i])
			}
		}
		
		/**
		 * Inspects a script.
		 */
		private function script(si:ScriptInfo):void {
			// first inspect classes, etc.
			for each(var t:Trait in si.traits){
				switch(t.type){
					case Trait.Class:
						klass(t as ClassTrait)
						break
					case Trait.Method: // package function
						indent
						str('package ')
						var mt:MethodTrait = t as MethodTrait
						if(mt.name.ns != ABCNamespace.public_ns){
							ns(mt.name.ns)
							str(' ')
						}
						line('{')
						methodInfo(mt.method, mt.name, {
							instance: true, named: true, konstructor: false
						})
						outdent
						line('}')
						break

					default:
						break;
				}
			}
			
			// then inspect the script itself.  usually this part is less interesting.
			methodInfo(si.init, new Multiname(Multiname.QName, ABCNamespace.public_ns, 'global$init'), {
				instance: true, named: false, konstructor: false
			})
		}
		
		private function klass(kt:ClassTrait):void {
			var ci:ClassInfo = kt.class_info
			var ii:InstanceInfo = _abc.instance_info_pool[_abc.class_info_pool.indexOf(ci)]
						
			str('package ')
			if(ii.name.ns != ABCNamespace.public_ns){
				ns(ii.name.ns)
				str(' ')
			}
			line('{')
			indent
			str(indents + 'public class ' + ii.name.name)
			if(ii.super_name){
				str(' extends ') // this might not actually be a simple null check (ie, Object is default)
				fqn(ii.super_name)
			}
			
			// TODO: interfaces, 'implements'
			indent
			line(' {')
			
			// class body
			
			// property declarations
			// instance
			for each(var t:Trait in ii.traits){
				if(t is SlotTrait){
					property(t, false, true)
				} else if(t is ConstTrait){
					property(t, true, true)
				}
			}
			// static
			for each(t in ci.traits){
				if(t is SlotTrait){
					property(t, false, false)
				} else if(t is ConstTrait){
					property(t, true, false)
				}
			}
			line()
			
			// $iinit
			'turns out that $iinit is added to the beginning of the constructor'
			
			// $cinit
			methodInfo(ci.cinit, new Multiname(Multiname.QName, ABCNamespace.public_ns, '$cinit'), { 
				instance: false, named: false, konstructor: false
			})
						
			// constructor
			methodInfo(ii.iinit, ii.name, {
				instance: true, named: true, konstructor: true
			})
			
			// methods
			for each(t in ii.traits){
				switch(t.type){
					case Trait.Method:
						var mt:MethodTrait = t as MethodTrait
						methodInfo(mt.method, mt.name, {
							instance:true, named: true, konstructor: false
						})
						break
					case Trait.Getter:
						var gt:GetterTrait = t as GetterTrait
						methodInfo(gt.method, gt.name, {
							instance: true, named: true, getter: true
						})
						break
					case Trait.Setter:
						var st:SetterTrait = t as SetterTrait
						methodInfo(st.method, st.name, {
							instance: true, named: true, setter: true
						})
						break
					case Trait.Function:
						throw 'unhandled FunctionTrait type: ' + t
				}
			}
			
			// static methods
			for each(t in ci.traits){
				switch(t.type){
					case Trait.Method:
						mt = t as MethodTrait
						methodInfo(mt.method, mt.name, {
							instance: false, named: true, konstructor: false
						})
				}
			}
			
			outdent
			
			line()
			str(indents)
			line('}') // ends class
			line()
			outdent
			line('}') // ends package
		}
		
		private function property(t:Trait, konst:Boolean, instance:Boolean):void {
			var _t:* = t
			str(indents)
			ns(_t.name.ns)
			instance ? null : str(' static')
			konst ? str(' const ') : str(' var ')
			str(_t.name.name)
			str(':')
			fqn(_t.type_name)
			if(_t.value){
				str(' = ' + literal(_t.value))
			}
			line()
		}
		
		private function methodInfo(mi:MethodInfo, name:Multiname, options:*):void {
			var
				instance:Boolean = options['instance'],
				named:Boolean = options['named'],
				konstructor:Boolean = options['konstructor'],
				getter:Boolean = options['getter'],
				setter:Boolean = options['setter'],
				func:Boolean = options['func'],
				nested:Boolean = options['nested']
				
			str(indents)
			
			if(named){
				if(!konstructor){
					if(!nested) ns(name.ns)
				} else {
					str('public')
				}
				if(!instance) str(' static')
				str(' function ')
				
				getter ? str('get ') : null
				setter ? str('set ') : null
				
				str(name.name + '(')
				
				// params
				if(mi.paramTypes.length > 0){
					pList(mi)
				}
				
				if(!konstructor){
					str('):')
					fqn(mi.returnType)
				} else {
					str(')')
				}
			} else {
				if(name){
					str('/* ' + name + ' */')
				}
			}
			line(' {')
			
			indent
			mbi(mi.body)
			outdent
			
			str(indents)
			line('}')
			line()
		}
		
		/**
		 * print a parameter list
		 */
		private function pList(mi:MethodInfo):void {
			for(var i:int = 0; i < mi.paramTypes.length; i++){
				if(mi.paramNames[i]){
					str(mi.paramNames[i])
				} else {
					str('param' + i)
				}
				str(':')
				fqn(mi.paramTypes[i])
				if(mi.defaultValues[i + (mi.paramTypes.length - mi.defaultValues.length)]){
					str(' = ' + literal(mi.defaultValues[i + (mi.paramTypes.length - mi.defaultValues.length)].value))
				}
				if(i < mi.paramTypes.length - 1) str(', ')
			}
			if(mi.needRest){
				str(', ...rest')
			}
		}
		
		/**
		 * Prints a fully-qualified name in the AS3 package style.
		 * flash.display.Sprite rather than flash.display::Sprite
		 */
		private function fqn(m:Multiname):void {
			if(m.kind == Multiname.TypeName){
				str('Vector.<')
				fqn(m.params[0])
				str('>')
				return
			}
			if(m.ns != ABCNamespace.public_ns){
				if(m.ns) str(m.ns.name + '.') // FIXME: Why was m.ns null here?
			} else if(m.name == ''){
				str('*')
			}
			str(m.name)
		}
		
		/**
		 * prints a namespace in the style of an access modifier
		 */
		private function ns(n:ABCNamespace):void {
			if(n == ABCNamespace.public_ns || (n.kind == ABC.PackageNamespace && n.name == '')){
				str('public')
			} else {
				switch(n.kind){
					case ABC.PackageInternalNs:
						str('internal')
						break
					case ABC.PrivateNs:
						str('private')
						break
					case ABC.ProtectedNamespace:
						str('protected')
						break
					case ABC.StaticProtectedNs:
						str('protected static')
						break
					default:
						str(n.name)
				}
			}
		}
		
		private function mbi(b:MethodBodyInfo):void {
			if(b){
				var labelCount:uint = 0
				for each(var instr:Instruction in b.code) if(instr.needsLabel) instr.label = (labelCount++).toString()
				for each(instr in b.code){
					if(instr.needsLabel){
						line()
						str(indents)
						line('<' + instr.label + '>:')
					}
					str(indents) + line(instr)
					if(instr.opcode == Op.newfunction){ // nested function
						var mi:MethodInfo = instr.operands[0]
						indent
						methodInfo(mi, new Multiname(Multiname.QName, null, mi.name), {
							instance: true, named: true, konstructor: false, nested: true
						})
						outdent
					}
				}
			}
		}
		
		public function inspectMBI(b:MethodBodyInfo):String {
			s = ''
			mbi(b)
			var temp:String = s
			s = ''
			return temp
		}
		
		public function get pools():String {
			s = ''
			line(_abc.toString())
			line('ints(' + _abc.int_pool.length + '): {\n\t' + _abc.int_pool.join('\n\t') + '\n}')
			line('uints(' + _abc.uint_pool.length + '): {\n\t' + _abc.uint_pool.join('\n\t') + '\n}')
			line('doubles(' + _abc.double_pool.length + '): {\n\t' + _abc.double_pool.join('\n\t') + '\n}')
			line('Strings(' + _abc.string_pool.length + '): {\n\t"' + _abc.string_pool.join('"\n\t"') + '"\n}')
			return s
		}
		
		/**
		 * Converts a value into its ActionScript literal form.
		 */
		private function literal(val:*):String {
			if(val is String){
				return '"' + val + '"'
			}
			return val
		}
		
		public function str(...args):void {
			for(var i:int = 0; i < args.length; i++){
				s += args[i]
				if(i < args.length - 1) s += '\t'
			}
		}
		
		public function line(...args):void {
			for(var i:int = 0; i < args.length; i++){
				s += args[i]
				if(i < args.length - 1) s += '\t'
			}
			s += '\n'
		}
		
		public function lines(...args):void {
			s += args.join('\n')
		}
		
		/**
		 * @return	the actual string of indent characters
		 */
		private function get indents():String {
			return (new Array(_indent + 1)).join('\t')
		}
		
		public function get indent():int {
			return ++_indent
		}
		
		public function get outdent():int {
			return --_indent
		}
	}
}