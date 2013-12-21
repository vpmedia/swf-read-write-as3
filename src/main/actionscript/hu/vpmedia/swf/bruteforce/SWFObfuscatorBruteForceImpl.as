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

package hu.vpmedia.swf.bruteforce {
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.codeazur.ClassRenamer;
import hu.vpmedia.swf.codeazur.MemberRenamer;
import hu.vpmedia.swf.codeazur.PackageRenamer;
import hu.vpmedia.swf.codeazur.SWFReaderWrapper;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;
import hu.vpmedia.swf.core.IdGenerator;
import hu.vpmedia.utils.SWFUtil;

public class SWFObfuscatorBruteForceImpl implements IBaseSWFObfuscator {
    private var packageRenamer:PackageRenamer;
    private var classRenamer:ClassRenamer;
    private var memberRenamer:MemberRenamer;
    private var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorBruteForceImpl() {
        swfReader = new SWFReaderWrapper();
        packageRenamer = new PackageRenamer();
        classRenamer = new ClassRenamer();
        memberRenamer = new MemberRenamer();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        swfReader.parse(data);
        // Decompress is neccessary
        var resultBA:ByteArray = swfReader.isCompressed() ? SWFUtil.decompress(data) : data;
        // Rename packages
        packageRenamer.rename(swfReader.abcList);
        writeBackTags(resultBA, packageRenamer.getPackages(), packageRenamer.getObfuscationMap());
        // Rename classes
        classRenamer.rename(swfReader.abcList);
        // Rename members
        memberRenamer.rename(swfReader.abcList);
        // Compress and pass back
        return SWFUtil.compress(resultBA);
    }

    private function writeBackTags(data:ByteArray, orderedList:Array, obfuscationMap:HashMap):void {
        // obfuscate
        var i:int;
        while (orderedList.length > 0) {
            var originalName:String = orderedList.shift();
            var renamedName:String = obfuscationMap.getValue(originalName);
            trace("\t", "=>", originalName, renamedName);
            data.position = 0;
            while (IdGenerator.findString(data, originalName)) {
                for (i = 0; i < renamedName.length; i++) {
                    data.writeByte(renamedName.charCodeAt(i));
                }
            }
        }
    }
}
}
