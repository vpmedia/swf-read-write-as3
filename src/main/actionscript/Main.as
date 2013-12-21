package {
import flash.display.MovieClip;
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

    [Embed(source="/../resources/Main-22.swf", mimeType="application/octet-stream")]
    private var symbolClass:Class;

    private var brute:SWFObfuscatorBruteForceImpl;

    private var codeazour:SWFObfuscatorCodeazurImpl;

    private var eval:SWFObfuscatorEvalImpl;

    private var swfassist:SWFObfuscatorSWFAssistImpl;

    private var swfwire:SWFObfuscatorSWFWireImpl;

    private var zero:SWFObfuscatorZeroImpl;

    private var abstraction:SWFObfuscatorAbstractionImpl;

    public function Main() {
        brute = new SWFObfuscatorBruteForceImpl();
        codeazour = new SWFObfuscatorCodeazurImpl();
        eval = new SWFObfuscatorEvalImpl();
        swfassist = new SWFObfuscatorSWFAssistImpl();
        swfwire = new SWFObfuscatorSWFWireImpl();
        zero = new SWFObfuscatorZeroImpl();
        abstraction = new SWFObfuscatorAbstractionImpl();

        var bruteForcedBA:ByteArray = brute.obfuscate(swfCloneAsByteArray);
        //var codeazourBA:ByteArray = codeazour.obfuscate(swfCloneAsByteArray);
        //var evalBA:ByteArray = eval.obfuscate(swfCloneAsByteArray);
        //var swfassistBA:ByteArray = swfassist.obfuscate(swfCloneAsByteArray);
        //var swfwireBA:ByteArray = swfwire.obfuscate(swfCloneAsByteArray);
        //var abstractionBA:ByteArray = abstraction.obfuscate(swfCloneAsByteArray);
    }

    private function get swfCloneAsByteArray():ByteArray {
        return SWFUtil.clone(new symbolClass());
    }
}
}
