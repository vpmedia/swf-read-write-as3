package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.ByteArray;

import hu.vpmedia.swf.abstraction.SWFObfuscatorAbstractionImpl;
import hu.vpmedia.utils.SWFUtil;

// cannot compile with ASC2
//import hu.vpmedia.codec.abc.obfuscators.as3commons.SWFObfuscatorAS3CommonsImpl;

public class Main extends MovieClip {

    // TEST ASSET
    [Embed(source="/../../../../commons/src/main/resources/Main-22.swf", mimeType="application/octet-stream")]
    private var symbolClass:Class;

    /* ABSTRACTION obfuscator */
    private var abstraction:SWFObfuscatorAbstractionImpl;


    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    public function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);

        abstraction = new SWFObfuscatorAbstractionImpl();
        var abstractionBA:ByteArray = abstraction.obfuscate(SWFUtil.clone(new symbolClass()));
    }
}
}
