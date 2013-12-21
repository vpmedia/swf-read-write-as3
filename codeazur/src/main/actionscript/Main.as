package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.ByteArray;

import hu.vpmedia.swf.bruteforce.SWFObfuscatorBruteForceImpl;
import hu.vpmedia.swf.codeazur.SWFObfuscatorCodeazurImpl;
import hu.vpmedia.utils.SWFUtil;

// cannot compile with ASC2
//import hu.vpmedia.codec.abc.obfuscators.as3commons.SWFObfuscatorAS3CommonsImpl;

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

        trace("#### BRUTE FORCE ####");
        var bruteForcedBA:ByteArray = brute.obfuscate(SWFUtil.clone(new symbolClass()));
        var codeazurBA:ByteArray = codeazur.obfuscate(SWFUtil.clone(new symbolClass()));
    }
}
}
