package hu.vpmedia.swf.bruteforce {
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.codeazur.SWFCodeazurReader;
import hu.vpmedia.swf.codeazur.renamers.ClassRenamer;
import hu.vpmedia.swf.codeazur.renamers.MemberRenamer;
import hu.vpmedia.swf.codeazur.renamers.PackageRenamer;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;
import hu.vpmedia.swf.utils.IdGenerator;
import hu.vpmedia.utils.SWFUtil;

public class SWFObfuscatorBruteForceImpl implements IBaseSWFObfuscator {
    private var packageRenamer:PackageRenamer;
    private var classRenamer:ClassRenamer;
    private var memberRenamer:MemberRenamer;
    private var swfReader:SWFCodeazurReader;

    public function SWFObfuscatorBruteForceImpl() {
        swfReader = new SWFCodeazurReader();
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
