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

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;
import hu.vpmedia.swf.core.IdGenerator;
import hu.vpmedia.utils.SWFUtil;

import org.libspark.swfassist.inprogress.swf.ABCInfoPrinter;
import org.libspark.swfassist.io.ByteArrayOutputStream;
import org.libspark.swfassist.swf.abc.io.ABCPrintingContext;
import org.libspark.swfassist.swf.abc.modifiers.ABCPatcher;
import org.libspark.swfassist.swf.abc.validators.ABCSecurityValidator;
import org.libspark.swfassist.swf.io.SWFWriter;
import org.libspark.swfassist.swf.io.WritingContext;

public class SWFObfuscatorSWFAssistImpl implements IBaseSWFObfuscator {
    protected var packageRenamer:PackageRenamer;
    //protected var classRenamer:ClassRenamer;
    // protected var memberRenamer:MemberRenamer;
    protected var swfReader:SWFReaderWrapper;

    public function SWFObfuscatorSWFAssistImpl() {
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
        // writeBackTags(resultBA, packageRenamer.packages, packageRenamer.obfuscationMap);
        // Rename classes
        // classRenamer.rename(swfReader.abcList);
        // Rename members
        // memberRenamer.rename(swfReader.abcList);
        //processABCTags();
        // Compress and pass back
        return writeSWF();
    }

    private function processABCTags():void {
        var validator:ABCSecurityValidator = new ABCSecurityValidator();
        var patcher:ABCPatcher = new ABCPatcher(validator, 0, 0, printTags);
        swfReader.swf.visit(patcher);
    }

    private function printTags():void {
        // Trace out the patched file ( call writeSWF() to write to a file )
        var printerContext:ABCPrintingContext = new ABCPrintingContext();
        printerContext.methodLimit = 0;
        printerContext.readMethodCode = false;
        var printer:ABCInfoPrinter = new ABCInfoPrinter(printerContext, 0);
        swfReader.swf.visit(printer);
    }

    protected function writeSWF():ByteArray {
        var swfOutputBytes:ByteArray = new ByteArray();
        var swfOutput:ByteArrayOutputStream = new ByteArrayOutputStream(swfOutputBytes);
        var swfWriterContext:WritingContext = new WritingContext();
        var swfWriter:SWFWriter = new SWFWriter();
        swfWriterContext.length = 999999;
        swfWriter.writeSWF(swfOutput, swfWriterContext, swfReader.swf);
        return swfOutput.byteArray;
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