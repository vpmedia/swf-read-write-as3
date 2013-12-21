package hu.vpmedia.swf.core {
import flash.geom.Rectangle;
import flash.utils.ByteArray;

public interface IBaseSWFReader {
    function parse(data:ByteArray):void;

    function getNumFrames():uint;

    function isCompressed():Boolean;

    function getVersion():uint;

    function getRectangle():Rectangle;

    function getFrameRate():Number;
}
}
