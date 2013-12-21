package abc {
	public class Metadata {
		public var  name:String,
					data:Array
					
		public function Metadata(name:String, data:Array) {
			this.name = name
			this.data = data
		}
		
		public function toString():String {
			var s:String = '[Metadata ' + name + ' {\n'
			for(var i:int = 0; i < data.length; i++){
				if(!data[i]) continue
				s += '\t' + data[i].key + ': ' + data[i].value
			}
			s += '\n}]'
			return s
		}
	}
}