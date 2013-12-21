/*
 * =BEGIN CLOSED LICENSE
 *
 *  Copyright(c) 2013 Andras Csizmadia.
 *  http://www.vpmedia.eu
 *
 *  For information about the licensing and copyright please
 *  contact Andras Csizmadia at andras@vpmedia.eu.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 *
 * =END CLOSED LICENSE
 */
package hu.vpmedia.utils {
import flash.utils.ByteArray;
import flash.utils.CompressionAlgorithm;
import flash.utils.Endian;

public class SWFUtil {
    public static const ZLIB_FLAG:String = "CWS";
    public static const LZMA_FLAG:String = "ZWS";
    public static const DECOMPRESSED_FLAG:String = "FWS";

    public function SWFUtil() {
    }

    public static function clone(source:*):* {
        var copier:ByteArray = new ByteArray;
        copier.writeObject(source);
        copier.position = 0;
        return (copier.readObject());
    }

    public static function compress(data:ByteArray, compressionAlgorithm:String = null):ByteArray {
        data.endian = Endian.LITTLE_ENDIAN;
        data.position = 0;
        var header:ByteArray = new ByteArray();
        var decompressed:ByteArray = new ByteArray();
        var result:ByteArray = new ByteArray();
        //
        header.writeBytes(data, 3, 5); // read the header, excluding the signature
        decompressed.writeBytes(data, 8); // read the rest
        if (!compressionAlgorithm)
            compressionAlgorithm = CompressionAlgorithm.LZMA;
        decompressed.compress(compressionAlgorithm);
        const signature:String = compressionAlgorithm == CompressionAlgorithm.ZLIB
                ? ZLIB_FLAG : LZMA_FLAG;
        result.writeMultiByte(signature, "us-ascii"); // mark as compressed
        result.writeBytes(header);
        result.writeBytes(decompressed);
        trace("[SWFCompressor]", "compress", compressionAlgorithm, data.length, "=>", result.length);
        result.position = 0;
        return result;
    }

    public static function decompress(data:ByteArray):ByteArray {
        const signature:String = data.readMultiByte(3, "us-ascii"); // CWS, ZWS
        const version:uint = data.readUnsignedByte();
        data.endian = Endian.LITTLE_ENDIAN;
        const fileLength:uint = data.readUnsignedInt();
        data.position = 0;
        trace("SWFUtil::decompress: " + signature + " | " + version + " | " + fileLength);
        if (signature == DECOMPRESSED_FLAG)
            return data;
        else if (signature == LZMA_FLAG)
            return decompressLZMA(data, fileLength);
        else if (signature == ZLIB_FLAG)
            return decompressZLIB(data);
        return null;
    }

    private static function decompressLZMA(data:ByteArray, fileLength:int):ByteArray {
        var result:ByteArray = new ByteArray();
        var header:ByteArray = new ByteArray();
        var compressed:ByteArray = new ByteArray();
        // read the uncompressed header, excluding the signature
        header.writeBytes(data, 3, 5);
        // read the rest, compressed
        // Write LZMA properties
        for (var i:uint = 0; i < 5; i++) {
            compressed.writeByte(data[i + 12]);
        }
        // Write uncompressed length (64 bit)
        compressed.endian = Endian.LITTLE_ENDIAN;
        compressed.writeUnsignedInt(fileLength - 8);
        compressed.writeUnsignedInt(0);
        // Write compressed data
        data.position = 17;
        data.readBytes(compressed, 13);
        // Uncompress
        compressed.position = 0;
        compressed.uncompress(CompressionAlgorithm.LZMA);
        // write back with signature + header + content
        result.writeMultiByte(DECOMPRESSED_FLAG, "us-ascii"); // mark as uncompressed
        result.writeBytes(header); // write the header back
        result.writeBytes(compressed); // write the now uncompressed content
        trace("SWFUtil::decompressLZMA", data.length, "=>", result.length);
        result.position = 0;
        return result;
    }

    private static function decompressZLIB(data:ByteArray):ByteArray {
        trace("SWFUtil::decompressZLIB");
        var result:ByteArray = new ByteArray();
        var header:ByteArray = new ByteArray();
        var compressed:ByteArray = new ByteArray();
        // read the uncompressed header, excluding the signature
        header.writeBytes(data, 3, 5);
        // read the rest, compressed
        compressed.writeBytes(data, 8);
        compressed.uncompress(CompressionAlgorithm.ZLIB);
        // write back with signature + header + content
        result.writeMultiByte(DECOMPRESSED_FLAG, "us-ascii"); // mark as uncompressed
        result.writeBytes(header); // write the header back
        result.writeBytes(compressed); // write the now uncompressed content
        trace("SWFUtil::decompressZLIB", data.length, "=>", result.length);
        result.position = 0;
        return result;
    }
}
}
