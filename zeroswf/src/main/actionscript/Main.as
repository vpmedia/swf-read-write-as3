package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.ByteArray;

import hu.vpmedia.swf.zero.SWFObfuscatorZeroImpl;
import hu.vpmedia.utils.SWFUtil;

// cannot compile with ASC2
//import hu.vpmedia.codec.abc.obfuscators.as3commons.SWFObfuscatorAS3CommonsImpl;

public class Main extends MovieClip {

    // TEST ASSET
    [Embed(source="/../../../../commons/src/main/resources/Main-22.swf", mimeType="application/octet-stream")]
    private var symbolClass:Class;

    /* ZERO obfuscator */
    private var zero:SWFObfuscatorZeroImpl;


    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    public function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);

        zero = new SWFObfuscatorZeroImpl();
        var zeroBA:ByteArray = zero.obfuscate(compressedSWF);
    }

    private function get compressedSWF():ByteArray {
        const result:ByteArray = SWFUtil.clone(new symbolClass());
        if (result.position)
            throw new Error("Position should be 0.");
        return result;
    }

    private function get decompressedSWF():ByteArray {
        const result:ByteArray = SWFUtil.decompress(compressedSWF);
        if (result.position)
            throw new Error("Position should be 0.");
        return result;
    }
}
}