package hu.vpmedia.swf.swfassist {
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;
import hu.vpmedia.swf.swfassist.renamers.PackageRenamer;
import hu.vpmedia.swf.utils.IdGenerator;
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
    protected var swfReader:SWFAssistReader;

    public function SWFObfuscatorSWFAssistImpl() {
        swfReader = new SWFAssistReader();
        packageRenamer = new PackageRenamer();
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
        packageRenamer.rename(swfReader.abcList);
        // writeBackTags(resultBA, packageRenamer.packages, packageRenamer.obfuscationMap);
        // Rename classes
        // classRenamer.rename(swfReader.abcList);
        // Rename members
        // memberRenamer.rename(swfReader.abcList);
        //processABCTags();
        // Compress and pass back
        return SWFUtil.compress(writeSWF());
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
