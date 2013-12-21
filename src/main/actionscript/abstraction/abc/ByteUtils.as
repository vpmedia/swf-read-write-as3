package abstraction.abc {
import flash.geom.Rectangle;
import flash.utils.ByteArray;

public class ByteUtils {

    /**
     * Unneccessary, but it complements writeU16
     */
    public static function readU16(bytes:ByteArray):uint {
        return bytes.readUnsignedShort()
    }

    /**
     * Reads a 24-bit / 3-byte, signed integer from the ABC file.  Used by some (annoying) AVM2 instructions.
     */
    public static function readS24(bytes:ByteArray):int {
        var result:int = bytes.readUnsignedByte() | (bytes.readUnsignedByte() << 8) | (bytes.readByte() << 16)
        return result
    }

    /**
     * Adapted from AVM+'s AvmCore.h
     * See: http://hg.mozilla.org/tamarin-central/raw-file/fbecf6c8a86f/core/AvmCore.h
     */
    public static function readU30(bytes:ByteArray):uint {
        var result:uint = bytes.readByte()
        if (!(result & 0x00000080)) {
            return result
        }
        result = (result & 0x0000007f) | bytes.readByte() << 7
        if (!(result & 0x00004000)) {
            return result
        }
        result = (result & 0x00003fff) | bytes.readByte() << 14
        if (!(result & 0x00200000)) {
            return result
        }
        result = (result & 0x001fffff) | bytes.readByte() << 21
        if (!(result & 0x10000000)) {
            return result
        }
        result = (result & 0x0fffffff) | bytes.readByte() << 28
        return result
    }

    /**
     * Also adapted from AVM+
     */
    public static function readS32(bytes:ByteArray):int {
        var result:int = bytes.readByte()
        if (!(result & 0x00000080)) {
            return result
        }
        result = (result & 0x0000007f) | bytes.readByte() << 7
        if (!(result & 0x00004000)) {
            return result
        }
        result = (result & 0x00003fff) | bytes.readByte() << 14
        if (!(result & 0x00200000)) {
            return result
        }
        result = (result & 0x001fffff) | bytes.readByte() << 21
        if (!(result & 0x10000000)) {
            return result
        }
        result = (result & 0x0fffffff) | bytes.readByte() << 28
        return result
    }

    /**
     * Adapted from senocular's SWFReader.
     * http://senocular.com/flash/actionscript/?file=ActionScript_3.0/com/senocular/utils/SWFReader.as
     */
    public static function readString(bytes:ByteArray):String {

        // find ending null character that
        // terminates the string
        var i:uint = bytes.position
        try {
            while (bytes[i] != 0) i++
        } catch (error:Error) {
            return ""
        }

        // null byte should have been found
        // return the read string
        return bytes.readUTFBytes(i - bytes.position)
    }

    public static function writeU16(bytes:ByteArray, val:uint):void {
        bytes.writeByte(val)
        bytes.writeByte(val >> 8)
    }

    public static function writeS24(bytes:ByteArray, val:int):void {
        writeU16(bytes, val)
        bytes.writeByte(val >> 16)
    }

    /**
     * Writes a variable-length int.
     * Adapted from:
     * opensource.adobe.com/svn/opensource/flex/sdk/trunk/modules/asc/src/java/adobe/abc/GlobalOptimizer.java
     */
    public static function writeU30(bytes:ByteArray, val:int):void {
        if (val < 128 && val >= 0) {
            bytes.writeByte(val)
        } else if (val < 16384 && val >= 0) {
            bytes.writeByte(val & 0x7F | 0x80)
            bytes.writeByte(val >> 7)
        } else if (val < 2097152 && val >= 0) {
            bytes.writeByte(val & 0x7F | 0x80)
            bytes.writeByte(val >> 7 | 0x80)
            bytes.writeByte(val >> 14)
        } else if (val < 268435456 && val >= 0) {
            bytes.writeByte(val & 0x7F | 0x80)
            bytes.writeByte(val >> 7 | 0x80)
            bytes.writeByte(val >> 14 | 0x80)
            bytes.writeByte(val >> 21)
        } else {
            bytes.writeByte(val & 0x7F | 0x80)
            bytes.writeByte(val >> 7 | 0x80)
            bytes.writeByte(val >> 14 | 0x80)
            bytes.writeByte(val >> 21 | 0x80)
            bytes.writeByte(val >> 28)
        }
    }

    public static function writeRect(bytes:ByteArray, rect:Rectangle):void {
        bitPos = 8
        currentByte = 0
        var left:int = rect.left * 20
        var right:int = rect.right * 20
        var top:int = rect.top * 20
        var bottom:int = rect.bottom * 20

        var max:int = Math.max(Math.abs(left), Math.abs(right), Math.abs(top), Math.abs(bottom))

        var nBits:uint = Math.max(Math.ceil(Math.log(max) / Math.LN2), 1) + 1 // 1 extra for sign?
        //trace('nBits: ', nBits, left, right, top, bottom)
        writeBits(bytes, nBits, 5)
        writeBits(bytes, left, nBits)
        writeBits(bytes, right, nBits)
        writeBits(bytes, top, nBits)
        writeBits(bytes, bottom, nBits)

        // thanks to @IQAndreas for fixing this
        if (bitPos != 8) bytes.writeByte(currentByte) // leftover
    }

    private static var
            bitPos:int,
            currentByte:uint

    /**
     * Adapted from:
     * http://opensource.adobe.com/svn/opensource/flex/sdk/trunk/modules/swfutils/src/java/flash/swf/SwfEncoder.java
     */
    private static function writeBits(bytes:ByteArray, val:int, nBits:uint):void {
        while (nBits > 0) {
            if (nBits > bitPos) {
                //if more bits left to write then shift out what will fit
                currentByte |= val << (32 - nBits) >>> (32 - bitPos)
                currentByte %= 256; // modulo, because AS3 doesn't have a `byte` type

                // shift all the way left, then right to right
                // justify the data to be or'ed in
                bytes.writeByte(currentByte)
                nBits -= bitPos
                currentByte = 0
                bitPos = 8
            } else { //  (nBits <= bytePos)
                currentByte |= val << (32 - nBits) >>> (32 - bitPos)
                currentByte %= 256
                bitPos -= nBits
                nBits = 0

                if (bitPos == 0) {
                    //if current byte is filled
                    bytes.writeByte(currentByte)
                    currentByte = 0
                    bitPos = 8
                }
            }
        }
    }
}
}