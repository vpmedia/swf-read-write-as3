package abstraction.swf.tags {
import abstraction.swf.SWFReader;

import flash.utils.*;

public class DefineBinaryDataTag extends DefinitionTag {
    public var data:ByteArray

    public function DefineBinaryDataTag(characterID:uint = 0, data:ByteArray = null) {
        super(Tag.DefineBinaryData, characterID)
        this.data = data
    }

    override public function readFrom(reader:SWFReader, length:uint):void {
        tag = reader.bytes.readUnsignedShort()
        reader.bytes.readUnsignedInt() // reserved 32 bits
        data = new ByteArray
        data.length = length - 6 // 6 is just the 2+4 bytes that were just read above
        reader.bytes.readBytes(data, 0, length - 6)
    }

    // an alias for the characterID
    public function get tag():uint {
        return characterID
    }

    public function set tag(id:uint):void {
        characterID = id
    }
}
}