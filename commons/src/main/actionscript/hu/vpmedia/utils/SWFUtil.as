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
        const compressionFlag:String = compressionAlgorithm == CompressionAlgorithm.ZLIB
                ? ZLIB_FLAG : LZMA_FLAG;
        result.writeMultiByte(compressionFlag, "us-ascii"); // mark as compressed
        result.writeBytes(header);
        result.writeBytes(decompressed);
        trace("[SWFCompressor]", "compress", compressionAlgorithm, data.length, "=>", result.length);
        result.position = 0;
        return result;
    }

    public static function decompress(data:ByteArray):ByteArray {
        var compressionType:String = data.readMultiByte(3, "us-ascii"); // CWS, ZWS
        data.position = 0;
        trace("SWFUtil::decompress: " + compressionType);
        if (compressionType == DECOMPRESSED_FLAG)
            return data;
        else if (compressionType == LZMA_FLAG)
            return decompressLZMA(data);
        else  if (compressionType == ZLIB_FLAG)
            return decompressZLIB(data);
        return null;
    }

    private static function decompressLZMA(data:ByteArray):ByteArray {
        trace("SWFUtil::decompressLZMA: " + data.position + " | " + data.length);
        return data;
    }

    private static function decompressZLIB(data:ByteArray):ByteArray {
        trace("SWFUtil::decompressZLIB: " + data.position + " | " + data.length);
        var result:ByteArray = new ByteArray();
        var header:ByteArray = new ByteArray();
        var compressed:ByteArray = new ByteArray();
        // read the uncompressed header, excluding the signature
        header.writeBytes(data, 3, 5);
        // read the rest, compressed
        compressed.writeBytes(data, 8);
        compressed.uncompress(CompressionAlgorithm.ZLIB);
        result.writeMultiByte(DECOMPRESSED_FLAG, "us-ascii"); // mark as uncompressed
        result.writeBytes(header); // write the header back
        result.writeBytes(compressed); // write the now uncompressed content
        trace("[SWFCompressor]", "decompress", data.length, "=>", result.length);
        result.position = 0;
        return result;
    }
}
}
