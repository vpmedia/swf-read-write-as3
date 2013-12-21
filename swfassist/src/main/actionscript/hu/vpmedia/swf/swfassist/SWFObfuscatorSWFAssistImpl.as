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

package hu.vpmedia.swf.swfassist {
import flash.utils.ByteArray;

import hu.vpmedia.swf.core.IBaseSWFObfuscator;

import org.libspark.swfassist.io.ByteArrayOutputStream;
import org.libspark.swfassist.swf.io.SWFWriter;
import org.libspark.swfassist.swf.io.WritingContext;

public class SWFObfuscatorSWFAssistImpl implements IBaseSWFObfuscator {
    private var packageRenamer:PackageRenamer;
    private var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorSWFAssistImpl() {
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
        var swfOutputBytes:ByteArray = new ByteArray();
        var swfOutput:ByteArrayOutputStream = new ByteArrayOutputStream(swfOutputBytes);
        var swfWriterContext:WritingContext = new WritingContext();
        var swfWriter:SWFWriter = new SWFWriter();
        swfWriterContext.length = 999999;
        swfWriter.writeSWF(swfOutput, swfWriterContext, swfReader.swf);
        return swfOutput.byteArray;
    }
}
}
