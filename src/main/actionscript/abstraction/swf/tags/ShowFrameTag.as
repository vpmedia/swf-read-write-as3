package abstraction.swf.tags {
import abstraction.swf.SWFReader;

public class ShowFrameTag extends Tag {
    public function ShowFrameTag() {
        super(Tag.ShowFrame)
    }

    override public function readFrom(reader:SWFReader, length:uint):void {

    }
}
}