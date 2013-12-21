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

package hu.vpmedia.swf.swfwire {
import com.swfwire.decompiler.SWF10Writer;
import com.swfwire.decompiler.SWFWriteResult;

import flash.utils.ByteArray;

import hu.vpmedia.swf.core.IBaseSWFObfuscator;

public class SWFObfuscatorSWFWireImpl implements IBaseSWFObfuscator {
    private var packageRenamer:PackageRenamer;
    private var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorSWFWireImpl() {
        swfReader = new SWFReaderWrapper();
        packageRenamer = new PackageRenamer();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        // read
        swfReader.parse(data);
        // obfuscate
        packageRenamer.rename(swfReader.abcList);
        // write
        var swfWriter:SWF10Writer = new SWF10Writer();
        var swfWriteResult:SWFWriteResult = swfWriter.write(swfReader.swf);
        trace(swfWriteResult.warnings);
        return swfWriteResult.bytes;
    }
}
}
