package hu.vpmedia.swf.swfwire {
import com.swfwire.decompiler.SWF10Writer;
import com.swfwire.decompiler.SWFWriteResult;

import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;
import hu.vpmedia.swf.swfwire.renamers.PackageRenamer;
import hu.vpmedia.swf.utils.IdGenerator;
import hu.vpmedia.utils.SWFUtil;

public class SWFObfuscatorSWFWireImpl implements IBaseSWFObfuscator {
    protected var packageRenamer:PackageRenamer;
    //protected var classRenamer:ClassRenamer;
    // protected var memberRenamer:MemberRenamer;
    protected var swfReader:SWFWireReader;

    public function SWFObfuscatorSWFWireImpl() {
        swfReader = new SWFWireReader();
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
        var swfWriter:SWF10Writer = new SWF10Writer();
        var swfWriteResult:SWFWriteResult = swfWriter.write(swfReader.swf);
        trace(swfWriteResult.warnings);
        // Compress and pass back
        return SWFUtil.compress(swfWriteResult.bytes);
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
