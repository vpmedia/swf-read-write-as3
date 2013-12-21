package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.ByteArray;
import flash.utils.ByteArray;

import hu.vpmedia.swf.bruteforce.SWFObfuscatorBruteForceImpl;
import hu.vpmedia.swf.codeazur.SWFObfuscatorCodeazurImpl;
import hu.vpmedia.utils.SWFUtil;
import hu.vpmedia.utils.SWFUtil;

public class Main extends MovieClip {

    // TEST ASSET
    [Embed(source="/../../../../commons/src/main/resources/Main-22.swf", mimeType="application/octet-stream")]
    private var symbolClass:Class;

    /* BRUTE obfuscator */
    private var brute:SWFObfuscatorBruteForceImpl;

    /* CODEAZUR obfuscator */
    private var codeazur:SWFObfuscatorCodeazurImpl;


    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    public function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);

        brute = new SWFObfuscatorBruteForceImpl();
        codeazur = new SWFObfuscatorCodeazurImpl();

        var source:ByteArray;
        var result:ByteArray;

        // test with compressed input
        source = SWFUtil.clone(new symbolClass());
        result = brute.obfuscate(source);

        // test with decompressed input
        source = SWFUtil.decompress(SWFUtil.clone(new symbolClass()));
        result = brute.obfuscate(source);

        source = SWFUtil.decompress(SWFUtil.clone(new symbolClass()));
        result = codeazur.obfuscate(source);
    }
}
}
