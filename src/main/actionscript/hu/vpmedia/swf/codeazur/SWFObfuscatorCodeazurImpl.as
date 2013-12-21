package hu.vpmedia.swf.codeazur {
import com.codeazur.as3swf.SWFData;

import flash.utils.ByteArray;

import hu.vpmedia.swf.codeazur.renamers.ClassRenamer;
import hu.vpmedia.swf.codeazur.renamers.MemberRenamer;
import hu.vpmedia.swf.codeazur.renamers.PackageRenamer;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;

public class SWFObfuscatorCodeazurImpl implements IBaseSWFObfuscator {
    private var packageRenamer:PackageRenamer;
    private var classRenamer:ClassRenamer;
    private var memberRenamer:MemberRenamer;
    private var swfReader:SWFCodeazurReader;

    public function SWFObfuscatorCodeazurImpl() {
        swfReader = new SWFCodeazurReader();
        packageRenamer = new PackageRenamer();
        classRenamer = new ClassRenamer();
        memberRenamer = new MemberRenamer();
        super();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        swfReader.parse(data);
        processTags();
        var swfData:SWFData = writeBackTags()
        return swfData;
    }

    private function processTags():void {
        packageRenamer.rename(swfReader.abcList);
        classRenamer.rename(swfReader.abcList);
        memberRenamer.rename(swfReader.abcList);
    }

    private function writeBackTags():SWFData {
        /*for (var i:int = 0; i < swfReader.abcList.length; i++)
         {
         var abc:ABC = ABC(swfReader.abcList[i]);
         var abcTag:TagDoABC = TagDoABC(swfReader.abcTagMap.getValue(abc));
         //trace(i,abc,abcTag);
         }*/
        var result:SWFData = new SWFData();
        swfReader.swf.publish(result);
        return result;
    }
}
}
