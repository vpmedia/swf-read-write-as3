package swf.tags {
	import swf.SWFReader
		import flash.utils.*
		
		public class ShowFrameTag extends Tag {
			public function ShowFrameTag(){
				super(Tag.ShowFrame)
			}
			
			override public function readFrom(reader:SWFReader, length:uint):void {

			}
		}
}