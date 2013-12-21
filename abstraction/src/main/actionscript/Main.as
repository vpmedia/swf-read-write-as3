package {
import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.ByteArray;

import hu.vpmedia.swf.abstraction.SWFObfuscatorAbstractionImpl;

import hu.vpmedia.swf.zero.SWFObfuscatorZeroImpl;

// cannot compile with ASC2
//import hu.vpmedia.codec.abc.obfuscators.as3commons.SWFObfuscatorAS3CommonsImpl;

import hu.vpmedia.swf.bruteforce.SWFObfuscatorBruteForceImpl;
import hu.vpmedia.swf.codeazur.SWFObfuscatorCodeazurImpl;
import hu.vpmedia.swf.eval.SWFObfuscatorEvalImpl;
import hu.vpmedia.swf.swfassist.SWFObfuscatorSWFAssistImpl;
import hu.vpmedia.swf.swfwire.SWFObfuscatorSWFWireImpl;
import hu.vpmedia.utils.SWFUtil;

public class Main extends MovieClip {

    // TEST ASSET
    [Embed(source="/../resources/Main-22.swf", mimeType="application/octet-stream")]
    private var symbolClass:Class;

    /* BRUTE obfuscator */
    private var brute:SWFObfuscatorBruteForceImpl;

    /* ABSTRACTION obfuscator */
    private var abstraction:SWFObfuscatorAbstractionImpl;

    /* ZERO obfuscator */
    private var zero:SWFObfuscatorZeroImpl;

    /* CODEAZUR obfuscator */
    private var codeazur:SWFObfuscatorCodeazurImpl;

    /* SWF-WIRE obfuscator */
    private var swfwire:SWFObfuscatorSWFWireImpl;

    /* SWF-ASSIST obfuscator */
    private var swfassist:SWFObfuscatorSWFAssistImpl;

    /* EVAL obfuscator */
    private var eval:SWFObfuscatorEvalImpl;


    public function Main() {
        addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    public function onAdded(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, onAdded);

        brute = new SWFObfuscatorBruteForceImpl();
        abstraction = new SWFObfuscatorAbstractionImpl();
        zero = new SWFObfuscatorZeroImpl();
        codeazur = new SWFObfuscatorCodeazurImpl();
        swfwire = new SWFObfuscatorSWFWireImpl();
        eval = new SWFObfuscatorEvalImpl();
        swfassist = new SWFObfuscatorSWFAssistImpl();

        trace("#### BRUTE FORCE ####");
        var bruteForcedBA:ByteArray = brute.obfuscate(compressedSWF);
        /*trace("");
        trace("#### ABSTRACTION ####");
        var abstractionBA:ByteArray = abstraction.obfuscate(decompressedSWF);
        trace("");
        trace("#### ZERO ####");
        var zeroBA:ByteArray = zero.obfuscate(compressedSWF);
        trace("");
        trace("#### CODEAZUR ####");
        var codeazurBA:ByteArray = codeazur.obfuscate(decompressedSWF);
        trace("");
        trace("#### SWF WIRE ####");
        var swfwireBA:ByteArray = swfwire.obfuscate(compressedSWF);
        trace("");
        trace("#### SWF ASSIST ####");
        var swfassistBA:ByteArray = swfassist.obfuscate(compressedSWF);
        trace("");
        trace("#### EVAL ####");
        var evalBA:ByteArray = eval.obfuscate(compressedSWF);   */
    }

    private function get compressedSWF():ByteArray {
        const result:ByteArray = SWFUtil.clone(new symbolClass());
        if(result.position)
            throw new Error("Position should be 0.");
        return result;
    }

    private function get decompressedSWF():ByteArray {
        const result:ByteArray = SWFUtil.decompress(compressedSWF);
        if(result.position)
            throw new Error("Position should be 0.");
        return result;
    }
}
}
