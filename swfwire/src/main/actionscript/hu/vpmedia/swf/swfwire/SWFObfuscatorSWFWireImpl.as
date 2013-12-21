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
    protected var packageRenamer:PackageRenamer;
    //protected var classRenamer:ClassRenamer;
    // protected var memberRenamer:MemberRenamer;
    protected var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorSWFWireImpl() {
        swfReader = new SWFReaderWrapper();
        packageRenamer = new PackageRenamer();
        //  classRenamer = new ClassRenamer();
        //  memberRenamer = new MemberRenamer();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        swfReader.parse(data);
        // Rename packages
        packageRenamer.rename(swfReader.abcList);
        // Rename classes
        // classRenamer.rename(swfReader.abcList);
        // Rename members
        // memberRenamer.rename(swfReader.abcList);
        var swfWriter:SWF10Writer = new SWF10Writer();
        var swfWriteResult:SWFWriteResult = swfWriter.write(swfReader.swf);
        trace(swfWriteResult.warnings);
        // Pass back uncompressed
        return swfWriteResult.bytes;
    }
}
}
