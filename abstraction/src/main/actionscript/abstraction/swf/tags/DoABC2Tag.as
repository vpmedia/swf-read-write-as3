package abstraction.swf.tags {
import abstraction.abc.ABC;
import abstraction.abc.ABCWriter;
import abstraction.swf.*;

import flash.utils.*;

/**
 * Represents the DoABC2 tag in the SWF format.
 */
public class DoABC2Tag extends DoABCTag {
    public var
            flags:uint

    public function DoABC2Tag(flags:uint = 0, name:String = '', abc:ABC = null) {
        super(null)
        this.flags = flags
        this.name = name
        _abc = abc
    }

    override public function readFrom(reader:SWFReader, length:uint):void {
        var startPos:int = reader.bytes.position
        flags = reader.readBits(32)
        name = reader.readString()

        // make a new ByteArray with just the abcfile
        var abcBytes:ByteArray = new ByteArray
        reader.bytes.readBytes(abcBytes, 0, length - (reader.bytes.position - startPos))
        abcBytes.position = 0
        _abc = ABC.readFrom(abcBytes)
        _abc.flags = flags
        _abc.abcname = name
    }

    override public function toByteArray():ByteArray {
        //trace('writing DoABC2', _abc, _abc.string_pool, _abc.method_body_info_pool)
        var bytes:ByteArray = new ByteArray
        bytes.endian = Endian.LITTLE_ENDIAN
        bytes.writeUnsignedInt(flags)
        bytes.writeUTFBytes(name)
        bytes.writeBytes(ABCWriter.writeABC(_abc))
        return bytes
    }
}
}