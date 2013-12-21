package com.codeazur.as3abc.data
{
	import __AS3__.vec.Vector;
	
	import com.codeazur.as3abc.ABC;
	import com.codeazur.as3abc.ABCData;
	import com.codeazur.as3abc.data.multinames.ABCQName;
	import com.codeazur.as3abc.data.multinames.IMultiname;
	import com.codeazur.as3abc.data.multinames.Multiname;
	import com.codeazur.as3abc.data.multinames.MultinameA;
	import com.codeazur.as3abc.data.multinames.MultinameL;
	import com.codeazur.as3abc.data.multinames.MultinameLA;
	import com.codeazur.as3abc.data.multinames.QNameA;
	import com.codeazur.as3abc.data.multinames.RTQName;
	import com.codeazur.as3abc.data.multinames.RTQNameA;
	import com.codeazur.as3abc.data.multinames.RTQNameL;
	import com.codeazur.as3abc.data.multinames.RTQNameLA;
	import com.codeazur.as3abc.data.multinames.TypeName;
	import com.codeazur.as3abc.factories.ABCMultinameFactory;
	import com.codeazur.utils.StringUtils;
	
	public class ConstantPool
	{
		public static const PUBLIC_NAMESPACE:ABCNamespace = new ABCNamespace(ABCNamespace.NAMESPACE, "");
		public static const EMPTY_MULTINAME:IMultiname = new ABCQName();
		
		public var abc:ABC;
		public var ints:Vector.<int>;
		public var uints:Vector.<uint>;
		public var doubles:Vector.<Number>;
		public var strings:Vector.<String>;
		public var namespaces:Vector.<ABCNamespace>;
		public var namespaceSets:Vector.<Vector.<ABCNamespace>>;
		public var multinames:Vector.<IMultiname>;
		
		public function ConstantPool()
		{
			ints = new Vector.<int>();
			uints = new Vector.<uint>();
			doubles = new Vector.<Number>();
			strings = new Vector.<String>();
			namespaces = new Vector.<ABCNamespace>();
			namespaceSets = new Vector.<Vector.<ABCNamespace>>();
			multinames = new Vector.<IMultiname>();
		}

		public function parse(data:ABCData):void
		{
			readInts(data);
			readUints(data);
			readDoubles(data);
			readStrings(data);
			readNamespaces(data);
			readNamespaceSets(data);
			readMultinames(data);
		}

		protected function readInts(data:ABCData):void {
			var i:uint, len:uint;
			len = data.readU32();
			
			if (ints.length == 0)
				ints[0] = 0;
			
			for (i = 1; i < len; i++)
				ints[i] = data.readU32();
		}
		
		protected function readUints(data:ABCData):void {
			var i:uint, len:uint;
			len = data.readU32();
			
			if (uints.length == 0)
				uints[0] = 0;
			
			for (i = 1; i < len; i++)
				uints[i] = uint(data.readU32());
		}
		
		protected function readDoubles(data:ABCData):void {
			var i:uint, len:uint;
			len = data.readU32();
			
			if (doubles.length == 0)
				doubles[0] = NaN;
				
			for (i = 1; i < len; i++)
				doubles[i] = data.readDouble();
		}
		
		protected function readStrings(data:ABCData):void {
			var i:uint, len:uint;
			len = data.readU32();
			
			if (strings.length == 0)
				strings[0] = "";
				
			for (i = 1; i < len; i++)
				strings[i] = data.readUTFBytes(data.readU32());
		}
		
		protected function readNamespaces(data:ABCData):void {
			var i:uint, len:uint;
			len = data.readU32();
			
			if (namespaces.length == 0)
				namespaces[0] = PUBLIC_NAMESPACE;
				
			for (i = 1; i < len; i++) {
				// TODO: Trap errors on bad data on string index
				namespaces[i] = new ABCNamespace(data.readByte(), strings[data.readU32()]);
			}
		}
		
		protected function readNamespaceSets(data:ABCData):void {
			var i:uint, ilen:uint, j:uint, jlen:uint;
			var namespaceSet:Vector.<ABCNamespace>;
			ilen = data.readU32();
			
			if (namespaceSets.length == 0)
				namespaceSets[0] = new Vector.<ABCNamespace>();
				
			for (i = 1; i < ilen; i++) {
				namespaceSet = namespaceSets[i] = new Vector.<ABCNamespace>();
				jlen = data.readU32();
				for (j = 0; j < jlen; j++) {
					// TODO: Trap errors on bad data on namespace index
					namespaceSet[j] = namespaces[data.readU32()];
				} 
			}
		}
		
		protected function readMultinames(data:ABCData):void {
			var i:uint, len:uint;
			var multiname:IMultiname;
			len = data.readU32();
			
			if (multinames.length == 0)
				multinames[0] = EMPTY_MULTINAME;
			
			for (i = 1; i < len; i++) {
				multiname = ABCMultinameFactory.create(data.readByte());
				multiname.parse(data, this);
				multinames[i] = multiname;
			}
		}
		
		public function getConstantValue(type:int, index:int):Object
		{
			switch(type) {
				case 0x03 /* int */:    return ints[index];
				case 0x04 /* uint */:   return uints[index];
				case 0x06 /* double */: return doubles[index];
				case 0x01 /* UTF-8 */:  return strings[index];
				case 0x0B /* true */:   return true;
				case 0x0A /* false */:  return false;
				
				case 0x0C /* null */: 							// Cascade
				case 0x00 /* undefined */:
					return null;
					
				case 0x08 /* namespace */:						// Cascade
				case 0x16 /* package namespace */:
				case 0x17 /* package internal namespace */:
				case 0x18 /* protected namespace */:
				case 0x19 /* explicit namespace */:
				case 0x1A /* static protected namespace */:
				case 0x05 /* private namespace */:
					return namespaces[index];
					
				default:

					throw new Error("Unknown parameter type.");
			}
		}
		
		public function dumpMultinameCounts(indent:uint = 0):String {
			
			var str:String, indentStr:String;
			var i:int, len:int = multinames.length;
			var item:IMultiname;
			var qname:int = 0, multiname:int = 0, multinamea:int = 0,
				multinamel:int = 0, multinamela:int = 0, qnamea:int = 0,
				rtqname:int = 0, rtqnamea:int = 0, rtqnamel:int = 0, 
				rtqnamela:int = 0, typename:int = 0;
				
			for (i = 0; i < len; i++) {
				item = multinames[i];
				if (item is ABCQName)         { qname++; }
				else if (item is Multiname)   { multiname++; }
				else if (item is MultinameA)  { multinamea++; }
				else if (item is MultinameL)  { multinamel++; }
				else if (item is MultinameLA) { multinamela++; }
				else if (item is QNameA)      { qnamea++; }
				else if (item is RTQName)     { rtqname++; }
				else if (item is RTQNameA)    { rtqnamea++; }
				else if (item is RTQNameL)    { rtqnamel++; }
				else if (item is RTQNameLA)   { rtqnamela++; }
				else if (item is TypeName)    { typename++; }
			}
			indentStr = StringUtils.repeat(indent + 4);
			str = indentStr + "QNames (" + qname + ")\n" +
				indentStr + "QNameAs (" + qnamea + ")\n" +
				indentStr + "RTQNames (" + rtqname + ")\n" +
				indentStr + "RTQNameAs (" + rtqnamea + ")\n" +
				indentStr + "RTQNameLs (" + rtqnamel + ")\n" +
				indentStr + "RTQNameLAs (" + rtqnamela + ")\n" +
				indentStr + "Multinames (" + multiname + ")\n" +
				indentStr + "MultinameAs (" + multinamea + ")\n" +
				indentStr + "MultinameLs (" + multinamel + ")\n" +
				indentStr + "MultinameLAs (" + multinamela + ")\n" +
				indentStr + "TypeNames (" + typename + ")"
			return str;
		}
		
		public function toString(indent:uint = 0):String
		{
			var innerIndentStr:String = StringUtils.repeat(indent + 4);
			var str:String = StringUtils.repeat(indent) + "Constant Pool: \n" +
				innerIndentStr + "ints (" + ints.length + ") " + "\n" +
				innerIndentStr + "uints (" + uints.length + ") " + "\n" +
				innerIndentStr + "doubles (" + doubles.length + ") " + "\n" +
				innerIndentStr + "strings (" + strings.length + ") " + "\n" +
				innerIndentStr + "namespaces (" + namespaces.length + ") " + "\n" +
				innerIndentStr + "namespace sets (" + namespaceSets.length + ") " + "\n" +
				innerIndentStr + "multinames (" + multinames.length + ") " + "\n" +
					dumpMultinameCounts(indent + 4);
			return str;
		}
	}
}