package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.ByteArray;

import hu.vpmedia.swf.swfassist.SWFObfuscatorSWFAssistImpl;
import hu.vpmedia.utils.SWFUtil;

public class Main extends MovieClip {

    // TEST ASSET
    [Embed(source="/../../../../commons/src/main/resources/Main-22.swf", mimeType="application/octet-stream")]
    private var symbolClass:Class;


    /* SWF-ASSIST obfuscator */
    private var obfuscator:SWFObfuscatorSWFAssistImpl;


    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    public function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);

        obfuscator = new SWFObfuscatorSWFAssistImpl();
        var sourceBA:ByteArray = SWFUtil.decompress(SWFUtil.clone(new symbolClass()));
        var obfuscatedBA:ByteArray = obfuscator.obfuscate(sourceBA);
    }
}
}
