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

    /* CODEAZUR obfuscator */
    private var obfuscator:SWFObfuscatorCodeazurImpl;

    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    public function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);

        obfuscator = new SWFObfuscatorCodeazurImpl();

        var sourceBA:ByteArray = SWFUtil.decompress(SWFUtil.clone(new symbolClass()));
        var obfuscatedBA:ByteArray = obfuscator.obfuscate(sourceBA);
    }
}
}
