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

package hu.vpmedia.swf.codeazur {
import com.codeazur.as3swf.SWFData;

import flash.utils.ByteArray;

import hu.vpmedia.swf.core.IBaseSWFObfuscator;

public class SWFObfuscatorCodeazurImpl implements IBaseSWFObfuscator {
    private var packageRenamer:PackageRenamer;
    private var classRenamer:ClassRenamer;
    private var memberRenamer:MemberRenamer;
    private var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorCodeazurImpl() {
        swfReader = new SWFReaderWrapper();
        packageRenamer = new PackageRenamer();
        classRenamer = new ClassRenamer();
        memberRenamer = new MemberRenamer();
        super();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        // read
        swfReader.parse(data);
        // modify
        packageRenamer.rename(swfReader.abcList);
        classRenamer.rename(swfReader.abcList);
        memberRenamer.rename(swfReader.abcList);
        // write
        var result:SWFData = new SWFData();
        swfReader.swf.publish(result);
        return result;
    }
}
}
