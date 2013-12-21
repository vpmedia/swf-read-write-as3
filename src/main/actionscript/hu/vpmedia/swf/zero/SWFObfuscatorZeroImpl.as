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

package hu.vpmedia.swf.zero {
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;
import hu.vpmedia.swf.core.IdGenerator;
import hu.vpmedia.utils.SWFUtil;

public class SWFObfuscatorZeroImpl implements IBaseSWFObfuscator {
    // protected var packageRenamer:PackageRenamer;
    //protected var classRenamer:ClassRenamer;
    // protected var memberRenamer:MemberRenamer;
    protected var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorZeroImpl() {
        swfReader = new SWFReaderWrapper();
        // packageRenamer = new PackageRenamer();
        //  classRenamer = new ClassRenamer();
        //  memberRenamer = new MemberRenamer();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        // Decompress is neccessary
        //var resultBA:ByteArray = swfReader.compressed ? SWFCompressor.decompress (data) : data;
        var resultBA:ByteArray = SWFUtil.decompress(data);
        swfReader.parse(resultBA);
        // Rename packages
        //packageRenamer.rename(swfReader.abcList);
        // writeBackTags(resultBA, packageRenamer.packages, packageRenamer.obfuscationMap);
        // Rename classes
        // classRenamer.rename(swfReader.abcList);
        // Rename members
        // memberRenamer.rename(swfReader.abcList);
        //processABCTags();
        // Compress and pass back
        return SWFUtil.compress(writeSWF());
    }

    /* private function processABCTags():void {
     var validator:ABCSecurityValidator = new ABCSecurityValidator();
     var patcher:ABCPatcher = new ABCPatcher(validator, 0, 0, printTags);
     swfReader.swf.visit(patcher);
     }*/

    /*private function printTags():void {
     // Trace out the patched file ( call writeSWF() to write to a file )
     var printerContext:ABCPrintingContext = new ABCPrintingContext();
     printerContext.methodLimit = 0;
     printerContext.readMethodCode = false;
     var printer:ABCInfoPrinter = new ABCInfoPrinter(printerContext, 0);
     swfReader.swf.visit(printer);
     } */

    protected function writeSWF():ByteArray {
        return swfReader.swf.toSWFData(null);
    }

    protected function writeBackTags(data:ByteArray, orderedList:Array, obfuscationMap:HashMap):void {
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
