package abstraction.swf.tags {
import abstraction.swf.SWFReader;

import flash.utils.ByteArray;

public class EndTag extends ControlTag {
    public function EndTag() {
        super(Tag.End)
    }

    override public function readFrom(reader:SWFReader, length:uint):void {

    }

    override public function toByteArray():ByteArray {
        return new ByteArray
    }
}
}