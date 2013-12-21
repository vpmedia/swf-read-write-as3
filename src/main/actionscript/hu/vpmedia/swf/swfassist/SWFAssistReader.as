package hu.vpmedia.swf.swfassist {
import flash.geom.Rectangle;
import flash.utils.ByteArray;

import hu.vpmedia.collections.HashMap;
import hu.vpmedia.swf.core.IBaseSWFReader;
import hu.vpmedia.utils.SWFUtil;

import org.libspark.swfassist.io.ByteArrayInputStream;
import org.libspark.swfassist.io.DataInput;
import org.libspark.swfassist.swf.io.ReadingContext;
import org.libspark.swfassist.swf.io.SWFReader;
import org.libspark.swfassist.swf.structures.Rect;
import org.libspark.swfassist.swf.structures.SWF;
import org.libspark.swfassist.swf.tags.AbstractTag;
import org.libspark.swfassist.swf.tags.DoABC;
import org.libspark.swfassist.swf.tags.SymbolClass;
import org.libspark.swfassist.swf.tags.TagCodeConstants;

public class SWFAssistReader implements IBaseSWFReader {
    public var swf:SWF;
    public var swfReader:SWFReader = new SWFReader();
    public var context:ReadingContext = new ReadingContext();
    public var abcTagList:Vector.<DoABC>;
    public var abcList:Vector.<DoABC>;
    public var abcTagMap:HashMap;
    public var symbolTagList:Vector.<SymbolClass>;

    public function SWFAssistReader() {
    }

    public function parse(data:ByteArray):void {
        abcList = new Vector.<DoABC>();
        abcTagList = new Vector.<DoABC>();
        abcTagMap = new HashMap(false);
        symbolTagList = new Vector.<SymbolClass>();
        var input:DataInput = new ByteArrayInputStream(SWFUtil.clone(data));
        context.needsABCData = true;
        swf = swfReader.readSWF(input, context);
        processTags();
    }

    public function getCode():uint {
        return swf.fileAttributes.code;
    }

    public function isActionScript3():Boolean {
        return swf.fileAttributes.isActionScript3;
    }

    public function hasMetadata():Boolean {
        return swf.fileAttributes.hasMetadata;
    }

    public function useNetwork():Boolean {
        return swf.fileAttributes.useNetwork;
    }

    //
    public function getNumFrames():uint {
        return swf.header.numFrames;
    }

    public function getVersion():uint {
        return swf.header.version;
    }

    public function getRectangle():Rectangle {
        var rect:Rect = swf.header.frameSize;
        var result:Rectangle = new Rectangle(rect.xMin, rect.yMin, rect.xMax, rect.yMax);
        return result;
    }

    public function getFrameRate():Number {
        return swf.header.frameRate;
    }

    public function isCompressed():Boolean {
        return swf.header.isCompressed;
    }

    //
    protected function processTags():void {
        var tags:Array = swf.tags.tags;
        var n:int = swf.tags.numTags;
        var i:int;
        for (i = 0; i < n; i++) {
            var t:AbstractTag = tags[i];
            read(t);
        }
    }

    protected function read(t:AbstractTag):void {
        switch (t.code) {
            case TagCodeConstants.TAG_SYMBOL_CLASS:
                var symbolTag:SymbolClass = SymbolClass(t);
                symbolTagList.push(symbolTag);
                break;
            case TagCodeConstants.TAG_DO_ABC:
                var abcTag:DoABC = DoABC(t);
                abcList.push(abcTag);
                abcTagList.push(abcTag);
                break;
        }
    }

    /*protected function getNamesByABC(abcData:ByteArrayInputStream): Array
     {
     trace(this, "getNamesByABC", abcData.length, abcData.position);
     var res: Array = [];
     var str: String = abcData.readUTF();
     if (str) res.push(str.replace(/\//g, "."));
     return res;
     }*/
}
}
