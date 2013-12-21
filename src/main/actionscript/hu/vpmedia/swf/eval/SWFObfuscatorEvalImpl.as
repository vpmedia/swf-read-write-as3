package hu.vpmedia.swf.eval {
import com.hurlant.eval.CompiledESC;
import com.hurlant.eval.dump.ABCDump;
import com.hurlant.eval.gen.ABCByteStream;

import flash.utils.ByteArray;

import hu.vpmedia.swf.codeazur.SWFCodeazurReader;
import hu.vpmedia.swf.core.IBaseSWFObfuscator;
import hu.vpmedia.utils.SWFUtil;

public class SWFObfuscatorEvalImpl implements IBaseSWFObfuscator {
    private var esc:CompiledESC = new CompiledESC;
    private var swfReader:SWFCodeazurReader;

    public function SWFObfuscatorEvalImpl() {
        swfReader = new SWFCodeazurReader();
        super();
    }

    public function obfuscate(data:ByteArray):ByteArray {
        trace(this, "obfuscate");
        var resultBA:ByteArray = SWFUtil.decompress(data);
        swfReader.parse(data);
        var a:Array = swfReader.abcTagMap.getValues();
        var n:int = a.length;
        for (var i:int = 0; i < n; i++) {
            var bs:ABCByteStream = new ABCByteStream(a[i].bytes);
            trace(bs);
            trace(ABCDump.dump(bs.getBytes()));
        }
        processTags();
        return SWFUtil.compress(resultBA);
    }

    private function processTags():void {
    }

    private function writeBackTags():void {
    }
}
}
