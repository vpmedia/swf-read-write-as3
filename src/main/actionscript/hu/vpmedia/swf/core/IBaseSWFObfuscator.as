package hu.vpmedia.swf.core {
import flash.utils.ByteArray;

public interface IBaseSWFObfuscator {
    function obfuscate(data:ByteArray):ByteArray
}
}
