package swf.tags {
	public class DefinitionTag extends Tag {
		public var characterID:uint;
		
		public function DefinitionTag(code:uint, characterID:uint){
			super(code)
			this.characterID = characterID
		}
	}
}