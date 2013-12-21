package abc.analysis {
	/**
	 * A convenience class to deal with the reality that AS3 Vectors can only have one type, 
	 * and that there are no other generic types so it's okay to treat this one specially.
	 */
	public class Vektor {
		public var type:*
		
		/**
		 * @param	t	The type parameter for this Vector type, as in Vector.<T>.
		 */
		public function Vektor(t:*){
			type = t
		}
		
		public function toString():String {
			return 'Vektor<' + type.toString() + '>'
		}
	}
}